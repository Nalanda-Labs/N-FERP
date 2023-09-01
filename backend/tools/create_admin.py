'''
This code creates an administrative user for NERP. Note that the environment
variable for DB_DSN need to be set for this in the .env file.
'''


import sys
# one might say that uuid1 is guarateed to be unique but uuid4 is not
# however, the chance of a collision for uuid4 is really really, really low
from uuid import uuid4

import argon2
import asyncio
import asyncpg

from config import settings    


async def main(email: str, password: str) -> int:
    conn = await asyncpg.connect(settings.database_url)
    
    if len(password) < 16:
        print('Password must be minimum 16 characters free form text.')
        return 2
    
    ph = argon2.PasswordHasher()
    hash = ph.hash(password)

    await conn.execute(
        'INSERT INTO users(id, email, password_hash, username) VALUES($1, $2, $3, $4)', uuid4(), email, hash, 'admin'
    )

    await conn.close()

    print('Administrator successfully created with username "admin"')

    return 0




if __name__ == "__main__":
    if len(sys.argv) < 3:
        print('Usage: python create_admin.py <email> <password>')
        exit(1)
    else:
        asyncio.get_event_loop().run_until_complete(main(sys.argv[1], sys.argv[2]))

