use async_trait::async_trait;
use sqlx::Error;

use super::users::*;
use crate::state::AppStateRaw;

#[async_trait]
pub trait IUser: std::ops::Deref<Target = AppStateRaw> {
    async fn user_query(&self, who: &str) -> sqlx::Result<User>;
}

#[cfg(any(feature = "postgres"))]
#[async_trait]
impl IUser for &AppStateRaw {
    async fn user_query(&self, email: &str) -> sqlx::Result<User> {
        let user = sqlx::query_as!(User,
            "SELECT id, first_name, last_name, username, email, password_hash, created_date, modified_date
            FROM users
            where email = $1",
            email
        )
        .fetch_optional(&self.sql)
        .await?;

        let user = match user {
            Some(user) => user,
            None => {
                return Err(Error::RowNotFound);
            }
        };

        Ok(user)
    }
}
