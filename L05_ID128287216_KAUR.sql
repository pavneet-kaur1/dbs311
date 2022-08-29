-- ***********************
-- Name: Pavneet Kaur
-- ID: 128287216
-- Date: 14 July, 2022
-- Purpose: Lab 5 DBS311
-- ***********************

SET SERVEROUTPUT ON
--Question1.Write a store procedure that get an integer number and prints
--The number is even.
--If a number is divisible by 2.
--Otherwise, it prints 
--The number is odd.
--Q1 SOLUTION
CREATE OR REPLACE  PROCEDURE even_odd(value IN NUMBER) AS
BEGIN
IF MOD(value, 2) = 0 THEN
DBMS_OUTPUT.PUT_LINE ( 'The number is Even');
ELSE
DBMS_OUTPUT.PUT_LINE ('The number is Odd');
END IF;
EXCEPTION
WHEN OTHERS
  THEN 
      DBMS_OUTPUT.PUT_LINE ('Error!');

END;   
--calling the procedure
BEGIN
even_odd(6) ;
END;

--Question2.Create a stored procedure named find_employee. This procedure gets an employee number and prints the following employee information:
--First name 
--Last name 
--Email
--Phone 	
--Hire date 
--Job title
--
--The procedure gets a value as the employee ID of type NUMBER.
--See the following example for employee ID 107: 
--
--First name: Summer
--Last name: Payn
--Email: summer.payne@example.com
--Phone: 515.123.8181
--Hire date: 07-JUN-16
--Job title: Public Accountant
--
--The procedure display a proper error message if any error accours.
--Q2 SOLUTION
CREATE OR REPLACE PROCEDURE find_employee(p_employee_id IN NUMBER) AS
p_first_name Employees.first_name%TYPE;
p_last_name Employees.last_name%TYPE;
p_email Employees.email%TYPE;
p_phone Employees.phone%TYPE;
p_hire_date Employees.hire_date%TYPE;
p_job_title Employees.job_title%TYPE;

BEGIN

SELECT FIRST_NAME, LAST_NAME, EMAIL, PHONE, HIRE_DATE, JOB_TITLE
   INTO   p_first_name, p_last_name, p_email, p_phone, p_hire_date, p_job_title
FROM EMPLOYEES WHERE EMPLOYEE_ID = p_employee_id;
  
   DBMS_OUTPUT.PUT_LINE('FIRST_NAME : ' || p_first_name);
   DBMS_OUTPUT.PUT_LINE('LAST_NAME: ' || p_last_name);
   DBMS_OUTPUT.PUT_LINE('EMAIL: ' || p_email);
   DBMS_OUTPUT.PUT_LINE('PHONE: ' || p_phone);
   DBMS_OUTPUT.PUT_LINE('HIRE_DATE: ' || p_hire_date);
   DBMS_OUTPUT.PUT_LINE('JOB_TITLE: ' || p_job_title);


EXCEPTION
  
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('ERROR! NO RECORD FOUND');
WHEN TOO_MANY_ROWS THEN
DBMS_OUTPUT.PUT_LINE('ERROR! MORE THAN ONE RECORD FOUND');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('UNKOWN ERROR OCCURRED!!');     
END;   
--calling the procedure
BEGIN
find_employee(107);
END;

--QUESTION3.Every year, the company increases the price of all products in one category. For example, the company wants to increase the price (list_price) of products in category 1 by $5. Write a procedure named update_price_by_cat to update the price of all products in a given category and the given amount to be added to the current price if the price is greater than 0. The procedure shows the number of updated rows if the update is successful.
--The procedure gets two parameters:
--•	category_id IN NUMBER
--•	amount NUMBER(9,2)
--To define the type of variables that store values of a table’ column, you can also write:
--vriable_name table_name.column_name%type;
--The above statement defines a variable of the same type as the type of the table’ column.
--category_id products.category_id%type;
--Or you need to see the table definition to find the type of the category_id column. Make sure the type of your variable is compatible with the value that is stored in your variable.
--To show the number of affected rows the update query, declare a variable named rows_updated of type NUMBER and use the SQL variable sql%rowcount to set your variable. Then, print its value in your stored procedure.
--Rows_updated := sql%rowcount;
--SQL%ROWCOUNT stores the number of rows affected by an INSERT, UPDATE, or DELETE.
--Q3 SOLUTION
CREATE OR REPLACE PROCEDURE update_price_by_cat(p_category_id IN products.category_id%TYPE, add_amount IN products.list_price%TYPE) AS
p_count NUMBER;
Rows_updated NUMBER;
begin

SELECT COUNT(category_id) INTO p_count FROM products WHERE category_id = p_category_id AND list_price>0;

IF ( p_count > 0) THEN
       UPDATE products SET LIST_PRICE = LIST_PRICE + add_amount WHERE category_id = p_category_id;
       Rows_updated := SQL%ROWCOUNT; 
       DBMS_OUTPUT.PUT_LINE('Rows Updated =' || Rows_updated);  
     
   ELSE
DBMS_OUTPUT.PUT_LINE('ERROR! NO CATEGORY FOUND OR THE PRICE IS LESS THAN 0');  
   END IF;

EXCEPTION
  
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('ERROR! NO RECORDS FOUND');   
WHEN TOO_MANY_ROWS THEN
DBMS_OUTPUT.PUT_LINE('ERROR! MORE THAN ONE RECORD FOUND');
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('UNKOWN ERROR OCCURRED!!');   
END;
--calling the procedure
DECLARE
p_category_id products.category_id%TYPE := 1;
add_amount products.list_price%TYPE := 5;
BEGIN
update_price_by_cat(p_category_id , add_amount );
END;

--QUESTION4.Every year, the company increase the price of products whose price is less than the average price of all products by 1%. (list_price * 1.01). Write a stored procedure named update_price_under_avg. This procedure do not have any parameters. You need to find the average price of all products and store it into a variable of the same type. If the average price is less than or equal to $1000, update products’ price by 2% if the price of the product is less than the calculated average. If the average price is greater than $1000, update products’ price by 1% if the price of the product is less than the calculated average. The query displays an error message if any error occurs. Otherwise, it displays the number of updated rows.
--Q4 SOLUTION
CREATE OR REPLACE  PROCEDURE update_price_under_avg AS
p_average products.list_price%TYPE;
p_update_rate products.list_price%TYPE;
rows_updated NUMBER;
begin

SELECT AVG(LIST_PRICE) INTO p_average FROM products ;

   IF( p_average >= 1000) THEN
       p_update_rate := 1.02;         
   ELSE
p_update_rate :=1.01;
   END IF;
  
  
   UPDATE products SET LIST_PRICE = LIST_PRICE * p_update_rate WHERE LIST_PRICE <= p_average;
   rows_updated:=SQL%ROWCOUNT;
   DBMS_OUTPUT.PUT_LINE('Rows Updated =' || rows_updated);  


EXCEPTION
  
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('ERROR! NO RECORDS FOUND');   
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('UNKOWN ERROR OCCURRED!!');    
END;
--calling the procedure

BEGIN
   update_price_under_avg;
END;

--QUESTION5.The company needs a report that shows three category of products based their prices. The company needs to know if the product price is cheap, fair, or expensive. Let’s assume that
--?	If the list price is less than 
--o	(avg_price - min_price) / 2
--The product’s price is cheap.
--?	If the list price is greater than 
--o	(max_price - avg_price) / 2
--The product’ price is expensive.
--?	If the list price is between 
--o	(avg_price - min_price) / 2
--o	and
--o	(max_price - avg_price) / 2
--o	the end values included
--The product’s price is fair.
--Write a procedure named product_price_report to show the number of products in each price category:
--The following is a sample output of the procedure if no error occurs:
--Cheap: 10
--Fair: 50
--Expensive: 18  
--The values in the above examples are just random values and may not match the real numbers in your result.
--The procedure has no parameter. First, you need to find the average, minimum, and maximum prices (list_price) in your database and store them into varibles avg_price, min_price, and max_price.
--You need more three varaibles to store the number of products in each price category:
--cheap_count
--fair_count
--exp_count
--Make sure you choose a proper type for each variable. You may need to define more variables based on your solution.
--Q5 SOLUTION
CREATE OR REPLACE PROCEDURE product_price_report AS
avg_price  products.list_price%TYPE;
min_price  products.list_price%TYPE;
max_price  products.list_price%TYPE;
cheap_count NUMBER;
fair_count NUMBER;
exp_count NUMBER;

BEGIN

SELECT AVG(list_price), MAX(list_price), MIN(list_price) INTO avg_price, max_price, min_price
FROM products;

SELECT COUNT(list_price) INTO cheap_count
FROM products
WHERE list_price < (avg_price - min_price) / 2;

SELECT COUNT(list_price) INTO exp_count
FROM products
WHERE list_price > (max_price - avg_price) / 2;

SELECT COUNT(list_price) INTO fair_count
FROM products
WHERE list_price >= (avg_price - min_price) / 2 AND list_price <= (max_price - avg_price) / 2;

DBMS_OUTPUT.PUT_LINE('Cheap: ' ||cheap_count);
DBMS_OUTPUT.PUT_LINE('Fair: ' ||fair_count);
DBMS_OUTPUT.PUT_LINE('Expensive: ' ||exp_count);
EXCEPTION
  
WHEN NO_DATA_FOUND THEN
DBMS_OUTPUT.PUT_LINE('ERROR! NO RECORDS FOUND');   
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('UNKOWN ERROR OCCURRED!!');    
END;


BEGIN
product_price_report();
END;


