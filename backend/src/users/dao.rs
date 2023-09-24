use async_trait::async_trait;
use nonblock_logger::info;
use sqlx::{Error, Row};

use super::users::*;
use crate::state::AppStateRaw;

#[async_trait]
pub trait IUser: std::ops::Deref<Target = AppStateRaw> {
    async fn user_query(&self, who: &str) -> sqlx::Result<User>;
    async fn users(
        &self,
        sort_by: &str,
        last_record: &str,
        ascending: bool,
    ) -> sqlx::Result<(Vec<User>, u64)>;
    async fn email_exists(&self, email: &str) ->sqlx::Result<bool>;
}

#[cfg(any(feature = "postgres"))]
#[async_trait]
impl IUser for &AppStateRaw {
    async fn user_query(&self, email: &str) -> sqlx::Result<User> {
        let user = sqlx::query_as!(
            User,
            r#"SELECT id, first_name, last_name, username, email, password_hash, created_date,
            modified_date, is_admin, status, department
            FROM users
            where email = $1 and deleted=false"#,
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

        info!("User found   ");
        Ok(user)
    }

    async fn users(
        &self,
        sort_by: &str,
        last_record: &str,
        ascending: bool,
    ) -> sqlx::Result<(Vec<User>, u64)> {
        let res = sqlx::query!(
            r#"
                select count(1) from users where deleted=false;
            "#,
        )
        .fetch_one(&self.sql)
        .await?;

        let count = match res.count {
            Some(c) => c as u64,
            None => 0 as u64,
        };

        let q: String;

        if ascending {
            q = format!(
                "SELECT id, first_name, last_name, username, email, password_hash, created_date,
                modified_date, is_admin, status, department
                FROM users where deleted=false and {sort_by} > '{last_record}' order by {sort_by} limit {results_per_page}",
                sort_by=sort_by, last_record=last_record, results_per_page=self.config.results_per_page
            );
        } else {
            q = format!(
                "SELECT id, first_name, last_name, username, email, password_hash, created_date,
                modified_date, is_admin, status, department
                FROM users where deleted=false and {sort_by} < '{last_record}' order by {sort_by} DESC limit {results_per_page}",
                sort_by=sort_by, last_record=last_record, results_per_page=self.config.results_per_page
            );
        }

        let res1 = sqlx::query(&q).fetch_all(&self.sql).await?;

        let mut users: Vec<User> = Vec::new();
        for r in res1 {
            let user: User = User {
                id: r.try_get("id")?,
                first_name: r.try_get("first_name")?,
                last_name: r.try_get("last_name")?,
                username: r.try_get("username")?,
                email: r.try_get("email")?,
                password_hash: r.try_get("password_hash")?,
                created_date: r.try_get("created_date")?,
                modified_date: r.try_get("modified_date")?,
                is_admin: r.try_get("is_admin")?,
                status: r.try_get("status")?,
                department: r.try_get("department")?,
            };
            users.push(user);
        }

        Ok((users, count))
    }

    async fn email_exists(&self, email: &str) ->sqlx::Result<bool> {
        let row = sqlx::query!(
            r#"
            SELECT email from users where email=$1
            "#,
            email
        ).fetch_optional(&self.sql).await?;

        let email = match row {
            Some(s) => s.email,
            None => "".to_owned()
        };

        if email != "" {
            Ok(true)
        } else {
            Ok(false)
        }
    }
}
