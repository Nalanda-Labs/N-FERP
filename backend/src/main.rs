extern crate nonblock_logger;
extern crate serde;
extern crate sqlx;
extern crate validator;

use actix_cors::Cors;
use actix_web::{middleware, web, App, HttpServer};
use num_cpus;

// pub mod accounts;
pub mod config;
pub mod middlewares;
pub mod state;
pub mod users;
pub mod utils;

use config::{Config, Opts};

#[actix_rt::main]
async fn main() -> std::io::Result<()> {
    Config::show();
    let (_handle, opt) = Opts::parse_from_args();
    let state = Config::parse_from_file(&opt.config).into_state().await;
    let state2 = state.clone();
    let apiv1 = "/api/v1";

    HttpServer::new(move || {
        App::new()
            .wrap(
                Cors::default()
                    .allowed_origin("http://localhost:5173")
                    .allow_any_header()
                    .allow_any_method()
                    .supports_credentials()
                    .max_age(3600),
            )
            .app_data(web::Data::new(state.clone()))
            .app_data(state.clone())
            .wrap(middleware::Logger::default())
            .wrap(middleware::Compress::default())
            .service(web::scope(apiv1).configure(users::routes::init))
    })
    .workers(num_cpus::get())
    .keep_alive(std::time::Duration::from_secs(300))
    .bind(&state2.config.listen)?
    .run()
    .await
}
