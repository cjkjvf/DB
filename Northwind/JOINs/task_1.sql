/*Task 1
We have tables Products and Suppliers.
Show a list of ProductID, ProductName and CompanyName (supplier's company name) 
for all products supplied by companies located in Germany or Spain.
The result should be sorted by ProductID in ascending order.
Note. You need to use JOIN to combine data from Products and Suppliers tables.*/

SELECT p.product_id, p.product_name, s.company_name
FROM products AS p 
JOIN suppliers AS s
ON p.supplier_id = s.supplier_id
WHERE s.country IN ('Germany', 'Spain')
ORDER BY product_id;

/*Task 2
We have tables Orders and Shippers.
Show a list of OrderID, OrderDate (alias ShortDate) and the CompanyName of the shipper 
for all orders with OrderID less than 10260.
The result should be sorted by OrderID in ascending order.
Note. You need to use JOIN to combine data from Orders and Shippers tables.*/

SELECT o.order_id, o.order_date AS short_date, s.company_name 
FROM orders AS o
JOIN shippers AS s  
ON o.ship_via = s.shipper_id
WHERE o.order_id < 10260
ORDER BY o.order_id;

/*Task 3
We have tables Orders, OrderDetails, Employees and Products.
Show a list of OrderID, ProductName and Quantity for all orders handled by employee 
Janet Leverling, where the quantity ordered was greater than 50.
The result should be sorted by Quantity in ascending order.
Note. You need to use multiple JOINs to combine data from Orders, OrderDetails, 
Employees and Products tables.*/

SELECT o.order_id, p.product_name, od.quantity
FROM orders o
JOIN order_details od ON od.order_id = o.order_id
JOIN employees e ON e.employee_id = o.employee_id
JOIN products p ON p.product_id = od.product_id 
WHERE e.last_name = 'Leverling' AND e.first_name = 'Janet' AND od.quantity > 50
ORDER BY quantity;

/*Task 4
We have tables Customers and Orders.
Show a list of company names of customers who have never placed an order.
Note. You need to use LEFT JOIN to find customers without matching records in Orders.*/

SELECT c.company_name
FROM customers AS c
LEFT JOIN orders AS o 
ON o.customer_id = c.customer_id
WHERE o.customer_id IS NULL;

/*Task 5
We have tables Customers and Orders.
Show a list of company names of customers who have never placed an order 
with employee ID 4.
Note. You need to use LEFT JOIN with an additional condition on the join clause.*/

SELECT c.company_name, order_id
FROM customers AS c
LEFT JOIN orders AS o 
ON o.customer_id = c.customer_id AND o.employee_id = 4
WHERE o.customer_id IS NULL ;

/*Task 6
We have tables Orders, OrderDetails, Products and Customers.
Create a report that shows CustomerID, CompanyName, OrderID and the total order amount 
(TotalOrderAmount) using the expression Quantity * UnitPrice, only for orders placed in 1998.
The report should contain only orders where the total order amount is 10000 or more.
The result should be sorted by TotalOrderAmount in descending order.
Note. The answer builds on multiple concepts, such as JOIN, grouping, aggregate functions, 
and aliases.*/

SELECT c.customer_id, c.company_name, o.order_id, SUM(od.quantity * od.unit_price) AS total_order_amount
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON p.product_id = od.product_id
WHERE EXTRACT(YEAR FROM o.order_date) = 1998
GROUP BY c.customer_id, c.company_name, o.order_id
HAVING SUM(od.quantity * od.unit_price) >= 10000
ORDER BY total_order_amount DESC;

/*Task 7
We have tables Customers, Orders, OrderDetails and Products.
Create a report that shows CustomerID, CompanyName and the total sum of all orders 
(TotalOrderAmount) placed by each customer in 1998, using the expression Quantity * UnitPrice.
The value TotalOrderAmount should be rounded to the 2nd digit after the decimal point.
The report should contain only customers whose total order amount is 15000 or more.
The result should be sorted by TotalOrderAmount in descending order.
Note. You need to use ROUND(<value>, 2) function for the sum result.*/

SELECT c.customer_id, c.company_name, ROUND(SUM(od.quantity * od.unit_price)::numeric, 2) AS total_order_amount
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON p.product_id = od.product_id
WHERE EXTRACT(YEAR FROM o.order_date) = 1998
GROUP BY c.customer_id, c.company_name
HAVING SUM(od.quantity * od.unit_price) >= 15000
ORDER BY total_order_amount DESC;

/*Task 8
We have tables Customers, Orders, OrderDetails and Products.
Create a report that shows CustomerID, CompanyName, the total sum of all orders 
(TotalOrderAmount) using the expression Quantity * UnitPrice, and the total sum with 
discount applied (TotalWithDiscount) using the expression Quantity * UnitPrice * (1 - Discount), 
for each customer in 1998.
Both values should be rounded to the 2nd digit after the decimal point.
The report should contain only customers whose TotalOrderAmount is 15000 or more.
The result should be sorted by TotalOrderAmount in descending order.
Note. The answer builds on multiple concepts, such as JOIN, grouping, aggregate functions, 
and aliases.*/


SELECT c.customer_id, c.company_name,
   ROUND(SUM(od.quantity * od.unit_price)::numeric, 2) AS total_order_amount,
   ROUND(SUM(od.quantity * od.unit_price *(1-od.discount))::numeric, 2) AS total_with_discount
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON p.product_id = od.product_id
WHERE EXTRACT(YEAR FROM o.order_date) = 1998
GROUP BY c.customer_id, c.company_name
HAVING SUM(od.quantity * od.unit_price) >= 15000
ORDER BY total_order_amount DESC;

/*Task 9
We have tables Orders and OrderDetails.
Create a report that shows OrderID and the total number of order lines 
(TotalOrderLines) for each order.
Show only the top 10 orders with the highest number of order lines.
The result should be sorted by TotalOrderLines in descending order.
Note. You need to use LIMIT to restrict the result to 10 rows.*/

SELECT o.order_id, COUNT(*) AS "TotalOrderLines"
FROM orders o 
JOIN order_details od ON o.order_id = od.order_id
GROUP BY o.order_id
ORDER BY "TotalOrderLines" DESC
LIMIT 10;

/*Task 10
We have tables Orders and Employees.
Create a report that shows EmployeeID, LastName and the total number of late orders 
(TotalLateOrders) for each employee. The condition of a late order is ShippedDate 
greater than RequiredDate.
The result should be sorted by TotalLateOrders in descending order.
Note. The answer builds on multiple concepts, such as JOIN, grouping, aggregate functions, 
and aliases.*/

SELECT o.employee_id, e.last_name, COUNT(*) AS "TotalLateOrders"
FROM orders o 
JOIN employees e ON o.employee_id = e.employee_id
WHERE o.shipped_date > o.required_date
GROUP BY o.employee_id, e.last_name
ORDER BY "TotalLateOrders" DESC;
