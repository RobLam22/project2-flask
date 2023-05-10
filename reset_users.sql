DROP TABLE users;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  password_hash TEXT NOT NULL
);


-- PGPASSWORD=YsRbSGWctAQTPL8pX5sOear938QrwlLW psql -h dpg-ch8fge6si8uhth779pq0-a.oregon-postgres.render.com -U pgrender flaskdb_uiod -f reset_users.sql