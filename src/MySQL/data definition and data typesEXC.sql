CREATE DATABASE `minions`;
USE `minions`;

-- -----#EXC1-----
CREATE TABLE `minions` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(30) NOT NULL,
`age` INT
);

CREATE TABLE `towns` (
`town_id` INT PRIMARY KEY AUTO_INCREMENT, 
`name` VARCHAR(30) NOT NULL
);
-- -----#EXC2-----
ALTER TABLE `minions`
ADD COLUMN `town_id` INT,
ADD CONSTRAINT `fk_minions_towns`
FOREIGN KEY (`town_id`)
REFERENCES `towns`(`id`);

-- -----#EXC3-----
INSERT INTO `towns`
VALUES 
(1, 'Sofia'), 
(2, 'Plovdiv'), 
(3, 'Varna');

INSERT INTO `minions`
VALUES
(1, 'Kevin', 22, 1), 
(2, 'Bob', 15, 3),
(3, 'Steward', NULL, 2);

-- -----#EXC4-----
TRUNCATE `minions`;

-- -----#EXC5-----
DROP TABLE `minions`;
DROP TABLE `towns`;

-- -----#EXC6-----
CREATE TABLE `people` (
`id` INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
`name` VARCHAR(200) NOT NULL,
`picture` BLOB,
`height` FLOAT(5, 2), 
`weight` FLOAT(5, 2), 
`gender` CHAR(1) NOT NULL, 
`birthdate` DATE NOT NULL, 
`biography` TEXT
);

INSERT INTO `people` (`name`, `picture`, `height`, `weight`, `gender`, `birthdate`, `biography`)
VALUES ('Pepi', '/home/Pictures', 3.00, 65.00, 'F', '2005-05-24', 'Pepis biography'),
('Toshko', '/home/Pictures', 2.00, 55.00, 'F', '2000-01-01', 'Tosho biogaphy'),
('Ceci', '/home/Pictures', 2.00, 55.00, 'F', '2000-01-01', 'Ceci biogaphy'),
('Penka', '/home/Pictures', 2.00, 55.00, 'F', '2000-01-01', 'Penka biogaphy'),
('Conko', '/home/Pictures', 2.00, 55.00, 'F', '2000-01-01', 'Conko biogaphy');

-- -----#EXC7-----
CREATE TABLE `users` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`username` VARCHAR(30) NOT NULL, 
`paassword` VARCHAR(26) NOT NULL,
`profile_picture` BLOB, 
`last_login_time` DATETIME, 
`is_deleted` BOOL
);

INSERT INTO `users` (`username`, `paassword`, `last_login_time`, `is_deleted`)
VALUES ('Pesho', 'pass1', '2010-12-01', FALSE),
('Gocho', 'pass2', '2010-12-03', TRUE),
('Gosho', 'pass3', '2010-12-05', FALSE),
('Tosho', 'pass4', '2010-12-07', FALSE),
('Losho', 'pass5', '2010-12-09', TRUE);

-- -----#EXC8-----
#The initial primary key name on id is pk_users. 
ALTER TABLE `users`
DROP PRIMARY KEY, 
ADD CONSTRAINT `pk_users`
PRIMARY KEY (`id`, `username`);

-- -----#EXC9-----
ALTER TABLE `users`
CHANGE COLUMN `last_login_time`
`last_login_time` DATETIME NULL DEFAULT NOW();

-- -----EXC10-----
ALTER TABLE `users`
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users 
PRIMARY KEY (`id`),
ADD CONSTRAINT uq_username 
UNIQUE (`username`);

-- -----EXC11-----
CREATE TABLE `directors` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`director_name` VARCHAR(20) NOT NULL, 
`notes` TEXT
);

CREATE TABLE `genres` (
`id` INT PRIMARY KEY AUTO_INCREMENT, 
`genre_name` VARCHAR(20) NOT NULL,
`notes` TEXT
);

CREATE TABLE `categories` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`category_name` VARCHAR(20) NOT NULL,
`notes` TEXT
);

CREATE TABLE `movies` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`title` VARCHAR(20) NOT NULL,
`director_id` INT ,
`copyright_year` YEAR,
`length` INT,
`genre_id` INT,
`category_id` INT,
`rating` DOUBLE,
`notes` TEXT
);

INSERT INTO `directors` (`director_name`, `notes`)
VALUES ('Ivan', 'A beautiful movie'),
('Gosho', 'A beautiful movie'),
('Tosho', 'A beautiful movie'),
('Pesho', 'A beautiful movie'),
('Saho', 'A beautiful movie');

INSERT INTO `genres`(`genre_name`, `notes`)
VALUES ('Horror', 'not for children under 15'),
('Comedy', 'not for children under 15'),
('Drama', 'not for children under 15'),
('Horror', 'not for children under 15'),
('Action', 'not for children under 15');

INSERT INTO `categories`(`category_name`, `notes`)
VALUES ('ABC', 'Bla Bla'),
('ABC', 'Bla Bla'),
('ABC', 'Bla Bla'),
('ABC', 'Bla Bla'),
('ABC', 'Bla Bla');

INSERT INTO `movies` (`title`, `copyright_year`, `length`, `rating`, `notes`)
VALUES ('Star Trek', '2020', 120, 6,'Bla bla'),
('Battlestar galactica', '2020', 90, 6, 'Bla bla'),
('Star wars', '2020', 90, 6, 'Bla bla'),
('Mandalorian', '2020',  120, 6,'Bla bla'),
('Star Trek2', '2020', 120, 6, 'Bla bla');

-- -----EXC12-----
CREATE DATABASE `car_rental`;
USE `car_rental`;

CREATE TABLE `categories` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`category` VARCHAR(5) NOT NULL,
`daily_rate` DOUBLE NOT NULL, 
`weekly_rate` DOUBLE NOT NULL,
`monthly_rate` DOUBLE NOT NULL,
`weekend_rate` DOUBLE NOT NULL
);

INSERT INTO `categories` 
(`category`, `daily_rate`, `weekly_rate`, `monthly_rate`, `weekend_rate`)
VALUES
('A', 52.5, 100, 200, 250),
('B', 65.5, 150, 250, 300),
('C', 65.5, 150, 250, 300);


CREATE TABLE `cars` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`plate_number` INT NOT NULL,
`make` VARCHAR(50) NOT NULL,
`model` VARCHAR(50) NOT NULL,
`car_year` YEAR,
`category_id` INT,
`doors` INT,
`picture` BLOB,
`car_condition` VARCHAR(20),
`available` BOOL NOT NULL
);

INSERT INTO `cars` (`plate_number`, `make`, `model`, `car_year`, `available`)
VALUES
(12345, 'ABSH', 'OPEL', '2018', FALSE),
(12346, 'sfdag', 'BMW', '2019', FALSE),
(12347, 'agagr', 'AUDI', '2017', TRUE);

CREATE TABLE `employees` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`first_name` VARCHAR(20),
`last_name` VARCHAR(20),
`title` VARCHAR (20),
`notes` TEXT
);

INSERT INTO `employees` (`first_name`, `last_name`, `title`)
VALUES
('Gosho', 'Goshev', 'Mr'),
('Tosho', 'Goshev', 'Mr'),
('Pesho', 'Goshev', 'Mr');

CREATE TABLE `customers` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`driver_licence_number` INT NOT NULL,
`full_name` VARCHAR(50),
`address` VARCHAR(50),
`city` VARCHAR (20),
`zip_code` VARCHAR(20),
`notes` TEXT
);

INSERT INTO `customers` (`driver_licence_number`, `full_name`, `city`)
VALUES 
(09357, 'Petar Petrov', 'Sofia'),
(08374, 'Gosho Petrov', 'Sofia'),
(08753, 'Tosho Petrov', 'Sofia');

CREATE TABLE `rental_orders` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`employee_id` INT,
`customer_id` INT,
`car_id` INT,
`car_condition` VARCHAR(50),
`tank_level` VARCHAR(20),
`kilometrage_start` INT,
`kilometrage_end` INT,
`total_kilometrage` INT,
`start_date` DATE,
`end_date` DATE,
`total_days` INT,
`rate_applied` DOUBLE,
`tax_rate` DOUBLE,
`order_status` VARCHAR(20),
`notes` TEXT
);

INSERT INTO `rental_orders` (`car_condition`, `tank_level`,
 `kilometrage_start`, `kilometrage_end`, `start_date`, `end_date`,`total_days`, `rate_applied`)
 VALUES
 ('used', 'full', 10000, 11000, '2020-09-05', '2020-09-08', 3, 250),
 ('used', 'full', 10000, 11000, '2020-09-05', '2020-09-08', 3, 250),
 ('used', 'full', 10000, 11000, '2020-09-05', '2020-09-08', 3, 250);


-- -----#EXC13-----
CREATE DATABASE `soft_uni`;
USE `soft_uni`;

CREATE TABLE `towns` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(30) NOT NULL
);

CREATE TABLE `addresses` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`address_text` VARCHAR(100) NOT NULL,
`town_id` INT NOT NULL,
CONSTRAINT fk_addresses_towns
FOREIGN KEY (`town_id`)
REFERENCES `towns`(`id`)
);

CREATE TABLE `departments` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(20) NOT NULL
);

CREATE TABLE `employees` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`first_name` VARCHAR(20) NOT NULL,
`middle_name` VARCHAR(30) NOT NULL,
`last_name` VARCHAR(30) NOT NULL,
`job_title` VARCHAR(20),
`salary` DECIMAL(10, 2),
`department_id` INT,
`hire_date` DATE,
`address_id` INT, 
CONSTRAINT `fk_employees_departments`
FOREIGN KEY (`department_id`)
REFERENCES `departments`(`id`),
CONSTRAINT `fk_employees_addresses`
FOREIGN KEY (`address_id`)
REFERENCES `addresses`(`id`)
);

INSERT INTO `towns`(`name`)
VALUES
('Sofia'),
('Plovdiv'),
('Varna'),
('Burgas');

INSERT INTO `departments` (`name`)
VALUES
('Engineering'),
('Sales'),
('Marketing'),
('Software Development'),
('Quality Assurance');

INSERT INTO `employees` (`id`, `first_name`, `middle_name`, `last_name`, `job_title`, `salary`, `department_id`, `hire_date`, `address_id`)
VALUES
(1, 'Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 3500.00, 4, '2013-02-01', NULL),
(2, 'Petar', 'Petrov', 'Petrov', 'Senior Engineer', 4000.00, 1, '2004-03-02', NULL),
(3, 'Maria', 'Petrova', 'Ivanova', 'Intern', 525.25, 5, '2016-08-28', NULL),
(4, 'Georgi', 'Terziev', 'Ivanov', 'CEO', 3000.00, 2, '2007-12-09', NULL),
(5, 'Peter', 'Pan', 'Pan', 'Intern', 599.88, 3, '2016-08-28', NULL);

-- -----#EXC 14-----
SELECT * FROM `towns`;
SELECT * FROM `departments`;
SELECT * FROM `employees`;

-- -----#EXC15-----EXC16
SELECT `name` FROM `towns`
ORDER BY `name`; # ascending order, alphabetically/ DESC

SELECT `name` FROM `departments`
ORDER BY `name`;

SELECT `first_name`, `last_name`, `job_title`, `salary` FROM `employees`
ORDER BY `salary` DESC;

-- -----#EXC17-----
UPDATE `employees`
SET `salary` = `salary` * 1.1;#на всички служители

SELECT `salary` FROM `employees`;

-- -----#EXC18-----
TRUNCATE `employees`;






