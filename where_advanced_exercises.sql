-- Create a file named where_advanced_exercises.sql. Use the employees database.
USE employees;
-- 1. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. 
-- What is the employee number of the top three results?
SHOW Tables; -- Uning the 'employees' table.
SELECT * FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya') LIMIT 3;

-- 2. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, 
-- but use OR instead of IN. What is the employee number of the top three results? 
-- Does it match the previous question? Yes
SELECT * FROM employees
WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya' LIMIT 3;

-- 3. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, 
-- and who is male. What is the employee number of the top three results.
SELECT * FROM employees
WHERE (first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya') AND gender = 'M' LIMIT 3;

-- 4. Find all unique last names that start with 'E'.
SELECT DISTINCT last_name FROM employees
WHERE last_name LIKE 'E%';

-- 5. Find all unique last names that start or end with 'E'.
SELECT DISTINCT last_name FROM employees
WHERE last_name LIKE 'E%' OR last_name LIKE '%e';

-- 6. Find all unique last names that end with E, but does not start with E?
SELECT DISTINCT last_name FROM employees
WHERE last_name LIKE '%e' AND last_name NOT LIKE 'E%';

-- 7. Find all unique last names that start and end with 'E'.
SELECT DISTINCT last_name FROM employees
WHERE last_name LIKE 'E%' AND last_name LIKE '%e';

-- 8. Find all current or previous employees hired in the 90s. Enter a comment with top three employee numbers.
SELECT * FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';
-- TOP three employee numbers are 10008, 10011, and 10012.

-- 9. Find all current or previous employees born on Christmas. Enter a comment with top three employee numbers.
SELECT * FROM employees
WHERE MONTH(birth_date) = 12 AND DAY(birth_date) = 25;
-- TOP three emp_no are 10078, 10115, and 10261

-- 10. Find all current or previous employees hired in the 90s and born on Christmas. 
-- Enter a comment with top three employee numbers.
SELECT * FROM employees
WHERE birth_date LIKE '%-12-25' AND hire_date BETWEEN '1990-01-01' AND '1999-12-31';

-- 11. Find all unique last names that have a 'q' in their last name.
SELECT DISTINCT last_name 
FROM employees 
WHERE LOWER(last_name) LIKE '%q%';

-- 12. Find all unique last names that have a 'q' in their last name but not 'qu'.
SELECT DISTINCT last_name 
FROM employees 
WHERE LOWER(last_name) 
LIKE '%q%' AND LOWER(last_name) NOT LIKE '%qu%';
