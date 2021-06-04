-- -----EXC1-----
SELECT count(*) 
FROM `wizzard_deposits`;

-- -----EXC2-----
#Select the size of the longest magic wand. 
#Rename the new column appropriately.
SELECT * FROM `wizzard_deposits`;
SELECT max(`magic_wand_size`) AS 'longest_magic_wand'
FROM `wizzard_deposits`;

-- -----EXC3-----
#For wizards in each deposit group show the longest magic wand. 
#Sort result by longest magic wand for each deposit group in increasing order, 
#then by deposit_group alphabetically. Rename the new column appropriately.
SELECT * FROM `wizzard_deposits`;
SELECT `deposit_group`, max(`magic_wand_size`) AS 'longest_magic_wand'
FROM `wizzard_deposits`
GROUP BY `deposit_group`
ORDER BY `longest_magic_wand`, `deposit_group`;

-- -----EXC4-----
#Select the deposit group with the lowest average wand size.
SELECT `deposit_group`
FROM `wizzard_deposits`
GROUP BY `deposit_group`
LIMIT 1;#ORDER BY avg(`magic_wand_size`)

-- -----EXC5----
#Select all deposit groups and its total deposit sum. 
#Sort result by total_sum in increasing order.
SELECT `deposit_group`, sum(`deposit_amount`) AS 'total_sum'
FROM `wizzard_deposits`
GROUP BY `deposit_group`
ORDER BY `total_sum`;

-- -----EXC6-----
/*Select all deposit groups and its total deposit sum but only for the wizards 
who has their magic wand crafted by Ollivander family. 
Sort result by deposit_group alphabetically.*/
SELECT `deposit_group`, sum(`deposit_amount`) AS 'total_sum'
FROM `wizzard_deposits`
WHERE `magic_wand_creator` = 'Ollivander family'
GROUP BY `deposit_group`
ORDER BY `deposit_group`;

-- -----EXC7-----
/*Select all deposit groups and its total deposit sum but only for the wizards 
who has their magic wand crafted by Ollivander family. 
After this, filter total deposit sums lower than 150000. 
Order by total deposit sum in descending order.*/
SELECT `deposit_group`, sum(`deposit_amount`) AS 'total_sum'
FROM `wizzard_deposits`
WHERE `magic_wand_creator` = 'Ollivander family'
GROUP BY `deposit_group`
HAVING `total_sum` < 150000
ORDER BY `total_sum` DESC;

-- -----EXC8-----
/*
Create a query that selects:
•	Deposit group 
•	Magic wand creator
•	Minimum deposit charge for each group 
Group by deposit_group and magic_wand_creator.
Select the data in ascending order by magic_wand_creator and deposit_group.
*/
SELECT `deposit_group`, `magic_wand_creator`, min(`deposit_charge`) 
AS 'min_deposit_charge'
FROM `wizzard_deposits` 
GROUP BY `deposit_group`, `magic_wand_creator`
ORDER BY `magic_wand_creator`, `deposit_group`;

-- -----EXC9-----
/*
Write down a query that creates 7 different groups based on their age.
Age groups should be as follows:
•	[0-10]
•	[11-20]
•	[21-30]
•	[31-40]
•	[41-50]
•	[51-60]
•	[61+]
The query should return:
•	Age groups
•	Count of wizards in it
Sort result by increasing size of age groups.
*/
SELECT 
    (CASE
        WHEN `age` BETWEEN 0 AND 10 THEN '[0-10]'
        WHEN `age` BETWEEN 11 AND 20 THEN '[11-20]'
        WHEN `age` BETWEEN 21 AND 30 THEN '[21-30]'
        WHEN `age` BETWEEN 31 AND 40 THEN '[31-40]'
        WHEN `age` BETWEEN 41 AND 50 THEN '[41-50]'
        WHEN `age` BETWEEN 51 AND 60 THEN '[51-60]'
        ELSE '[61+]'
    END) AS 'age_group', count(*) AS 'wizzard_count'
FROM
    `wizzard_deposits`
GROUP BY `age_group`#групиране на база новосъздадените age групи
ORDER BY `age_group` ASC;

-- -----EXC10-----
/*Write a query that returns all unique wizard first letters of their first names 
only if they have deposit of type Troll Chest. Order them alphabetically. 
Use GROUP BY for uniqueness.*/
SELECT substring(`first_name`, 1, 1) AS 'first_letter' #LEFT(), DISTINCT
FROM `wizzard_deposits`
WHERE `deposit_group` = 'Troll Chest'
GROUP BY `first_letter`
ORDER BY `first_letter`;

-- -----EXC11-----
/*
Mr. Bodrog is highly interested in profitability.
He wants to know the average interest of all deposits groups split by whether the deposit has expired or not.
But that's not all. He wants you to select deposits with start date after 01/01/1985.
 Order the data descending by Deposit Group and ascending by Expiration Flag.
*/
SELECT `deposit_group`, `is_deposit_expired`, 
avg(`deposit_interest`) AS 'avg_interest'
FROM `wizzard_deposits`
WHERE `deposit_start_date` > '1985-01-01'#EXTRACT YEAR
GROUP BY `deposit_group`, `is_deposit_expired`
ORDER BY `deposit_group` DESC, `is_deposit_expired`;

-- -----EXC12-----
/*
That's it! You no longer work for Mr. Bodrog. 
You have decided to find a proper job as an analyst in SoftUni. 
It's not a surprise that you will use the soft_uni database. 
Select the minimum salary from the employees for departments with ID (2,5,7) 
but only for those who are hired after 01/01/2000. Sort result by department_id in ascending order.
Your query should return:
•	department_id
*/
SELECT `department_id`, min(`salary`) AS 'min_salary'
FROM `employees`
WHERE `department_id` IN (2, 5, 7) AND YEAR(`hire_date`) >= 2000
GROUP BY `department_id`
ORDER BY `department_id`;

-- -----EXC13----- 
/*
Select all high paid employees who earn more than 30000 into a new table. 
Then delete all high paid employees who have manager_id = 42 from the new table. 
Then increase the salaries of all high paid employees with department_id = 1 with 5000 in the new table. 
Finally, select the average salaries in each department from the new table.
Sort result by department_id in increasing order.
*/
#местим в нова таблица
CREATE TABLE `high_paid_employees` AS
SELECT * FROM `employees`
WHERE `salary` > 30000 AND `manager_id` != 42;

UPDATE `high_paid_employees` 
SET `salary` = `salary` + 5000 
WHERE `department_id` = 1;

SELECT `department_id`, avg(`salary`) AS 'avg_salary'
FROM `high_paid_employees`
GROUP BY `department_id`
ORDER BY `department_id`;

-- -----EXC14-----
/*
Find the max salary for each department. Filter those which have max salaries not in the range 30000 and 70000.
 Sort result by department_id in increasing order.
*/
SELECT `department_id`, max(`salary`) AS 'max'
FROM `employees` 
GROUP BY `department_id`
HAVING `max` NOT BETWEEN 30000 AND 70000
ORDER BY `department_id` ASC;

-- -----EXC15-----

#Count the salaries of all employees who don't have a manager.	
SELECT count(`salary`) FROM `employees`
WHERE `manager_id` IS NULL;

-- -----EXC16-----
#Find the third highest salary in each department if there is such. 
#Sort result by department_id in increasing order.
SELECT 
    e.`department_id`,
    (SELECT DISTINCT
            e2.`salary`
        FROM
            `employees` AS e2
        WHERE
            e2.`department_id` = e.`department_id`
        ORDER BY e2.`salary` DESC
        LIMIT 1 OFFSET 2) AS 'third_highest_salary'
FROM
    `employees` AS e
GROUP BY e.`department_id`
HAVING `third_highest_salary` IS NOT NULL
ORDER BY e.`department_id`;

-- -----EXC17-----
/*
Write a query that returns:
•	first_name
•	last_name
•	department_id
for all employees who have salary higher than the average salary of their respective departments. 
Select only the first 10 rows. Order by department_id, employee_id.
*/
SELECT e.`first_name`, e.`last_name`, e.`department_id`
FROM `employees` AS e
WHERE e.`salary` > 
(
SELECT avg(e2.`salary`) 
FROM `employees` AS e2
WHERE e2.`department_id` = e.`department_id`
) 
ORDER BY `department_id`, `employee_id`
LIMIT 10;

-- -----EXC18-----
SELECT `department_id`, sum(`salary`)  AS 'total_salary' 
FROM `employees`
GROUP BY `department_id`
ORDER BY `department_id`;