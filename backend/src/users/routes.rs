use super::dao::IUser;
use super::users::*;
use crate::middlewares::auth::AuthorizationService;
use crate::state::AppState;
// use crate::utils::security::{check_signature, sign};
// use crate::utils::verify_user::verify_profile_user;

use cookie::Cookie;
use lettre::{
    transport::smtp::authentication::Credentials, AsyncSmtpTransport, AsyncTransport, Message,
    Tokio1Executor,
};
use nonblock_logger::{debug, info};
use ntex::web;
use ntex::web::{get, post, Error, HttpResponse, Responder};
use serde::{Deserialize, Serialize};
use uuid::Uuid;
use validator::Validate;

#[derive(Serialize, Deserialize, Debug)]
pub struct LoginResponse {
    pub success: bool,
}

#[post("/login")]
async fn login(form: web::types::Json<Login>, state: AppState) -> impl Responder {
    let form = form.into_inner();

    use chrono::{DateTime, Duration, Utc};
    use jsonwebtoken::{encode, EncodingKey, Header};

    // todo: distable login for deleted and blocked users
    match state.get_ref().user_query(&form.email).await {
        Ok(user) => {
            info!("find user {:?} ok: {:?}", form, user);

            if !user.email_verified {
                return HttpResponse::Unauthorized().finish();
            }

            if form.verify(&user.pass) {
                let exp: DateTime<Utc> = Utc::now() + Duration::days(1);

                let uuid = Uuid::new_v4().to_string();
                let my_claims = Claims {
                    sub: user.username.clone(),
                    exp: exp.timestamp() as usize,
                    email: form.email,
                    id: user.id,
                    xsrf_token: uuid,
                    image_url: user.image_url,
                };
                let key = state.config.jwt_priv.as_bytes();
                let token = encode(
                    &Header::default(),
                    &my_claims,
                    &EncodingKey::from_secret(key),
                )
                .unwrap();
                let r = LoginResponse { success: true };
                let resp = match serde_json::to_string(&r) {
                    Ok(json) => HttpResponse::Ok()
                        .cookie(
                            Cookie::build("jwt", token)
                                .domain("localhost")
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
