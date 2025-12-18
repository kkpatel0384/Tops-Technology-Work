use customer;
select * from customers;

SELECT customer_id, cust_name, city, grade, salesman_id
FROM customers
WHERE city = 'NewYork'
   OR grade <= 100
   OR grade IS NULL;
 

   
   CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    cust_name VARCHAR(100) NOT NULL,
    city VARCHAR(100),
    grade INT,
    salesman_id INT
);

INSERT INTO customers(customer_id ,cust_name ,city ,grade ,salesman_id)
values
        (3002,'Nick Rimando','New York',100,5001),
        (3007,'Brad Davis', 'New York' , 200 ,5001),
        (3005 ,'Graham Zusi','California',200 ,5002),
        (3008 ,'Julian Green','London' ,300 ,5002),
        (3004 ,'Fabian Johnson','Paris' ,300 ,5006),
        (3009 ,'Geoff Cameron','Berlin' ,100 ,5003),
        (3003,'Jozy Altidor','Moscow' ,200 ,5007),
        (3001 ,'Brad Guzan','London' ,5005);
        
   select * from customers;
select name , city from customers;

SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE orders (
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(10,2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT
);
INSERT INTO orders(ord_no, purch_amt, ord_date, customer_id ,salesman_id)
values

(70001,150.5  ,2012-10-05,3005 ,5002),
(70009,270.65 ,2012-09-10 ,3001, 5005),
(70002 ,65.26 ,2012-10-05 ,3002 ,5001),
(70004 ,110.5 ,2012-08-17 ,3009 ,5003),
(70007 ,948.5 ,2012-09-10 ,3005 ,5002),
(70005 ,2400.6 ,2012-07-27,3007 ,5001),
(70008 ,5760 ,2012-09-10 ,3002 ,5001),
(70010 ,1983.43,2012-10-10,3004 ,5006),
(70003 ,2480.4 ,2012-10-10 ,3009 ,5003),
(70012 ,250.45 ,2012-06-27 ,3008 ,5002),
(70011 ,75.29 ,2012-08-17 ,3003 ,5007),
(70013 ,3045.6 ,2012-04-25,3002,500);

select * from orders;

CREATE TABLE salesman (
    salesman_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(100),
    commission DECIMAL(4,2)
);
INSERT INTO salesman(salesman_id ,name ,city,commission)
values

        (5001,'James Hoog','New York',0.15),
        (5002,'Nail Knite','Paris', 0.13),
        (5005,'Pit Alex','London',0.11),
        (5006,'Mc Lyon','Paris',0.14),
        (5007,'Paul Adam','Rome',0.13),
        (5003,'Lauson Hen','San Jose',0.12);
        
select * from salesman;

CREATE TABLE emp_details (
    emp_idno INT PRIMARY KEY,
    emp_fname VARCHAR(100) NOT NULL,
    emp_lname VARCHAR(100) NOT NULL,
    emp_dept INT
);

INSERT INTO emp_details(EMP_IDNO ,EMP_FNAME,EMP_LNAME, EMP_DEPT)
values

   (127323, 'Michale','Robbin',57),
   (526689 ,'Carlos','Snares',63),
   (843795 ,'Enric','Dosio', 57),
   (328717 ,'Jhon' ,'Snares' ,63),
   (444527 ,'Joseph','Dosni', 47,
   (659831,' Zanifer','Emily',47),
   (847674 ,'Kuleswar','Sitaraman',57),
   (748681,'Henrey','Gabriel',47),
   (555935 ,'Alex','Manuel',57),
   (539569 ,'George','Mardy',27),
   (733843 ,'Mario' ,'Saule',63),
   (631548 ,'Alan','Snappy',27),
   (839139 ,'Maria' ,'Foster',57);

select * from salesman;


CREATE TABLE item_mast (
    pro_id INT PRIMARY KEY,
    pro_name VARCHAR(100) NOT NULL,
    pro_price DECIMAL(10,2),
    pro_com INT
);


INSERT INTO item_mast( PRO_ID,PRO_NAME ,PRO_PRICE ,PRO_COM)
values

    (101,' Motherboard',3200.00,15),
    (102,'Keyboard', 450.00 ,16),
    (103 ,'ZIP drive',250.00 ,14),
    (104 ,'Speaker',550.00 ,16),
    (105 ,'Monitor',5000.00,11),
    (106 ,'DVD drive',900.00,12),
    (107 ,'CD drive',800.00,12),
    (108 ,'Printer',2600.00 ,13),
    (109 ,'Refill cartridge',350.00 ,13),
    (110 ,'Mouse',250.00,12);

select * from item_mast;


# start question ans  #

#1
SELECT customer_id, cust_name, city, grade, salesman_id
FROM customer
WHERE city = 'New York'
   OR NOT (grade > 100);

#2
SELECT customer_id, cust_name, city, grade, salesman_id
FROM customer
WHERE city = 'New York'
  AND grade > 100;

#3
SELECT 
    ord_no,
    purch_amt,
    (purch_amt / 6000) * 100 AS achieved_percentage,
    (100 - (purch_amt / 6000) * 100) AS unachieved_percentage
FROM orders
WHERE purch_amt > 3000;

#4
SELECT SUM(purch_amt) AS total_purchase_amount
FROM orders;

#5
SELECT customer_id,
       MAX(purch_amt) AS max_purchase_amount
FROM orders
GROUP BY customer_id;

#6
SELECT AVG(pro_price) AS average_product_price
FROM item_mast;

#7
SELECT e.emp_fname, e.emp_lname, e.emp_idno, d.job_id
FROM employees e
JOIN departments d
   ON e.department_id = d.department_id
WHERE d.location = 'Toronto';

#8
SELECT employee_id, first_name, last_name, job_id
FROM employees
WHERE salary < (
        SELECT MIN(salary)
        FROM employees
        WHERE job_id = 'MK_MAN'
    )
  AND job_id <> 'MK_MAN';

#9
SELECT e.first_name, e.last_name, e.department_id, d.department_name
FROM employees e
JOIN departments d
  ON e.department_id = d.department_id
WHERE e.department_id IN (80, 40);

#10
SELECT d.department_name,
       AVG(e.salary) AS avg_salary,
       COUNT(e.commission_pct) AS employees_with_commission
FROM employees e
JOIN departments d
  ON e.department_id = d.department_id
GROUP BY d.department_name;

#11
SELECT first_name, last_name, department_id, job_id
FROM employees
WHERE job_id = (
    SELECT job_id 
    FROM employees
    WHERE employee_id = 169
)
AND employee_id <> 169;

#12
SELECT employee_id, first_name, last_name
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

#13
SELECT e.department_id,
       e.first_name,
       e.job_id,
       d.department_name
FROM employees e
JOIN departments d 
    ON e.department_id = d.department_id
WHERE d.department_name = 'Finance';

#14
SELECT first_name, last_name, salary
FROM employees
WHERE salary < (
    SELECT salary
    FROM employees
    WHERE employee_id = 182
);

#15
CREATE PROCEDURE CountEmployeesByDept()
BEGIN
    SELECT department_id, COUNT(*) AS total_employees
    FROM employees
    GROUP BY department_id,
END;

#16
CREATE PROCEDURE AddNewEmployee(
    IN p_emp_id INT,
    IN p_first_name VARCHAR(50),
    IN p_last_name VARCHAR(50),
    IN p_email VARCHAR(100),
    IN p_job_id VARCHAR(10),
    IN p_salary DECIMAL(10,2),
    IN p_department_id INT
)
BEGIN
    INSERT INTO employees(employee_id, first_name, last_name, email, job_id, salary, department_id)
    VALUES (p_emp_id, p_first_name, p_last_name, p_email, p_job_id, p_salary, p_department_id),
END;

#17
CREATE PROCEDURE DeleteEmployeesByDept(IN p_dept_id INT)
BEGIN
    DELETE FROM employees
    WHERE department_id = p_dept_id;
END;

#18
CREATE PROCEDURE GetTopPaidEmployees()
BEGIN
    SELECT e.*
    FROM employees e
    WHERE salary = (
        SELECT MAX(salary)
        FROM employees
        WHERE department_id = e.department_id
    ),
END;

#19
CREATE PROCEDURE PromoteEmployee(
    IN p_emp_id INT,
    IN p_new_salary DECIMAL(10,2),
    IN p_new_job_id VARCHAR(10)
)
BEGIN
    UPDATE employees
    SET salary = p_new_salary,
        job_id = p_new_job_id
    WHERE employee_id = p_emp_id,
END;

#20
CREATE PROCEDURE AssignManagerToDepartment(
    IN p_manager_id INT,
    IN p_dept_id INT
)
BEGIN
    UPDATE employees
    SET manager_id = p_manager_id
    WHERE department_id = p_dept_id,
END;













