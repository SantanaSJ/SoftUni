-- -----EXC1-----

SELECT 
e.employee_id, 
concat(e.first_name, ' ', e.last_name) AS 'full name',
d.department_id, 
d.`name`
FROM `employees` AS e
RIGHT JOIN `departments` AS d
ON d.manager_id = e.employee_id
ORDER BY e.employee_id
LIMIT 5;

-- -----EXC2-----
SELECT 
t.`town_id`, 
t.`name` AS 'town_name',
a.address_text
FROM `addresses` AS a
LEFT JOIN `towns` AS t
USING (`town_id`)
WHERE t.name IN ('San Francisco', 'Sofia', 'Carnation')
ORDER BY a.town_id, a.address_id;

-- -----EXC3-----
SELECT `employee_id`, `first_name`, `last_name`, `department_id`, `salary`
FROM `employees`
WHERE `manager_id` IS NULL;

-- -----EXC4-----
SELECT count(*) FROM `employees`
WHERE salary > (SELECT AVG(`salary`) FROM `employees`);


