use core::fmt;
use async_trait::async_trait;
use mobc_redis::redis::AsyncCommands;
use nonblock_logger::info;
use std::future::Future;
use actix_web::{FromRequest, HttpRequest, dev};
use serde::{Deserialize, Serialize};

use crate::state::AppStateRaw;
use crate::users::token;
use crate::users::users::User;

#[derive(Clone, Debug, PartialEq, Serialize, Deserialize)]
struct QueryParams {
    access_token: String,
}

#[derive(Debug, Serialize)]
struct ErrorResponse {
    status: String,
    message: String,
}

impl fmt::Display for ErrorResponse {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{}", serde_json::to_string(&self).unwrap())
    }
}

#[derive(Debug)]
pub struct AuthorizationService {
    pub user: User,
    pub xsrf_token: String,
}

#[async_trait]
impl FromRequest for AuthorizationService {
    type Error = actix_web::Error;
    type Future = std::pin::Pin<Box<dyn Future<Output=Result<Self,Self::Error> >  > > ;

    fn from_request(req: &HttpRequest, _payload: &mut dev::Payload) -> Self::Future {
        let state = req.app_data::<AppStateRaw>().unwrap().clone();

        let xsrf_token_header = req
            .headers()
            .get("X-XSRF-Token")
            .and_then(|h| h.to_str().ok());

        let xsrf_token = match xsrf_token_header {
            Some(x) => x.to_owned(),
            None => {
                return Box::pin(async move{Err(actix_web::error::ErrorBadRequest("Wrong XSRF token.").into())});
            }
        };

        let mut access_token = match req.cookie("access_token") {
            Some(c) => c.to_string(),
            None => {
                info!("semi step 2");
                return Box::pin(async move{Err(actix_web::error::ErrorBadRequest("Wrong XSRF token.").into())});
            }
        };

        access_token = match access_token.split_once("=") {
            Some(v) => v.1.to_owned(),
            None => {
                return Box::pin(async move{Err(actix_web::error::ErrorBadRequest("Wrong access token.").into())});
            }
        };

        info!("{:?}", access_token);
        let access_token_details = match token::verify_jwt_token(
            state.config.access_token_public_key.to_owned(),
            &access_token,
        ) {
            Ok(token_details) => token_details,
            Err(e) => {
                return Box::pin(async move{Err(actix_web::error::ErrorUnauthorized(e).into())});
            }
        };

        info!("step 3");
        let access_token_uuid =
            uuid::Uuid::parse_str(&access_token_details.token_uuid.to_string()).unwrap();
        
        if xsrf_token != access_token_uuid.clone().to_string() {
            return Box::pin(async move{Err(actix_web::error::ErrorBadRequest("Wrong XSRF token.").into())});
        }

        info!("step 4");
        // let user_id_redis_result = async move {
        Box::pin(async move{
            let mut redis_client = match state.kv.get().await {
                Ok(redis_client) => redis_client,
                Err(e) => {
                    return Err(actix_web::error::ErrorInternalServerError(ErrorResponse {
                        status: "fail".to_string(),
                        message: format!("Could not connect to Redis: {}", e),
                    }));
                }
            };

            let user_id = match redis_client
                .get::<_, String>(access_token_uuid.clone().to_string())
                .await
            {
                Ok(value) => value,
                Err(e) => {
                    return Err(actix_web::error::ErrorUnauthorized(ErrorResponse {
                        status: "fail".to_string(),
                        message: format!("Token is invalid or session has expired: {:?}", e),
                    }));
                }
            };
            let query_result =
                sqlx::query_as!(User, 
                    "SELECT id, first_name, last_name, username, email, password_hash, created_date, modified_date,
                    is_admin, status, department FROM users WHERE id = $1 and deleted=false",
                    uuid::Uuid::parse_str(&user_id).unwrap()
                )
                .fetch_optional(&state.sql)
                .await;

            match query_result {
                Ok(Some(user)) => Ok(AuthorizationService { user, xsrf_token: access_token_uuid.to_string() }),
                Ok(None) => {
                    let json_error = ErrorResponse {
                        status: "fail".to_string(),
                        message: "the user belonging to this token no logger exists".to_string(),
                    };
                    Err(actix_web::error::ErrorUnauthorized(json_error))
                }
                Err(e) => {
                    let json_error = ErrorResponse {
                        status: "error".to_string(),
                        message: format!("Faled to check user existence: {:?}", e),
                    };
                    Err(actix_web::error::ErrorInternalServerError(json_error))
                }
            }
        })
    }
}
