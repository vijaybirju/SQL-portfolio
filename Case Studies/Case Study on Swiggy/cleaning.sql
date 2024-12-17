USE swiggy;

SELECT column_name FROM Information_schema.columns WHERE table_name = 'swiggy_cleaned';

DELIMITER //
CREATE PROCEDURE  count_blank_rows()
BEGIN
	SELECT group_concat(
			concat( 'SUM(Case WHEN`', column_name,'`=  '''' THEN 1 ELSE 0 END) AS `' , column_name ,'`') 
	) into @sql 
	FROM Information_schema.columns 
	WHERE table_name = 'swiggy_cleaned';

	SET @SQL = Concat('SELECT ', @sql, 'FROM Swiggy_cleaned');
    

	PREPARE smt FROM @SQL;
	EXECUTE smt;
	DEALLOCATE PREPARE smt;
END
// 
DELIMITER ;

CALL count_blank_rows();

CREATE TABLE clean AS (
SELECT * FROM swiggy_cleaned WHERE rating LIKE "%mins%");


-- Updating empty  time_minute rows from ratings columns
SET sql_safe_updates = 0;

WITH CLEANED AS (
SELECT *, f_name(rating) AS 'rating_cleaned' FROM clean
) 
UPDATE Swiggy_cleaned AS s INNER JOIN CLEANED c ON s.hotel_name = c.hotel_name
SET s.time_minutes = c.rating_cleaned;

Drop table clean;

SELECT * FROM Swiggy_cleaned;


-- Cleaning for - in time_minute
CREATE TABLE clean AS (
SELECT * FROM swiggy_cleaned WHERE time_minutes LIKE '%-%'
);

SELECT * FROM clean;

WITH CLEANED AS (
SELECT *, f_name(time_minutes) AS f1, l_name(time_minutes) AS f2 FROM clean
) 
UPDATE Swiggy_cleaned AS s INNER JOIN CLEANED c ON s.hotel_name = c.hotel_name
SET s.time_minutes = (c.f1+c.f2)/2
;

SELECT * FROM SWiggy_cleaned WHERE hotel_name = 'NH1 Bowls - Highway To North';
DROP TABLE clean;

-- time_minutes table has been cleaned  


-- Cleaning rating columns
WITH avg_rat_table AS (
SELECT location, ROUND(AVG(rating),2) AS avg_rating FROM swiggy_cleaned  WHERE rating NOT LIKE '%mins%' GROUP BY location
)
UPDATE swiggy_cleaned S 
INNER JOIN avg_rat_table a 
ON s.location = a.location 
SET s.rating= avg_rating
WHERE s.rating LIKE '%mins%';

SELECT * FROM Swiggy_cleaned WHERE rating LIKE '%mins%';

set @avg_rating = (SELECT AVG(rating) FROM swiggy_cleaned WHERE rating NOT LIKE '%mins%' );

UPDATE swiggy_cleaned SET rating = @avg_rating WHERE rating LIKE '%mins%';

UPDATE swiggy_cleaned
SET rating = ROUND(rating, 2);

-- rating columsn has been cleaned 
