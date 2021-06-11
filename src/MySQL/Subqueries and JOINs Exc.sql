-- -----EXC1-----
SELECT 
e.`employee_id`,
e.`job_title`, 
a.`address_id`,
a.`address_text`
FROM `employees` AS e
JOIN `addresses` AS a
ON e.`address_id` = a.`address_id`#USING
ORDER BY `address_id` ASC
LIMIT 5;

-- -----EXC2-----
SELECT 
e.`first_name`, 
e.`last_name`,
t.`name` AS 'town',
a.`address_text`
FROM `employees` AS e
JOIN `addresses` AS a
JOIN `towns` AS t
ON e.`address_id` = a.`address_id` AND a.`town_id` = t.`town_id`
ORDER BY `first_name` ASC, `last_name`
LIMIT 5;

-- -----EXC3-----
SELECT 
e.`employee_id`,
e.`first_name`,
e.`last_name`,
d.`name` AS 'department_name'
FROM `employees` AS e
JOIN `departments` AS d
ON e.`department_id` = d.`department_id`
WHERE d.`name` = 'Sales'
ORDER BY `employee_id` DESC;

-- -----EXC4-----
SELECT 
e.`employee_id`,
e.`first_name`,
e.`salary`,
d.`name`AS 'department_name'
FROM `employees` AS e
JOIN `departments` AS d
ON e.`department_id` = d.`department_id`
WHERE e.`salary` > 15000
ORDER BY d.`department_id` DESC
LIMIT 5;

-- -----EXC5-----
SELECT 
e.`employee_id`,
e.`first_name`
FROM `employees` AS e
LEFT JOIN `employees_projects` AS ep
ON e.`employee_id` = ep.`employee_id`
WHERE ep.`project_id` IS NULL
ORDER BY e.`employee_id` DESC
LIMIT 3;

-- -----EXC5-----
SELECT e.`employee_id`, e.`first_name`
FROM `employees` AS e
WHERE e.`employee_id` NOT IN 
(SELECT `employee_id` FROM `employees_projects`)
ORDER BY e.`employee_id` DESC
LIMIT 3;

-- -----EXC6-----
SELECT 
e.`first_name`,
e.`last_name`,
e.`hire_date`,#EXTRACT YEAR
d.`name` AS 'dept_name'
FROM `employees` AS e
JOIN `departments` AS d
ON e.`department_id` = d.`department_id`
WHERE e.`hire_date` > '1999-01-01' AND d.`name` IN ('Sales', 'Finance')
ORDER BY `hire_date` ASC;

-- -----EXC7-----
SELECT 
e.`employee_id`,
e.`first_name`,
p.`name`
FROM `employees` AS e
JOIN `employees_projects` AS ep
ON e.`employee_id` = ep.`employee_id`
JOIN `projects` AS p
USING (`project_id`)
WHERE DATE(p.`start_date`) > '2002-08-13' AND p.`end_date` IS NULL
ORDER BY e.`first_name`, p.`name` ASC
LIMIT 5;

-- -----EXC8-----
SELECT 
e.`employee_id`,
e.`first_name`,
IF(YEAR(p.`start_date`) > 2004, NULL, p.`name`) AS 'p.name'
FROM `employees` AS e
JOIN `employees_projects` AS ep
ON ep.`employee_id` = e.`employee_id`
JOIN `projects` AS p
ON p.`project_id` = ep.`project_id`
WHERE e.`employee_id` = 24
ORDER BY `p.name`;

-- -----EXC9-----
SELECT 
e.`employee_id`,
e.`first_name`,
e.`manager_id`,
m.`first_name` AS 'manager_name'
FROM `employees`  AS e
JOIN `employees` AS m
ON m.`employee_id`  = e.`manager_id`
WHERE e.`manager_id` IN (3, 7)
ORDER BY e.`first_name` ASC;

-- -----EXC10-----
SELECT 
e.`employee_id`,
concat_Ws(' ', e.`first_name`, e.`last_name`) AS 'first_name',
concat_ws(' ', m.`first_name`, m.`last_name`) AS 'manager_name',
d.`name`
FROM `employees` AS e
JOIN `employees` AS m
ON e.`manager_id` = m.`employee_id`
JOIN `departments` AS d
ON e.`department_id` = d.`department_id`
ORDER BY e.`employee_id`
LIMIT 5;

-- -----EXC11-----
SELECT 
 avg(salary) AS 's.avg'
FROM `employees`
GROUP BY `department_id`
ORDER BY `s.avg`
LIMIT 1;

-- -----EXC12-----
SELECT 
c.`country_code`, m.`mountain_range`, p.`peak_name`, p.`elevation`
FROM `countries` AS c
JOIN `mountains_countries` AS mc
ON c.`country_code` = mc.`country_code`
JOIN `mountains` AS m
ON mc.`mountain_id` = m.`id`
JOIN `peaks` AS p
ON p.`mountain_id` = m.`id`
WHERE c.`country_code` = 'BG' AND p.`elevation` > 2835
ORDER BY p.`elevation` DESC;

-- -----EXC13-----
SELECT 
mc.`country_code`,
count(m.`id`) AS 'm_count'
FROM `mountains` AS m
JOIN `mountains_countries` AS mc
ON mc.`mountain_id` = m.`id`
WHERE mc.`country_code` IN ('BG', 'RU', 'US')
GROUP BY mc.`country_code`
ORDER BY `m_count` DESC;

-- -----EXC14-----
SELECT 
c.`country_name`,
r.`river_name`
FROM `countries` AS c
LEFT JOIN `countries_rivers` AS cr
ON c.`country_code` = cr.`country_code`
LEFT JOIN `rivers` AS r
ON cr.`river_id` = r.`id`
WHERE `continent_code` = 'AF'
ORDER BY `country_name` ASC
LIMIT 5;

-- -----15-----
SELECT 
`continent_code`,
`currency_code`,
count(`country_name`) AS 'currency_usage'
FROM `countries` AS c
GROUP BY `continent_code`, `currency_code`
HAVING `currency_usage` = (
SELECT count(`country_code`) AS 'count'
FROM `countries` AS c1
WHERE c1.`continent_code` = c.`continent_code`
GROUP BY `currency_code`
ORDER BY `count` DESC
LIMIT 1
) AND `currency_usage` > 1
ORDER BY `continent_code`, `currency_code`;

-- -----EXC16-----
SELECT 
count(*)
FROM `countries` AS c
WHERE c.`country_code` NOT IN 
(SELECT `country_code` FROM `mountains_countries`);

-- -----EXC17-----
SELECT 
c.`country_name`,
max(p.`elevation`) AS 'm.elevation',
max(r.`length`) AS 'm.length'
FROM `countries` AS c
JOIN `countries_rivers` AS cr
ON cr.`country_code` = c.`country_code`
JOIN `rivers` AS r
ON r.`id` = cr.`river_id`
JOIN `mountains_countries` AS mc
ON c.`country_code` = mc.`country_code`
JOIN `mountains` AS m
ON mc.`mountain_id` = m.`id`
JOIN `peaks` AS p
ON p.`mountain_id` = m.`id`
GROUP BY c.`country_code`
ORDER BY `m.elevation` DESC, `m.length`DESC, c.`country_name`
LIMIT 5;
