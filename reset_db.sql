DROP TABLE board_list;
DROP TABLE homepage_board;
DROP TABLE boardgame_board;
DROP TABLE macbook_board;
DROP TABLE cityscape_board;
DROP TABLE marvel_movies;

CREATE TABLE board_list (
  id SERIAL PRIMARY KEY,
  board_name TEXT NOT NULL UNIQUE,
  description TEXT,
  is_private BOOLEAN,
  user_id_access TEXT,
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

CREATE TABLE marvel_movies (
  id SERIAL PRIMARY KEY,
  description TEXT,
  hashtag TEXT,
  image TEXT,
  user_id BIGINT,
  board_list_id BIGINT
);

CREATE TABLE dc_movies (
  id SERIAL PRIMARY KEY,
  description TEXT,
  hashtag TEXT,
  image TEXT,
  user_id BIGINT,
  board_list_id BIGINT
);

CREATE TABLE wes_anderson_symmetry (
  id SERIAL PRIMARY KEY,
  description TEXT,
  hashtag TEXT,
  image TEXT,
  user_id BIGINT,
  board_list_id BIGINT
);

CREATE TABLE doggos (
  id SERIAL PRIMARY KEY,
  description TEXT,
  hashtag TEXT,
  image TEXT,
  user_id BIGINT,
  board_list_id BIGINT
);

CREATE TABLE noodles (
  id SERIAL PRIMARY KEY,
  description TEXT,
  hashtag TEXT,
  image TEXT,
  user_id BIGINT,
  board_list_id BIGINT
);

CREATE TABLE anime (
  id SERIAL PRIMARY KEY,
  description TEXT,
  hashtag TEXT,
  image TEXT,
  user_id BIGINT,
  board_list_id BIGINT
);

-- Add homepage_board and boardgame_board to board_list
INSERT INTO board_list(board_name, description, is_private, created_by) VALUES ('homepage_board',  'What a board can look like!',  FALSE, 1);
INSERT INTO board_list(board_name, description, is_private, user_id_access, created_by) VALUES ('boardgame_board', 'Roberts Game Collection!',  TRUE,'1,2', 1);
INSERT INTO board_list(board_name, description, is_private, created_by) VALUES ('macbook_board',   'Macbook Photos!',              FALSE, 1);
INSERT INTO board_list(board_name, description, is_private, created_by) VALUES ('cityscape_board', 'Cityscape Photos!',            FALSE, 1);
INSERT INTO board_list(board_name, description, is_private, user_id_access, created_by) VALUES ('marvel_movies',   'Marvel Movies!',  TRUE, '2', 2);
INSERT INTO board_list(board_name, description, is_private, created_by) VALUES ('dc_movies',        'DC Movies!',                        FALSE, 2);
INSERT INTO board_list(board_name, description, is_private, created_by) VALUES ('wes_anderson_symmetry', 'Stills of Wes Anderon Movies!',FALSE, 2);
INSERT INTO board_list(board_name, description, is_private, created_by) VALUES ('doggos', 'Doggos!',            FALSE, 3);
INSERT INTO board_list(board_name, description, is_private, created_by) VALUES ('noodles', 'Asian Noodles!',    FALSE, 3);
INSERT INTO board_list(board_name, description, is_private, created_by) VALUES ('anime', 'NAISUUUUU!',            FALSE, 3);

-- marvel
INSERT INTO marvel_movies(description, hashtag, image, user_id, board_list_id) VALUES ('Avengers', '#film#marvel#superhero', 'https://upload.wikimedia.org/wikipedia/en/8/8a/The_Avengers_%282012_film%29_poster.jpg', 2,   6);
INSERT INTO marvel_movies(description, hashtag, image, user_id, board_list_id) VALUES ('No Way Home', '#film#marvel#superhero', 'https://upload.wikimedia.org/wikipedia/en/0/00/Spider-Man_No_Way_Home_poster.jpg', 2,   6);
INSERT INTO marvel_movies(description, hashtag, image, user_id, board_list_id) VALUES ('GotG3', '#film#marvel#superhero', 'https://upload.wikimedia.org/wikipedia/en/7/74/Guardians_of_the_Galaxy_Vol._3_poster.jpg', 2,   6);
INSERT INTO marvel_movies(description, hashtag, image, user_id, board_list_id) VALUES ('Iron Man', '#film#marvel#superhero', 'https://upload.wikimedia.org/wikipedia/en/0/02/Iron_Man_%282008_film%29_poster.jpg', 2, 6);

-- dc
INSERT INTO dc_movies(description, hashtag, image, user_id, board_list_id) VALUES ('Flash', '#film#dc#superhero', 'https://upload.wikimedia.org/wikipedia/en/e/ed/The_Flash_%28film%29_poster.jpg', 2,   6);
INSERT INTO dc_movies(description, hashtag, image, user_id, board_list_id) VALUES ('MoS', '#film#dc#superhero', 'https://upload.wikimedia.org/wikipedia/en/5/50/Man_of_Steel_%28film%29_poster.jpg', 2,   6);
INSERT INTO dc_movies(description, hashtag, image, user_id, board_list_id) VALUES ('BvS', '#film#dc#superhero', 'https://upload.wikimedia.org/wikipedia/en/3/31/superhero_v_Superman_Dawn_of_Justice_poster.jpg', 2,   6);
INSERT INTO dc_movies(description, hashtag, image, user_id, board_list_id) VALUES ('WW', '#film#dc#batman', 'https://upload.wikimedia.org/wikipedia/en/b/b0/Wonder_Woman_%282017_film%29_poster.jpg', 2, 6);

-- wes
INSERT INTO wes_anderson_symmetry(description, hashtag, image, user_id, board_list_id) VALUES ('GBH', '#film#wes#symmetry', 'https://static.wixstatic.com/media/d291ba_18b4d8c74047424690ad9eed707cadf1~mv2.jpg/v1/fill/w_970,h_595,al_c,q_85,enc_auto/d291ba_18b4d8c74047424690ad9eed707cadf1~mv2.jpg', 2,   7);
INSERT INTO wes_anderson_symmetry(description, hashtag, image, user_id, board_list_id) VALUES ('GBH', '#film#wes#symmetry', 'https://static.wixstatic.com/media/d291ba_3c462da3b3054c9b959f44ac30abe142~mv2.jpg/v1/fill/w_873,h_492,al_c,lg_1,q_85,enc_auto/d291ba_3c462da3b3054c9b959f44ac30abe142~mv2.jpg', 2,   7);
INSERT INTO wes_anderson_symmetry(description, hashtag, image, user_id, board_list_id) VALUES ('FMF', '#film#wes#symmetry', 'https://i0.wp.com/www.aesdes.org/wp-content/uploads/2023/03/Capture42-1.png?w=1920&ssl=1', 2,   7);
INSERT INTO wes_anderson_symmetry(description, hashtag, image, user_id, board_list_id) VALUES ('FMF', '#film#wes#symmetry', 'https://i0.wp.com/www.aesdes.org/wp-content/uploads/2023/03/Capture7.png?w=1920&ssl=1', 2, 7);
INSERT INTO wes_anderson_symmetry(description, hashtag, image, user_id, board_list_id) VALUES ('IOF', '#film#wes#symmetry', 'https://i0.wp.com/www.aesdes.org/wp-content/uploads/2023/03/Capture14.png?w=1920&ssl=1', 2, 7);

-- noodles
INSERT INTO doggos(description, hashtag, image, user_id, board_list_id) VALUES ('Border Collie', '#dogs#animals#pets', 'https://en.wikipedia.org/wiki/File:Blue_Merle_Border_Collie._Female.jpg', 3,   8);
INSERT INTO doggos(description, hashtag, image, user_id, board_list_id) VALUES ('German Shepherd', '#dogs#animals#pets', 'https://dogtime.com/assets/uploads/gallery/german-shepherd-dog-breed-pictures/standing-7.jpg', 3,   8);
INSERT INTO doggos(description, hashtag, image, user_id, board_list_id) VALUES ('Corgi', '#dogs#animals#pets', 'https://en.wikipedia.org/wiki/File:Welchcorgipembroke.JPG', 3,   8);
INSERT INTO doggos(description, hashtag, image, user_id, board_list_id) VALUES ('Golden Retriever', '#dogs#animals#pets', 'https://upload.wikimedia.org/wikipedia/commons/b/bd/Golden_Retriever_Dukedestiny01_drvd.jpg', 3, 8);
INSERT INTO doggos(description, hashtag, image, user_id, board_list_id) VALUES ('Samoyed', '#dogs#animals#pets', 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/18/Samojed00.jpg/1280px-Samojed00.jpg', 3, 8);

-- noodles
INSERT INTO anime(description, hashtag, image, user_id, board_list_id) VALUES ('Ramen', '#noodles#asian#food', 'https://www.forkknifeswoon.com/wp-content/uploads/2014/10/simple-homemade-chicken-ramen-fork-knife-swoon-01.jpg', 3,   9);
INSERT INTO anime(description, hashtag, image, user_id, board_list_id) VALUES ('Tonkotsu', '#noodles#asian#food', 'https://www.seriouseats.com/thmb/VRNLs0nXGchoBlj5LJ5hxCzlcbU=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/rich-and-creamy-tonkotsu-ramen-broth-from-scratch-recipe-Diana-Chistruga-hero-6d318fadcca64cc9ac3e1c40fc7682fb.JPG', 3,   9);
INSERT INTO anime(description, hashtag, image, user_id, board_list_id) VALUES ('Yakisoba', '#noodles#asian#food', 'https://www.jocooks.com/wp-content/uploads/2021/06/yakisoba-1-11.jpg', 3,   9);
INSERT INTO anime(description, hashtag, image, user_id, board_list_id) VALUES ('Wonton Noodle Soup', '#noodles#asian#food', 'https://www.elmundoeats.com/wp-content/uploads/2022/10/Wonton-noodle-soup-in-a-bowl-view-from-up.jpg', 3, 9);
INSERT INTO anime(description, hashtag, image, user_id, board_list_id) VALUES ('Dan Dan Noodles', '#noodles#asian#food', 'https://www.recipetineats.com/wp-content/uploads/2020/02/Dan-Dan-Noodles_4-2.jpg', 3, 9);

-- anime
INSERT INTO anime(description, hashtag, image, user_id, board_list_id) VALUES ('Naruto', '#naruto#shonen#japanese', 'https://en.wikipedia.org/wiki/File:NarutoCoverTankobon1.jpg', 3,   10);
INSERT INTO anime(description, hashtag, image, user_id, board_list_id) VALUES ('Susanoooo', '#naruto#shonen#japanese', 'https://i.redd.it/9u15zs27u7w61.jpg', 3,   10);
INSERT INTO anime(description, hashtag, image, user_id, board_list_id) VALUES ('Bleach', '#bleach#shonen#bloodwar', 'https://www.animenewsnetwork.com/images/encyc/A25066-825432658.1659822888.jpg', 3,   10);
INSERT INTO anime(description, hashtag, image, user_id, board_list_id) VALUES ('Captains', '#bleach#shonen#bloodwar', 'https://wall.alphacoders.com/big.php?i=1255445', 3,   10);
INSERT INTO anime(description, hashtag, image, user_id, board_list_id) VALUES ('Princess Mononoke', '#ghibli#animated#japanese', 'https://upload.wikimedia.org/wikipedia/en/8/8c/Princess_Mononoke_Japanese_poster.png', 3, 10);
INSERT INTO anime(description, hashtag, image, user_id, board_list_id) VALUES ('Howls Moving Castle', '#ghibli#animated#japanese', 'https://upload.wikimedia.org/wikipedia/en/a/a0/Howls-moving-castleposter.jpg', 3, 10);
INSERT INTO anime(description, hashtag, image, user_id, board_list_id) VALUES ('Spirited Away', '#ghibli#animated#japanese', 'https://upload.wikimedia.org/wikipedia/en/d/db/Spirited_Away_Japanese_poster.png', 3, 10);
INSERT INTO anime(description, hashtag, image, user_id, board_list_id) VALUES ('Demon Slayer', '#demonslayer#nature#japanese', 'https://upload.wikimedia.org/wikipedia/en/6/6c/DemonSlayerKimetsukeyvisual.jpg', 3, 10);
INSERT INTO anime(description, hashtag, image, user_id, board_list_id) VALUES ('Mugen Train', '#demonslayer#nature#kimetsunoyaiba', 'https://upload.wikimedia.org/wikipedia/en/2/21/Kimetsu_no_Yaiba_Mugen_Ressha_Hen_Poster.jpg', 3, 10);

-- Homepage Board
INSERT INTO homepage_board(description, hashtag, image, user_id, board_list_id) VALUES ('Landscape #1', '#landscapes#nature#photography', 'https://picsum.photos/id/11/200/300', 1, 1);
INSERT INTO homepage_board(description, hashtag, image, user_id, board_list_id) VALUES ('Landscape #2', '#landscapes#nature#photography', 'https://picsum.photos/id/12/200/300', 1, 1);
INSERT INTO homepage_board(description, hashtag, image, user_id, board_list_id) VALUES ('Landscape #3', '#landscapes#nature#photography', 'https://picsum.photos/id/13/200/300', 1, 1);
INSERT INTO homepage_board(description, hashtag, image, user_id, board_list_id) VALUES ('Landscape #4', '#landscapes#nature#photography', 'https://picsum.photos/id/14/200/300', 1, 1);
INSERT INTO homepage_board(description, hashtag, image, user_id, board_list_id) VALUES ('Landscape #5', '#landscapes#nature#photography', 'https://picsum.photos/id/15/200/300', 1, 1);
INSERT INTO homepage_board(description, hashtag, image, user_id, board_list_id) VALUES ('Landscape #6', '#landscapes#nature#photography', 'https://picsum.photos/id/16/200/300', 1, 1);
INSERT INTO homepage_board(description, hashtag, image, user_id, board_list_id) VALUES ('Landscape #7', '#landscapes#nature#photography', 'https://picsum.photos/id/17/200/300', 1, 1);
INSERT INTO homepage_board(description, hashtag, image, user_id, board_list_id) VALUES ('Landscape #8', '#landscapes#nature#photography', 'https://picsum.photos/id/18/200/300', 1, 1);
INSERT INTO homepage_board(description, hashtag, image, user_id, board_list_id) VALUES ('Landscape #9', '#landscapes#nature#photography', 'https://picsum.photos/id/19/200/300', 1, 1);
INSERT INTO homepage_board(description, hashtag, image, user_id, board_list_id) VALUES ('Landscape #10','#landscapes#nature#photography','https://picsum.photos/id/10/200/300', 1, 1);

-- Roberts Boardgame_board
INSERT INTO boardgame_board(description, hashtag, image, user_id, board_list_id) VALUES ('Catan',            '#boardgame#tabletop#meeples', 'https://cf.geekdo-images.com/W3Bsga_uLP9kO91gZ7H8yw__imagepage/img/M_3Vg1j2HlNgkv7PL2xl2BJE2bw=/fit-in/900x600/filters:no_upscale():strip_icc()/pic2419375.jpg', 1, 2);
INSERT INTO boardgame_board(description, hashtag, image, user_id, board_list_id) VALUES ('Ticket to Ride',   '#boardgame#tabletop#meeples', 'https://cf.geekdo-images.com/ZWJg0dCdrWHxVnc0eFXK8w__imagepage/img/FcSGmLeIStNfb0l_qKSuOyz-rHY=/fit-in/900x600/filters:no_upscale():strip_icc()/pic38668.jpg', 1, 2);
INSERT INTO boardgame_board(description, hashtag, image, user_id, board_list_id) VALUES ('Scythe',           '#boardgame#tabletop#meeples', 'https://cf.geekdo-images.com/7k_nOxpO9OGIjhLq2BUZdA__imagepage/img/zoz-t_z9nqqxL7OwQenbqp9PRl8=/fit-in/900x600/filters:no_upscale():strip_icc()/pic3163924.jpg', 1, 2);
INSERT INTO boardgame_board(description, hashtag, image, user_id, board_list_id) VALUES ('Yura Yura Penguin','#boardgame#tabletop#meeples', 'https://cf.geekdo-images.com/yDySl7jc4Vy2Mso-GgXOag__imagepage/img/qNaJK1Tz7GHvxjLQEi--2pXsIw8=/fit-in/900x600/filters:no_upscale():strip_icc()/pic5783938.jpg', 1, 2);
INSERT INTO boardgame_board(description, hashtag, image, user_id, board_list_id) VALUES ('Cascadia',         '#boardgame#tabletop#meeples', 'https://cf.geekdo-images.com/MjeJZfulbsM1DSV3DrGJYA__imagepage/img/0ksox22FKLq-Z-rsbBlF2IDG9x0=/fit-in/900x600/filters:no_upscale():strip_icc()/pic5100691.jpg', 1, 2);
INSERT INTO boardgame_board(description, hashtag, image, user_id, board_list_id) VALUES ('Ark Nova',         '#boardgame#tabletop#meeples', 'https://cf.geekdo-images.com/SoU8p28Sk1s8MSvoM4N8pQ__imagepage/img/qR1EvTSNPjDa-pNPGxU9HY2oKfs=/fit-in/900x600/filters:no_upscale():strip_icc()/pic6293412.jpg', 1, 2);
INSERT INTO boardgame_board(description, hashtag, image, user_id, board_list_id) VALUES ('Earth',            '#boardgame#tabletop#meeples', 'https://cf.geekdo-images.com/0xqF_KyOb7V26Lu5YT3fxw__imagepage/img/sxzhjfiLwG7mtEkRpAvsw1P5cec=/fit-in/900x600/filters:no_upscale():strip_icc()/pic6699821.jpg', 1, 2);
INSERT INTO boardgame_board(description, hashtag, image, user_id, board_list_id) VALUES ('Frosthaven',       '#boardgame#tabletop#meeples', 'https://cf.geekdo-images.com/iEBr5o8AbJi9V9cgQcYROQ__imagepage/img/3h7303cwluGrIhEN6x-wNEWqbng=/fit-in/900x600/filters:no_upscale():strip_icc()/pic6177719.jpg', 1, 2);
INSERT INTO boardgame_board(description, hashtag, image, user_id, board_list_id) VALUES ('Brass: Birmingham','#boardgame#tabletop#meeples', 'https://cf.geekdo-images.com/x3zxjr-Vw5iU4yDPg70Jgw__imagepage/img/-17KkOmxbTu2slJTabGrkO8ZW8s=/fit-in/900x600/filters:no_upscale():strip_icc()/pic3490053.jpg', 1, 2);
INSERT INTO boardgame_board(description, hashtag, image, user_id, board_list_id) VALUES ('Camel Up',         '#boardgame#tabletop#meeples', 'https://cf.geekdo-images.com/pRZrHJNoPQ3gay9EkpuZLw__imagepage/img/irfKJQj_CqQHYn9QJ89tVLzMX-A=/fit-in/900x600/filters:no_upscale():strip_icc()/pic4304741.jpg', 1, 2);

-- Macbook Board
INSERT INTO macbook_board(description, hashtag, image, user_id, board_list_id) VALUES ('Macbook #1', '#technology#photography#apple#macbook', 'https://picsum.photos/id/1/300/300', 1, 3);
INSERT INTO macbook_board(description, hashtag, image, user_id, board_list_id) VALUES ('Macbook #2', '#technology#photography#apple#macbook', 'https://picsum.photos/id/2/300/300', 1, 3);
INSERT INTO macbook_board(description, hashtag, image, user_id, board_list_id) VALUES ('Macbook #3', '#technology#photography#apple#macbook', 'https://picsum.photos/id/3/300/300', 1, 3);
INSERT INTO macbook_board(description, hashtag, image, user_id, board_list_id) VALUES ('Macbook #4', '#technology#photography#apple#macbook', 'https://picsum.photos/id/4/300/300', 1, 3);
INSERT INTO macbook_board(description, hashtag, image, user_id, board_list_id) VALUES ('Macbook #5', '#technology#photography#apple#macbook', 'https://picsum.photos/id/5/300/300', 1, 3);
INSERT INTO macbook_board(description, hashtag, image, user_id, board_list_id) VALUES ('Macbook #6', '#technology#photography#apple#macbook', 'https://picsum.photos/id/6/300/300', 1, 3);
INSERT INTO macbook_board(description, hashtag, image, user_id, board_list_id) VALUES ('Macbook #7', '#technology#photography#apple#macbook', 'https://picsum.photos/id/7/300/300', 1, 3);
INSERT INTO macbook_board(description, hashtag, image, user_id, board_list_id) VALUES ('Macbook #8', '#technology#photography#apple#macbook', 'https://picsum.photos/id/8/300/300', 1, 3);
INSERT INTO macbook_board(description, hashtag, image, user_id, board_list_id) VALUES ('Macbook #9', '#technology#photography#apple#macbook', 'https://picsum.photos/id/9/300/300', 1, 3);
INSERT INTO macbook_board(description, hashtag, image, user_id, board_list_id) VALUES ('Macbook #10','#technology#photography#apple#macbook','https://picsum.photos/id/0/300/300',  1, 3);

-- Cityscape Board
INSERT INTO cityscape_board(description, hashtag, image, user_id, board_list_id) VALUES ('City #2', '#city#photography#architecture', 'https://picsum.photos/id/234/300/500', 1, 4);
INSERT INTO cityscape_board(description, hashtag, image, user_id, board_list_id) VALUES ('City #1', '#city#photography#architecture', 'https://picsum.photos/id/233/300/500', 1, 4);
INSERT INTO cityscape_board(description, hashtag, image, user_id, board_list_id) VALUES ('City #3', '#city#photography#architecture', 'https://picsum.photos/id/236/300/500', 1, 4);
INSERT INTO cityscape_board(description, hashtag, image, user_id, board_list_id) VALUES ('City #4', '#city#photography#architecture', 'https://picsum.photos/id/238/300/500', 1, 4);
INSERT INTO cityscape_board(description, hashtag, image, user_id, board_list_id) VALUES ('City #5', '#city#photography#architecture', 'https://picsum.photos/id/240/300/500', 1, 4);
INSERT INTO cityscape_board(description, hashtag, image, user_id, board_list_id) VALUES ('City #6', '#city#photography#architecture', 'https://picsum.photos/id/242/300/500', 1, 4);
INSERT INTO cityscape_board(description, hashtag, image, user_id, board_list_id) VALUES ('City #7', '#city#photography#architecture', 'https://picsum.photos/id/249/300/500', 1, 4);
INSERT INTO cityscape_board(description, hashtag, image, user_id, board_list_id) VALUES ('City #8', '#city#photography#architecture', 'https://picsum.photos/id/257/300/500', 1, 4);
INSERT INTO cityscape_board(description, hashtag, image, user_id, board_list_id) VALUES ('City #9', '#city#photography#architecture', 'https://picsum.photos/id/259/300/500', 1, 4);
INSERT INTO cityscape_board(description, hashtag, image, user_id, board_list_id) VALUES ('City #10','#city#photography#architecture', 'https://picsum.photos/id/232/300/500', 1, 4);


-- psql -d p2 -f reset_db.sql -p 5433
-- PGPASSWORD=YsRbSGWctAQTPL8pX5sOear938QrwlLW psql -h dpg-ch8fge6si8uhth779pq0-a.oregon-postgres.render.com -U pgrender flaskdb_uiod 
-- PGPASSWORD=YsRbSGWctAQTPL8pX5sOear938QrwlLW psql -h dpg-ch8fge6si8uhth779pq0-a.oregon-postgres.render.com -U pgrender -f reset_db.sql flaskdb_uiod 