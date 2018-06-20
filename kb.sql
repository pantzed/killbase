DROP DATABASE IF EXISTS killbase;
CREATE DATABASE killbase;
\c killbase

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
  assassin_id integer references assassins(id)
);

-- Assign the following jobs to these assassins
INSERT INTO asn_contract_j (contract_id, assassin_id)
VALUES (1, 6),
(1, 2),
(2, 5),
(3, 7),
(5, 9),
(4, 6),
(3, 8),
(1, 3);

-- Count the number of currently contracted assassins
SELECT COUNT(assassin_id) FROM asn_contract_j;

-- Find the lowest total cost to complete all assigned contracts
SELECT SUM(budget) FROM contracts;

-- Add a new contract: Snake Plissken
INSERT INTO targets (id, name, location, photo, security)
VALUES (DEFAULT, 'Snake Plissken', 'New York', 'https://i.kinja-img.com/gawker-media/image/upload/s--mbwBG8vL--/18lvo57tluxjejpg.jpg', 5);

INSERT INTO contracts (id, target, client, budget, complete, completed_by)
VALUES (DEFAULT, 6, 1, 35, FALSE, NULL);

-- Assign all assassins with a rate lower than the cost of the new contract to the new contract.
-- Incomplete!



-- Complete these contracts
UPDATE contracts SET complete = TRUE, completed_by = 1 WHERE target = 2;
UPDATE assassins SET kills = kills+1 WHERE id = 1;

UPDATE contracts SET complete = TRUE, completed_by = 3 WHERE target = 1;
UPDATE assassins SET kills = kills+1 WHERE id = 3;

UPDATE contracts SET complete = TRUE, completed_by = 8 WHERE target = 6;
UPDATE assassins SET kills = kills+1 WHERE id = 8;




-- Select all the completed contracts, showing only the assassins to be paid, and the amount paid to them. 
SELECT assassins.name, contracts.budget AS payment_amount
FROM assassins, contracts
WHERE assassins.id = contracts.completed_by;

-- Show the total cost of the completed contracts.
SELECT SUM(budget) AS total_paid FROM assassins INNER JOIN contracts ON (assassins.id = contracts.completed_by);

-- The Jackal has retired. Remove him from the database
-- We will keep all records in the database and create a new column indicating retirement status
ALTER TABLE assassins ADD COLUMN retired bool;
UPDATE assassins SET retired = FALSE;
UPDATE assassins SET retired = TRUE WHERE id = 1;

-- Ghost Dog and Nikita Mears have increased their rates by 5 and 10, respectively. Update their entries to reflect this.
UPDATE assassins SET min_price = min_price+10 WHERE id = 8;
UPDATE assassins SET min_price = min_price+5 WHERE id = 3;

-- The contract on Norman Stansfield has been rescinded. Remove it (and any associated data) from the database.
DELETE FROM contracts USING targets
WHERE targets.id = 3;

-- Winston has taken out a contract on John Wick! (Security 9, budget 100) We may have to rethink the way we're structuring our data. How can we refactor our database schema to allow a person to be an assassin, a client, or the target of a contract? Do that, then assign all assassins not already on a job to this new contract.


-- Show all tables
SELECT * FROM assassins;
SELECT * FROM code_names;
SELECT * FROM clients;
SELECT * FROM contracts;
SELECT * FROM targets;
SELECT * FROM asn_contract_j;
