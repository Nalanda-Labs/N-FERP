use std::time::{SystemTime, UNIX_EPOCH};

use jsonwebtoken::{decode, Algorithm, DecodingKey, Validation};
use nonblock_logger::error;
use ntex::http::HttpMessage;
use ntex::util::Ready;
use ntex::web::{FromRequest, HttpRequest};
use serde::{Deserialize, Serialize};

use crate::state::AppStateRaw;
use crate::users::users::Claims;

#[derive(Clone, Debug, PartialEq, Serialize, Deserialize)]
struct QueryParams {
    access_token: String,
}

#[derive(Debug)]
pub struct AuthorizationService {
    pub claims: Claims,
    pub xsrf_token: String,
}

impl<Err> FromRequest<Err> for AuthorizationService {
    type Error = ntex::web::Error;
    type Future = Ready<AuthorizationService, Self::Error>;

    fn from_request(req: &HttpRequest, _payload: &mut ntex::http::Payload) -> Self::Future {
        let xsrf_token_header = req
            .headers()
            .get("X-XSRF-Token")
            .and_then(|h| h.to_str().ok());

        let xsrf_token = match xsrf_token_header {
            Some(x) => x.to_owned(),
            None => "".to_owned(),
        };

        let token = match req.cookie("jwt") {
            Some(c) => c.to_string(),
            None => "".to_owned(),
        };

        let state = req.app_state::<AppStateRaw>().expect("get AppStateRaw");
        let key = state.config.jwt_priv.as_bytes();

        match decode::<Claims>(
            &token,
            &DecodingKey::from_secret(key),
            &Validation::new(Algorithm::HS256),
        ) {
            Ok(claims) => {
                if claims.claims.xsrf_token != xsrf_token {
                    Ready::Err(ntex::web::error::ErrorUnauthorized("Mismatched tokens.").into())
                } else {
                    let start = SystemTime::now()
                        .duration_since(UNIX_EPOCH)
                        .unwrap()
                        .as_secs() as usize;

                    if claims.claims.exp < start {
                        Ready::Err(ntex::web::error::ErrorUnauthorized("JWT has expired").into())
                    } else {
                        Ready::Ok(AuthorizationService {
                            claims: claims.claims,
                            xsrf_token: xsrf_token,
                        })
                    }
                }
            }
            Err(e) => {
                error!("jwt.decode {} failed: {:?}", token, e);
                Ready::Err(ntex::web::error::ErrorBadRequest("Decoding failed.").into())
            }
        }
    }
}
