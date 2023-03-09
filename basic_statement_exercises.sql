-- 1. Use the albums_db database.
USE albums_db;
-- 2. What is the primary key for the albums table?
-- Show albums tables
SHOW TABLES;
-- Show table properties
SHOW CREATE TABLE albums;
-- Primary key is 'id'
-- 3. What does the column named 'name' represent? --> A variable string upto 240 characters
-- 4. What do you think the sales column represents? --> A float that cannot be NULL
-- 5.Find the name of all albums by Pink Floyd. -- > The Dark Side of the Moon and The Wall
SELECT * From albums;
SELECT artist, name FROM albums
WHERE artist = 'Pink Floyd';
-- 6. What is the year Sgt. Pepper's Lonely Hearts Club Band was released? --> 1967
SELECT name, release_date FROM albums
WHERE name = 'Sgt. Pepper''s Lonely Hearts Club Band';
-- 7. What is the genre for the album Nevermind? -->Grunge, Alternative rock
SELECT name, genre FROM albums
WHERE name = 'Nevermind';
-- 8. Which albums were released in the 1990s? --> The Bodyguard, Jagged Little Pill, Come On Over, Falling into You,
-- Let's Talk About Love, etc.
SELECT name, release_date FROM albums
WHERE release_date BETWEEN '1990' AND '1999';
-- 9. Which albums had less than 20 million certified sales? See below.
SELECT name, sales FROM albums
WHERE sales < '20';