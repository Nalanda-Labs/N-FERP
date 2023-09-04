use argon2;
use chrono::Utc;
use serde::{Deserialize, Serialize};
use uuid::Uuid;

fn passhash_verify(pass: &str, hash: &str) -> bool {
    argon2::verify_encoded(&hash, pass.as_bytes()).unwrap()
}

type SqlDateTime = chrono::DateTime<Utc>;

#[derive(Serialize, Deserialize, Debug)]
pub struct User {
    pub id: Uuid,
    pub first_name: String,
    pub last_name: String,
    pub username: String,
    pub email: String,
    // not return password
    #[serde(skip_serializing)]
    pub password_hash: String,
    pub created_date: SqlDateTime,
    pub modified_date: SqlDateTime,
    pub is_admin: bool
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
