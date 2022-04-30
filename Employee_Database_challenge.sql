-- Retirement Titles
SELECT e.emp_no,
e.first_name,
e.last_name,
ti.title,
ti.from_date,
ti.to_date
INTO reitrement_titles
FROM employees as e
INNER JOIN titles AS ti
	ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows.// Clean_retirement
SELECT DISTINCT ON (ret.emp_no) ret.emp_no,
ret.first_name,
ret.last_name,
ret.title
INTO clean_retirement_titles
FROM reitrement_titles as ret
WHERE ret.to_date = '9999-01-01'
ORDER BY ret.emp_no, ret.to_date DESC;

-- Retiring Titles
SELECT COUNT(crt.title),
crt.title
INTO retiring_titles
FROM clean_retirement_titles as crt
GROUP BY crt.title
ORDER BY COUNT(crt.title) DESC;

--Mentorship Eligibility
SELECT DISTINCT ON (e.emp_no) e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
ti.title	
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de 
	ON (e.emp_no = de.emp_no)
INNER JOIN titles AS ti 
	ON (e.emp_no = ti.emp_no)
WHERE de.to_date = '9999-01-01'	
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;