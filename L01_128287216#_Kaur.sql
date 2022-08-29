-- ***********************
-- Name: Pavneet Kaur
-- ID: 128287216
-- Date: 5/19/2022
-- Purpose: Lab 1 DBS311
-- ***********************

-- Question 1 : Write a query to display the tomorrow’s date in the following format:
    -- January 10th of year 2019
--the result will depend on the day when you RUN/EXECUTE this query.  Label the column “Tomorrow”.

-- Q1 SOLUTION --
SELECT TO_CHAR(SYSDATE+1, 'month dd"th of year "yyyy' ) AS "Tomorrow" 
    FROM dual;
 
--Question2.For each product in category 2, 3, and 5, show product ID, product name, list price, and the new list price increased by 2%. Display a new list price as a whole number.
--In your result, add a calculated column to show the difference of old and new list prices.
--Q2 SOLUTION--
SELECT  product_id,product_name, list_price,
          round(list_price*1.02) AS "new_lsit",
        round((list_price*1.02)-list_price) AS "difference"
    FROM PRODUCTS
    WHERE category_id IN(2,3,5);   

--Question3.For employees whose manager ID is 2, write a query that displays the employee’s Full Name and Job Title in the following format:
--SUMMER, PAYNE is Public Accountant.
--Q3 SOLUTION--
SELECT UPPER(last_name)||' , '||UPPER(first_name)||' is '||job_title||'.' AS "Information"
    FROM employees
    WHERE manager_id = 2; 
   
--Question4.For each employee hired before October 2016, display the employee’s last name, hire date and calculate the number of YEARS between TODAY and the date the employee was hired.
--•	Label the column Years worked. 
--•	Order your results by the number of years employed.  Round the number of years employed up to the closest whole number.
--Q4 SOULTION--
SELECT  last_name,
        hire_date,
       ROUND((months_between( sysdate, hire_date))/12) AS "Years worked"
    FROM employees
    WHERE  hire_date<TO_DATE('OCT-2016', 'MONTH-YYYY')
    ORDER BY "Years worked";

--Question5.: Display each employee’s last name, hire date, and the review date, which is the first Tuesday after a year of service, but only for those hired after 2016.  
--•	Label the column REVIEW DAY. 
--•	Format the dates to appear in the format like:
--   TUESDAY, August the Thirty-First of year 2016
--•	Sort by review date
--Q5 SOULTION--
SELECT  last_name ,
        hire_date ,
        to_char(next_day(add_months(hire_date,+12)-1,'Tuesday'),'DAY", " Month" the "Ddspth" of year "yyyy') AS "REVIEW DAY"
    FROM employees
    WHERE hire_date>to_date('01012016','ddmmyyyy')
    ORDER BY "REVIEW DAY";

--Question6.: For all warehouses, display warehouse id, warehouse name, city, and state. For warehouses with the null value for the state column, display “unknown”.
--Q6 SOLUTION--
SELECT  w.warehouse_id ,
w.warehouse_name,
l.city,
nvl(l.state,'unknown') AS "STATE"
FROM warehouses w JOIN locations l ON w.location_id=l.location_id;





   
