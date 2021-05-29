-- -----EXC1-----
SELECT `title` FROM `books`
WHERE SUBSTRING(`title`, 1, 3) = 'The'
ORDER BY `id` ASC;

-- -----EXC2-----
SELECT replace(`title`, 'The', '***') AS 'relacement', `title` AS 'original'
FROM `books`
WHERE substring(`title`, 1, 3) = 'The'
ORDER BY `id`;

-- -----EXC3-----
SELECT * FROM `books`;
SELECT round(sum(`cost`), 2) AS 'total'
FROM `books`;

/*UPDATE `books` 
SET `cost` = round(sum(`cost`), 2);*/

-- -----EXC4-----
SELECT * FROM `authors`;
SELECT concat(`first_name`, ' ', `last_name`) AS 'Full Name',
timestampdiff(DAY,`born`, `died`) AS 'Days Lived'  FROM `authors`;

 -- -----EXC5-----
 SELECT * FROM `books`;
 SELECT `title` FROM `books`
 WHERE `title` LIKE 'Harry Potter%'
 ORDER BY `id`;

