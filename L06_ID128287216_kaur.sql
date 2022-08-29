-- ***********************
-- Name:Pavneet Kaur
-- ID: 128287216
-- Date: 21/7/2022
-- Purpose: Lab 5 DBS311
-- ***********************
SET SERVEROUTPUT ON
--  Question1.Write a store procedure that gets an integer number n and calculates and displays its factorial.
--Q1 SOLUTION
CREATE OR REPLACE PROCEDURE factorial(value IN INT) 
IS 
 num INT := 1; 
i INT := 0; 
BEGIN 
IF(value < 0) 
THEN
   DBMS_OUTPUT.PUT_LINE ('Please enter positive numbers');
elsif (value = 0) 
THEN
   DBMS_OUTPUT.PUT_LINE ('Factorial: 1');
   ELSE
LOOP 
num := ( num * ( value - i ) ); 
i := i + 1; 
EXIT WHEN i = value; 
END LOOP; 
DBMS_OUTPUT.PUT_LINE ('Factorial: ' || num); 
END
IF;
EXCEPTION 
WHEN OTHERS THEN 
DBMS_OUTPUT.PUT_LINE ('error!! occured'); 
END; 
--calling the procedure
BEGIN 
factorial(4); 
END;

--Question2.The company wants to calculate the employees’ annual salary:
--The first year of employment, the amount of salary is the base salary which is $10,000.
--Every year after that, the salary increases by 5%.
--Write a stored procedure named calculate_salary which gets an employee ID and for that employee calculates the salary based on the number of years the employee has been working in the company.  (Use a loop construct to calculate the salary).
--Q2 SOLUTION
CREATE OR REPLACE PROCEDURE calculate_salary(v_employee_id employees.employee_id%type) 
IS 
  v_salary    NUMBER := 10000; 
  v_year_worked NUMBER; 
  v_first_name employees.first_name%type; 
  v_last_name  employees.last_name%type; 
  i         INT := 0; 
BEGIN 
   SELECT
      first_name,
      last_name,
     TRUNC(TO_CHAR(SYSDATE - employees.hire_date) / 365) 
     INTO v_first_name,
      v_last_name,
      v_year_worked
   
    FROM   employees 
    WHERE  employees.employee_id = calculate_salary.v_employee_id; 

LOOP 
v_salary := v_salary * 1.05; 
i := i + 1; 
EXIT WHEN i = v_year_worked; 
END LOOP; 
 DBMS_OUTPUT.PUT_LINE('First Name: ' ||v_first_name); 
 DBMS_OUTPUT.PUT_LINE('Last Name: ' ||v_last_name); 
 DBMS_OUTPUT.PUT_LINE('Salary: $' ||v_salary); 
EXCEPTION 
  WHEN no_data_found 
  THEN DBMS_OUTPUT.PUT_LINE('Employee does not exist'); 
  WHEN
   others 
THEN
   DBMS_OUTPUT.PUT_LINE('Error!! Occured');
END;
--calling the procedure
BEGIN 
calculate_salary(13); 
END;

--Question3.Write a stored procedure named warehouses_report to print the warehouse ID, warehouse name, and the city where the warehouse is located in the following format for all warehouses:
--Warehouse ID:
--Warehouse name:
--City:
--State:
--Q3 SOLUTION
CREATE PROCEDURE warehouse_report IS
v_warehouse_id warehouses.warehouse_id % TYPE;
v_warehouse_name warehouses.warehouse_name % TYPE;
v_city locations.city % TYPE;
v_state locations.state % TYPE;
BEGIN
FOR i IN 1..9 LOOP 
SELECT
      w.warehouse_id,
      w.warehouse_name,
      l.city,
      nvl(l.state, 'no state')
      INTO 
      v_warehouse_id,
      v_warehouse_name,
      v_city,
      v_state 
FROM warehouses w 
INNER JOIN locations l 
ON (w.location_id = l.location_id) 
WHERE w.warehouse_id = i;
DBMS_OUTPUT.PUT_LINE('Warehouse ID: ' || v_warehouse_id);
DBMS_OUTPUT.PUT_LINE('Warehouse name: ' || v_warehouse_name);
DBMS_OUTPUT.PUT_LINE('City: ' || v_city);
DBMS_OUTPUT.PUT_LINE('State: ' || v_state);
DBMS_OUTPUT.PUT_LINE('-----------------');
END
LOOP;
EXCEPTION 
WHEN OTHERS 
THEN DBMS_OUTPUT.PUT_LINE('Error Occured');
END;
--calling the procedure
BEGIN 
warehouse_report();
END;