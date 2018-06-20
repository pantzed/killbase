\c killbase
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

CREATE TABLE assassins (
  id serial primary key,
  name text,
  weapon text,
  age integer,
  min_price integer,
  rating float,
  kills integer,
  open_contracts integer
);

INSERT INTO assassins (id, name, weapon, age, min_price, rating, kills, open_contracts) 
VALUES
(DEFAULT, 'Alexander Duggan', 'Sniper rifle', 31, 45, 7.5, 28, 0),
(DEFAULT, 'Anton Chigurh', 'Pneumatic bolt gun', 52, 40, 9, 72, 0),
(DEFAULT, NULL, 'Pistol', 28, 20, 6.5, 35, 0),
(DEFAULT, 'Jason Bourne', 'Parkour', 27, 25, 7, 48, 0),
(DEFAULT, 'John Wick', 'Lots of guns', 35, 50, 9.5, 433, 0),
(DEFAULT, 'Jules Winnfield', 'Pistol', 26, 15, 6.5, 13, 0),
(DEFAULT, 'Leon', 'Everything', 41, 30, 8.5, 87, 0),
(DEFAULT, 'Nikita Mears', 'Silenced pistols', 28, 30, 7, 32, 0),
(DEFAULT, 'Pickle Rick', 'Lasers and office supplies', 60, 0, 8, 24, 0)
;

CREATE TABLE code_names (
  asn_id integer references assassins(id),
  code_name text
);

INSERT INTO code_names (asn_id, code_name)
VALUES 
(1, 'The Jackal'),
(2, 'Old Man'),
(3, 'Ghost Dog'),
(5, 'Baba Yaga'),
(7, 'The Professional'),
(8, 'Nikita'),
(8, 'La Femme Nikita'),
(9, 'Solenya')
;

CREATE TABLE targets (
  id serial primary key,
  name text,
  location text,
  photo text,
  security integer
);

INSERT INTO targets (id, name, location, photo, security)
VALUES
(DEFAULT, 'Butch Coolidge', 'Los Angeles', 'https://goo.gl/LCquZj', 3),
(DEFAULT, 'The Jaguar', 'Russian Embassy', 'https://goo.gl/6JWsiv', 9),
(DEFAULT, 'Normal Stansfield', 'Manhattan', 'https://i.imgur.com/mdIk33E.jpg', 7),
(DEFAULT, 'Santino D''Antonio', 'Continental Hotel', 'https://goo.gl/fUPkYy', 10),
(DEFAULT, 'Sonny Valerio', 'Queens', 'https://goo.gl/8DHYUS', 4)
;

CREATE TABLE clients (
  id serial primary key,
  client_name text
);

INSERT INTO clients (id, client_name)
VALUES
(1, 'Marcellus Wallace'),
(2, 'Concerto'),
(3, 'Mathilda'),
(4, 'Winston'),
(5, 'Ray Vargo')
;

CREATE TABLE contracts (
  id serial primary key,
  target integer references targets(id),
  client integer references clients(id),
  budget integer,
  complete boolean NOT NULL,
  completed_by integer references assassins(id)
);

INSERT INTO contracts (id, target, client, budget, complete, completed_by)
VALUES
(DEFAULT, 1, 1, 40, FALSE, NULL),
(DEFAULT, 2, 2, 70, FALSE, NULL),
(DEFAULT, 3, 3, 35, FALSE, NULL),
(DEFAULT, 4, 4, 25, FALSE, NULL),
(DEFAULT, 5, 5, 10, FALSE, NULL)
;

CREATE TABLE asn_contract_j (
  contract_id integer references contracts(id),
  assassian_id integer references assassins(id)
);

SELECT * FROM assassins;
SELECT * FROM code_names;
SELECT * FROM clients;
SELECT * FROM contracts;
SELECT * FROM targets;
SELECT * FROM asn_contract_j;
