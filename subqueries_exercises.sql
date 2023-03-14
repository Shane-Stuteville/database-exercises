USE employees;
show tables;
select * from departments;
select * from dept_emp;
select * from dept_manager;
select * from employees;
select * from salaries;
select * from titles;


/* 1. Find all the current employees(first_name, last_name) with the same hire date (hire_date) as employee 101010 (emp_no) 
using a subquery in mysql and show first_name, last_name, and emp_no. */
SELECT emp_no, first_name, last_name
FROM employees 
WHERE hire_date = (SELECT hire_date 
                   FROM employees 
                   WHERE emp_no = 101010)
  AND (SELECT dept_no FROM dept_emp WHERE emp_no = employees.emp_no AND to_date > NOW()) 
      = (SELECT dept_no FROM dept_emp WHERE emp_no = 101010 AND to_date > NOW());

/* 2. Find all the titles (titles table and title row and emp_no row) ever held by all current employees (employees table) 
with the first name (first_name) Aamod showing first_name, last_name, titles, and emp_no using mysql. */
SELECT e.first_name, e.last_name, t.title, t.from_date, t.to_date, t.emp_no
FROM employees e
INNER JOIN titles t ON e.emp_no = t.emp_no
WHERE e.first_name = 'Aamod'
AND t.to_date > NOW();

/* 3. How many people in the employees table (employees.emp_no, employees.hire_date) are no longer working for the company 
(salaries.emp_no, salaries.to_date) using the employees and salaries table and only showing the answer using mysql?
 Give the answer in a comment in your code. */
 -- 59,900
SELECT COUNT(DISTINCT e.emp_no) as num_people_no_longer_working
FROM employees e
LEFT JOIN (
    SELECT emp_no, MAX(to_date) as to_date
    FROM salaries
    GROUP BY emp_no
) s ON e.emp_no = s.emp_no
WHERE s.to_date < NOW() OR s.to_date IS NULL;

/* 4. Find all the current department managers (dept_manager.emp_no, dept_manager.to_date) that are 
female (employees.emp_no, employees.first_name, employees.last_name, employees.gender) showing only the first_name and last_name,
using mysql. List their names in a comment in your code. */
-- Isamu Legleitner, Karsten Sigstam, Leon DasSarma, and Hilary Kambil

SELECT DISTINCT e.first_name, e.last_name
FROM employees e
INNER JOIN dept_manager dm ON e.emp_no = dm.emp_no
WHERE dm.to_date > NOW()
AND e.gender = 'F';

/* 5. Find all the employees (employees.emp_no, employees.first_name, employees.last_name) who currently have a higher salary
 than the companies overall, historical average salary (salaries.salary and salaries.emp_no) showing first_name,
 last_name, salary, and historical average salary using mysql. */
SELECT e.first_name, e.last_name, s.salary, avg_salary.avg_salary
FROM employees e
INNER JOIN salaries s ON e.emp_no = s.emp_no
INNER JOIN (
    SELECT AVG(salary) AS avg_salary
    FROM salaries
) avg_salary
WHERE s.to_date > NOW()
AND s.salary > avg_salary.avg_salary;

/* 6. How many current salaries are within 1 standard deviation of the highest current salary 
(salaries.salary and salaries.to_date) and what percentage of salaries is this using mysql? 
(Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?
* Hint You will likely use multiple subqueries in a variety of ways
* Hint It's a good practice to write out all of the small queries that you can. Add a comment above the query showing the 
number of rows returned. You will use this number (or the query that produced it) in other, larger queries. */

SELECT
    COUNT(*) AS num_salaries_within_stdev,
    (COUNT(*) / (SELECT COUNT(*) FROM salaries WHERE to_date > NOW())) * 100 AS percentage_within_stdev
FROM salaries
JOIN (
    SELECT
        MAX(salary) - STDDEV_POP(salary) AS lower_bound,
        MAX(salary) AS upper_bound
    FROM salaries
    WHERE to_date > NOW()
) AS bounds
WHERE
    to_date > NOW()
    AND salary BETWEEN bounds.lower_bound AND bounds.upper_bound;


-- BONUS --

/* 1. Find all the current department managers (dept_manager.emp_no, dept_manager.to_date) that are 
female (employees.emp_no, employees.first_name, employees.last_name, employees.gender) showing the first_name, last_name, and department
(departments.dept_no, departments.dept_name) using mysql. */
SELECT e.first_name, e.last_name, d.dept_name
FROM employees e
INNER JOIN dept_manager dm ON e.emp_no = dm.emp_no
INNER JOIN departments d ON dm.dept_no = d.dept_no
WHERE dm.to_date > NOW()
AND e.gender = 'F';

/* 2. Find the first and last name (employee.first_name, employee.last_name, employee.emp_id) of the employee with the highest salary
(salaries.emp_no, salaries.salary). */
SELECT e.first_name, e.last_name, e.emp_no
FROM employees e
INNER JOIN salaries s ON e.emp_no = s.emp_no
WHERE s.salary = (SELECT MAX(salary) FROM salaries);

/* 3. Find the department name (departments.dept_no, departments.dept_name) that the employee with the highest salary
(salaries.emp_no, salaries.salary) works in using mysql. */
SELECT d.dept_no, d.dept_name
FROM departments d
INNER JOIN dept_emp de ON d.dept_no = de.dept_no
INNER JOIN salaries s ON de.emp_no = s.emp_no
WHERE s.salary = (SELECT MAX(salary) FROM salaries);

/* 4. Who is the highest paid (salaries.emp_no, salaries.salary) employee (employees.emp_no, employees.first_name,
 employees.last_name) within each department (departments.dept_no, departments.dept_name) (dept_manager.emp_no, dept_manager.dept_no)
 showing first_name, last_name, department, and salary using mysql? */
SELECT e.first_name, e.last_name, d.dept_name, s.salary
FROM (
    SELECT de.dept_no, MAX(s.salary) AS max_salary
    FROM dept_emp de
    INNER JOIN salaries s ON de.emp_no = s.emp_no
    WHERE de.to_date > NOW()
    GROUP BY de.dept_no
) max_salaries
INNER JOIN dept_emp de ON max_salaries.dept_no = de.dept_no
INNER JOIN employees e ON de.emp_no = e.emp_no
INNER JOIN salaries s ON e.emp_no = s.emp_no
INNER JOIN departments d ON de.dept_no = d.dept_no
WHERE s.salary = max_salaries.max_salary
ORDER BY d.dept_name ASC;

