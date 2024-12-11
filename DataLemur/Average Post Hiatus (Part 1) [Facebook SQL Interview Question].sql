
WITH CTE AS (
    
    SELECT 
        user_id, 
        MIN(post_date) AS first_date_of_post,
        MAX(post_date) As last_date_of_post,
        COUNT(post_date) AS post_count
      FROM posts
      WHERE EXTRACT(YEAR FROM post_date) = 2021
      GROUP BY user_id
)
SELECT 
  user_id,
  EXTRACT(DAY FROM last_date_of_post - first_date_of_post) AS days_between
FROM CTE 
WHERE post_count>=2
