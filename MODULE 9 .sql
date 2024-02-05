 CREATE TABLE employees(
 emp_no VARCHAR,
emp_title_id VARCHAR, 
  birth_date DATE,
    first_name VARCHAR,
    last_name VARCHAR,
    sex VARCHAR,
    hire_date DATE);

SELECT * FROM employees;


Create TABLE dept_emp
(emp_nop VARCHAR NOT NULL,
dept_no VARCHAR NOT NULL);	


SELECT * FROM dept_emp;
	
 Create TABLE dept_manager(
	 dept_no VARCHAR NOT NULL,
     emp_no VARCHAR NOT NULL);
	 
 SELECT * FROM dept_manager;
	 
CREATE TABLE salaries
(emp_no INTEGER NOT NULL ,
 salary INTEGER NOT NULL);
 
 SELECT * FROM salaries;

CREATE TABLE departments
(dept_no VARCHAR NOT NULL,
 dept_name VARCHAR NOT NULL);

SELECT * FROM departments;

CREATE TABLE titles
(title_id VARCHAR NOT NULL,
 title VARCHAR NOT NULL);

SELECT*FROM titles;

-- ADJUSTING DATA
ALTER TABLE employees
ALTER COLUMN emp_no SET NOT NULL,
ALTER COLUMN emp_title_id SET NOT NULL,
ALTER COLUMN birth_date SET NOT NULL,
ALTER COLUMN first_name SET NOT NULL,
ALTER COLUMN last_name SET NOT NULL,
ALTER COLUMN hire_date SET NOT NULL,
ALTER COLUMN sex SET  NOT NULL;

ALTER TABLE salaries
ALTER COLUMN emp_no TYPE VARCHAR;


--- 1. JOINING EMPLOYEES WITH SALRY 


SELECT employees.emp_no,
       employees.last_name,
       employees.first_name,
       employees.sex,
       salaries.salary
FROM employees
JOIN salaries ON employees.emp_no = salaries.emp_no;


-- 2 List the first name, last name, and hire date for the employees who were hired in 1986.

SELECT first_name, last_name, hire_date 
FROM employees
WHERE hire_date BETWEEN '1/1/1986' AND '12/31/1986'
ORDER BY hire_date;

-Adjusting data
ALTER TABLE dept_emp
RENAME COLUMN emp_nop TO emp_no;

-- 3 List the manager of each department along with their department number, department name, employee number, last name, and first name.

SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM departments
JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no
JOIN employees
ON dept_manager.emp_no = employees.emp_no; 

-- 4 List the department number for each employee along with that employee’s employee number, last name, first name, and department name

SELECT dept_emp.emp_no, 
       employees.last_name, 
       employees.first_name, 
       departments.dept_name
FROM dept_emp
JOIN employees ON dept_emp.emp_no = employees.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no;


-- 5 List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B (2 points)
Select employees.first_name, 
employees.last_name,
employees.sex
FROM employees
WHERE first_name = 'Hercules'
and last_name Like 'B%'

-- 6 List each employee in the Sales department, including their employee number, last name, and first name (2 points)
SELECT departments.dept_name, 
       employees.last_name,
       employees.first_name
FROM dept_emp
JOIN employees ON dept_emp.emp_no = employees.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';

-- 7.List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name (4 points)

SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales' 
OR departments.dept_name = 'Development';

-- 8.List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name) (4 points)

SELECT last_name, COUNT(last_name) AS "FREQUENCY"
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;