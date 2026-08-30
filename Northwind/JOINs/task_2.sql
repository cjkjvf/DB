/*Task 1
We have tables Customers and Orders.
Create a report that shows CompanyName and the total number of orders (NumberOfOrders) 
placed by each customer, only for orders placed after December 31, 1997.
The report should contain only customers who placed more than 10 orders.
The result should be sorted by NumberOfOrders in descending order.
Note. The answer builds on multiple concepts, such as JOIN, grouping, aggregate functions, 
and aliases.*/

SELECT c.company_name, COUNT(*) AS "NumberOfOrders" 
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_date > '1997-12-31'
GROUP BY c.company_name
HAVING COUNT(*) > 10
ORDER BY "NumberOfOrders" DESC;

/*Task 2
We have a table Employees.
Create a report that shows EmployeeID, the full name of each employee (alias Employee), 
and the full name of their manager (alias Manager), using the ReportsTo column 
to identify who reports to whom.
The result should be sorted by EmployeeID in ascending order.
Note. You need to use a self-join (JOIN the Employees table with itself) to match 
employees with their managers.*/

SELECT e.employee_id,
    e.last_name || ' ' || e.first_name AS employee,
    m.last_name || ' ' || m.first_name AS manager
FROM employees e 
JOIN employees m ON e.reports_to = m.employee_id
ORDER BY e.employee_id;

/*Task 3
We have tables Customers, Orders and OrderDetails.
Create a report that shows ContactName and the total sum (TotalSum) of all orders 
where a discount was applied, using the expression UnitPrice * Quantity * (1 - Discount).
The value TotalSum should be rounded to the 2nd digit after the decimal point.
The report should contain only customers whose TotalSum exceeds 10000.
The result should be sorted by ContactName in ascending order.
Note. You need to use ROUND(<value>, 2) function for the sum result.*/

SELECT c.contact_name, ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount))::numeric, 2) AS total_sum
FROM customers c 
JOIN orders o ON o.customer_id = c.customer_id
JOIN order_details od ON o.order_id = od.order_id
WHERE od.discount > 0
GROUP BY c.contact_name
HAVING ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount))::numeric, 2) > 10000
ORDER BY c.contact_name;

/*Task 4
We have tables Products and OrderDetails.
Create a report that shows ProductName and the total number of units sold (TotalUnits) 
for each product, using the Quantity column.
The report should contain only products where the total units sold is less than 200.
The result should be sorted by ProductName in ascending order.
Note. The answer builds on multiple concepts, such as JOIN, grouping, aggregate functions, 
and aliases.*/

SELECT p.product_name, SUM(od.quantity) AS total_units
FROM products p
JOIN order_details od ON p.product_id = od.product_id
GROUP BY p.product_name
HAVING SUM(od.quantity) < 200
ORDER BY p.product_name;    

/*Task 5
We have tables Customers and Orders.
Create a report that shows CompanyName and the total number of orders (NumOrders) 
placed by each customer, only for orders placed after December 31, 1997.
The report should contain only customers who placed more than 5 orders.
The result should be sorted by NumOrders in descending order.
Note. The answer builds on multiple concepts, such as JOIN, grouping, aggregate functions, 
and aliases.*/

SELECT c.company_name, COUNT(*) AS num_orders
FROM customers c 
JOIN orders o ON o.customer_id = c.customer_id
WHERE o.order_date > '1997-12-31'
GROUP BY c.company_name
HAVING COUNT(*) > 5
ORDER BY num_orders DESC;

/*Task 6
We have tables Customers, Orders and OrderDetails.
Create a report that shows CompanyName, OrderID and the total price (TotalPrice) 
of each order, using the expression UnitPrice * Quantity * (1 - Discount).
The value TotalPrice should be rounded to the 2nd digit after the decimal point.
The report should contain only orders where the total price exceeds 10000.
The result should be sorted by TotalPrice in descending order.
Note. You need to use ROUND(<value>, 2) function for the sum result.*/

SELECT c.company_name, o.order_id, ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount))::numeric, 2) AS total_price
FROM customers c 
JOIN orders o ON o.customer_id = c.customer_id
JOIN order_details od ON od.order_id = o.order_id
GROUP BY c.company_name, o.order_id
HAVING ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount))::numeric, 2) > 10000
ORDER BY total_price DESC;

/*Task 7
We have tables Employees and Customers.
Create a report that shows City, the number of distinct employees (NumEmployees) 
and the number of distinct companies (NumCompanies), for cities where both employees 
and customers are located.
The result should be sorted by NumEmployees in ascending order.
Note. You need to use COUNT(DISTINCT <column>) to avoid duplicate counts.*/

SELECT c.city, COUNT(DISTINCT e.employee_id) AS num_employees, COUNT(DISTINCT c.customer_id) AS num_companies
FROM employees e 
JOIN customers c ON e.city = c.city
GROUP BY c.city
ORDER BY num_employees;

/*Task 8
We have tables Employees, Customers and Suppliers.
Create a report that shows a combined list of names, phone numbers and a type label 
('employee', 'customer' or 'supplier') for all employees, customers and suppliers 
located in London.
Note. You need to use UNION ALL to combine results from three different tables.*/

SELECT e.last_name || ' ' || e.first_name AS employee,
    e.home_phone AS phone,
    'employee' AS type
FROM employees e
WHERE e.city = 'London'
UNION ALL 

SELECT c.company_name AS name,
    c.phone AS phone,
    'customer' AS type
FROM customers c
WHERE c.city = 'London'
UNION ALL 

SELECT s.company_name AS name,
    s.phone AS phone,
    'supplier' AS type
FROM suppliers s 
WHERE s.city = 'London';

/*Task 9
We have tables Employees, Orders and OrderDetails.
Create a report that shows the first name, last name and total sales amount 
(TotalSales) for each employee, using the expression UnitPrice * Quantity * (1 - Discount).
The value TotalSales should be rounded to the 2nd digit after the decimal point.
The report should contain only employees whose total quantity sold exceeds 200.
Note. The answer builds on multiple concepts, such as JOIN, grouping, aggregate functions, 
and aliases.*/

SELECT e.first_name, e.last_name, ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount))::numeric, 2)  AS total_sales
FROM employees e 
JOIN orders o ON o.employee_id = e.employee_id
JOIN order_details od ON od.order_id = o.order_id
GROUP BY e.first_name, e.last_name
HAVING SUM(od.quantity) > 200;

/*Task 10
We have tables Employees, Orders, OrderDetails, Products and Suppliers.
Create a report that shows the first name and last name of employees who worked 
with products from more than 25 distinct suppliers during 1998.
Note. You need to use COUNT(DISTINCT <column>) together with multiple JOINs 
to combine data from five tables.*/

SELECT e.first_name, e.last_name
FROM employees e 
JOIN orders o ON e.employee_id = o.employee_id
JOIN order_details od ON od.order_id = o.order_id
JOIN products p ON p.product_id = od.product_id
JOIN suppliers s ON s.supplier_id = p.supplier_id
WHERE EXTRACT(YEAR FROM o.order_date) = 1998
GROUP BY e.first_name, e.last_name
HAVING COUNT(DISTINCT s.supplier_id) > 25;
