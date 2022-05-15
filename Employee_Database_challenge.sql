SELECT first_name, last_name, emp_no
FROM employees

Select title, from_date, to_date
From Titles

--Deliverable 1
SELECT e.emp_no,
    e.first_name,
	e.last_name,
	ti.title,
    ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees as e
LEFT JOIN Titles as ti
ON e.emp_no = ti.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
Order by emp_no;


SELECT emp_no,first_name, last_name, title
FROM retirement_titles

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title

INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;


SELECT COUNT(title) as title_count,
	title
Into Retiring_Titles
from unique_titles
GROUP BY title
ORDER BY title_count desc;

SELECT emp_no, first_name, last_name, birth_date
FROM employees;



-- Deliverable 2
SELECT distinct on (e.emp_no) e.emp_no,
    e.first_name,
	e.last_name,
	e.birth_date,
    de.from_date,
	de.to_date,
	ti.title
INTO Mentorship_Eligibility
FROM employees as e
JOIN dept_emp as de 
ON e.emp_no = de.emp_no
JOIN titles as ti
ON e.emp_no = ti.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31') and de.to_date = '9999-01-01'
Order by e.emp_no;


--summary new queries 

--bringing dept name into the unique table to analyze how many employees per department is retiring.
SELECT DISTINCT ON (ut.emp_no) ut.emp_no,
    ut.first_name,
	ut.last_name,
    de.from_date,
	de.to_date,
	ut.title,
	d.dept_name
INTO updated_unique_titles
FROM unique_titles as ut
JOIN dept_emp as de 
ON ut.emp_no = de.emp_no
JOIN Departments as d
ON de.dept_no = d.dept_no
Order by ut.emp_no;


--changing mentorship elgibility to look at employees not retiring soon versus just the age of employees.
SELECT distinct on (e.emp_no) e.emp_no,
    e.first_name,
	e.last_name,
	e.birth_date,
    de.from_date,
	de.to_date,
	ti.title
INTO New_Mentorship_Eligibility
FROM employees as e
JOIN dept_emp as de 
ON e.emp_no = de.emp_no
JOIN titles as ti
ON e.emp_no = ti.emp_no
WHERE (e.birth_date not between '1952-01-01' AND '1955-12-31') and de.to_date = '9999-01-01'
Order by e.emp_no;