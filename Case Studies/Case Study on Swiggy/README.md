# 🚀 SQL Project: Data Cleaning for Swiggy Data

In this project, I worked on cleaning and transforming Swiggy's restaurant data to enhance the quality and consistency for analysis.

### Key Steps:

1. **Identifying Blank Rows**:
   - Created a stored procedure `count_blank_rows` to detect blank values in each column of the `swiggy_cleaned` table.

2. **Handling Ratings with 'mins'**:
   - Extracted rows where the `rating` column contained 'mins' and created a new `rating_cleaned` column to store cleaned time values.
   - Used a custom function `f_name()` to extract the numeric part and update the `time_minutes` column.

3. **Dealing with Invalid Time Values**:
   - Identified and cleaned records with invalid time values (e.g., containing '-') by averaging the start and end times using `f_name()` and `l_name()` functions.

4. **Updating Ratings Based on Location**:
   - Calculated the average rating for each location (excluding ratings with 'mins') and updated the `rating` column for rows that had time-based ratings.
   - Used `ROUND()` to clean up ratings to two decimal places.

5. **Final Cleanup**:
   - After cleaning, ensured the ratings and time values were consistent, accurate, and ready for further analysis.

---

💻 **Key SQL Concepts Used**:
- Stored Procedures
- Dynamic SQL
- Conditional Statements (e.g., `CASE` and `LIKE`)
- Aggregation (`AVG()`, `GROUP BY`)
- String Manipulation (e.g., `LEFT()`, `RIGHT()`)

#DataCleaning #SQL #Swiggy #ETL #DataAnalysis #MySQL #SQLProjects

