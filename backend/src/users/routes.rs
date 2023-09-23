use super::dao::IUser;
use super::users::*;
use crate::middlewares::auth;
use crate::state::AppState;
use crate::users::token;
use actix_web::{cookie::Cookie, get, post, web, Error, HttpRequest, HttpResponse, Responder};
use cookie::time::Duration;
use mobc_redis::redis::{self, AsyncCommands};
use nonblock_logger::{debug, info};
use serde::{Deserialize, Serialize};
use serde_json::json;
use uuid::Uuid;

#[derive(Serialize, Deserialize, Debug)]
pub struct LoginResponse {
    pub user: User,
    pub success: bool,
}

#[post("/auth/login")]
async fn login(form: web::Json<Login>, state: AppState) -> impl Responder {
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
                        return HttpResponse::BadGateway()
                            .json(&json!({"status": "fail", "message": format_args!("{}", e)}));
                    }
                };

                let refresh_token_details = match token::generate_jwt_token(
                    user.id,
                    state.config.refresh_token_max_age,
                    state.config.refresh_token_private_key.to_owned(),
                ) {
                    Ok(token_details) => token_details,
                    Err(e) => {
                        return HttpResponse::BadGateway()
                            .json(&json!({"status": "fail", "message": format_args!("{}", e)}));
                    }
                };

                let mut redis_client = match state.kv.get().await {
                    Ok(redis_client) => redis_client,
                    Err(e) => {
                        return HttpResponse::InternalServerError()
                            .json(&json!({"status": "fail", "message": format_args!("{}", e)}));
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
                    return HttpResponse::UnprocessableEntity()
                        .json(&json!({"status": "error", "message": format_args!("{}", e)}));
                }

                let refresh_result: redis::RedisResult<()> = redis_client
                    .set_ex(
                        refresh_token_details.token_uuid.to_string(),
                        user.id.to_string(),
                        (state.config.refresh_token_max_age * 60) as usize,
                    )
                    .await;

                if let Err(e) = refresh_result {
                    return HttpResponse::UnprocessableEntity()
                        .json(&json!({"status": "error", "message": format_args!("{}", e)}));
                }

                drop(redis_client);

                let access_cookie =
                    Cookie::build("access_token", access_token_details.token.clone().unwrap())
                        .domain(&state.config.host)
                        .path("/")
                        .secure(true)
                        .max_age(Duration::new(state.config.access_token_max_age * 60, 0))
                        .http_only(true)
                        .finish();
                let refresh_cookie =
                    Cookie::build("refresh_token", refresh_token_details.token.unwrap())
                        .domain(&state.config.host)
                        .path("/")
                        .secure(true)
                        .max_age(Duration::new(state.config.refresh_token_max_age * 60, 0))
                        .http_only(true)
                        .finish();

                let r: LoginResponse = LoginResponse {
                    user,
                    success: true,
                };
                let resp = match serde_json::to_string(&r) {
                    Ok(json) => HttpResponse::Ok()
                        .cookie(access_cookie)
                        .cookie(refresh_cookie)
                        .cookie(
                            Cookie::build("logged_in", json)
                                .domain(&state.config.host)
                                .path("/")
                                .secure(true)
                                .http_only(true)
                                .max_age(Duration::new(state.config.access_token_max_age * 60, 0))
                                .finish(),
                        )
                        .content_type("application/json")
                        .body(""),
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
async fn refresh_access_token_handler(req: HttpRequest, state: AppState) -> impl Responder {
    let message = "could not refresh access token";

    let refresh_token = match req.cookie("refresh_token") {
        Some(c) => c.value().to_string(),
        None => {
            info!("step 1");
            return HttpResponse::Forbidden().json(&json!({"status": "fail", "message": message}));
        }
    };

    let refresh_token_details = match token::verify_jwt_token(
        state.config.refresh_token_public_key.to_owned(),
        &refresh_token,
    ) {
        Ok(token_details) => token_details,
        Err(e) => {
            info!("step 2");
            return HttpResponse::Forbidden()
                .json(&json!({"status": "fail", "message": format_args!("{:?}", e)}));
        }
    };

    let result = state.kv.get().await;
    let mut redis_client = match result {
        Ok(redis_client) => redis_client,
        Err(e) => {
            info!("step 3");
            return HttpResponse::Forbidden().json(
                &json!({"status": "fail", "message": format!("Could not connect to Redis: {}", e)}),
            );
        }
    };
    let redis_result: redis::RedisResult<String> = redis_client
        .get(refresh_token_details.token_uuid.to_string())
        .await;

    let user_id = match redis_result {
        Ok(value) => value,
        Err(e) => {
            info!("step 4");
            return HttpResponse::Forbidden()
                .json(&json!({"status": "fail", "message": e.to_string()}));
        }
    };

    let user_id_uuid = Uuid::parse_str(&user_id).unwrap();
    let query_result = sqlx::query_as!(
        User,
        "SELECT id, first_name, last_name, username, email, password_hash, created_date,
        modified_date, is_admin, status, department FROM users WHERE id = $1",
        user_id_uuid
    )
    .fetch_optional(&state.sql)
    .await
    .unwrap();

    if query_result.is_none() {
        return HttpResponse::Forbidden()
            .json(&json!({"status": "fail", "message": "the user belonging to this token no logger exists"}));
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
                .json(&json!({"status": "fail", "message": format_args!("{:?}", e)}));
        }
    };

    let refresh_token_details = match token::generate_jwt_token(
        user.id,
        state.config.refresh_token_max_age,
        state.config.refresh_token_private_key.to_owned(),
    ) {
        Ok(token_details) => token_details,
        Err(e) => {
            return HttpResponse::BadGateway()
                .json(&json!({"status": "fail", "message": format_args!("{}", e)}));
        }
    };

    let redis_result: redis::RedisResult<()> = redis_client
        .set_ex(
            refresh_token_details.token_uuid.to_string(),
            user.id.to_string(),
            (state.config.access_token_max_age * 60) as usize,
        )
        .await;

    if redis_result.is_err() {
        return HttpResponse::UnprocessableEntity().json(
            &json!({"status": "error", "message": format_args!("{:?}", redis_result.unwrap_err())}),
        );
    }

    let redis_result: redis::RedisResult<()> = redis_client
        .set_ex(
            access_token_details.token_uuid.to_string(),
            user.id.to_string(),
            (state.config.access_token_max_age * 60) as usize,
        )
        .await;

    if redis_result.is_err() {
        return HttpResponse::UnprocessableEntity().json(
            &json!({"status": "error", "message": format_args!("{:?}", redis_result.unwrap_err())}),
        );
    }

    drop(redis_client);

    let access_cookie = Cookie::build("access_token", access_token_details.token.clone().unwrap())
        .domain(&state.config.host)
        .path("/")
        .secure(true)
        .max_age(Duration::new(state.config.access_token_max_age * 60, 0))
        .http_only(true)
        .finish();

    let refresh_cookie = Cookie::build("refresh_token", refresh_token_details.token.unwrap())
        .domain(&state.config.host)
        .path("/")
        .secure(true)
        .max_age(Duration::new(state.config.refresh_token_max_age * 60, 0))
        .http_only(true)
        .finish();

    let r: LoginResponse = LoginResponse {
        user,
        success: true,
    };
    let resp = match serde_json::to_string(&r) {
        Ok(json) => HttpResponse::Ok()
            .cookie(access_cookie)
            .cookie(refresh_cookie)
            .cookie(
                Cookie::build("logged_in", json)
                    .domain(&state.config.host)
                    .path("/")
                    .secure(true)
                    .http_only(true)
                    .max_age(Duration::new(state.config.access_token_max_age * 60, 0))
                    .finish(),
            )
            .content_type("application/json")
            .body(""),
        Err(e) => Error::from(e).into(),
    };
    resp
}

#[post("/auth/logout")]
async fn logout_handler(
    req: HttpRequest,
    auth_guard: auth::AuthorizationService,
    state: AppState,
) -> impl Responder {
    let message = "Token is invalid or session has expired";

    let refresh_token = match req.cookie("refresh_token") {
        Some(c) => c.value().to_string(),
        None => {
            return HttpResponse::Forbidden().json(&json!({"status": "fail", "message": message}));
        }
    };

    let refresh_token_details = match token::verify_jwt_token(
        state.config.refresh_token_public_key.to_owned(),
        &refresh_token,
    ) {
        Ok(token_details) => token_details,
        Err(e) => {
            return HttpResponse::Forbidden()
                .json(&json!({"status": "fail", "message": format_args!("{:?}", e)}));
        }
    };

    let mut redis_client = state.kv.get().await.unwrap();
    let redis_result: redis::RedisResult<usize> = redis_client
        .del(&[
            refresh_token_details.token_uuid.to_string(),
            auth_guard.xsrf_token,
        ])
        .await;

    if redis_result.is_err() {
        return HttpResponse::UnprocessableEntity().json(
            &json!({"status": "error", "message": format_args!("{:?}", redis_result.unwrap_err())}),
        );
    }

    drop(redis_client);

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
        .json(&json!({"status": "success"}))
}

#[post("/users")]
async fn users_handler(
    req: web::Json<UsersRequest>,
    auth_guard: auth::AuthorizationService,
    state: AppState,
) -> impl Responder {
    let current_user = auth_guard.user;
    if !current_user.is_admin {
        HttpResponse::Forbidden().json(
            &json!({"status": "error", "message": "Users page is not available to normal user."}),
        )
    } else {
        match state
            .get_ref()
            .users(&req.sort_by, &req.last_record, req.ascending)
            .await
        {
            Ok((users, count)) => HttpResponse::Ok().json(&json!({"users": users, "count": count})),
            Err(e) => {
                info!("{:?}", e);
                HttpResponse::InternalServerError()
                    .json(&json!({"status": "fail", "errors": "Internal Server Error"}))
            }
        }
    }
}

#[post("/user/create")]
async fn create_user_handler(
    req: web::Json<CreateUserRequest>,
    auth_guard: auth::AuthorizationService,
    state: AppState,
) -> impl Responder {
    let current_user = auth_guard.user;
    if !current_user.is_admin {
        HttpResponse::Forbidden().json(
            &json!({"status": "error", "message": "create user is not available to normal user."}),
        )
    } else {
        match state
            .get_ref()
            .create_user(&req)
            .await
        {
            Ok((id)) => HttpResponse::Ok().json(&json!({"status": "success", "id": id})),
            Err(e) => {
                info!("{:?}", e);
                HttpResponse::InternalServerError()
                    .json(&json!({"status": "fail", "errors": "Internal Server Error"}))
            }
        }
    }
}

pub fn init(cfg: &mut web::ServiceConfig) {
    cfg.service(login);
    cfg.service(refresh_access_token_handler);
    cfg.service(logout_handler);
}
