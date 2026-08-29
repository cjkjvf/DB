/* task 1
1. Show all info about company_name and address from the customers table.
2. Show all info about company_name and contact_person from the suppliers table.
3. Show all info about product_name and unit_price from the products table.
4. Show all info about last_name, first_name, birth_date and hire_date of employees. */

SELECT company_name, address
FROM customers;

SELECT company_name, contact_name
FROM suppliers;

SELECT product_name, unit_price
FROM products;

SELECT last_name, first_name, birth_date, hire_date
FROM employees;

/* task 2
1. Show all info about the employee with ID 8.
2. Show the list of first and last names of the employees from London.
3. Show the list of first, last names and ages of the employees whose age is greater than 55.
2. Show the list of products with the price between 10 and 50. */

SELECT * FROM employees
WHERE employee_id = 8;


SELECT first_name, last_name
FROM employees
WHERE city IN ('London');

SELECT first_name, last_name, EXTRACT(YEAR FROM AGE(birth_date)) AS age 
FROM employees
WHERE  EXTRACT(YEAR FROM AGE(birth_date)) > 55;

SELECT product_name, unit_price
FROM products
WHERE unit_price BETWEEN 10 AND 50;

/* task 3
1. Show the list of products which names start form ‘N’ and price is greater than 50.
2. Show the total number of employees which live in the same city.
3. Show the list of suppliers which name begins with letter ‘A’ and are situated in London.
4. Show the list of first, last names and ages of the employees whose age is greater than
average age of all employees. The result should be sorted by last name.
5. Calculate the count of customers from Mexico and contact signed as ‘Owner’ */

SELECT product_name, unit_price
FROM products
WHERE product_name LIKE 'N%' AND unit_price > 50;

SELECT COUNT(*) AS employees_count, city
FROM employees
GROUP BY city;

SELECT contact_name, city
FROM suppliers
WHERE contact_name LIKE 'A%' AND city = 'London';

SELECT first_name, last_name, EXTRACT(YEAR FROM AGE(birth_date)) AS age
FROM employees
WHERE EXTRACT(YEAR FROM AGE(birth_date)) > 
  (SELECT AVG(EXTRACT(YEAR FROM AGE(birth_date))) FROM employees)
ORDER BY last_name;

SELECT COUNT(*), country, contact_title
FROM customers
WHERE country = 'Mexico' AND contact_title = 'Owner'
GROUP BY country, contact_title;
