use super::dao::IAccount;
use super::accounts::*;
use crate::middlewares::auth;
use crate::state::AppState;
use nonblock_logger::{debug, info};
use ntex::web::{self, get, post, Error, HttpRequest, HttpResponse, Responder};

#[post("/accounts/create")]
async fn login(form: web::types::Json<Account>, state: AppState) -> impl Responder {
    let form = form.into_inner();
}