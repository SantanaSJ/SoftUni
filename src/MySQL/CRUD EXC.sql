-- -----EXC1-----
SELECT * FROM `departments`
ORDER BY `department_id`;

-- -----EXC2-----
SELECT `name` FROM `departments`
ORDER BY `department_id`;

-- -----EXC3-----
SELECT `first_name`, `last_name`, `salary` 
FROM `employees`;

-- -----EXC4-----
SELECT `first_name`, `middle_name`, `last_name`
FROM `employees`;

/*SELECT * FROM `employees`
WHERE `middle_name` IS NULL;*/

-- -----EXC5-----
SELECT CONCAT(`first_name`, '.', `last_name`, '@softuni.bg')
AS 'full_email_address'
FROM `employees`;

-- -----EXC6-----
SELECT DISTINCT `salary` FROM `employees`
ORDER BY `employee_id`;

-- -----EXC7----
SELECT * FROM `employees`
WHERE `job_title` = 'Sales Representative'
ORDER BY `employee_id`;

-- -----EXC8-----
SELECT `first_name`, `last_name`, `job_title`
FROM `employees`
WHERE `salary` BETWEEN 20000 AND 30000 # >= AND salary <= 
ORDER BY `employee_id`;

-- -----EXC9-----
SELECT CONCAT_WS(' ', `first_name`, `middle_name`, `last_name`) 
AS 'FULL NAME'
FROM `employees`
WHERE `salary` IN (25000, 14000, 12500, 23600);

-- -----EXC10-----
SELECT `first_name`, `last_name` FROM `employees`
WHERE `manager_id` IS NULL;

-- -----EXC11-----
SELECT`first_name`, `last_name`, `salary`
FROM `employees`
WHERE `salary` > 50000
ORDER BY `salary` DESC;

-- -----EXC12-----
SELECT `first_name`, `last_name`
FROM `employees`
ORDER BY `salary` DESC
LIMIT 5;

-- -----EXC13-----
SELECT `first_name`, `last_name`
FROM `employees`
WHERE `department_id` != 4;

-- -----EXC14-----
SELECT * FROM `employees`
ORDER BY `salary` DESC, `first_name`, `last_name` DESC, `middle_name`;

-- -----EXC15-----
CREATE VIEW `v_employees_salaries` AS
SELECT `first_name`, `last_name`, `salary`
FROM `employees`;
SELECT * FROM `v_employees_salaries`;

-- -----EXC16-----
CREATE VIEW `v_employees_job_titles` AS
SELECT CONCAT_WS(' ', `first_name`, `middle_name`, `last_name`) AS 'full name',
`job_title`
FROM `employees`;
SELECT * FROM `v_employees_job_titles`;

-- -----EXC17-----
SELECT DISTINCT `job_title`  FROM `employees`
ORDER BY `job_title` ASC;


-- -----EXC18-----
SELECT * FROM `projects`
ORDER BY `start_date`, `name`, `project_id`
LIMIT 10;

-- -----EXC19-----
SELECT * FROM `employees`;
SELECT `first_name`, `last_name`, `hire_date`
FROM `employees`
ORDER BY `hire_date` DESC
LIMIT 7;

-- -----EXC20-----
SELECT * FROM `employees`;
UPDATE `employees`
SET `salary` = `salary` * 1.12
WHERE `department_id` IN (1, 2, 4, 11);
SELECT `salary` FROM `employees`;

-- -----EXC21-----
SELECT `peak_name`FROM `peaks`
ORDER BY `peak_name`;

-- -----EXC22-----
SELECT `country_name`, `continent_code`, `population` 
FROM `countries`
WHERE `continent_code` = 'EU'
ORDER BY `population` DESC, `country_name`
LIMIT 30;

CREATE VIEW `v_biggest_population` AS (
SELECT `country_name`, `continent_code`,`population`  FROM `countries`
WHERE `continent_code` = 'EU');

SELECT`country_name`, `population` FROM `v_biggest_population`
ORDER BY `population` DESC, `country_name` ASC
LIMIT 30;

-- -----EXC23-----
SELECT * FROM `countries`;
SELECT `country_name`, `country_code`,
IF (`currency_code` = 'EUR', 'Euro', 'Not Euro')  AS 'currency'
FROM `countries`
ORDER BY `country_name`;

-- -----EXC24-----
SELECT * FROM `characters`;
SELECT `name` FROM `characters` 
ORDER BY `name`;


