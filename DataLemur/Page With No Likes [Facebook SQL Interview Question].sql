SELECT p.page_id
FROM pages p
FULL OUTER JOIN page_likes pl ON p.page_id = pl.page_id
WHERE pl.page_id IS NULL
ORDER BY page_id
