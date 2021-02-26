-- Create base table (emp_no identified as main key)
CREATE TABLE employee_data(
	emp_no INTEGER PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	birth_date VARCHAR(12),
	gender VARCHAR(5),
	hire_date VARCHAR(12)
);

-- Creation of subsequent tables

	CREATE TABLE title_table (
		emp_no INTEGER,
		title VARCHAR(100),
		from_date VARCHAR(50),
		to_date VARCHAR(50),
		FOREIGN KEY (emp_no) REFERENCES employee_data(emp_no)
);


CREATE TABLE departments (
	dept_no VARCHAR(10) PRIMARY KEY,
	dept_name VARCHAR(100)
);

CREATE TABLE employee_dept (
	dept_no VARCHAR(10),
	emp_no INTEGER NOT NULL,
	from_date VARCHAR(12) NOT NULL,
	to_date VARCHAR(12) NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employee_data(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

CREATE TABLE dept_managers(
	dept_no VARCHAR(10),
	emp_no INTEGER NOT NULL,
	from_date VARCHAR(12) NOT NULL,
	to_date VARCHAR(12) NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employee_data(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);


CREATE TABLE salaries(
	emp_no INTEGER NOT NULL,
	salary INTEGER NOT NULL,
	from_date VARCHAR(12) NOT NULL,
	to_date VARCHAR(12) NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employee_data(emp_no)
);


-- Beginning of queries

-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT a.emp_no, a.last_name, a.first_name, a.gender, b.salary
FROM employee_data AS a
LEFT JOIN salaries AS b
ON a.emp_no = b.emp_no;

-- 2. List employees who were hired in 1986.
SELECT *
FROM employee_data
WHERE hire_date LIKE '%1986';

-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT a.dept_no, c.dept_name, a.emp_no, b.last_name, b.first_name, a.from_date, a.to_date
FROM dept_managers AS a
LEFT JOIN employee_data AS b
ON a.emp_no = b.emp_no
LEFT JOIN departments AS c
ON a.dept_no = c.dept_no;

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT a.emp_no, b.last_name, b.first_name, c.dept_name
FROM employee_dept AS a
INNER JOIN employee_data AS b
ON a.emp_no = b.emp_no
INNER JOIN departments AS c
ON a.dept_no = c.dept_no;

-- 5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT *
FROM employee_data
WHERE first_name like 'Hercules'
AND last_name like 'B%';

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT a.emp_no, b.last_name, b.first_name, c.dept_name
FROM employee_dept AS a
INNER JOIN employee_data AS b
ON a.emp_no = b.emp_no
INNER JOIN departments AS c
ON a.dept_no = c.dept_no
WHERE c.dept_name = 'Sales';



-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT a.emp_no, b.last_name, b.first_name, c.dept_name
FROM employee_dept AS a
INNER JOIN employee_data AS b
ON a.emp_no = b.emp_no
INNER JOIN departments AS c
ON a.dept_no = c.dept_no
WHERE c.dept_name = 'Development' OR c.dept_name = 'Sales';



-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(*) FROM employee_data
GROUP BY last_name
ORDER BY COUNT(*) DESC;


