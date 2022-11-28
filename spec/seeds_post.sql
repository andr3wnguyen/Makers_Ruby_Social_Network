--DROP TABLE post;
-- DROP TABLE users;
-- can also use drop tables

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    fullname text, 
    user_name text,
    email_address text
);

TRUNCATE TABLE users RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO users(fullname, user_name, email_address) VALUES ('David D', 'DD1', 'david1@aol.com');
INSERT INTO users(fullname, user_name, email_address) VALUES ('Anna A', 'AA1','anna1@aol.com');
INSERT INTO users(fullname, user_name, email_address) VALUES ('David B', 'DD2', 'david12@aol.com');
INSERT INTO users(fullname, user_name, email_address) VALUES ('Anna B', 'AA2','anna12@aol.com');


CREATE TABLE IF NOT EXISTS post (
    id SERIAL,
    title text,
    content text,
    view_count int,
    users_id INT,
    CONSTRAINT fk_user_id foreign key(users_id) REFERENCES users(id) 
);

TRUNCATE TABLE post RESTART IDENTITY; -- replace with your own table name.

INSERT INTO post(title, content, view_count, users_id) VALUES ('First', 'This is my first entry', 2, 1);
INSERT INTO post(title, content, view_count, users_id) VALUES ('First entry', 'This is also my first entry', 5, 2);
INSERT INTO post(title, content, view_count, users_id) VALUES ('Second', 'This is my second entry', 22, 1);
INSERT INTO post(title, content, view_count, users_id) VALUES ('First', 'This is my first entry', 2, 1);
INSERT INTO post(title, content, view_count, users_id) VALUES ('First entry', 'This is also my first entry', 5, 2);
INSERT INTO post(title, content, view_count, users_id) VALUES ('Second', 'This is my second entry', 22, 1);

