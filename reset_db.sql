-- DROP TABLE food;
-- DROP TABLE users;

DROP TABLE board_list;
DROP TABLE homepage_board;
DROP TABLE boardgame_board;

CREATE TABLE board_list (
  id SERIAL PRIMARY KEY,
  board_name TEXT NOT NULL UNIQUE,
  description TEXT,
  is_private BOOLEAN,
  user_id_access BIGINT
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

-- Add homepage_board and boardgame_board to board_list
INSERT INTO board_list(board_name, description, is_private) VALUES ('homepage_board',  'What a board can look like!', FALSE);
INSERT INTO board_list(board_name, description, is_private) VALUES ('boardgame_board', 'Roberts Game Collection!',    TRUE);

-- Homepage Board
INSERT INTO boardgame_board(description, hashtag, image, user_id, board_list_id) VALUES ('Example Image', 'Landscapes', 'https://picsum.photos/id/10/200/300', 1, 1);
INSERT INTO boardgame_board(description, hashtag, image, user_id, board_list_id) VALUES ('Example Image', 'Landscapes', 'https://picsum.photos/id/11/200/300', 1, 1);
INSERT INTO boardgame_board(description, hashtag, image, user_id, board_list_id) VALUES ('Example Image', 'Landscapes', 'https://picsum.photos/id/12/200/300', 1, 1);
INSERT INTO boardgame_board(description, hashtag, image, user_id, board_list_id) VALUES ('Example Image', 'Landscapes', 'https://picsum.photos/id/13/200/300', 1, 1);
INSERT INTO boardgame_board(description, hashtag, image, user_id, board_list_id) VALUES ('Example Image', 'Landscapes', 'https://picsum.photos/id/14/200/300', 1, 1);
INSERT INTO boardgame_board(description, hashtag, image, user_id, board_list_id) VALUES ('Example Image', 'Landscapes', 'https://picsum.photos/id/15/200/300', 1, 1);
INSERT INTO boardgame_board(description, hashtag, image, user_id, board_list_id) VALUES ('Example Image', 'Landscapes', 'https://picsum.photos/id/16/200/300', 1, 1);
INSERT INTO boardgame_board(description, hashtag, image, user_id, board_list_id) VALUES ('Example Image', 'Landscapes', 'https://picsum.photos/id/17/200/300', 1, 1);
INSERT INTO boardgame_board(description, hashtag, image, user_id, board_list_id) VALUES ('Example Image', 'Landscapes', 'https://picsum.photos/id/18/200/300', 1, 1);
INSERT INTO boardgame_board(description, hashtag, image, user_id, board_list_id) VALUES ('Example Image', 'Landscapes', 'https://picsum.photos/id/19/200/300', 1, 1);

-- Roberts Boardgame_board
INSERT INTO boardgame_board(description, hashtag, image, user_id, board_list_id) VALUES ('Catan',            'boardgame', 'https://cf.geekdo-images.com/W3Bsga_uLP9kO91gZ7H8yw__imagepage/img/M_3Vg1j2HlNgkv7PL2xl2BJE2bw=/fit-in/900x600/filters:no_upscale():strip_icc()/pic2419375.jpg', 1, 2);
INSERT INTO boardgame_board(description, hashtag, image, user_id, board_list_id) VALUES ('Ticket to Ride',   'boardgame', 'https://cf.geekdo-images.com/ZWJg0dCdrWHxVnc0eFXK8w__imagepage/img/FcSGmLeIStNfb0l_qKSuOyz-rHY=/fit-in/900x600/filters:no_upscale():strip_icc()/pic38668.jpg', 1, 2);
INSERT INTO boardgame_board(description, hashtag, image, user_id, board_list_id) VALUES ('Wingspan',         'boardgame', 'https://cf.geekdo-images.com/7k_nOxpO9OGIjhLq2BUZdA__imagepage/img/zoz-t_z9nqqxL7OwQenbqp9PRl8=/fit-in/900x600/filters:no_upscale():strip_icc()/pic3163924.jpght', 1, 2);
INSERT INTO boardgame_board(description, hashtag, image, user_id, board_list_id) VALUES ('Yura Yura Penguin','boardgame', 'https://cf.geekdo-images.com/yDySl7jc4Vy2Mso-GgXOag__imagepage/img/qNaJK1Tz7GHvxjLQEi--2pXsIw8=/fit-in/900x600/filters:no_upscale():strip_icc()/pic5783938.jpg', 1, 2);

-- PGPASSWORD=YsRbSGWctAQTPL8pX5sOear938QrwlLW psql -h dpg-ch8fge6si8uhth779pq0-a.oregon-postgres.render.com -U pgrender -f reset_db.sql flaskdb_uiod 