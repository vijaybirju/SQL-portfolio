-- Q6. Your goal is to Pinpoint Locations 
-- WHERE the average salary Has consistently Increased over the Past 
-- few years (Countries WHERE data is available for 3 years 
-- Only(present year and past two years) providing Insights 
-- into Locations experiencing Sustained salary growth.
select * from salaries;
select * from 
(
SELECT 
    c.company_location,c.avg_2022,c.avg_2023,d.avg_2024
FROM
    (SELECT 
        a.company_location, a.avg_2022, b.avg_2023
    FROM
        (SELECT 
        company_location, AVG(salary_in_usd) AS avg_2022
    FROM
        salaries
    WHERE
        work_year = 2022
    GROUP BY company_location) AS a
    INNER JOIN (SELECT 
        company_location, AVG(salary_in_usd) AS avg_2023
    FROM
        salaries
    WHERE
        work_year = 2023
    GROUP BY company_location) AS b ON a.company_location = b.company_location) AS c
        INNER JOIN
    (SELECT 
        company_location, AVG(salary_in_usd) AS avg_2024
    FROM
        salaries
    WHERE
        work_year = 2024
    GROUP BY company_location) AS d ON c.company_location = d.company_location)
    as e
     where avg_2024>avg_2023 and avg_2023>avg_2022;
     

-- Q7. Picture yourself AS a workforce strategist employed by a global HR tech startup. 
-- Your Mission is to Determine the percentage of fully remote 
-- work for each experience level IN 2021 and compare it WITH the corresponding 
-- figures for 2024, Highlighting any significant Increases or decreases 
-- IN remote work Adoption over the years.

SELECT * FROM salaries; 
SELECT 
    t21.experience_level, 
    percent_in_2021, 
    percent_in_2024 
FROM 
    (
        SELECT 
            t.experience_level, 
            (COALESCE(cnt, 0) / total) * 100 AS percent_in_2021 
        FROM 
            (
                SELECT 
                    experience_level, 
                    COUNT(*) AS total 
                FROM 
                    salaries 
                WHERE 
                    work_year = 2021 
                GROUP BY 
                    experience_level
            ) AS t
        LEFT JOIN  
            (
                SELECT 
                    experience_level, 
                    COUNT(*) AS cnt 
                FROM 
                    salaries 
                WHERE 
                    work_year = 2021 
                    AND remote_ratio = 100 
                GROUP BY 
                    experience_level
            ) AS t2
        ON 
            t.experience_level = t2.experience_level
    ) AS t21
LEFT JOIN 
    (
        SELECT 
            t.experience_level, 
            (COALESCE(cnt, 0) / total) * 100 AS percent_in_2024 
        FROM 
            (
                SELECT 
                    experience_level, 
                    COUNT(*) AS total 
                FROM 
                    salaries 
                WHERE 
                    work_year = 2024 
                GROUP BY 
                    experience_level
            ) AS t
        LEFT JOIN  
            (
                SELECT 
                    experience_level, 
                    COUNT(*) AS cnt 
                FROM 
                    salaries 
                WHERE 
                    work_year = 2024 
                    AND remote_ratio = 100 
                GROUP BY 
                    experience_level
            ) AS t2
        ON 
            t.experience_level = t2.experience_level
    ) AS t24
ON 
    t21.experience_level = t24.experience_level;
    
    
--  Q8	AS a Compensation specialist at a Fortune 500 company, 
-- you're tasked WITH analyzing salary trends over time. 
-- Your objective is to calculate the average salary increase 
-- percentage for each experience level and job title between 
-- the years 2023 and 2024, helping the company stay competitive IN the talent market.


-- Q9 You're a database administrator tasked with role-based access control for a company's 
-- employee database. Your goal is to implement a security measure where employees in 
-- different experience level (e.g. Entry Level, Senior level etc.) 
-- can only access details relevant to their respective experience level, 
-- ensuring data confidentiality and minimizing the risk of unauthorized access.
 
 CREATE USER 'ENTRY_LEVEL'@'%' IDENTIFIED BY 'EN'
 
CREATE VIEW entery_level AS 
 (
   SELECT * FROM Salaries WHERE experience_level = 'EN'
 )
 
GRANT SELECT ON Salary.entery_level TO 'ENTRY_LEVEL'@'%'
 SHOW PRIVILEGES
 
 