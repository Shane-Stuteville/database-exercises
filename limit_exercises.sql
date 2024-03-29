/* 1. Create a new SQL script named limit_exercises.sql. */

/* 2. MySQL provides a way to return only unique results from our queries with the keyword DISTINCT. 
For example, to find all the unique titles within the company, we could run the following query:
SELECT DISTINCT title FROM titles;
List the first 10 distinct last name sorted in descending order. */
USE employees;
-- SELECT * FROM employees;
SELECT DISTINCT last_name FROM employees
ORDER BY last_name DESC LIMIT 10;

/* 3. Find all previous or current employees hired in the 90s and born on Christmas. Find the first 
5 employees hired in the 90's by sorting by hire date and limiting your results to the first 5 records. 
Write a comment in your code that lists the five names of the employees returned. */
-- Alselm Cappello, Utz Mandell, Bouchung Schreiter, Baocai Kushner, Petter Stroustrup
SELECT * FROM employees
WHERE birth_date LIKE '%-12-25' AND hire_date BETWEEN '1990-01-01' AND '1999-12-31'
ORDER BY hire_date ASC LIMIT 5;

/* 4. Try to think of your results as batches, sets, or pages. The first five results are your first page. 
The five after that would be your second page, etc. Update the query to find the tenth page of results.
LIMIT and OFFSET can be used to create multiple pages of data. What is the relationship between 
OFFSET (number of results to skip), LIMIT (number of results per page), and the page number? */
-- Offset will begin displaying the results into the count and limit will adjust the quantity of returned results
SELECT * FROM employees
ORDER BY last_name DESC LIMIT 5 OFFSET 45;
