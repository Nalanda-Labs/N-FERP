use super::user::*;
use crate::state::AppStateRaw;
use md5::compute;

#[async_trait]
pub trait IUser: std::ops::Deref<Target = AppStateRaw> {
    async fn user_query(&self, who: &str) -> sqlx::Result<User>;
}

#[cfg(any(feature = "postgres"))]
#[async_trait]
impl IUser for &AppStateRaw {
    async fn user_query(&self, email: &str) -> sqlx::Result<User> {
        let row = sqlx::query!(
            "SELECT id, first_name, last_name, email, phone, password_hash, email_verified, image_url, created_date
            FROM users
            where email = {};",
            email
        )
        .fetch_one(&self.sql)
        .await?;

        user = User{id.row.id, first_name: row.first_name, last_name: row.last_name, email: row.email, password_hash: row.password_hash, image_url: row.image_url, created_date: row.created_date, modified_date: row.modified_date};

        Ok(User)
    }
}
