/* 1. Write a query that returns all employees (employees.first_name, employees.last_name, employees.emp_no), 
their department number using either the department employee table (dept_emp.emp_no, dept_emp.dept_no) or the 
department manager table (dept_manager.emp_no, dept_manager.dept_no), their start date (employees.hire_date), 
their end date (salaries.emp_no, salaries.to_date), and a new column 'is_current_employee' that is a 1 if the employee is 
still with the company and 0 if not. */

USE employees;

SELECT 
  e.first_name, 
  e.last_name, 
  e.emp_no, 
  COALESCE(de.dept_no, dm.dept_no) AS dept_no, 
  e.hire_date, 
  s.to_date, 
  CASE 
    WHEN s.to_date = '9999-01-01' THEN 1 
    ELSE 0 
  END AS is_current_employee
FROM 
  employees AS e
  LEFT JOIN dept_emp AS de ON e.emp_no = de.emp_no
  LEFT JOIN dept_manager AS dm ON e.emp_no = dm.emp_no
  LEFT JOIN salaries AS s ON e.emp_no = s.emp_no
WHERE 
  s.to_date = (
    SELECT 
      MAX(to_date) 
    FROM 
      salaries 
    WHERE 
      emp_no = e.emp_no
  )
ORDER BY 
  e.last_name, 
  e.first_name;

/* 2. Write a query that returns all employees (employees.first_name, employees.last_name, employees.emp_no), 
their start date (employees.hire_date), their end date (salaries.emp_no, salaries.to_date), and a new column 'alpha_group' 
that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name. */

SELECT 
  e.first_name, 
  e.last_name, 
  e.emp_no, 
  e.hire_date, 
  s.to_date, 
  CASE 
    WHEN LEFT(e.last_name, 1) BETWEEN 'A' AND 'H' THEN 'A-H' 
    WHEN LEFT(e.last_name, 1) BETWEEN 'I' AND 'Q' THEN 'I-Q' 
    ELSE 'R-Z' 
  END AS alpha_group
FROM 
  employees AS e
  INNER JOIN salaries AS s ON e.emp_no = s.emp_no
WHERE 
  s.to_date = (
    SELECT 
      MAX(to_date) 
    FROM 
      salaries 
    WHERE 
      emp_no = e.emp_no
  )
ORDER BY 
  e.last_name, 
  e.first_name;

/* 3. How many employees (employees.birth_date) (current or previous) were born in each decade? */

SELECT 
  CONCAT(YEAR(employees.birth_date) DIV 10 * 10, '-', YEAR(employees.birth_date) DIV 10 * 10 + 9) AS decade, 
  COUNT(*) AS num_employees
FROM 
  employees
GROUP BY 
  decade
ORDER BY 
  decade;

/* 4. What is the current average salary rounded to the nearest cent (salaries.salary, salaries.emp_no) for each of the following
department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service (departments.dept_name, departments.dept_no) 
using the department manager (dept_manager.dept_no, dept_manager.emp.no) and department employee tables
(dept_emp.emp_no, dept_emp.dept_no) using mysql? */

SELECT 
  d.dept_name, 
  ROUND(AVG(s.salary), 2) AS avg_salary
FROM 
  departments AS d
  INNER JOIN dept_manager AS m ON d.dept_no = m.dept_no
  INNER JOIN dept_emp AS e ON d.dept_no = e.dept_no
  INNER JOIN salaries AS s ON e.emp_no = s.emp_no
WHERE 
  s.to_date = '9999-01-01' AND
  m.to_date = '9999-01-01' AND
  e.to_date = '9999-01-01'
GROUP BY 
  d.dept_name;





SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'employees';