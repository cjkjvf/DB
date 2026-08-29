/*Task 1
We have a table Orders. 
Show the date of the first order ever made in the Orders table.
Note. There’s a aggregate function called Min that you need to use for this problem.*/

SELECT MIN(order_date)
FROM orders;

/*Task 2
We have a table Customers. 
Show a list of countries where the Northwind company has customers and the number of Customers who work there (alias NumberOfCustomers).
The result should be sorted by NumberOfCustomers in descending order
Note. You need to use grouping and an aggregate function called COUNT() for this problem.*/

SELECT country, COUNT(*) AS "NumberOfCustomers"
FROM customers
GROUP BY country
ORDER BY COUNT(*) DESC;

/*Task 3
We have a table Customers. 
Show a list of countries where Northwind company has customers and the number of Customers who work there (alias NumberOfCustomers).
The result should contain only the data about countries where the number of customers equals or exceeds 3.
The result should be sorted by NumberOfCustomers in descending order, and by Country ascending.
Note. You need to use grouping and an aggregate function called COUNT() for this problem.*/

SELECT country, COUNT(*) AS "NumberOfCustomers"
FROM customers
GROUP BY country
HAVING COUNT(*) >= 3
ORDER BY COUNT(*) DESC, country ASC;

/*Task 4
Given a table Customers. 
Show a list of all distinct values in the Customers table for ContactTitles. Also include a count for each ContactTitle (alias TotalContactTitle). 
The result set should be sorted in descending order by TotalContactTitle, and in ascending order by ContactTitle.
Note. The solution of this problem is built on multiple concepts, such as grouping, aggregate functions, and aliases.*/

SELECT DISTINCT contact_title, COUNT(*) AS "TotalContactTitle"
FROM customers
GROUP BY contact_title
ORDER BY COUNT(*) DESC, contact_title ASC;

/*Task 5
We have a table Products. 
Write a query that should show the list of CategoryID, the number of all products within each category (NumberOfProducts) only for those products with the value UnitsInStock less than UnitsOnOrder.
The report should contain only the rows where NumberOfProducts is more than 1. 
The result set should be sorted in ascending order by NumberOfProducts.
Note. The answer for this problem builds on multiple concepts, such as grouping, aggregate functions, and aliases.*/

SELECT category_id, COUNT (*) AS "NumberOfProducts"
FROM products
WHERE units_in_stock < units_on_order 
GROUP BY category_id
HAVING COUNT(*) > 1
ORDER BY COUNT(*) ASC;
