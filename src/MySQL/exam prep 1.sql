CREATE DATABASE fsd;
use fsd;
CREATE TABLE coaches (
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(10)  not null,
last_name varchar(20) not null,
salary decimal (10,2) not null default 0,
coach_level int not null default 0
);


create table countries(
id int primary key auto_increment,
`name` varchar(45) not null
);

create table towns (
id int primary key auto_increment,
`name` varchar(45) not null,
country_id int not null,
constraint fk_towns_countries
foreign key (country_id)
references countries(id)
);

create table stadiums (
id int primary key auto_increment,
`name` varchar(45) not null,
capacity int not null,
town_id int not null,
constraint fk_stadiums_towns
foreign key (town_id)
references towns(id)
);

create table teams (
id int primary key auto_increment,
`name` varchar(45) not null,
established date not null,
fan_base bigint not null default 0,
stadium_id int not null,
constraint fk_teams_stadiums
foreign key (stadium_id)
references stadiums(id)
);

create table skills_data (
id int primary key auto_increment,
dribbling int default 0,
pace int default 0,
passing int default 0,
shooting int default 0,
speed int default 0,
strength int default 0
);

create table players (
id int primary key auto_increment,
first_name varchar(10) not null,
last_name varchar(20) not null,
age int not null default 0,
position char(1) not null,
salary decimal(10,2) not null default 0,
hire_date datetime,
skills_data_id int not null,
constraint fk_players_skills_data
foreign key (skills_data_id)
references skills_data(id),
team_id int,
constraint fk_players_teams
foreign key (team_id)
references teams(id)
);

create table players_coaches (
player_id int,
coach_id int,
constraint pk_players_coaches
primary key (player_id, coach_id),
constraint fk_players_coaches_players
foreign key (player_id)
references players(id),
constraint fk_players_coaches_coaches
foreign key (coach_id)
references coaches(id)
);
-- ----- DML -----
-- insert
/*
You will have to insert records of data into the coaches table, based on the players table. 
For players with age over 45 (inclusive), insert data in the coaches table with the following values:
•	first_name – set it to first name of the player
•	last_name – set it to last name of the player.
•	salary – set it to double as player’s salary. 
•	coach_level – set it to be equals to count of the characters in player’s first_name.
*/
insert into coaches (first_name, last_name, salary, coach_level)
SELECT first_name, last_name, salary * 2, char_length(first_name) FROM players
WHERE age >= 45;

-- update
/*
Update all coaches, who train one or more players and their first_name starts with ‘A’. 
Increase their level with 1.
*/
update coaches
set coach_level = coach_level + 1
where first_name like 'A%'
and id = (select coach_id from players_coaches where coach_id = id limit 1);
#AND id IN (select coach_id from players_coaches)

-- delete
/*
As you remember at the beginning of our work, we promoted several football players to coaches. 
Now you need to remove all of them from the table of players in order for our database to be updated accordingly.	
Delete all players from table players, which are already added in table coaches. 
*/
delete from players
where age >= 45;


-- ----- Quering -----
-- 5
/*
Extract from the Football Scout Database (fsd) database, info about all of the players. 
Order the results by players - salary descending.
*/
select 
first_name,
age,
salary
from players
order by salary desc;

-- 6
/*
One of the coaches wants to know more about all the young players (under age of 23) 
who can strengthen his team in the offensive (played on position ‘A’). 
As he is not paying a transfer amount, he is looking only for those who have not signed a contract so far 
(haven’t hire_date) and have strength of more than 50. Order the results ascending by salary, then by age.
*/
select 
p.id,
concat(p.first_name, ' ', p.last_name) as full_name,
p.age,
p.`position`,
p.hire_date
FROM players as p
JOIN skills_data as sd
ON p.skills_data_id = sd.id
where p.age < 23  and p.`position` = 'A' and p.hire_date is null and sd.strength > 50 
order by p.salary asc, p.age asc;

-- 7
/*
Extract from the database all of the teams and the count of the players that they have.
Order the results descending by count of players, then by fan_base descending. 
*/
select 
t.`name`,
t.established,
t.fan_base,
(select count(*) from players where team_id = t.id) as 'players_count'
from teams as t
order by players_count desc, t.fan_base desc;

select 
t.`name`,
t.established,
t.fan_base,
count(p.id) as 'players_count' #броим по уникална стойост
from teams as t
left join players as p
on p.team_id = t.id
group by t.id
order by players_count desc, fan_base desc;

-- 8
/*
Extract from the database, the fastest player (having max speed), in terms of towns where their team played.
Order players by speed descending, then by town name.
Skip players that played in team ‘Devify’
*/
select 
max(sd.speed) as 'max_speed',
t.`name`
from towns as t
left join stadiums as s
on t.id = s.town_id
left join teams as te
on s.id = te.stadium_id
left join players as p
on te.id = p.team_id
left join skills_data as sd
on sd.id = p.skills_data_id
where te.`name`!= 'Devify'
group by t.id
order by max_speed desc, t.`name`;


-- 9
/*
 And like everything else in this world, everything is ultimately about finances. 
 Now you need to extract detailed information on the amount of all salaries given to football players 
 by the criteria of the country in which they played.
If there are no players in a country, display NULL.  
Order the results by total count of players in descending order, then by country name alphabetically.
*/
SELECT 
c.`name`,
count(p.id) as total_count_of_players,
sum(p.salary) as total_sum_of_salaries
from countries as c
left join towns as t
on c.id = t.country_id
left join stadiums as s
on t.id = s.town_id
left join teams as te
on s.id = te.stadium_id
left join players as p
on te.id = p.team_id
group by c.id
order by total_count_of_players desc, c.`name`
;

-- Functions and Procedures
-- 10
/*
Create a user defined function with the name udf_stadium_players_count (stadium_name VARCHAR(30)) 
that receives a stadium’s name and returns the number of players that play home matches there.
*/

delimiter $$
CREATE FUNCTION `udf_stadium_players_count`(stadium_name VARCHAR(30))
 RETURNS varchar(30) CHARSET utf8mb4
DETERMINISTIC
BEGIN
return (select  
count(p.id) as count
from players as p
join teams as t
on p.team_id = t.id
join stadiums as s
on t.stadium_id = s.id
where s.`name` = stadium_name);
END
delimiter ;

select udf_stadium_players_count('Jaxworks');

-- 11
/*
Create a stored procedure udp_find_playmaker which accepts the following parameters:
•	min_dribble_points -> skills_data
•	team_name (with max length 45) -> teams, players
 And extracts data about the players with the given skill stats (more than min_dribble_points), 
 played for given team (team_name) and have more than average speed for all players. 
Order players by speed descending. Select only the best one.
Show all needed info for this player: full_name, age, salary, dribbling, speed, team name.
*/
delimiter $$
CREATE PROCEDURE `udp_find_playmaker`(min_dribble_points INT, team_name varchar(45))
BEGIN
select 
concat(p.first_name, ' ', p.last_name) as full_name,
p.age,
p.salary,
s.dribbling,
s.speed,
t.`name` as 'team_name'
from players as p
join skills_data as s
on p.skills_data_id = s.id
join teams as t
on p.team_id = t.id
where s.dribbling > min_dribble_points and t.`name` = team_name
order by s.speed desc
limit 1;
END
delimiter ;

call udp_find_playmaker(20,'Skyble');

