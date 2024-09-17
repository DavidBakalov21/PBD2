CREATE DATABASE Assignment2;
USE Assignment2;
DROP DATABASE Assignment2;
TRUNCATE TABLE client_order;
TRUNCATE TABLE product;
TRUNCATE TABLE client;
INSERT INTO client (name, surname, email, phone, address)
VALUES ('John', 'Doe', 'john.doe@example.com', '123-456-7890', '123 Main St, Springfield');


CREATE TABLE IF NOT EXISTS client (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    surname VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(50) NOT NULL,
    address TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    product_price INT NOT NULL,
    product_category ENUM('food', 'furniture', 'clothes', 'hardware') NOT NULL,
    description TEXT
);

CREATE TABLE IF NOT EXISTS client_order(
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    user_id INT NOT NULL,
    order_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



