create database insta_influencers;
use insta_influencers;

create table users (
id int primary key auto_increment,
username varchar(30) not null unique,
`password` varchar(30) not null,
email varchar(50) not null,
gender char(1) not null,
age int not null,
job_title varchar(40) not null,
ip varchar(30) not null
);

create table addresses (
id int primary key auto_increment,
address varchar(30) not null,
town varchar(30) not null,
country varchar(30) not null,
user_id int not null,
constraint fk_addresses_users
foreign key (user_id)
references users(id)
);

create table photos (
id int primary key auto_increment,
`description` text not null,
`date` datetime not null,
views int not null default 0
);

create table likes (
id int primary key auto_increment,
photo_id int,
user_id int,
constraint fk_likes_photos
foreign key (photo_id)
references photos(id),
constraint fk_likes_users
foreign key (user_id)
references users(id)
);

create table comments (
id int primary key auto_increment,
`comment` varchar(255) not null,
date datetime not null,
photo_id int not null,
constraint fk_comments_photos
foreign key (photo_id)
references photos(id)
);

create table users_photos (
user_id int not null,
photo_id int not null,

constraint fk_users_photos_users
foreign key (user_id)
references users(id),

constraint fk_users_photos_photos
foreign key (photo_id)
references photos(id)
);

-- Insert
/*
You will have to insert records of data into the addresses table, based on the users table. 
For users with male gender, insert data in the addresses table with the following values:
•	address – set it to username of the user.
•	town – set it to password of the user.
•	country – set it to ip of the user. 
•	user_id – set it to age of the user. 
*/
Insert into addresses (address, town, country, user_id)
select username, `password`, ip, age
from users
where gender = 'M';

-- Update
/*
Rename those countries, which meet the following conditions:
•	If the country name starts with 'B' – change it to 'Blocked'.
•	If the country name starts with 'T' – change it to 'Test'.
•	If the country name starts with 'P' – change it to 'In Progress'.
*/
Update addresses
set country = (
case 
when country like 'B%' then 'Blocked'
when country like 'T%' then 'Test'
when country like '%P' then 'In Progress'
end);

#OR 
-- (case left (country, 1)
-- when 'B' then 'Blocked'
-- when 'T' then 'Test'
-- when 'P' then 'In Progress'
-- end)

-- Delete
/*As you remember at the beginning of our work, we inserted and updated some data. 
Now you need to remove some addresses.	
Delete all addresses from table addresses, which id is divisible by 3.*/

delete from addresses
where id % 3 = 0;

-- Querying
-- 5
/*
Extract from the Insta Database (instd), info about all the users. 
Order the results by age descending then by username ascending.
*/
select 
username,
gender,
age
from users
order by age desc, username asc;

-- 6
/*
Extract from the database, 5 most commented photos with their count of comments. 
Sort the results by commentsCount, descending, then by id in ascending order.
*/
select 
p.id,
p.`date` as date_and_time,
p.`description`,
count(c.id) as commentsCount
from photos as p
join comments as c
on p.id = c.photo_id
group by p.id
order by commentsCount desc, p.id asc
limit 5;

-- 7
/*
When the user has the same id as its photo, it is considered Lucky User. 
Extract from the database all lucky users. 
Extract id_username (concat id + " " + username) and email of all lucky users. 
Order the results ascending by user id.
*/
select 
concat(u.id, ' ', u.username) as id_username,
email
from users as u
join users_photos as up
on u.id = up.photo_id
where u.id = up.user_id
order by up.user_id;

-- 8
/*
Extract from the database, photos id with their likes and comments. 
Order them by count of likes descending, then by comments count descending and lastly by photo id ascending.
*/
select 
p.id,
count(distinct l.id) as likes_count,
count(distinct c.id) as comments_count
from photos as p
left join likes as l
on p.id = l.photo_id
join comments as c
on p.id = c.photo_id
group by p.id
order by likes_count desc, comments_count desc, p.id;

#OR
select 
p.id,
(select count(*) from likes where photo_id = p.id) as likes_count,
(select count(*) from comments as c where p.id = c.photo_id) as comments_count
from photos as p
order by likes_count desc, comments_count desc, p.id;

-- 9
/*
Extract from the database those photos that their upload day is 10 and summarize their description. 
The summary must be 30 symbols long plus "..." at the end. Order the results by date descending order. 
*/
select 
concat(substring(`description`, 1, 30), '...') as summary, 
`date` 
from photos
where day(`date`) = 10
order by date desc;

-- 10
/*
Create a user defined function with the name udf_users_photos_count(username VARCHAR(30)) 
that receives a username and returns the number of photos this user has upload.
*/
DELIMITER &&
CREATE FUNCTION `udf_users_photos_count`(username VARCHAR(30)) 
RETURNS int
DETERMINISTIC
BEGIN
return (select 
count(up.photo_id) as photosCount #up.user_id
from users as u
join users_photos as up
on u.id = up.user_id
where u.username = username);
END
DELIMITER ;

-- 11
/*Create a stored procedure udp_modify_user which accepts the following parameters:
•	address
•	town 
udp_modify_user (address VARCHAR(30), town VARCHAR(30)) that receives an address and town 
and increase the age of the user by 10 years only if the given user exists. 
Show all needed info for this user: username, email, gender, age and job_title.*/

DELIMITER &&
CREATE PROCEDURE `udp_modify_user` (p_address VARCHAR(30), p_town VARCHAR(30))
BEGIN
update users as u
join address as a
on u.id = a.user_id
set age = age + 10
where a.address = p_address and a.town  = p.town;
END
DELIMITER ;



