USE salary;

SELECT * FROM salaries;

-- Q1. You're a Compensation analyst employed by a multinational corporation. 
-- Your Assignment is to Pinpoint Countries who give work fully remotely, 
-- for the title 'managers’ Paying salaries Exceeding $90,000 USD

SELECT DISTINCT company_location FROM salaries
WHERE remote_ratio = 100 and salary_in_usd>90000 and job_title LIKE '%manager%';


-- Q2. AS a remote work advocate Working for a progressive HR tech startup 
-- who place their freshers’ clients IN large tech firms. 
-- you're tasked WITH Identifying top 5 Country Having greatest 
-- count of large (company size) number of companies.

Select * From Salaries;

WITH CTE AS 
(SELECT  company_location, COUNT(*) AS count  FROM salaries WHERE company_size='L'and experience_level='EN'
GROUP BY company_location ORDER BY count DESC LIMIT 5)
SELECT company_location FROM CTE;

-- Q3. Your objective is to calculate the percentage of employees. 
-- Who enjoy fully remote roles WITH salaries Exceeding $100,000 USD, 
-- Shedding light ON the attractiveness of high-paying remote positions IN today's job market.

Select * from salaries;
WITH nume_rows AS (SELECT * FROM salaries WHERE salary_in_usd >100000 AND remote_ratio=100)
, deno_rows AS (SELECT * FROM salaries WHERE salary_in_usd >100000)
SELECT Round(((SELECT COUNT(*) FROM nume_rows)/(SELECT COUNT(*) FROM deno_rows))*100,2) AS Percentage_of_remote ;


-- Q4. 
-- Your Task is to identify the Locations where entry-level average salaries 
-- exceed the average salary for that job title IN market for entry level, 
-- helping your agency guide candidates towards lucrative opportunities.

SELECT t.job_title, avg_salary, company_location, avg_salary_per_country FROM (
SELECT job_title, AVG(salary_in_usd) AS avg_salary FROM salaries WHERE experience_level = "EN" GROUP BY  job_title) AS t
INNER JOIN (
SELECT company_location, job_title, AVG(salary_in_usd) AS avg_salary_per_country FROM salaries WHERE experience_level = "EN" GROUP BY  job_title, company_location) AS m 
ON t.job_title = m.job_title
WHERE avg_salary_per_country > avg_salary;


--  Q5. You've been hired by a big HR Consultancy to look at 
-- how much people get paid IN different Countries. 
-- Your job is to Find out for each job title which. 
-- Country pays the maximum average salary. 
-- This helps you to place your candidates IN those countries.

WITH cte2 As (WITH CTE AS (SELECT job_title, company_location, AVG(salary_in_usd) AS average FROM salaries GROUP BY job_title, company_location)
SELECT job_title, 
    company_location, 
    average, 
    RANK() OVER (PARTITION BY job_title ORDER BY average DESC) AS rank_Salary FROM CTE)
    
SELECT * FROM cte2 WHERE Rank_salary = 1

