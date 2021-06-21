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
insert into clients (full_name, phone_number)
select 
concat(first_name, ' ', last_name), 
concat('(088) 9999', id * 2)
from drivers
where id between 10 and 20;

-- Update

update cars
set `condition` = 'C'
where  mileage >= 800000 or mileage is null 
and `year` >= '2010'
and make not in ( 'Mercedes-Benz');


-- Delete
delete c from clients as c
left join courses as co
on c.id = co.client_id
where co.client_id is null
and char_length(full_name) > 3;

-- 5
select 
make,
model,
`condition`
from cars
order by id;

-- 6
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
