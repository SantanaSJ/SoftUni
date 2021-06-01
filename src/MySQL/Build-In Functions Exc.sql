-- -----EXC1-----
SELECT * FROM `employees`;
SELECT `first_name`, `last_name` FROM `employees`
WHERE substring(`first_name`, 1, 2) = 'Sa'
#WHERE LEFT(`first_name`, 2) = 'Sa'
#WHERE `first_name` LIKE 'Sa%'
ORDER BY `employee_id`;

-- -----EXC2-----
SELECT * FROM `employees`;
SELECT `first_name`,`last_name` FROM `employees`
WHERE `last_name` LIKE '%ei%'
ORDER by `employee_id`;

-- -----EXC3-----
SELECT `first_name` 
FROM `employees`
WHERE `department_id` in (3, 10)
AND YEAR(`hire_date`) BETWEEN 1995 AND 2005
ORDER BY `employee_id`;

-- -----EXC4-----
SELECT `first_name`, `last_name` FROM `employees`
WHERE `job_title` NOT LIKE '%engineer%'
ORDER BY `employee_id`;

-- -----EXC5
SELECT `name` FROM `towns`
WHERE char_length(`name`) IN(5, 6)
ORDER BY `name`;

-- -----EXC6-----
SELECT `town_id`, `name`FROM `towns`
WHERE LEFT(`name`, 1) IN ('M', 'K', 'B', 'E')
ORDER BY `name`;

-- -----EXC7-----
SELECT * FROM `towns`;
SELECT `town_id`, `name` FROM `towns`
WHERE LEFT (`name`, 1) NOT IN('R', 'B', 'D')
ORDER BY `name`;


-- -----EXC8-----
CREATE VIEW `v_employees_hired_after_2000` AS
SELECT `first_name`, `last_name`
FROM `employees`
WHERE YEAR (`hire_date`) > 2000;

SELECT * FROM `v_employees_hired_after_2000`;

-- -----EXC9-----
SELECT `first_name`, `last_name`
FROM `employees`
WHERE char_length(`last_name`) = 5;

-- -----EXC10-----
SELECT `country_name`, `iso_code`
FROM `countries`
WHERE `country_name` LIKE '%A%A%A%'
ORDER by `iso_code`;

-- -----EXC11-----
SELECT `peak_name`, `river_name`,
lower(concat(`peak_name`, substring(`river_name`, 2))) AS 'mix'
FROM `peaks`, `rivers`
WHERE right(`peak_name`, 1) = left(`river_name`, 1)
ORDER BY `mix`;

-- -----EXC12-----
SELECT `name`, date_format(`start`, '%Y-%m-%d')`start`
FROM `games`
WHERE YEAR(`start`) BETWEEN 2011 AND 2012
ORDER BY `start`, `name`
LIMIT 50;

-- -----EXC13-----
SELECT `user_name`, substring(`email`, locate('@', `email`) + 1) AS 'email_provider'
FROM `users`
ORDER BY `email_provider`, `user_name`;

-- -----EXC14-----
SELECT `user_name`, `ip_address`
FROM `users`
WHERE `ip_address` LIKE '___.1%.%.___'
ORDER BY `user_name`; 

-- -----EXC15-----
SELECT 
    `name`,
    (CASE
        WHEN HOUR(`start`) BETWEEN 0 AND 11 THEN 'Morning'
        WHEN HOUR(`start`) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END) AS 'Part of the Day',
    (CASE
        WHEN `duration` < 4 THEN 'Extra Short'
        WHEN `duration` < 7 THEN 'Short'
        WHEN `duration` < 11 THEN 'Long'
        ELSE 'Extra Long'
    END) AS 'Duration'
FROM
    `games`;
    
    -- -----EXC16-----
SELECT `product_name`, `order_date`, 
date_add(`order_date`, INTERVAL 3 DAY) AS
'pay_due',
date_add(`order_date`, Interval 1 MONTH)
FROM `orders`;