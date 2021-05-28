USE `hotel`;
#EXC1
SELECT `id`, `first_name`, `last_name`, `job_title` 
FROM `employees` 
ORDER BY `id`;

#EXC2
SELECT `id`, concat(`first_name`, ' ',  `last_name`) 
AS `full_name`, `job_title`, `salary` 
FROM `employees`
WHERE `salary` > 1000;

#EXC3
UPDATE `employees`
SET `salary` = `salary` + 100
WHERE `job_title` = 'Manager';
SELECT `salary` FROM `employees`;

#EXC4
CREATE view `v_top_paid` AS (
SELECT * FROM `employees`
ORDER BY `salary` DESC
LIMIT 1
);

SELECT * FROM `v_top_paid`;

#EXC5
SELECT * FROM `employees`
WHERE `department_id` = 4 AND `salary` >= 1000;

SHOW CREATE TABLE `departments`;

#EXC6 DELETE
DELETE FROM `employees`
WHERE `department_id`IN (1, 2);
SELECT * FROM `employees`;