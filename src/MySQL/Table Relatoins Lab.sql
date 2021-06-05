-- -----EXC1/EXC3-----
CREATE TABLE `mountains` (
`id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
`name` VARCHAR(45) NOT NULL
);

CREATE TABLE `peaks` (
`id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
`name` VARCHAR(45) NOT NULL,
`mountain_id` INT NOT NULL,
CONSTRAINT `fk_peaks_mountains`
FOREIGN KEY (`mountain_id`)
REFERENCES `mountains` (`id`)
ON DELETE CASCADE
);

-- -----EXC2-----
SELECT c.`id` AS `driver_id`,v.`vehicle_type`, 
concat(`first_name`, ' ', `last_name`) AS 'driver_name'
FROM `campers` AS c
JOIN `vehicles` AS v
ON v.`driver_id` = c.`id`;

-- -----EXC4-----
SELECT 
r.`starting_point`, 
r.`end_point`, 
r.`leader_id`,
concat(c.`first_name`, ' ', c.`last_name`) AS 'leader_name'
 FROM `campers` AS c
JOIN `routes` AS r
ON r.`leader_id` = c.id;

-- -----EXC5-----
CREATE TABLE `cleints` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`client_name` VARCHAR(100)
);

CREATE TABLE `projects` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`client_id` INT,
`project_lead_id` INT,
CONSTRAINT `fk_proj_clients`
FOREIGN KEY (`cleint_id`)
REFERENCES `clients`(`id`)
);

CREATE TABLE `employees` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`f_name` VARCHAR(100),
`l_name` VARCHAR(100),
`project_id` INT,
CONSTRAINT `fk_emp_proj`
FOREIGN KEY (`project_id`)
REFERENCES `projects`(`id`)
);

ALTER TABLE `projects`
ADD CONSTRAINT `fk_project_lead`
FOREIGN KEY (`project_lead_id`)
REFERENCES `employees`(`id`);


