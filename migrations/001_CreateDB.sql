-- +goose Up
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    login varchar(50) NOT NULL,
    password varchar(255) NOT NULL,
    email varchar(50) NOT null
);

INSERT INTO users (login, "password" , email) VALUES 
('test_user_1', 'test_password_1', 'test_email'),
('test_user_2', 'test_password_2', 'test_email'),
('test_user_3', 'test_password_3', 'test_email');

CREATE TABLE IF NOT EXISTS products (
    id SERIAL PRIMARY KEY,
    product varchar(255) NOT NULL,
    proteins NUMERIC (3, 1) NOT NULL,
    fats NUMERIC (3, 1) NOT NULL,
    carbohydrates NUMERIC (3, 1) NOT NULL
);

INSERT INTO products (product, proteins, fats, carbohydrates) VALUES 
('тыква', 1.0, 0.1, 4.4),
('кабачек', 0.6, 0.3, 4.6),
('огурец', 0.8, 0.1, 2.8),
('форель', 18.0, 12.0, 0.0),
('грецкие орехи', 15.2, 65.2, 7.0),
('шампиньоны', 4.3, 1.0, 0.1),
('грейпфрут', 0.7, 0.2, 6.5),
('мед', 0.8, 0.0, 81.5);

CREATE TABLE IF NOT EXISTS users_products (
    id SERIAL PRIMARY KEY,
    user_id SERIAL,
    product_id SERIAL,
    CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE cascade,
    CONSTRAINT fk_product FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE CASCADE
);

INSERT INTO users_products (user_id, product_id) VALUES 
(1, 1),
(2, 1),
(3, 2),
(1, 2);

CREATE TABLE IF NOT EXISTS nutrition_profile (
    id SERIAL PRIMARY KEY,
    user_id SERIAL,
    activity_index NUMERIC (2, 1) NOT NULL,
    current_weight NUMERIC (5, 2) NOT NULL,
    target_weight NUMERIC (5, 2) NOT NULL,
    person_height NUMERIC (3, 1) NOT NULL,
    person_age int NOT null,
    proteins_proportion NUMERIC (2, 1) NOT NULL,
    fats_proportion NUMERIC (2, 1) NOT NULL,
    carbohydrates_proportion NUMERIC (2, 1) NOT NULL,
    bmr NUMERIC (5, 1) NOT null,
   	CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS analytics (
    id SERIAL PRIMARY KEY,
    user_id SERIAL,
    person_weight NUMERIC (5, 2) NOT NULL,
    calories NUMERIC (6, 2) NOT NULL,
    deficit NUMERIC (5, 2) NOT NULL,
    deficit_per_mounth NUMERIC (5, 2) NOT NULL,
    mounth varchar(15),
    CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS menu (
    id SERIAL PRIMARY KEY,
    user_id SERIAL,
    product varchar(50),
    gramms NUMERIC (5, 1) NOT NULL,
    proteins NUMERIC (3, 1) NOT NULL,
    fats NUMERIC (3, 1) NOT NULL,
    carbohydrates NUMERIC (3, 1) NOT NULL,
    menu_date timestamptz default now(),
    CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS pfc_daily (
    id SERIAL PRIMARY KEY,
    menu_id SERIAL,
    proteins_per_day NUMERIC (3, 1) NOT NULL,
    fats_per_day NUMERIC (3, 1) NOT NULL,
    calories_per_day NUMERIC (5, 1) NOT null,
    proteins_remnant NUMERIC (3, 1) NOT NULL,
    fats_remnant NUMERIC (3, 1) NOT NULL,
    calories_remnant NUMERIC (5, 1) NOT null,
    CONSTRAINT fk_menu FOREIGN KEY(menu_id) REFERENCES menu(id) ON DELETE CASCADE
);

-- +goose Down
DROP TABLE IF EXISTS users_products;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS nutrition_profile;
DROP TABLE IF EXISTS pfc_daily;
DROP TABLE IF EXISTS menu;
DROP TABLE IF EXISTS analytics;
DROP TABLE IF EXISTS users;