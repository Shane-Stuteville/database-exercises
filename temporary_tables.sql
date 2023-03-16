USE employees;

SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'employees';

DROP DATABASE pagel_2192;

CREATE DATABASE pagel_2192;

SHOW databases;

USE pagel_2192;

SHOW tables;

SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'employees_with_departments';


/* 1. Create a temporary table called "employees_with_departments" within the "pagel_2192" database. The information will come from
the "employees" database. The employees_with_departments table will contain first_name (employees.employees.first_name), 
last_name (employees.employees.last_name), dept_name (employees.employees.emp_no, employees.dept_emp.emp_no, employees.dept_emp.dept_no, 
employees.dept_manager.emp_no, employees.dept_manager.dept_no, employees.departments.dept_no, employees.departments.dept_name) for employees
currently within that department (dept_manager.to_date, dept_emp.to_date) */

USE pagel_2192;

CREATE TEMPORARY TABLE pagel_2192.employees_with_departments AS 
SELECT e.first_name, e.last_name, d.dept_name  
FROM employees.employees AS e  
INNER JOIN employees.dept_emp AS de ON e.emp_no = de.emp_no AND de.to_date = '9999-01-01'  
INNER JOIN employees.departments AS d ON de.dept_no = d.dept_no  
UNION  
SELECT e.first_name, e.last_name, d.dept_name  
FROM employees.employees AS e  
INNER JOIN employees.dept_manager AS dm ON e.emp_no = dm.emp_no AND dm.to_date = '9999-01-01'  
INNER JOIN employees.departments AS d ON dm.dept_no = d.dept_no;
SELECT * FROM pagel_2192.employees_with_departments;






/* Using the employees database create a temporary table called employees_with_departments
in the "pagel_2192" database. The data created for the employees_with_departments table must write to the pagel_2192 database and
not the employees database because I do not have write permissions to the employees database. The new temporary table 
employees_with_departments needs to contain fromm the employees database 


Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", it means that the 
query was attempting to write a new table to a database that you can only read. 
	
	d. What is another way you could have ended up with this same table? */

-- DROP TEMPORARY TABLE IF EXISTS pagel_2192.employees_with_departments;




/* 		a. Add a column named full_name (employees.first_name, employees.last_name) to the pagel_2192.employees_with_departments table.
		It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns. 
        b. Update the table so that the full_name column contains the correct data.*/
	



/* 		c. Remove the first_name (employees.first_name) and last_name (employees.last_name)
		columns from the employees_with_departments table. */
        

     


/* 2. Create a temporary table based on the payment table from the sakila database.
Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents 
of the payment. For example, 1.99 should become 199. */

USE pagel_2192;

CREATE TEMPORARY TABLE pagel_2192.temp_payments AS
SELECT payment_id, customer_id, staff_id, rental_id, CAST(amount * 100 AS UNSIGNED) AS amount_cents, payment_date
FROM sakila.payment;

SELECT * FROM pagel_2192.temp_payments;


/* 3. Find out how the current average pay in each department compares to the overall current pay for everyone at the company. 
For this comparison, you will calculate the z-score for each salary. In terms of salary, what is the best department 
right now to work for? The worst? */