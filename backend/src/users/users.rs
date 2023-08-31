use argon2::{self, Config};
use chrono::Utc;
use rand::Rng;
use ring::digest;
use serde::{Deserialize, Serialize};
use uuid::Uuid;

fn passhash(email: &str, pass: &str) -> String {
    let config = Config::default();
    const CREDENTIAL_LEN: usize = digest::SHA256_OUTPUT_LEN;
    let salt = rand::thread_rng().gen::<[u8; CREDENTIAL_LEN]>();
    let hash = argon2::hash_encoded(pass.as_bytes(), &salt, &config).unwrap();
    hash
}

fn passhash_verify(pass: &str, hash: &str) -> bool {
    argon2::verify_encoded(&hash, pass.as_bytes()).unwrap()
}

type SqlDateTime = chrono::DateTime<Utc>;

#[derive(Serialize, Deserialize, Debug)]
pub struct User {
    pub id: Uuid,
    pub phone: String,
    pub first_name: String,
    pub last_name: String,
    pub email: String,
    // not return password
    #[serde(skip_serializing)]
    pub password_hash: String,
    pub image_url: String,
    pub email_verified: bool,
    pub created_date: SqlDateTime,
    pub modified_date: SqlDateTime,
}

#[derive(Serialize, Deserialize, Debug)]
pub struct Login {
    pub email: String,
    pub password: String,
    #[serde(default)]
    pub rememberme: bool,
}

impl Login {
    pub fn verify(&self, hash: &str) -> bool {
        passhash_verify(&self.password, hash)
    }
}

#[derive(Debug, Default, Serialize, Deserialize)]
pub struct Claims {
    // email
    pub sub: String,
    pub exp: usize,
    pub email: String,
    pub id: i64,
    pub xsrf_token: String,
    pub image_url: String,
}
