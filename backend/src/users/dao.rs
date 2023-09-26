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
    async fn email_exists(&self, email: &str) -> sqlx::Result<bool>;
    async fn username_exists(&self, username: &str) -> sqlx::Result<bool>;
    async fn create_user(&self, req: &CreateUserRequest) -> sqlx::Result<String>;
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

        let mut sort_by_col = sort_by;

        if sort_by == "" {
            sort_by_col = "first_name";
        }

        let q: String;

        if ascending {
            q = format!(
                "SELECT id, first_name, last_name, username, email, password_hash, created_date,
                modified_date, is_admin, status, department
                FROM users where deleted=false and {sort_by_col} > '{last_record}' order by {sort_by_col} limit {results_per_page}",
                sort_by_col=sort_by_col, last_record=last_record, results_per_page=self.config.results_per_page
            );
        } else {
            q = format!(
                "SELECT id, first_name, last_name, username, email, password_hash, created_date,
                modified_date, is_admin, status, department
                FROM users where deleted=false and {sort_by_col} < '{last_record}' order by {sort_by_col} DESC limit {results_per_page}",
                sort_by_col=sort_by_col, last_record=last_record, results_per_page=self.config.results_per_page
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

    async fn email_exists(&self, email: &str) -> sqlx::Result<bool> {
        let row = sqlx::query!(
            r#"
            SELECT email from users where email=$1
            "#,
            email
        )
        .fetch_optional(&self.sql)
        .await?;

        let email = match row {
            Some(s) => s.email,
            None => "".to_owned(),
        };

        if email != "" {
            Ok(true)
        } else {
            Ok(false)
        }
    }

    async fn username_exists(&self, username: &str) -> sqlx::Result<bool> {
        let row = sqlx::query!(
            r#"
            SELECT username from users where username=$1
            "#,
            username
        )
        .fetch_optional(&self.sql)
        .await?;

        let username = match row {
            Some(s) => s.username,
            None => "".to_owned(),
        };

        if username != "" {
            Ok(true)
        } else {
            Ok(false)
        }
    }

    async fn create_user(&self, req: &CreateUserRequest) -> sqlx::Result<String> {
        let mut tx = self.sql.begin().await?;

        let r = sqlx::query!(
            r#"
            SELECT id from users where username=$1
            "#,
            req.reports_to_id
        )
        .fetch_optional(&mut *tx)
        .await?;

        let reports_to_id = match r {
            Some(rec) => match rec.id {
                id => id.to_string(),
            },
            None => "".to_owned(),
        };

        let id = uuid::Uuid::new_v4();
        let password_hash = passhash(&req.password);

        if reports_to_id != "" {
            let reports_to = uuid::Uuid::parse_str(&reports_to_id).unwrap();
            sqlx::query!(
                r#"
                INSERT into users(id, email, password_hash, pwd_last_changed, first_name, last_name, username,
                is_admin, title, department, phone_home, phone_mobile, phone_work, phone_other, phone_fax,
                status, address_street, address_city, address_state, address_country, address_postalcode,
                reports_to_id, factor_auth, whatsapp, telegram)
                VALUES($1, $2, $3, now(), $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17,
                $18, $19, $20, $21, $22, $23, $24)
                "#,
                id, &req.email, &password_hash, &req.first_name, &req.last_name, &req.username,
                &req.is_admin, &req.title, &req.department, &req.phone_home, &req.phone_mobile,
                &req.phone_work, &req.phone_other, &req.phone_fax, &req.status, &req.address_street,
                &req.address_city, &req.address_state, &req.address_country, &req.address_postalcode,
                reports_to, req.factor_auth, &req.whatsapp, &req.telegram
            )
            .execute(&mut *tx)
            .await?;
        } else {
            sqlx::query!(
                r#"
                INSERT into users(id, email, password_hash, pwd_last_changed, first_name, last_name, username,
                is_admin, title, department, phone_home, phone_mobile, phone_work, phone_other, phone_fax,
                status, address_street, address_city, address_state, address_country, address_postalcode,
                factor_auth, whatsapp, telegram)
                VALUES($1, $2, $3, now(), $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17,
                $18, $19, $20, $21, $22, $23)
                "#,
                id, &req.email, &password_hash, &req.first_name, &req.last_name, &req.username,
                &req.is_admin, &req.title, &req.department, &req.phone_home, &req.phone_mobile,
                &req.phone_work, &req.phone_other, &req.phone_fax, &req.status, &req.address_street,
                &req.address_city, &req.address_state, &req.address_country, &req.address_postalcode,
                req.factor_auth, &req.whatsapp, &req.telegram
            )
            .execute(&mut *tx)
            .await?;
        }

        tx.commit().await?;
        return Ok(id.to_string());

    }
}
