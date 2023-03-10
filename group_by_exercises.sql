-- 1. Create a new file named group_by_exercises.sql

/* 2. In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? 
Answer that in a comment in your SQL file. */
-- 6 unique titles
USE employees;
SELECT title AS unique_titles, 
COUNT(DISTINCT title) AS total_unique_titles 
FROM titles 
GROUP BY title;

-- 3. Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.
SELECT last_name
FROM employees
WHERE last_name LIKE 'E%' AND last_name LIKE '%E'
GROUP BY last_name;


-- 4. Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
SELECT DISTINCT first_name, last_name
FROM employees
WHERE last_name LIKE 'E%' AND last_name LIKE '%E'
ORDER BY last_name, first_name;

-- 5. Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
-- Chleq, Lindqvist, Qiwen
SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';

-- 6. Add a COUNT() to your results (the query above) to find the number of employees with the same last name.
SELECT last_name, COUNT(*) as num_employees
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY last_name;

/* 7. Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees 
for each gender with those names. */
SELECT gender, COUNT(*) AS num_employees
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY gender;

-- 8. Using your query that generates a username for all of the employees, generate a count employees for each unique username.
SELECT username, COUNT(*) AS num_employees
FROM (
    SELECT CONCAT(LEFT(first_name, 1), 
		SUBSTRING(last_name, -4), '_', DATE_FORMAT(birth_date, '%m%y')) 
        AS username
    FROM employees
) AS subquery
GROUP BY username;

/* 9. From your previous query, are there any duplicate usernames? What is the higest number of times a username shows up? 
Bonus: How many duplicate usernames are there from your previous query? */
SELECT username, COUNT(*) as count_duplicates
FROM (
  SELECT CONCAT(LEFT(first_name, 1), 
  SUBSTRING(last_name, -4), '_', MONTH(birth_date), RIGHT(YEAR(birth_date), 2)) 
  AS username
  FROM employees
) AS subquery
GROUP BY username
HAVING COUNT(*) > 1;

