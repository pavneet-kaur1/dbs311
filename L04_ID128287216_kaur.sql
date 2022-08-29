-- ***********************
-- Name: Pavneet Kaur
-- ID: 128287216
-- Date: 15/6/20222
-- Purpose: Lab 4 DBS311
-- ***********************

--Question1.The HR department needs a list of Department IDs for departments that do not contain the job ID of ST_CLERK> Use a set operator to create this report.
--Q1 SOLUTION
SELECT manager_id 
FROM employees
MINUS
SELECT manager_id
FROM employees
WHERE job_title = 'Stock Clerk' ;

--Question2.Display cities that no warehouse is located in them. (use set operators to answer this question)
--Q2 SOLUTION
 SELECT city 
FROM locations
MINUS
SELECT l.city 
FROM locations l, warehouses w 
WHERE l.location_id = w.location_id;

--Question3.Display the category ID, category name, and the number of products in category 1, 2, and 5. In your result, display first the number of products in category 5, then category 1 and then 2.
--Q3 SOLUTION
SELECT pc.category_id, pc.category_name, COUNT(p.product_id)
FROM product_categories pc
JOIN products p
ON pc.category_id = p.category_id
WHERE p.category_id = 5
GROUP BY pc.category_id, pc.category_name
UNION ALL 
SELECT pc.category_id, pc.category_name, COUNT(p.product_id)
FROM product_categories pc 
JOIN products p
ON pc.category_id = p.category_id
WHERE p.category_id = 1
GROUP BY pc.category_id, pc.category_name
UNION ALL 
SELECT pc.category_id, pc.category_name, COUNT(p.product_id)
FROM product_categories pc 
JOIN products p
ON pc.category_id = p.category_id
WHERE p.category_id = 2
GROUP BY pc.category_id, pc.category_name;

--Question4.Display product ID for ordered products whose quantity in the inventory is greater than 5. (You are not allowed to use JOIN for this question.)
--Q4 SOLUTION
SELECT product_id
FROM products
INTERSECT
SELECT product_id
FROM inventories
WHERE quantity >5;

--Question5.We need a single report to display all warehouses and the state that they are located in and all states regardless of whether they have warehouses in them or not.
--Q5 SOLUTION
SELECT warehouse_name, state 
FROM warehouses  LEFT JOIN locations 
 ON warehouses.location_id = locations.location_id 
UNION
SELECT warehouse_name, state 
FROM warehouses  RIGHT JOIN locations 
 ON warehouses.location_id = locations.location_id;
