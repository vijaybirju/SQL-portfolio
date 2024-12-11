WITH cte AS
(
    SELECT company_id, title, description
    FROM job_listings
    GROUP BY company_id, title, description
    HAVING COUNT(*) > 1
)
SELECT COUNT(DISTINCT company_id) AS duplicate_company_count
FROM cte
