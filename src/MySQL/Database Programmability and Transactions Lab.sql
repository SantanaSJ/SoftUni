-- -----EXC1-----
DELIMITER ###

CREATE FUNCTION `ufn_count_employees_by_town` (town_name VARCHAR(45))
RETURNS INTEGER
DETERMINISTIC
BEGIN

DECLARE my_result INT;

SET my_result := (SELECT count(*)
FROM `employees` AS e
JOIN `addresses` AS a
USING (`address_id`)
JOIN `towns` AS tufn_count_employees_by_town
USING (`town_id`)
WHERE t.`name` = town_name 
GROUP BY t.`name`);

RETURN my_result;

END
DELIMITER ;

-- -----EXC2-----
DELIMITER &&
CREATE PROCEDURE usp_raise_salaries (department_name VARCHAR(50))
BEGIN
UPDATE  `employees`
JOIN `departments`
USING (`department_id`)
SET `salary` = `salary` * 1.05
WHERE departments.`name` = department_name;
END
DELIMITER ;

-- -----EXC3-----
DELIMITER &&
CREATE DEFINER=`root`@`localhost` PROCEDURE `usp_raise_salary_by_id`(emp_id INT)
BEGIN
IF((SELECT count(*) FROM `employees` WHERE `employee_id` = `emp_id`) = 1)
THEN
UPDATE `employees`
SET `salary` = `salary` * 1.05
WHERE `employee_id` = `emp_id`;
END IF;
END
DELIMITER ;

-- -----ЕXC4-----
CREATE TABLE `deleted_employees`(
	`employee_id` INT PRIMARY KEY AUTO_INCREMENT,
	`first_name` VARCHAR(20),
	`last_name` VARCHAR(20),
	`middle_name` VARCHAR(20),
	`job_title` VARCHAR(50),
	`department_id` INT,
	`salary` DOUBLE 
);
DELIMITER &&
CREATE TRIGGER `deleted_employees_AFTER_DELETE` 
AFTER DELETE ON `employees` 
FOR EACH ROW BEGIN
INSERT INTO 
`deleted_employees`(`employee_id`, `first_name`, `last_name`, `middle_name`, `job_title`, `department_id`, `salary`)
VALUES (OLD.`employee_id`, OLD.`first_name`, OLD.`last_name`, OLD.`middle_name`, OLD.`job_title`, OLD.`department_id`, OLD.`salary`);
END
DELIMITER ;

DELETE FROM `employees` WHERE `employee_id` = 1;