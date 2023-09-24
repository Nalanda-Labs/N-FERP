use argon2;
use chrono::Utc;
use serde::{Deserialize, Serialize};
use uuid::Uuid;
use validator::Validate;

fn passhash_verify(pass: &str, hash: &str) -> bool {
    argon2::verify_encoded(&hash, pass.as_bytes()).unwrap()
}

type SqlDateTime = chrono::DateTime<Utc>;

#[derive(Serialize, Deserialize, Debug)]
#[serde(rename_all = "camelCase")]
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
    pub is_admin: bool,
    pub status: String,
    pub department: String,
}

#[derive(Serialize, Deserialize, Debug, Validate)]
pub struct Login {
    #[validate(email)]
    pub email: String,
    #[validate(length(min = 16))]
    pub password: String,
}

impl Login {
    pub fn verify(&self, hash: &str) -> bool {
        passhash_verify(&self.password, hash)
    }
}

#[derive(Serialize, Deserialize, Debug)]
pub struct UsersRequest {
    pub sort_by: String,
    pub last_record: String,
    pub ascending: bool,
}

#[derive(Serialize, Deserialize, Debug)]
#[serde(rename_all = "camelCase")]
pub struct UsersResponse {
    pub users: Vec<User>,
    pub count: u64,
}

#[derive(Serialize, Deserialize, Debug, Validate)]
#[serde(rename_all = "camelCase")]
pub struct CreateUserRequest {
    #[validate(email)]
    pub email: String,
    pub username: String,
    #[validate(length(min = 16))]
    pub password: String,
    #[validate(length(min = 16))]
    pub confirm_password: String,
    #[validate(length(min = 2))]
    pub first_name: String,
    #[validate(length(min = 2))]
    pub last_name: String,
    pub is_admin: bool,
    pub title: String,
    pub department: String,
    pub phone_home: String,
    pub phone_mobile: String,
    pub phone_work: String,
    pub phone_other: String,
    pub phone_fax: String,
    pub status: String,
    pub address_street: String,
    pub address_city: String,
    pub address_state: String,
    pub address_country: String,
    pub address_postalcode: String,
    pub employee_status: String,
    pub messanger_id: String,
    pub messanger_type: String,
    pub reports_to_id: String,
    pub factor_auth: bool,
}

#[derive(Serialize, Deserialize, Debug, Validate)]
pub struct EmailExistsRequest {
    #[validate(email)]
    pub email: String,
}

#[derive(Serialize, Deserialize, Debug, Validate)]
pub struct UsernameExistsRequest {
    pub username: String,
}

