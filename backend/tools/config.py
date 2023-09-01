from asyncpg import Pool
from pydantic import BaseSettings, PostgresDsn
from typing import Optional


class Settings(BaseSettings):
    database_url: PostgresDsn

    class Config:
        # adjust this to match the env file
        env_file = '../.env'
        env_file_encoding = 'utf-8'

settings = Settings(_env_file_encoding='utf-8')

db_pool: Optional[Pool] = None

