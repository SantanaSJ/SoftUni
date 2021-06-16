-- -----EXC1-----
/*
Create stored procedure usp_get_employees_salary_above_35000 that returns all employees' 
first and last names for whose salary is above 35000. 
The result should be sorted by first_name then by last_name alphabetically, and id ascending.
*/
DELIMITER &&
CREATE PROCEDURE `usp_get_employees_salary_above_35000`()
BEGIN
SELECT 
`first_name`,
`last_name`
FROM `employees`
WHERE `salary` > 35000
ORDER BY `first_name`, `last_name`, `employee_id` ASC;
END;
DELIMITER ;

-- -----EXC2-----
/*
Create stored procedure usp_get_employees_salary_above that accept a decimal number 
(with precision, 4 digits after the decimal point) as parameter and return all employee's
 first and last names whose salary is above or equal to the given number. 
 The result should be sorted by first_name then by last_name alphabetically and id ascending. 
*/
DELIMITER $$
CREATE PROCEDURE `usp_get_employees_salary_above` (salary_value DECIMAL(18,4))
BEGIN
SELECT 
`first_name`,
`last_name`
FROM `employees`
WHERE `salary` >= `salary_value`
ORDER BY `first_name`, `last_name`, `employee_id` ASC;
END
DELIMITER ;

-- -----EXC3-----
/*Write a stored procedure usp_get_towns_starting_with that accept string as parameter 
and returns all town names starting with that string. 
The result should be sorted by town_name alphabetically. */

DELIMITER $$
CREATE PROCEDURE `usp_get_towns_starting_with`(some_string VARCHAR(20))
BEGIN
SELECT
`name` AS 'town_name'
FROM `towns`
WHERE `name` LIKE concat(some_string, '%') 
ORDER BY `name`;
END;
DELIMITER ;
call usp_get_towns_starting_with ('B');

-- -----EXC4-----
/*
Write a stored procedure usp_get_employees_from_town that accepts town_name as parameter 
and return the employees' first and last name that live in the given town. 
The result should be sorted by first_name then by last_name alphabetically and id ascending. 
*/
DELIMITER &&
CREATE PROCEDURE `usp_get_employees_from_town`(town_name VARCHAR(20))
BEGIN
SELECT
`first_name`,
`last_name`
FROM `employees` AS e
JOIN `addresses` AS a
ON e.`address_id` = a.`address_id`
JOIN `towns` AS t
ON a.`town_id` = t.`town_id`
WHERE t.`name` = town_name
ORDER BY `first_name`, `last_name`, `employee_id` ASC;
END;
DELIMITER ;
call usp_get_employees_from_town('Sofia');

-- -----EXC5-----
/*Write a function ufn_get_salary_level that receives salary of an employee and returns the level of the salary.
•	If salary is < 30000 return "Low"
•	If salary is between 30000 and 50000 (inclusive) return "Average"
•	If salary is > 50000 return "High"
*/
DELIMITER &&
CREATE FUNCTION `ufn_get_salary_level`(input DECIMAL) 
RETURNS varchar(10) CHARSET utf8
DETERMINISTIC
BEGIN
DECLARE result VARCHAR(10);
SET result := (
(CASE  
WHEN input < 30000 THEN 'Low'
WHEN input BETWEEN 30000 AND 50000 THEN 'Average'
WHEN input > 50000 THEN 'High'
END) );
RETURN result;
END
DELIMITER ;

SELECT 
`salary`,
ufn_get_salary_level(13500.00) AS 'salary_level'
FROM `employees`;

-- --------------------------------
/*IF `salary` < 30000 THEN SET `salary_level` := 'Low'
ELSE IF salary <= 50000 THEN SET `salary_level` := 'Average'
ELSE 
SET `salary_level` := 'High'
END IF*/

-- -----EXC6-----
/*
Write a stored procedure usp_get_employees_by_salary_level that receive as parameter level of salary 
(low, average or high) and print the names of all employees that have given level of salary. 
The result should be sorted by first_name then by last_name both in descending order.
*/
 DELIMITER &&
CREATE PROCEDURE `usp_get_employees_by_salary_level`(salary_level VARCHAR(20))
BEGIN
 SELECT 
    e.`first_name`,
    e.`last_name` 
    FROM `employees` AS e 
    WHERE (select ufn_get_salary_level(e.salary) = salary_level)
    ORDER BY e.`first_name` DESC, e.`last_name` DESC;
    END
DELIMITER ;

call usp_get_employees_by_salary_level('high');

-- -----EXC7-----
/*
Define a function ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))  
that returns 1 or 0 depending on that if the word is a comprised of the given set of letters. 
*/
DELIMITER &&
CREATE FUNCTION `ufn_is_word_comprised`(set_of_letters varchar(50), word varchar(50)) 
RETURNS bit(1)
DETERMINISTIC
BEGIN
RETURN (SELECT word REGEXP(concat('^[',set_of_letters,']+$')));
END
DELIMITER ;

-- -----EXC8-----
/*
Write a stored procedure usp_get_holders_full_name that selects the full names of all people. 
The result should be sorted by full_name alphabetically and id ascending.
*/
DELIMITER &&
SELECT
CREATE PROCEDURE `usp_get_holders_full_name`()
BEGIN
SELECT
concat(`first_name`, ' ', `last_name`) AS 'full_name'
FROM `account_holders`
ORDER BY `full_name`, `id`;
END
DELIMITER ;

call usp_get_holders_full_name;

-- -----EXC9-----
/*
Your task is to create a stored procedure usp_get_holders_with_balance_higher_than 
that accepts a number as a parameter and returns all people who have more money in 
total of all their accounts than the supplied number. 
The result should be sorted by account_holders.id ascending. 
*/
DELIMITER &&
CREATE PROCEDURE `usp_get_holders_with_balance_higher_than`(input DECIMAL)
BEGIN
SELECT 
ah.`first_name`,
ah.`last_name`
FROM `account_holders` AS ah 
JOIN `accounts` AS a
ON ah.`id` = a.`account_holder_id`
GROUP BY `account_holder_id`
HAVING sum(a.`balance`) > input
ORDER BY a.`account_holder_id`;
END
DELIMITER ;

call usp_get_holders_with_balance_higher_than(7000);

-- -----EXC10-----
/*Your task is to create a function ufn_calculate_future_value that accepts as parameters – sum 
(with precision, 4 digits after the decimal point), yearly interest rate (double) and number of years(int). 
It should calculate and return the future value of the initial sum. 
The result from the function must be decimal, with percision 4.
 Using the following formula:
 
•	I – Initial sum
•	R – Yearly interest rate
•	T – Number of years
*/

DELIMITER &&
CREATE FUNCTION `ufn_calculate_future_value`
(balance DECIMAL(19, 4), interest DECIMAL(19,4), years INT)
RETURNS decimal(19,4)
DETERMINISTIC
BEGIN
RETURN balance * pow((1 + interest), years);
END
DELIMITER ;

-- -----EXC11-----
/*
Your task is to create a stored procedure usp_calculate_future_value_for_account that accepts as parameters – 
id of account and interest rate. The procedure uses the function from the previous problem to give an interest 
to a person's account for 5 years, along with information about his/her account id, first name, last name and 
current balance as it is shown in the example below. It should take the account_id and the interest_rate as parameters. 
Interest rate should have precision up to 0.0001, same as the calculated balance after 5 years. 
Be extremely careful to achieve the desired precision!
*/
DELIMITER &&
CREATE PROCEDURE `usp_calculate_future_value_for_account`(input INT, interest DECIMAL(19, 4))
BEGIN
SELECT 
a.`id` AS 'account_id',
ah.`first_name`,
ah.`last_name`, 
a.`balance` AS 'current_balance',
(select ufn_calculate_future_value(a.`balance`, interest, 5)) AS 'balance_in_5_years'
FROM `account_holders` AS ah
JOIN accounts AS a 
ON ah.`id` = a.`account_holder_id`
WHERE a.`id` = input;
END
DELIMITER ;

call usp_calculate_future_value_for_account(1, 0.1);

-- -----EXC12----- deposit money
-- TRANSACTIONS
/*
Add stored procedure usp_deposit_money(account_id, money_amount) that operate in transactions. 
Make sure to guarantee valid positive money_amount with precision up to fourth sign after decimal point. 
The procedure should produce exact results working with the specified precision.
*/
DELIMITER &&
CREATE PROCEDURE `usp_deposit_money`(account_id INT, money_amount DECIMAL(19,4))
BEGIN
START TRANSACTION;
IF(money_amount <= 0) THEN ROLLBACK;
ELSE UPDATE `accounts` SET `balance` = `balance` + money_amount
WHERE id = account_id;
END IF;
END
DELIMITER ;

call usp_deposit_money(1, 100);

-- -----EXC15-----
/*
Create another table – logs(log_id, account_id, old_sum, new_sum). 
Add a trigger to the accounts table that enters a new entry into the logs 
table every time the sum on an account changes.
*/
CREATE TABLE `logs` (
`log_id` INT PRIMARY KEY AUTO_INCREMENT,
`account_id` INT,
`old_sum` DECIMAL(19, 2),
`new_sum` DECIMAL(19, 2)
); 

DELIMITER &&
CREATE TRIGGER tr_balance_change()
AFTER UPDATE
ON `accounts`
FOR EACH ROW
BEGIN
INSERT INTO `logs`(account_id, old_sum, new_sum)
VALUES(old.id, old.balance, new.balance);
END
DELIMITER ;
