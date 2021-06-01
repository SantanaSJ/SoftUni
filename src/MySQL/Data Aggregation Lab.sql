-- -----EXC1-----
SELECT * FROM `employees`, `departments`;
SELECT `department_id`, count(*)
FROM `employees`
group by `department_id`;

-- -----EXC2-----
SELECT `department_id`, round(avg(`salary`), 2)
FROM `employees`
group by `department_id`;

-- -----EXC3-----
SELECT 
    `department_id`, ROUND(MIN(`salary`), 2) AS 'Min Salary'
FROM
    `employees`
GROUP BY `department_id`
HAVING `Min Salary` > 800
ORDER BY `department_id`;

-- ----EXC4----
SELECT count(*)
FROM `products`
WHERE `category_id` = 2 AND `price` > 8;

-- -----EXC5-----
SELECT 
    `category_id`,
    ROUND(AVG(`price`), 2) AS 'Average Price',
    ROUND(MIN(`price`), 2) AS 'Cheapest Product',
    ROUND(MAX(`price`), 2) AS 'Most Expensive Product'
FROM
    `products`
GROUP BY `category_id`
ORDER BY `category_id`;

