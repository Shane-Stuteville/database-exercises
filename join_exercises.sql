-- Join Example Database

-- 1. Use the join_example_db. Select all the records from both the users and roles tables.
USE join_example_db;

SELECT * FROM users
UNION
SELECT * FROM roles;

/* 2. Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. 
Before you run each query, guess the expected number of results. */

-- JOIN
SELECT * FROM users
JOIN roles ON users.role_id = roles.id;

-- LEFT JOIN
SELECT * FROM users
LEFT JOIN roles ON users.role_id = roles.id;

-- RIGHT JOIN
SELECT * FROM users
RIGHT JOIN roles ON users.role_id = roles.id;

/* 3. Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. 
Use count and the appropriate join type to get a list of roles along with the number of users that has the role. 
Hint: You will also need to use group by in the query. */
SELECT roles.name, COUNT(users.id) AS user_count
FROM roles
LEFT JOIN users ON roles.id = users.role_id
GROUP BY roles.name;

-- Employees Database

-- 1. Use the employees database.
USE employees;

/* 2. Using the example in the Associative Table Joins section as a guide, write a query that shows each department 
along with the name of the current manager for that department. */
SELECT departments.dept_name, CONCAT(employees.first_name, ' ', employees.last_name) AS manager_name
FROM departments
INNER JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
INNER JOIN employees ON dept_manager.emp_no = employees.emp_no
WHERE dept_manager.to_date = '9999-01-01';

-- 3. Find the name of all departments currently managed by women.
SELECT departments.dept_name, CONCAT(employees.first_name, ' ', employees.last_name) AS manager_name
FROM departments
INNER JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
INNER JOIN employees ON dept_manager.emp_no = employees.emp_no
WHERE dept_manager.to_date = '9999-01-01' AND employees.gender = 'F';

-- 4. Find the current titles of employees currently working in the Customer Service department.
SELECT titles.title, COUNT(*) AS title_count
FROM titles
INNER JOIN employees ON titles.emp_no = employees.emp_no
INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Customer Service' AND dept_emp.to_date = '9999-01-01'
GROUP BY titles.title;

-- 5. Find the current salary of all current managers.
SELECT CONCAT(employees.first_name, ' ', employees.last_name) AS manager_name, salaries.salary, departments.dept_name
FROM employees
INNER JOIN dept_manager ON employees.emp_no = dept_manager.emp_no
INNER JOIN salaries ON employees.emp_no = salaries.emp_no
INNER JOIN departments ON dept_manager.dept_no = departments.dept_no
WHERE dept_manager.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01';

-- 6. Find the number of current employees in each department.
SELECT departments.dept_no, departments.dept_name, COUNT(*) AS num_employees
FROM departments
INNER JOIN dept_emp ON departments.dept_no = dept_emp.dept_no
WHERE dept_emp.to_date = '9999-01-01'
GROUP BY departments.dept_no, departments.dept_name;

-- 7. Which department has the highest average salary? Hint: Use current not historic information.
SELECT departments.dept_name, AVG(salaries.salary) AS average_salary
FROM departments
INNER JOIN dept_emp ON departments.dept_no = dept_emp.dept_no
INNER JOIN salaries ON dept_emp.emp_no = salaries.emp_no
WHERE dept_emp.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01'
GROUP BY departments.dept_no
ORDER BY AVG(salaries.salary) DESC
LIMIT 1;

-- 8. Who is the highest paid employee in the Marketing department?
SELECT employees.first_name, employees.last_name
FROM employees
INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
INNER JOIN salaries ON employees.emp_no = salaries.emp_no
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Marketing' AND dept_emp.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01'
ORDER BY salaries.salary DESC
LIMIT 1;

-- 9. Which current department manager has the highest salary?
SELECT employees.first_name, employees.last_name, salaries.salary, departments.dept_name
FROM employees
INNER JOIN dept_manager ON employees.emp_no = dept_manager.emp_no
INNER JOIN salaries ON employees.emp_no = salaries.emp_no
INNER JOIN departments ON dept_manager.dept_no = departments.dept_no
WHERE dept_manager.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01'
ORDER BY salaries.salary DESC
LIMIT 1;

-- 10. Determine the average salary for each department. Use all salary information and round your results.
SELECT departments.dept_name, ROUND(AVG(salaries.salary), 2) AS avg_salary
FROM departments
INNER JOIN dept_emp ON departments.dept_no = dept_emp.dept_no
INNER JOIN salaries ON dept_emp.emp_no = salaries.emp_no
GROUP BY departments.dept_name;

-- 11. Bonus Find the names of all current employees, their department name, and their current manager's name.
SELECT CONCAT(employees.first_name, ' ', employees.last_name) AS employee_name, departments.dept_name, CONCAT(managers.first_name, ' ', managers.last_name) AS manager_name
FROM employees
INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
INNER JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
INNER JOIN employees AS managers ON dept_manager.emp_no = managers.emp_no
WHERE dept_emp.to_date = '9999-01-01' AND dept_manager.to_date = '9999-01-01';



