DROP DATABASE IF EXISTS twitter_db;
CREATE DATABASE twitter_db;
USE twitter_db;

DROP TABLE IF EXISTS users;

CREATE TABLE users (
	user_id INT NOT NULL AUTO_INCREMENT,
    user_handle VARCHAR(50) NOT NULL UNIQUE,
    email_address VARCHAR(50) NOT NULL UNIQUE,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone_number CHAR(10) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT (NOW()),
	PRIMARY KEY(user_id)
);

INSERT INTO users(user_handle, email_address, first_name, last_name, phone_number)
VALUES
("charon12", "charon12@gmail.com", "Robert","Lowski", "970345912"),
("charon33", "charon33@gmail.com", "Jorge","Dunka", "123345912"),
("charon87", "charon87@gmail.com", "Helen","Sagest", "777345912"),
("charon34", "charon34@gmail.com", "Crhis","Leghten", "888345912"),
("charon51", "charon51@gmail.com", "charon51","Pertest", "944345912"),
("bristol", "bristol@gmail.com", "Bristolin","Askhuak", "944345912")
;

DROP TABLE IF EXISTS followers;

CREATE TABLE followers (
	follower_id INT NOT NULL,
    following_id INT NOT NULL,
    FOREIGN KEY(follower_id) REFERENCES users(user_id),
    FOREIGN KEY(following_id) REFERENCES users(user_id),
    PRIMARY KEY(follower_id, following_id)
);

INSERT INTO followers(follower_id, following_id)
VALUES
(1,2),
(2,1),
(3,1),
(4,2),
(1,5),
(2,5),
(3,5);
-- Añadir CONSTRAINS para hacer checks

ALTER TABLE followers
ADD CONSTRAINT check_follower_id
CHECK (follower_id <> followinf_id);

SELECT * FROM followers;
SELECT follower_id FROM followers WHERE following_id=5;
SELECT COUNT(follower_id) FROM followers WHERE following_id=5;

-- Top 3 usuarios con mayor numero de seguidores
SELECT following_id, COUNT(follower_id) AS followers
FROM followers
GROUP BY following_id
ORDER BY followers DESC
LIMIT 3;

-- Top 3 con Join
SELECT users.user_id, users.user_handle, users.first_name, COUNT(follower_id) AS followers
FROM followers
JOIN users ON users.user_id = followers.following_id
GROUP BY following_id
ORDER BY followers DESC
LIMIT 3;

CREATE TABLE tweets (
	tweet_id INT NOT NULL AUTO_INCREMENT,
    user_id INT NOT NULL,
    tweet_text VARCHAR(200) NOT NULL,
    num_likes INT DEFAULT 0,
    num_retweets INT DEFAULT 0,
    num_comments INT DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT (NOW()),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    PRIMARY KEY (tweet_id)
);
    
