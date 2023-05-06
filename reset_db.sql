-- DROP TABLE food;
-- DROP TABLE users;


CREATE TABLE board_list (
  id SERIAL PRIMARY KEY,
  board_name TEXT NOT NULL UNIQUE,
  description TEXT,
  private BOOLEAN,
  user_access TEXT
);

CREATE TABLE homepage_board (
  id SERIAL PRIMARY KEY,
  description TEXT,
  hashtag TEXT,
  url TEXT
);

CREATE TABLE boardgame_board (
  id SERIAL PRIMARY KEY,
  description TEXT,
  hashtag TEXT,
  url TEXT
);

-- Add homepage_board and boardgame_board to board_list
INSERT INTO board_list(board_name, description, private) VALUES ('homepage_board', 'What a board can look like!', FALSE);
INSERT INTO board_list(board_name, description, private, user_access) VALUES ('boardgame_board', 'Roberts Game Collection!', FALSE, 'robert@email.com');

-- Example Board
INSERT INTO boardgame_board(item, price, category, image) VALUES ('Catan',     'boardgame',  'light',  'https://www.wandercooks.com/wp-content/uploads/2019/09/takoyaki-recipe-2.jpg');
INSERT INTO boardgame_board(item, price, category, image) VALUES ('Scythe',        '1200', 'light',  'https://www.wandercooks.com/wp-content/uploads/2020/10/okonomiyaki-japanese-pancake-recipe-3-683x1024.jpg');
INSERT INTO boardgame_board(item, price, category, image) VALUES ('Wingspan',    '1400', 'light',  'https://rasamalaysia.com/wp-content/uploads/2021/07/chicken-karaage1-730x1095.jpg');
INSERT INTO boardgame_board(item, price, category, image) VALUES ('Jenga',         '1500', 'light',  'https://allwaysdelicious.com/wp-content/uploads/2015/01/char-siu-bao-1.jpg');

-- PGPASSWORD=YsRbSGWctAQTPL8pX5sOear938QrwlLW psql -h dpg-ch8fge6si8uhth779pq0-a.oregon-postgres.render.com -U pgrender -f reset_db.sql flaskdb_uiod 