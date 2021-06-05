CREATE DATABASE `gamebar`;
USE `gamebar`;

#Lab1 CREATE TABLES
CREATE TABLE `employees` (
`id` INT PRIMARY KEY AUTO_INCREMENT, 
`first_name` VARCHAR(50) NOT NULL, 
`last_name` VARCHAR(50) NOT NULL
);

CREATE TABLE `categories` (
`id` INT PRIMARY KEY AUTO_INCREMENT, 
`name` VARCHAR(50) NOT NULL
);

CREATE TABLE `products` (
`id` INT PRIMARY KEY AUTO_INCREMENT, 
`name` VARCHAR(50) NOT NULL,
`category_id` INT NOT NULL
);

#Lab2 INSERT DATA IN TABLES
INSERT INTO `employees` (`first_name`, `last_name`)
VALUES ('Ivan','Ivanov');

TRUNCATE `employees`;

INSERT INTO `employees` (`first_name`, `last_name`)
VALUES ('Ivan','Ivanov');
INSERT INTO `employees` (`first_name`, `last_name`)
VALUES ('Pesho', 'Peshov');
INSERT INTO `employees` (`first_name`, `last_name`)
VALUES ('Traicho', 'Traikov');

TRUNCATE `employees`;

INSERT INTO `employees` (`first_name`, `last_name`)
VALUES ('Ivan','Ivanov');
INSERT INTO `employees` (`first_name`, `last_name`)
VALUES ('Pesho', 'Peshov');
INSERT INTO `employees` (`first_name`, `last_name`)
VALUES ('Traicho', 'Traikov');

/* INSERT INTO `employees`
VALUES
(1, `Pesho`, `Peshov`), 
(2, `Gosho`, Goshov`), 
(3, `Ivan`, Ivanov`);
*/

ALTER TABLE `employees`
ADD `middle_name` VARCHAR(50);

ALTER TABLE `employees`
DROP COLUMN `middle_name`;

SELECT * FROM `employees`;

#Lab3 ALTER TABLES
ALTER TABLE `employees`
ADD `middle_name` VARCHAR(30);

SELECT * FROM `employees`;

#Lab4 ADDING CONSTRAINTS
ALTER TABLE `products`
ADD CONSTRAINT fk_products_categories
FOREIGN KEY (`category_id`) 
REFERENCES `categories`(`id`);

#Lab5 MODIFYING COLUMN
ALTER TABLE `employees`
MODIFY COLUMN `middle_name` VARCHAR (100);

SELECT * FROM `employees`;










