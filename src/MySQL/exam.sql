create database stc;
use stc;

create table categories (
id int primary key auto_increment,
`name` varchar(10) not null
);

create table cars (
id int primary key auto_increment,
make varchar(20) not null,
model varchar(20),
year int not null default 0,
mileage int default 0,
`condition` char(1) not null,
category_id int not null,
constraint fk_cars_categories
foreign key (category_id)
references categories(id)
);

create table addresses (
id int primary key auto_increment,
`name` varchar(100) not null
);


create table clients (
id int primary key auto_increment,
full_name varchar(50) not null,
phone_number varchar(20) not null
);

create table courses (
id int primary key auto_increment,
from_address_id int not null,
constraint fk_courses_addresses
foreign key (from_address_id)
references addresses(id),
`start` datetime not null,
bill decimal(10,2) default 0,
car_id int not null,
constraint fk_courses_cars
foreign key (car_id)
references cars(id),
client_id int not null,
constraint fk_courses_clients
foreign key (client_id)
references clients(id)
);

create table drivers (
id int primary key auto_increment,
first_name varchar(30) not null,
last_name varchar(30) not null,
age int not null,
rating float default 5.5
);

create table cars_drivers (
car_id int not null,
driver_id int not null,
constraint pk_cars_drivers
primary key (car_id, driver_id),
constraint fk_cars_drivers_cars
foreign key (car_id)
references cars(id),
constraint fk_cars_drivers_drivers
foreign key (driver_id)
references drivers(id)
);

-- Insert
/*
You will have to insert records of data into the clients table, based on the drivers table. 
For all drivers with an id between 10 and 20 (both inclusive), 
insert data in the clients table with the following values:
•	full_name – get first and last name of the driver separated by single space
•	phone_number – set it to start with (088) 9999 and the driver_id multiplied by 2
*/
insert into clients (full_name, phone_number)
select 
concat(first_name, ' ', last_name), 
concat('(088) 9999', id * 2)
from drivers
where id between 10 and 20;

-- Update
/*
After many kilometers and over the years, the condition of cars is expected to deteriorate.
Update all cars and set the condition to be 'C'. The cars  must have a mileage greater than 800000 
(inclusive) or NULL and must be older than 2010(inclusive).
Skip the cars that contain a make value of Mercedes-Benz. They can work for many more years.
*/

update cars
set `condition` = 'C'
where  mileage >= 800000 or mileage is null 
and `year` >= '2010'
and make not in ( 'Mercedes-Benz');


-- Delete
/*
Some of the clients have not used the services of our company recently, so we need to remove them 
from the database.	
Delete all clients from clients table, that do not have any courses and the count of the characters 
in the full_name is more than 3 characters. 
*/
delete c from clients as c
left join courses as co
on c.id = co.client_id
where co.client_id is null
and char_length(full_name) > 3;

-- 5
/*
Extract the info about all the cars. 
Order the results by car’s id.
*/
select 
make,
model,
`condition`
from cars
order by id;

-- 6
/*
Now, we need a more detailed information about drivers and their cars.
Select all drivers and cars that they drive. Extract the driver’s first and last name 
from the drivers table and the make, the model and the mileage from the cars table. 
Order the result by the mileage in descending order, then by the first name alphabetically. 
Skip all cars that have NULL as a value for the mileage.
*/
select 
d.first_name,
d.last_name,
c.make,
c.model,
c.mileage
from drivers as d
join cars_drivers as cd
on d.id = cd.driver_id
join cars as c
on cd.car_id = c.id
where mileage is not null
order by c.mileage desc, d.first_name;

-- 7
/*
Extract from the database all the cars and the count of their courses.
Also display the average bill of each course by the car, rounded to the second digit.
Order the results descending by the count of courses, then by the car’s id. 
Skip the cars with exactly 2 courses
*/

select 
c.id,
c.make,
c.mileage,
count(co.id) as count_of_courses,
round(avg(co.bill),2) as avg_bill
from cars as c
left join courses as co
on c.id = co.car_id
group by c.id
having count_of_courses != 2
order by count_of_courses desc, c.id;

-- 8
/*
Extract the regular clients, who have ridden in more than one car. 
The second letter of the customer's full name must be 'a'.
Select the full name, the count of cars that he ridden and total sum of all courses.
Order clients by their full_name.
*/

select 
c.full_name,
count(ca.id) as count_of_cars,
sum(co.bill) as total_sum
from clients as c
join courses as co
on c.id = co.client_id
join cars as ca
on co.car_id = ca.id
where c.full_name like '_a%'
group by c.id
having count_of_cars > 1
order by c.full_name;

-- 9
/*
The headquarters want us to make a query that shows the complete information about all courses in the database. 
The information that they need is the address, if the course is made in the Day (between 6 and 20(inclusive both)) 
or in the Night (between 21 and 5(inclusive both)), the bill of the course, the full name of the client, 
the car maker, the model and the name of the category.
Order the results by course id.
*/

select 
a.`name`,
if (hour(co.`start`) >= 6 and hour(co.`start`) <= 20, 'Day',
'Night') as day_time,
co.bill,
cl.full_name,
ca.make,
ca.model,
cat.`name` as category_name
from addresses as a
join courses as co
on a.id = co.from_address_id
join clients as cl
on co.client_id = cl.id
join cars as ca
on co.car_id = ca.id
join categories as cat
on ca.category_id = cat.id
order by co.id;

select 
a.`name`,
(case
when hour(co.`start`) between 6 and 20 then 'Day'
else 'Night'
end) as day_time,
co.bill,
cl.full_name,
ca.make,
ca.model,
cat.`name` as category_name
from addresses as a
join courses as co
on a.id = co.from_address_id
join clients as cl
on co.client_id = cl.id
join cars as ca
on co.car_id = ca.id
join categories as cat
on ca.category_id = cat.id
order by co.id;

-- 10
/*
Create a user defined function with the name udf_courses_by_client (phone_num VARCHAR (20)) 
that receives a client’s phone number and returns the number of courses that clients have in database.
*/

DELIMITER &&
CREATE FUNCTION `udf_courses_by_client`(phone_num VARCHAR (20)) 
RETURNS int
DETERMINISTIC
BEGIN
return (select 
count(co.id) as count
from courses as co
join clients as c
on co.client_id = c.id
where c.phone_number = phone_num);
END
DELIMITER ;

SELECT udf_courses_by_client ('(831) 1391236') as `count`;

-- 11
/*
Create a stored procedure udp_courses_by_address which accepts the following parameters:
•	address_name (with max length 100)

Extract data about the addresses with the given address_name. 
The needed data is the name of the address, full name of the client, level of bill 
(depends of course bill – Low – lower than 20(inclusive), Medium – lower than 30(inclusive), and High), 
make and condition of the car and the name of the category.
 Order addresses by make, then by client’s full name.
*/

DELIMITER &&
CREATE PROCEDURE `udp_courses_by_address`(address_name varchar(100))
BEGIN
select 
a.`name` ,
cl.full_name as full_names,
(case
when co.bill <= 20 then 'Low'
when co.bill <= 30 then 'Medium'
else 'High'
end)  as level_of_bill,
c.make, 
c.`condition`,
cat.`name` as cat_name
from addresses as a
join courses as co
on a.id = co.from_address_id
join clients as cl
on co.client_id = cl.id
join cars as c
on co.car_id = c.id
join categories as cat
on c.category_id = cat.id
where a.`name` = address_name
order by c.make, cl.full_name;
END
DELIMITER ;
