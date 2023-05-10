DROP TABLE board_list;
DROP TABLE homepage_board;
DROP TABLE boardgame_board;
DROP TABLE macbook_board;
DROP TABLE cityscape_board;

CREATE TABLE board_list (
  id SERIAL PRIMARY KEY,
  board_name TEXT NOT NULL UNIQUE,
  description TEXT,
  is_private BOOLEAN,
  user_id_access BIGINT,
  created_by BIGINT
);

CREATE TABLE homepage_board (
  id SERIAL PRIMARY KEY,
  description TEXT,
  hashtag TEXT,
  image TEXT,
  user_id BIGINT,
  board_list_id BIGINT
);

CREATE TABLE boardgame_board (
  id SERIAL PRIMARY KEY,
  description TEXT,
  hashtag TEXT,
  image TEXT,
  user_id BIGINT,
  board_list_id BIGINT
);

CREATE TABLE macbook_board (
  id SERIAL PRIMARY KEY,
  description TEXT,
  hashtag TEXT,
  image TEXT,
  user_id BIGINT,
  board_list_id BIGINT
);

CREATE TABLE cityscape_board (
  id SERIAL PRIMARY KEY,
  description TEXT,
  hashtag TEXT,
  image TEXT,
  user_id BIGINT,
  board_list_id BIGINT
);

-- Add homepage_board and boardgame_board to board_list
INSERT INTO board_list(board_name, description, is_private, created_by) VALUES ('homepage_board',  'What a board can look like!',  FALSE, 1);
INSERT INTO board_list(board_name, description, is_private, created_by) VALUES ('boardgame_board', 'Roberts Game Collection!',     FALSE, 1);
INSERT INTO board_list(board_name, description, is_private, created_by) VALUES ('macbook_board',   'Macbook Photos!',              FALSE, 1);
INSERT INTO board_list(board_name, description, is_private, created_by) VALUES ('cityscape_board', 'Cityscape Photos!',            FALSE, 1);

-- Homepage Board
INSERT INTO homepage_board(description, hashtag, image, user_id, board_list_id) VALUES ('Landscape #0', '#landscapes', 'https://picsum.photos/id/10/200/300', 1, 1);
INSERT INTO homepage_board(description, hashtag, image, user_id, board_list_id) VALUES ('Landscape #1', '#landscapes', 'https://picsum.photos/id/11/200/300', 1, 1);
INSERT INTO homepage_board(description, hashtag, image, user_id, board_list_id) VALUES ('Landscape #2', '#landscapes', 'https://picsum.photos/id/12/200/300', 1, 1);
INSERT INTO homepage_board(description, hashtag, image, user_id, board_list_id) VALUES ('Landscape #3', '#landscapes', 'https://picsum.photos/id/13/200/300', 1, 1);
INSERT INTO homepage_board(description, hashtag, image, user_id, board_list_id) VALUES ('Landscape #4', '#landscapes', 'https://picsum.photos/id/14/200/300', 1, 1);
INSERT INTO homepage_board(description, hashtag, image, user_id, board_list_id) VALUES ('Landscape #5', '#landscapes', 'https://picsum.photos/id/15/200/300', 1, 1);
INSERT INTO homepage_board(description, hashtag, image, user_id, board_list_id) VALUES ('Landscape #6', '#landscapes', 'https://picsum.photos/id/16/200/300', 1, 1);
INSERT INTO homepage_board(description, hashtag, image, user_id, board_list_id) VALUES ('Landscape #7', '#landscapes', 'https://picsum.photos/id/17/200/300', 1, 1);
INSERT INTO homepage_board(description, hashtag, image, user_id, board_list_id) VALUES ('Landscape #8', '#landscapes', 'https://picsum.photos/id/18/200/300', 1, 1);
INSERT INTO homepage_board(description, hashtag, image, user_id, board_list_id) VALUES ('Landscape #9', '#landscapes', 'https://picsum.photos/id/19/200/300', 1, 1);

-- Roberts Boardgame_board
INSERT INTO boardgame_board(description, hashtag, image, user_id, board_list_id) VALUES ('Catan',            '#boardgame', 'https://cf.geekdo-images.com/W3Bsga_uLP9kO91gZ7H8yw__imagepage/img/M_3Vg1j2HlNgkv7PL2xl2BJE2bw=/fit-in/900x600/filters:no_upscale():strip_icc()/pic2419375.jpg', 1, 2);
INSERT INTO boardgame_board(description, hashtag, image, user_id, board_list_id) VALUES ('Ticket to Ride',   '#boardgame', 'https://cf.geekdo-images.com/ZWJg0dCdrWHxVnc0eFXK8w__imagepage/img/FcSGmLeIStNfb0l_qKSuOyz-rHY=/fit-in/900x600/filters:no_upscale():strip_icc()/pic38668.jpg', 1, 2);
INSERT INTO boardgame_board(description, hashtag, image, user_id, board_list_id) VALUES ('Scythe',           '#boardgame', 'https://cf.geekdo-images.com/7k_nOxpO9OGIjhLq2BUZdA__imagepage/img/zoz-t_z9nqqxL7OwQenbqp9PRl8=/fit-in/900x600/filters:no_upscale():strip_icc()/pic3163924.jpg', 1, 2);
INSERT INTO boardgame_board(description, hashtag, image, user_id, board_list_id) VALUES ('Yura Yura Penguin','#boardgame', 'https://cf.geekdo-images.com/yDySl7jc4Vy2Mso-GgXOag__imagepage/img/qNaJK1Tz7GHvxjLQEi--2pXsIw8=/fit-in/900x600/filters:no_upscale():strip_icc()/pic5783938.jpg', 1, 2);
INSERT INTO boardgame_board(description, hashtag, image, user_id, board_list_id) VALUES ('Cascadia',         '#boardgame', 'https://cf.geekdo-images.com/MjeJZfulbsM1DSV3DrGJYA__imagepage/img/0ksox22FKLq-Z-rsbBlF2IDG9x0=/fit-in/900x600/filters:no_upscale():strip_icc()/pic5100691.jpg', 1, 2);
INSERT INTO boardgame_board(description, hashtag, image, user_id, board_list_id) VALUES ('Ark Nova',         '#boardgame', 'https://cf.geekdo-images.com/SoU8p28Sk1s8MSvoM4N8pQ__imagepage/img/qR1EvTSNPjDa-pNPGxU9HY2oKfs=/fit-in/900x600/filters:no_upscale():strip_icc()/pic6293412.jpg', 1, 2);
INSERT INTO boardgame_board(description, hashtag, image, user_id, board_list_id) VALUES ('Earth',            '#boardgame', 'https://cf.geekdo-images.com/0xqF_KyOb7V26Lu5YT3fxw__imagepage/img/sxzhjfiLwG7mtEkRpAvsw1P5cec=/fit-in/900x600/filters:no_upscale():strip_icc()/pic6699821.jpg', 1, 2);
INSERT INTO boardgame_board(description, hashtag, image, user_id, board_list_id) VALUES ('Frosthaven',       '#boardgame', 'https://cf.geekdo-images.com/iEBr5o8AbJi9V9cgQcYROQ__imagepage/img/3h7303cwluGrIhEN6x-wNEWqbng=/fit-in/900x600/filters:no_upscale():strip_icc()/pic6177719.jpg', 1, 2);

-- Macbook Board
INSERT INTO macbook_board(description, hashtag, image, user_id, board_list_id) VALUES ('Macbook #0', '#technology', 'https://picsum.photos/id/0/300/300', 3, 1);
INSERT INTO macbook_board(description, hashtag, image, user_id, board_list_id) VALUES ('Macbook #1', '#technology', 'https://picsum.photos/id/1/300/300', 3, 1);
INSERT INTO macbook_board(description, hashtag, image, user_id, board_list_id) VALUES ('Macbook #2', '#technology', 'https://picsum.photos/id/2/300/300', 3, 1);
INSERT INTO macbook_board(description, hashtag, image, user_id, board_list_id) VALUES ('Macbook #3', '#technology', 'https://picsum.photos/id/3/300/300', 3, 1);
INSERT INTO macbook_board(description, hashtag, image, user_id, board_list_id) VALUES ('Macbook #4', '#technology', 'https://picsum.photos/id/4/300/300', 3, 1);
INSERT INTO macbook_board(description, hashtag, image, user_id, board_list_id) VALUES ('Macbook #5', '#technology', 'https://picsum.photos/id/5/300/300', 3, 1);
INSERT INTO macbook_board(description, hashtag, image, user_id, board_list_id) VALUES ('Macbook #6', '#technology', 'https://picsum.photos/id/6/300/300', 3, 1);
INSERT INTO macbook_board(description, hashtag, image, user_id, board_list_id) VALUES ('Macbook #7', '#technology', 'https://picsum.photos/id/7/300/300', 3, 1);
INSERT INTO macbook_board(description, hashtag, image, user_id, board_list_id) VALUES ('Macbook #8', '#technology', 'https://picsum.photos/id/8/300/300', 3, 1);
INSERT INTO macbook_board(description, hashtag, image, user_id, board_list_id) VALUES ('Macbook #9', '#technology', 'https://picsum.photos/id/9/300/300', 3, 1);

-- Cityscape Board
INSERT INTO cityscape_board(description, hashtag, image, user_id, board_list_id) VALUES ('City #0', '#city', 'https://picsum.photos/id/232/300/500', 3, 1);
INSERT INTO cityscape_board(description, hashtag, image, user_id, board_list_id) VALUES ('City #1', '#city', 'https://picsum.photos/id/233/300/500', 3, 1);
INSERT INTO cityscape_board(description, hashtag, image, user_id, board_list_id) VALUES ('City #2', '#city', 'https://picsum.photos/id/234/300/500', 3, 1);
INSERT INTO cityscape_board(description, hashtag, image, user_id, board_list_id) VALUES ('City #3', '#city', 'https://picsum.photos/id/236/300/500', 3, 1);
INSERT INTO cityscape_board(description, hashtag, image, user_id, board_list_id) VALUES ('City #4', '#city', 'https://picsum.photos/id/238/300/500', 3, 1);
INSERT INTO cityscape_board(description, hashtag, image, user_id, board_list_id) VALUES ('City #5', '#city', 'https://picsum.photos/id/240/300/500', 3, 1);
INSERT INTO cityscape_board(description, hashtag, image, user_id, board_list_id) VALUES ('City #6', '#city', 'https://picsum.photos/id/242/300/500', 3, 1);
INSERT INTO cityscape_board(description, hashtag, image, user_id, board_list_id) VALUES ('City #7', '#city', 'https://picsum.photos/id/249/300/500', 3, 1);
INSERT INTO cityscape_board(description, hashtag, image, user_id, board_list_id) VALUES ('City #8', '#city', 'https://picsum.photos/id/257/300/500', 3, 1);
INSERT INTO cityscape_board(description, hashtag, image, user_id, board_list_id) VALUES ('City #9', '#city', 'https://picsum.photos/id/259/300/500', 3, 1);


-- psql -d p2 -f reset_db.sql -p 5433
-- PGPASSWORD=YsRbSGWctAQTPL8pX5sOear938QrwlLW psql -h dpg-ch8fge6si8uhth779pq0-a.oregon-postgres.render.com -U pgrender -f reset_db.sql flaskdb_uiod 