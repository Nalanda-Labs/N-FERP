use chrono::Utc;
use serde::{Deserialize, Serialize};
use uuid::Uuid;

type SqlDateTime = chrono::DateTime<Utc>;

#[derive(Serialize, Deserialize, Debug)]
pub struct Account {

}
