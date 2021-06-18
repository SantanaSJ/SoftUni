create database softUni_stores_system;
use softUni_stores_system;

create table towns (
id int primary key auto_increment,
`name` varchar(20) not null unique
);

create table addresses (
id int primary key auto_increment,
`name` varchar(50) not null unique,
town_id int not null,
constraint fk_addresses_towns
foreign key (town_id)
references towns(id)
);

create table pictures (
id int primary key auto_increment,
url varchar(100) not null,
added_on datetime not null
);

create table stores (
id int primary key auto_increment,
`name` varchar(20) not null unique,
rating float not null,
has_parking boolean default false,
address_id int not null,
constraint fk_stores_addresses
foreign key (address_id)
references addresses(id)
);

create table employees (
id int primary key auto_increment,
first_name varchar(15) not null,
middle_name char(1),
last_name varchar(20) not null,
salary decimal(19,2) default 0,
hire_date date not null,
manager_id int,
store_id int not null,
constraint fk_employees_employees
foreign key (manager_id)
references employees(id),
constraint fk_employees_stores
foreign key (store_id)
references stores(id)
);

create table categories (
id int primary key auto_increment,
`name` varchar(40) not null unique
);

create table products (
id int primary key auto_increment,
`name` varchar(40) not null unique,
best_before date,
price decimal(10,2) not null,
`description` text,
category_id int not null,
picture_id int not null,
constraint fk_products_categories
foreign key (category_id)
references categories(id),
constraint fk_products_pictures
foreign key (picture_id)
references pictures(id)
);

create table products_stores (
product_id int not null,
store_id int not null,
constraint pk_products_stores
primary key (product_id, store_id),
constraint fk_products_stores_products
foreign key (product_id)
references products(id),
constraint fk_products_stores_stores
foreign key (store_id)
references stores(id)
);


-- ----- DML -----
-- Insert
/*
You will have to insert records of data into the products_stores table, 
based on the products table. 
Find all products that are not offered in any stores (don’t have a relation with stores) 
and insert data in the products_stores.
 For every product saved -> product_id and 1(one) as a store_id. 
 And now this product will be offered in store with name Wrapsafe and id 1.
*/
insert into products_stores (product_id, store_id)
select id, 1
from products as p
left join products_stores as ps
on p.id = ps.product_id
where ps.product_id is null;

/*
Това с delete на foreign key можеш да го оправиш така SET FOREIGN_KEY_CHECKS = 0; 
TRUNCATE table $table_name; SET FOREIGN_KEY_CHECKS = 1;
*/
 
-- Update
/*
Update all employees that hire after 2003(exclusive) year and 
not work in store Cardguard and Veribet. 
Set their manager to be Carolyn Q Dyett (with id 3) and decrease salary with 500.
*/
SHOW INDEXES FROM employees;

#solution 1
update employees e
set e.salary = e.salary - 500, e.manager_id = 3
where year(e.hire_date) >= 2003
and e.store_id not in 
(select s.id from stores  as s where s.`name` = 'Veribet' or s.`name` = 'Cardguard');

#solution 2
update employees as e
join stores as s
on e.store_id = s.id
set e.manager_id = 3 
where year(e.hire_date) > 2003 and s.`name` not in('Cardguard','Veribet');

update employees as e
join stores as s
on e.store_id = s.id
set e.salary = e.salary - 500
where year(e.hire_date) > 2003 and s.`name` not in('Cardguard','Veribet');

-- Delete
/*
It is time for the stores to start working. All good employees already are in their stores. 
But some of the employers are too expensive and we need to cut them, because of finances restrictions.
Be careful not to delete managers they are also employees.
Delete only those employees that have managers and a salary is more than 6000(inclusive)
*/
delete from employees
where salary >= 6000
and manager_id is not null;

-- Quering
-- 5
/*
Extract from the SoftUni Stores System database, info about all of the employees. 
Order the results by employees hire date in descending order.
*/
select 
first_name,
middle_name,
last_name,
salary,
hire_date from employees
order by hire_date desc;

-- 6
/*
A photographer wants to take pictures of products that have old pictures. 
You must select all of the products that have a description more than 100 characters long description, 
and a picture that is made before 2019 (exclusive) and the product price being more than 20. 
Select a short description column that consists of first 10 characters of the picture's description plus '…'. 
Order the results by product price in descending order.
*/
select 
p.`name` as product_name,
p.price,
p.best_before,
concat(substring(p.`description`,1,10), '...') as short_description,
pi.url
from products as p
join pictures as pi
on p.picture_id = pi.id
where p.price > 20
and year(pi.added_on) < 2019
and char_length(p.`description`) > 100
order by p.price desc;

-- 7
/*
The managers needs to know in which stores sell different products and their average price.
Extract from the database all of the stores (with or without products) and the count of the products that they have. 
Also you can show the average price of all products (rounded to the second digit after decimal point) that sells in store.
Order the results descending by count of products in store, then by average price in descending order and finally by store id. 
*/
select
s.`name`,
count(ps.product_id) as product_count,
round(avg(p.price), 2) as 'avg'
from stores as s
left join products_stores as ps
on s.id = ps.store_id
left join products as p
on ps.product_id = p.id
group by s.id
order by product_count desc, `avg` desc, s.id;

-- 8
/*There are many employees in our shop system, but we need to find only the one that passes some specific criteria. 
Extract from the database, the full name of employee, name of store that he works, address of store, and salary. 
The employee's salary must be lower than 4000, the address of the store must contain '5' somewhere,
the length of the store name needs to be more than 8 characters and the employee’s last name must end with an 'n'.*/

select 
concat(e.first_name, ' ', e.last_name) as Full_name,
s.`name`,
a.`name`,
e.salary
from employees as e
join stores as s
on e.store_id = s.id
join addresses as a
on s.address_id = a.id
where salary < 4000
and a.`name` like '%5%'
and char_length(s.`name`) > 8
and e.last_name like '%n';

-- 9
/*
The managers always want to know how the business goes. Now, they want from us to show all store names, 
but for security, the name and must be in the reversed order.
Select the name of stores (in reverse order). 
After that, the full_address in format: {town name in upper case}-{address name}.
The next info is the count of employees, that work in the store.
Filter only the stores that have a more than one employee.
Order the results by the full_address in ascending order.
*/
select
reverse(s.`name`), 
concat(upper(t.`name`), '-', a.`name`) as full_address,
count(e.id) as employees_count
from employees as e
join stores as s
on e.store_id = s.id
join addresses as a
on s.address_id = a.id
join towns as t
on a.town_id = t.id
group by s.id
having employees_count > 0
order by full_address asc;

-- 10
/*
Create a user defined function with the name udf_top_paid_employee_by_store(store_name VARCHAR(50)) 
that receives a store name and returns the full name of top paid employee. 
Full info must be in format:
 	{first_name} {middle_name}. {last_name} works in store for {years of experience} years
The years of experience is the difference when they were hired and 2020-10-18
*/
DELIMITER &&
CREATE FUNCTION `udf_top_paid_employee_by_store`(store_name VARCHAR(50)) 
RETURNS varchar(50) CHARSET utf8mb4
DETERMINISTIC
BEGIN
RETURN (select 
concat(first_name, ' ', middle_name, '. ', last_name, 
' works in store for ', 2020 - year(hire_date), ' years') as full_info
from employees as e
join stores as s
on e.store_id = s.id
where s.`name` = store_name
order by e.salary desc
limit  1);
END
DELIMITER ;

-- 11
/*
CREATE user define procedure udp_update_product_price (address_name VARCHAR (50)), 
that receives as parameter an address name.
Increase the product's price with 100 if the address starts with 0 (zero) 
otherwise increase the price with 200.
*/
DELIMITER &&
CREATE PROCEDURE `udp_update_product_price`(address_name VARCHAR (50))
BEGIN
update products as p
join products_stores as ps
on p.id = ps.product_id
join stores as s
on ps.store_id = s.id
join addresses as a
on s.address_id = a.id
set p.price = (
	case 
    when a.`name` like '0%' then p.price + 100
    else p.price + 200
    end
    )
where a.`name` = address_name;
END
DELIMITER ;

