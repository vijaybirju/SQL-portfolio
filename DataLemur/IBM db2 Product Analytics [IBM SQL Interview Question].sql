WITH cte AS
(
  SELECT
    employee_id,
    COUNT(DISTINCT query_id) AS unique_queries
  FROM 
    queries
  WHERE
    EXTRACT(MONTH FROM query_starttime) BETWEEN 7 AND 9
    AND EXTRACT(YEAR FROM query_starttime) = 2023
  GROUP BY employee_id
  
),
cte2 AS 
(
  SELECT employee_id
  FROM employees
)

SELECT 
  COALESCE(cte.unique_queries,0) AS unique_queries,
  COUNT(cte2.employee_id) AS employee_count
FROM cte2
LEFT JOIN cte ON cte2.employee_id = cte.employee_id
GROUP BY unique_queries
ORDER BY unique_queries


