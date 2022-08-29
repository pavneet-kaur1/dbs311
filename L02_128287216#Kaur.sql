-- ***********************
-- Name: Pavneet Kaur
-- ID: 128287216
-- Date: 31/5/2022
-- Purpose: Lab 2 DBS311
-- ***********************
-- Q1: For each job title display the number of employees. 
--Q1 SOLUTION
SELECT  job_title,COUNT(*)AS "employees_count" FROM employees
GROUP BY job_title;

-- Q2: Display the Highest, Lowest and Average customer credit limits. Name these results High, Low and Avg. Add a column that shows the difference between the highest and lowest credit limits.
--o	Use the round function to display two digits after the decimal point.
--Q2 SOLUTION
 SELECT MAX(credit_limit) AS "High",
 MIN(credit_limit) AS "Low",
 ROUND(AVG(credit_limit),2) AS "Avg.",
 MAX(credit_limit)-MIN(credit_limit) AS "Difference"
FROM customers;

-- Q3: Display the order id and the total order amount for orders with the total amount over $1000,000. 
--Q3 SOLUTION
SELECT
   order_id,
   SUM(quantity) AS "order_items",
   SUM(quantity*unit_price) AS "order_amount" 
FROM
   order_items 
GROUP BY
   order_id 
HAVING
   SUM(quantity*unit_price) > 1000000 ;
   
-- Q4: Display the warehouse id, warehouse name, and the total number of products for each warehouse.
--Q4 SOLUTION
SELECT
   w.warehouse_id,
   w.warehouse_name,
   SUM(i.quantity) AS "total_products" 
FROM
   warehouses w 
   INNER JOIN
      inventories i 
      ON w.warehouse_id = i.warehouse_id 
GROUP BY
   w.warehouse_id,
   w.warehouse_name ;
   
-- Q5: For each customer display the number of orders issued by the customer. If the customer does not have any orders, the result show display 0.
--Q5 SOLUTION
SELECT
c.customer_id,
   c.name ,
   NVL(COUNT(o.order_id),0) AS "total_orders" 
FROM
   customers c 
   LEFT JOIN
      orders o 
      ON c.customer_id = o.customer_id 

GROUP BY 
  c.customer_id,
   c.name; 

-- Q6: Write a SQL query to show the total and the average sale amount for each category.
--Q6 SOLUTION
SELECT
   p.category_id,
   SUM(o.quantity*o.unit_price) AS "total_sale",
   ROUND(AVG(o.quantity*o.unit_price)) AS "average_sale" 
FROM
   order_items o 
   INNER JOIN
      products p 
      ON p.product_id = o.product_id 
GROUP BY
   p.category_id;
