-- Employee_Database_challenge Deliverable 1

SELECT * FROM employees;
SELECT * FROM titles;

----Steps 1 -7
SELECT e.emp_no, 
       e.first_name, 
	   e.last_name, 
       t.title, 
	   t.from_date, 
	   t.to_date
INTO retirement_titles
FROM employees AS e
LEFT JOIN titles AS t ON (e.emp_no = t.emp_no)
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY emp_no;

SELECT * FROM retirement_titles; 
SELECT * FROM dept_emp;
SELECT * FROM titles;

SELECT COUNT (*) FROM retirement_titles;

SELECT r.emp_no, 
	   r.first_name,
	   r.last_name,
	   r.title,
	   r.from_date,
	   r.to_date	  
FROM retirement_titles AS r
ORDER BY r.emp_no, r.to_date DESC;

-- Steps  8 - 15
-- Use Dictinct with Orderby to remove duplicate rows
-- Sort asc by the employee number and desc order by the most recent title.
SELECT DISTINCT ON (emp_no) emp_no, first_name,
                   last_name,
				   title				
INTO unique_titles 
FROM retirement_titles
WHERE to_date ='9999-01-01'
ORDER BY emp_no, to_date DESC;

SELECT * FROM unique_titles

-- Step 16 -
SELECT COUNT (*) FROM unique_titles;

SELECT COUNT (emp_no) AS  "count",  title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(*) DESC;

SELECT * FROM retiring_titles;

-- Deliverable 2. 
--- Create a Mentorship Eligibility Table with  all the current employees, 
-- whose the birth_date are between January 1, 1965 and December 31, 1965.
SELECT * FROM employees;
SELECT * FROM dept_emp;
SELECT * FROM titles;


SELECT DISTINCT ON (emp_no) e.emp_no, 
       e.first_name, 
	   e.last_name, 
	   e.birth_date, 
       de.from_date, 
	   de.to_date,
	   t.title	   	   
INTO mentorship_eligibilty
FROM employees AS e
  INNER JOIN dept_emp AS de 
    ON (e.emp_no = de.emp_no)
  INNER JOIN titles as t
    ON (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01') AND    
      (t.to_date = '9999-01-01') AND
      (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;
SELECT * FROM mentorship_eligibilty;

-- Aditional Tables for suportting Summary
-- Mentorship_titles
SELECT COUNT (emp_no) AS  "count",  title
INTO mentorship_titles
FROM mentorship_eligibilty
GROUP BY title
ORDER BY COUNT(*) DESC;  

SELECT * FROM mentorship_titles
--- Actual Employeers not in Retirement
SELECT e.emp_no, 
       e.first_name, 
	   e.last_name, 
       t.title, 
	   t.from_date, 
	   t.to_date
INTO actual_employees
FROM employees AS e
LEFT JOIN titles AS t ON (e.emp_no = t.emp_no)
WHERE birth_date > '1955-12-31' AND (t.to_date ='9999-01-01')  
ORDER BY emp_no;

SELECT * FROM actual_employees;

--- Actual positions  
SELECT COUNT (emp_no) AS  "count",  title
INTO actual_positions
FROM actual_employees
GROUP BY title
ORDER BY COUNT(*) DESC;

SELECT * FROM actual_positions