extern crate nonblock_logger;
extern crate validator;
extern crate sqlx;
extern crate serde;

use ntex::{web, web::App, web::HttpServer};
use num_cpus;

pub mod config;
pub mod users;
pub mod middlewares;
pub mod state;

use config::{Config, Opts};

#[ntex::main]
async fn main() -> std::io::Result<()> {
    Config::show();
    let (_handle, opt) = Opts::parse_from_args();
    let state = Config::parse_from_file(&opt.config).into_state().await;
    let state2 = state.clone();
    let apiv1 = "/api/v1";

    HttpServer::new(move || {
        App::new()
            .state(state.clone())
            // we will not be sending JSON data of more than 10KB so compression is not used
            .wrap(web::middleware::Logger::default())
            // .service(web::scope(apiv1).configure(users::routes::init))
    }).workers(num_cpus::get())
    .keep_alive(300)
    .bind(&state2.config.listen)?
    .run()
    .await
}