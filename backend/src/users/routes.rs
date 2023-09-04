use super::dao::IUser;
use super::users::*;
use crate::middlewares::auth;
use crate::state::AppState;
use crate::users::token;
use cookie::time::Duration;
use cookie::Cookie;
use mobc_redis::redis::{self, AsyncCommands};
use nonblock_logger::{debug, info};
use ntex::http::HttpMessage;
use ntex::web;
use ntex::web::{get, post, Error, HttpRequest, HttpResponse, Responder};
use serde::{Deserialize, Serialize};
use uuid::Uuid;

#[derive(Serialize, Deserialize, Debug)]
pub struct LoginResponse {
    pub user: User,
    pub success: bool,
}

#[post("/auth/login")]
async fn login(form: web::types::Json<Login>, state: AppState) -> impl Responder {
    let form = form.into_inner();

    // todo: distable login for deleted and blocked users
    match state.get_ref().user_query(&form.email).await {
        Ok(user) => {
            info!("find user {:?} ok: {:?}", form, user);

            if form.verify(&user.password_hash) {
                let access_token_details = match token::generate_jwt_token(
                    user.id,
                    state.config.access_token_max_age,
                    state.config.access_token_private_key.to_owned(),
                ) {
                    Ok(token_details) => token_details,
                    Err(e) => {
                        return HttpResponse::BadGateway().json(
                            &serde_json::json!({"status": "fail", "message": format_args!("{}", e)}),
                        );
                    }
                };

                let refresh_token_details = match token::generate_jwt_token(
                    user.id,
                    state.config.refresh_token_max_age,
                    state.config.refresh_token_private_key.to_owned(),
                ) {
                    Ok(token_details) => token_details,
                    Err(e) => {
                        return HttpResponse::BadGateway().json(
                            &serde_json::json!({"status": "fail", "message": format_args!("{}", e)}),
                        );
                    }
                };

                let mut redis_client = match state.kv.get().await {
                    Ok(redis_client) => redis_client,
                    Err(e) => {
                        return HttpResponse::InternalServerError().json(
                            &serde_json::json!({"status": "fail", "message": format_args!("{}", e)}),
                        );
                    }
                };

                let access_result: redis::RedisResult<()> = redis_client
                    .set_ex(
                        access_token_details.token_uuid.to_string(),
                        user.id.to_string(),
                        (state.config.access_token_max_age * 60) as usize,
                    )
                    .await;

                if let Err(e) = access_result {
                    return HttpResponse::UnprocessableEntity().json(
                        &serde_json::json!({"status": "error", "message": format_args!("{}", e)}),
                    );
                }

                let refresh_result: redis::RedisResult<()> = redis_client
                    .set_ex(
                        refresh_token_details.token_uuid.to_string(),
                        user.id.to_string(),
                        (state.config.refresh_token_max_age * 60) as usize,
                    )
                    .await;

                if let Err(e) = refresh_result {
                    return HttpResponse::UnprocessableEntity().json(
                        &serde_json::json!({"status": "error", "message": format_args!("{}", e)}),
                    );
                }

                let access_cookie =
                    Cookie::build("access_token", access_token_details.token.clone().unwrap())
                        .path("/")
                        .max_age(Duration::new(state.config.access_token_max_age * 60, 0))
                        .http_only(true)
                        .finish();
                let refresh_cookie =
                    Cookie::build("refresh_token", refresh_token_details.token.unwrap())
                        .path("/")
                        .max_age(Duration::new(state.config.refresh_token_max_age * 60, 0))
                        .http_only(true)
                        .finish();

                let r = LoginResponse { user, success: true };
                let resp = match serde_json::to_string(&r) {
                    Ok(json) => HttpResponse::Ok()
                        .cookie(access_cookie)
                        .cookie(refresh_cookie)
                        .cookie(
                            Cookie::build("logged_in", "true")
                                .domain(&state.config.host)
                                .path("/")
                                .secure(true)
                                .http_only(true)
                                .finish(),
                        )
                        .content_type("application/json")
                        .body(json),
                    Err(e) => Error::from(e).into(),
                };
                resp
            } else {
                HttpResponse::Unauthorized().finish()
            }
        }
        Err(e) => {
            debug!("find user {:?} error: {:?}", form, e);
            HttpResponse::Unauthorized().finish()
        }
    }
}

#[get("/auth/refresh")]
async fn refresh_access_token_handler(
    req: HttpRequest,
    state: AppState,
) -> impl Responder {
    let message = "could not refresh access token";

    let refresh_token = match req.cookie("refresh_token") {
        Some(c) => c.value().to_string(),
        None => {
            return HttpResponse::Forbidden()
                .json(&serde_json::json!({"status": "fail", "message": message}));
        }
    };

    let refresh_token_details =
        match token::verify_jwt_token(state.config.refresh_token_public_key.to_owned(), &refresh_token)
        {
            Ok(token_details) => token_details,
            Err(e) => {
                return HttpResponse::Forbidden().json(
                    &serde_json::json!({"status": "fail", "message": format_args!("{:?}", e)}),
                );
            }
        };

    let result = state.kv.get().await;
    let mut redis_client = match result {
        Ok(redis_client) => redis_client,
        Err(e) => {
            return HttpResponse::Forbidden().json(
                &serde_json::json!({"status": "fail", "message": format!("Could not connect to Redis: {}", e)}),
            );
        }
    };
    let redis_result: redis::RedisResult<String> = redis_client
        .get(refresh_token_details.token_uuid.to_string())
        .await;

    let user_id = match redis_result {
        Ok(value) => value,
        Err(_) => {
            return HttpResponse::Forbidden()
                .json(&serde_json::json!({"status": "fail", "message": message}));
        }
    };

    let user_id_uuid = Uuid::parse_str(&user_id).unwrap();
    let query_result = sqlx::query_as!(User, 
        "SELECT id, first_name, last_name, username, email, password_hash, created_date, modified_date, is_admin FROM users WHERE id = $1",
        user_id_uuid)
        .fetch_optional(&state.sql)
        .await
        .unwrap();

    if query_result.is_none() {
        return HttpResponse::Forbidden()
            .json(&serde_json::json!({"status": "fail", "message": "the user belonging to this token no logger exists"}));
    }

    let user = query_result.unwrap();

    let access_token_details = match token::generate_jwt_token(
        user.id,
        state.config.access_token_max_age,
        state.config.access_token_private_key.to_owned(),
    ) {
        Ok(token_details) => token_details,
        Err(e) => {
            return HttpResponse::BadGateway()
                .json(&serde_json::json!({"status": "fail", "message": format_args!("{:?}", e)}));
        }
    };

    let redis_result: redis::RedisResult<()> = redis_client
        .set_ex(
            access_token_details.token_uuid.to_string(),
            user.id.to_string(),
            (state.config.access_token_max_age * 60) as usize,
        )
        .await;

    if redis_result.is_err() {
        return HttpResponse::UnprocessableEntity().json(
            &serde_json::json!({"status": "error", "message": format_args!("{:?}", redis_result.unwrap_err())}),
        );
    }

    let access_cookie = Cookie::build("access_token", access_token_details.token.clone().unwrap())
        .path("/")
        .max_age(Duration::new(state.config.access_token_max_age * 60, 0))
        .http_only(true)
        .finish();

    let logged_in_cookie = Cookie::build("logged_in", "true")
        .path("/")
        .max_age(Duration::new(state.config.access_token_max_age * 60, 0))
        .http_only(false)
        .finish();

    HttpResponse::Ok()
        .cookie(access_cookie)
        .cookie(logged_in_cookie)
        .json(&serde_json::json!({"status": "success", "access_token": access_token_details.token.unwrap()}))
}

#[get("/auth/logout")]
async fn logout_handler(
    req: HttpRequest,
    auth_guard: auth::AuthorizationService,
    state: AppState,
) -> impl Responder {
    let message = "Token is invalid or session has expired";

    let refresh_token = match req.cookie("refresh_token") {
        Some(c) => c.value().to_string(),
        None => {
            return HttpResponse::Forbidden()
                .json(&serde_json::json!({"status": "fail", "message": message}));
        }
    };

    let refresh_token_details =
        match token::verify_jwt_token(state.config.refresh_token_public_key.to_owned(), &refresh_token)
        {
            Ok(token_details) => token_details,
            Err(e) => {
                return HttpResponse::Forbidden().json(
                    &serde_json::json!({"status": "fail", "message": format_args!("{:?}", e)}),
                );
            }
        };

    let mut redis_client = state.kv.get().await.unwrap();
    let redis_result: redis::RedisResult<usize> = redis_client
        .del(&[
            refresh_token_details.token_uuid.to_string(),
            auth_guard.xsrf_token.to_string(),
        ])
        .await;

    if redis_result.is_err() {
        return HttpResponse::UnprocessableEntity().json(
            &serde_json::json!({"status": "error", "message": format_args!("{:?}", redis_result.unwrap_err())}),
        );
    }

    let access_cookie = Cookie::build("access_token", "")
        .path("/")
        .max_age(Duration::new(-1, 0))
        .http_only(true)
        .finish();
    let refresh_cookie = Cookie::build("refresh_token", "")
        .path("/")
        .max_age(Duration::new(-1, 0))
        .http_only(true)
        .finish();
    let logged_in_cookie = Cookie::build("logged_in", "")
        .path("/")
        .max_age(Duration::new(-1, 0))
        .http_only(true)
        .finish();

    HttpResponse::Ok()
        .cookie(access_cookie)
        .cookie(refresh_cookie)
        .cookie(logged_in_cookie)
        .json(&serde_json::json!({"status": "success"}))
}

pub fn init(cfg: &mut web::ServiceConfig) {
    cfg.service(login);
    cfg.service(refresh_access_token_handler);
    cfg.service(logout_handler);
}
