use super::dao::IUser;
use super::users::*;
use crate::state::AppState;
use crate::users::token;
use chrono::{DateTime, Utc};
use cookie::time::Duration;
use cookie::Cookie;
use jsonwebtoken::{encode, EncodingKey, Header};
use mobc_redis::redis::{self, AsyncCommands};
use nonblock_logger::{debug, info};
use ntex::web;
use ntex::web::{post, Error, HttpResponse, Responder};
use serde::{Deserialize, Serialize};
use uuid::Uuid;

#[derive(Serialize, Deserialize, Debug)]
pub struct LoginResponse {
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

                let r = LoginResponse { success: true };
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

