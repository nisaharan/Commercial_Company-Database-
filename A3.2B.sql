--Large Company Database

--Q27
--Write a query to display the eight departments in the LGDEPARTMENT table
--sorted by department name.
SELECT dept_name
FROM lgdepartment
ORDER BY dept_name

--Q28
--Write a query to display the SKU (stock keeping unit), description, type, base, category,
--and price for all products that have a PROD_BASE of Water and a PROD_
--CATEGORY of Sealer
SELECT prod_sku, prod_descript, prod_type, prod_base, prod_category, prod_price
FROM lgproduct
WHERE PROD_BASE IN ('WATER') AND prod_category IN ('SEALER')

--Q29
--Write a query to display the first name, last name, and email address of employees
--hired from January 1, 2005, to December 31, 2014. Sort the output by last name and
--then by first name
SELECT emp_fname, emp_lname, emp_email
FROM lgemployee
WHERE emp_hiredate>='2005-01-01' AND emp_hiredate<='2014-12-31'
ORDER BY emp_lname, emp_fname

--Q30
--Write a query to display the first name, last name, phone number, title, and department
--number of employees who work in department 300 or have the title “CLERK
--I.” Sort the output by last name and then by first name
SELECT emp_fname, emp_lname, emp_phone, emp_title, dept_num
FROM lgemployee
WHERE dept_num=300 OR emp_title='CLERK I'
ORDER BY emp_lname, emp_fname

--Q31
--Write a query to display the employee number, last name, first name, salary “from”
--date, salary end date, and salary amount for employees 83731, 83745, and 84039.
--Sort the output by employee number and salary “from” date
SELECT E.emp_num, E.emp_lname, E.emp_fname, S.sal_from, S.sal_end, S.sal_amount
FROM lgemployee E INNER JOIN lgsalary_history S ON E.emp_num=S.emp_num
WHERE E.emp_num IN (83731, 83745, 84039)
ORDER BY E.emp_num, S.sal_from

--Q32
--Write a query to display the first name, last name, street, city, state, and zip code of
--any customer who purchased a Foresters Best brand top coat between July 15, 2015,
--and July 31, 2015. If a customer purchased more than one such product, display the
--customer’s information only once in the output. Sort the output by state, last name,
--and then first name 
SELECT DISTINCT(C.cust_fname), C.cust_lname, C.cust_street, C.cust_city, C.cust_state, C.cust_zip 
FROM lgcustomer C INNER JOIN lginvoice I ON C.cust_code=I.cust_code INNER JOIN lgline L ON I.inv_num=L.inv_num 
INNER JOIN lgproduct P ON P.prod_sku=L.prod_sku INNER JOIN lgbrand B ON B.brand_id=P.brand_id
WHERE B.brand_name=('FORESTERS BEST') AND P.prod_category=('Top Coat') AND I.inv_date BETWEEN '2015-07-15' AND '2015-07-31'
ORDER BY C.cust_state, C.cust_lname, C.cust_fname

--Q33
--Write a query to display the employee number, last name, email address, title, and
--department name of each employee whose job title ends in the word “ASSOCIATE.”
--Sort the output by department name and employee title (Figure P7.33).
SELECT e.emp_num, e.emp_lname, e.emp_email, e.emp_title, d.dept_name
FROM lgemployee E INNER JOIN lgdepartment D on E.dept_num=D.dept_num
WHERE e.emp_title LIKE ('%ASSOCIATE')
ORDER BY D.dept_name, E.emp_title

--Q34
--Write a query to display a brand name and the number of products of that brand
--that are in the database. Sort the output by the brand name
SELECT B.brand_name, COUNT(P.prod_descript)AS number_of_products 
FROM lgbrand B INNER JOIN lgproduct P ON B.brand_id=P.brand_id
GROUP BY B.brand_name
ORDER BY B.brand_name

--Q35
--Write a query to display the number of products in each category that have a water
--base, sorted by category
SELECT PROD_CATEGORY, COUNT(prod_descript)AS number_of_products
FROM lgproduct
WHERE prod_base=('WATER')
GROUP BY prod_category
ORDER BY prod_category

--Q36
--Write a query to display the number of products within each base and type combination,
--sorted by base and then by type
SELECT prod_base, prod_type, COUNT(prod_descript) AS number_of_products
FROM lgproduct
GROUP BY prod_base, prod_type
ORDER BY prod_base, prod_type

--Q37
--Write a query to display the total inventory—that is, the sum of all products on hand
--for each brand ID. Sort the output by brand ID in descending order
SELECT B.brand_id, SUM(P.prod_qoh)AS TOTAL_INVENTORY 
FROM lgbrand B INNER JOIN lgproduct P ON B.brand_id=P.brand_id
GROUP BY B.brand_id
ORDER BY B.brand_id DESC


--Q38
--Write a query to display the brand ID, brand name, and average price of products
--of each brand. Sort the output by brand name. Results are shown with the average
--price rounded to two decimal places
SELECT B.brand_id, B.brand_name AS BRAND_NAME, ROUND(AVG(P.prod_price),2) AS AVG_PRICE
FROM lgbrand B INNER JOIN lgproduct P ON B.brand_id=P.brand_id
GROUP BY B.brand_id, B.brand_name
ORDER BY B.brand_name

--Q39
--Write a query to display the department number and most recent employee hire
--date for each department. Sort the output by department number
SELECT dept_num, MAX(emp_hiredate) AS MOSTRECENT
FROM lgemployee
GROUP BY dept_num
ORDER BY dept_num

--Q40
--Write a query to display the employee number, first name, last name, and largest
--salary amount for each employee in department 200. Sort the output by largest salary
--in descending order
SELECT E.emp_num, E.emp_fname, E.emp_lname, MAX(S.sal_amount) AS LARGESTSALARY
FROM lgemployee E INNER JOIN lgsalary_history S ON E.emp_num=S.emp_num
WHERE E.dept_num='200'
GROUP BY E.emp_num, E.emp_fname, E.emp_lname
ORDER BY LARGESTSALARY DESC

--Q41
--Write a query to display the customer code, first name, last name, and sum of all
--invoice totals for customers with cumulative invoice totals greater than $1,500. Sort
--the output by the sum of invoice totals in descending order
SELECT C.cust_code, C.cust_fname, C.cust_lname, ROUND(SUM(I.inv_total),2) AS TOTALINVOICES
FROM lgcustomer C INNER JOIN lginvoice I ON C.cust_code=I.cust_code
GROUP BY C.cust_code, C.cust_fname, C.cust_lname
HAVING ROUND(SUM(I.inv_total),2)>1500
ORDER BY TOTALINVOICES DESC

--Q42
--Write a query to display the department number, department name, department
--phone number, employee number, and last name of each department manager. Sort
--the output by department name
SELECT D.dept_num, D.dept_name, D.dept_phone, D.emp_num, E.emp_lname
FROM lgemployee E INNER JOIN lgdepartment D ON E.emp_num=D.emp_num
ORDER BY D.dept_name

--Q43
--Write a query to display the vendor ID, vendor name, brand name, and number of
--products of each brand supplied by each vendor. Sort the output by vendor name
--and then by brand name
SELECT V.vend_id, V.vend_name, B.brand_name, COUNT(B.brand_id) AS NUMPRODUCTS
FROM lgvendor V INNER JOIN lgSUPPLIES S ON V.vend_id=S.vend_id INNER JOIN lgproduct P ON S.prod_sku=P.prod_sku INNER JOIN lgbrand B ON P.brand_id=B.brand_id
GROUP BY V.vend_id, V.vend_name, B.brand_name
ORDER BY V.vend_name, B.brand_name

--Q44
--Write a query to display the employee number, last name, first name, and sum
--of invoice totals for all employees who completed an invoice. Sort the output by
--employee last name and then by first name
SELECT E.emp_num, E.emp_lname, E.emp_fname, SUM(inv_total) AS TOTALINVOICES
FROM lgemployee E INNER JOIN lginvoice I ON E.emp_num=I.employee_id
GROUP BY E.emp_num, E.emp_lname, E.emp_fname
ORDER BY E.emp_lname, E.emp_fname

--Q45
--Write a query to display the largest average product price of any brand
SELECT MAX(AVGPRICE) AS 'LARGEST AVERAGE'
FROM (SELECT AVG(prod_price) AVGPRICE from lgproduct group by brand_id) A

--Q46
--Write a query to display the brand ID, brand name, brand type, and average price
--of products for the brand that has the largest average product price
SELECT B.brand_id, B.brand_name, B.brand_type, ROUND(AVG(PROD_PRICE),2) AVGPRICE
FROM lgbrand B INNER JOIN lgproduct P ON P.brand_id=B.brand_id
GROUP BY B.brand_id, B.brand_name, B.brand_type
HAVING AVG(PROD_PRICE)=(SELECT MAX(AVGPRICE) AS 'LARGEST AVERAGE'
FROM (SELECT AVG(prod_price) AVGPRICE from lgproduct group by brand_id) A)


--Q47
--Write a query to display the manager name, department name, department phone
--number, employee name, customer name, invoice date, and invoice total for the
--department manager of the employee who made a sale to a customer whose last
--name is Hagan on May 18, 2015
SELECT E.emp_fname AS MANAGER_FNAME, E.emp_lname AS MANAGER_LNAME, D.dept_name, D.dept_phone, Q.emp_fname AS EMPLOYEE_FNAME, Q.emp_lname AS EMPLOYEE_LNAME, C.cust_fname AS CUSTOMER_FNAME, C.cust_lname AS CUCTOMER_LNAME, I.inv_date, I.inv_total 
FROM lgemployee E INNER JOIN lgdepartment D ON E.EMP_NUM=D.emp_num INNER JOIN lgemployee Q ON E.dept_num=Q.dept_num INNER JOIN lginvoice I ON I.employee_id=Q.emp_num INNER JOIN lgcustomer C ON C.cust_code=I.cust_code 
WHERE C.cust_lname='HAGAN' AND I.inv_date='2015-05-18'
--Q48
--Write a query to display the current salary for each employee in department 300.
--Assume that only current employees are kept in the system, and therefore the most
--current salary for each employee is the entry in the salary history with a NULL end
--date. Sort the output in descending order by salary amount
SELECT E.emp_num, E.emp_lname, E.emp_fname, S.sal_amount
FROM lgemployee E INNER JOIN lgsalary_history S ON E.emp_num=S.emp_num
WHERE E.dept_num=300 AND S.sal_end IS NULL
ORDER BY S.sal_amount DESC

--Q49
--Write a query to display the starting salary for each employee. The starting salary
--would be the entry in the salary history with the oldest salary start date for each
--employee. Sort the output by employee number
SELECT E.emp_num, E.emp_lname, E.emp_fname, MIN(S.sal_amount) AS SAL_AMOUNT
FROM lgemployee E INNER JOIN lgsalary_history S ON E.emp_num=S.emp_num
GROUP BY E.emp_num, E.emp_lname, E.emp_fname
ORDER BY E.emp_num

--Q50
--Write a query to display the invoice number, line numbers, product SKUs, product
--descriptions, and brand ID for sales of sealer and top coat products of the same
--brand on the same invoice. Sort the results by invoice number in ascending order,
--first line number in ascending order, and then by second line number in descending
--order
SELECT B.inv_num, B.line_num as lLine_num, B.prod_sku as pprod_sku, B.prod_descript as pprod_desc, A.line_num as l2Line_num, A.prod_sku as p2prod_sku, A.prod_descript as p2prod_descript, A.brand_id
FROM (SELECT L.inv_num, L.line_num, P.prod_sku,P.prod_descript, P.brand_id
FROM lgline L INNER JOIN lgproduct P ON L.prod_sku=P.prod_sku
WHERE P.prod_category='Top Coat') A INNER JOIN 
(SELECT L.inv_num, L.line_num, P.prod_sku,P.prod_descript, P.brand_id
FROM lgline L INNER JOIN lgproduct P ON L.prod_sku=P.prod_sku
WHERE P.prod_category='Sealer') B ON A.inv_num=B.inv_num AND A.brand_id=B.brand_id
ORDER BY A.inv_num, A.line_num, B.line_num DESC

--Q51
--The Binder Prime Company wants to recognize the employee who sold the most of
--its products during a specified period. Write a query to display the employee number,
--employee first name, employee last name, email address, and total units sold for
--the employee who sold the most Binder Prime brand products between November
--1, 2015, and December 5, 2015. If there is a tie for most units sold, sort the output
--by employee last name

SELECT EMP_NUM,EMP_FNAME,EMP_LNAME,EMP_EMAIL,TOTAL
FROM LGEMPLOYEE E INNER JOIN (SELECT EMPLOYEE_ID, SUM(LINE_QTY) AS TOTAL
FROM LGINVOICE I INNER JOIN LGLINE L ON I.INV_NUM = L.INV_NUM
INNER JOIN LGPRODUCT P ON L.PROD_SKU = P.PROD_SKU
INNER JOIN LGBRAND B ON B.BRAND_ID = P.BRAND_ID
WHERE BRAND_NAME = 'Binder Prime' AND INV_DATE BETWEEN '2015-11-01' AND '2015-12-05'
GROUP BY EMPLOYEE_ID) R ON E.EMP_NUM = R.EMPLOYEE_ID
WHERE TOTAL = (SELECT MAX(Q.TOTAL)
FROM (SELECT EMPLOYEE_ID, SUM(LINE_QTY) AS TOTAL
FROM LGINVOICE AS I INNER JOIN LGLINE L ON I.INV_NUM = L.INV_NUM
INNER JOIN LGPRODUCT P ON L.PROD_SKU = P.PROD_SKU INNER JOIN LGBRAND B ON B.BRAND_ID = P.BRAND_ID
WHERE BRAND_NAME = 'Binder Prime' AND INV_DATE BETWEEN '2015-11-01' AND '2015-12-05'
GROUP BY EMPLOYEE_ID) AS Q)
ORDER BY EMP_LNAME



--Q52
--Write a query to display the customer code, first name, and last name of all customers
--who have had at least one invoice completed by employee 83649 and at least one
--invoice completed by employee 83677. Sort the output by customer last name and
--then first name
SELECT DISTINCT A.CUST_CODE, A.CUST_FNAME, A.CUST_LNAME
FROM (SELECT C.CUST_CODE, C.CUST_FNAME, C.CUST_LNAME
FROM lgcustomer C, lginvoice I
WHERE C.cust_code=I.cust_code AND employee_ID=83649) A INNER JOIN 
(SELECT C.cust_code, C.cust_fname, C.cust_lname
FROM lgcustomer C, lginvoice I
WHERE C.cust_code=I.cust_code AND employee_ID=83677) B ON A.cust_code=B.cust_code
ORDER BY A.CUST_LNAME, A.CUST_FNAME

--Q53
--LargeCo is planning a new promotion in Alabama (AL) and wants to know about
--the largest purchases made by customers in that state. Write a query to display
--the customer code, customer first name, last name, full address, invoice date, and
--invoice total of the largest purchase made by each customer in Alabama. Be certain
--to include any customers in Alabama who have never made a purchase; their
--invoice dates should be NULL and the invoice totals should display as 0. Sort the
--results by customer last name and then first name 
SELECT C.cust_code, C.cust_fname, C.cust_lname, C.cust_street, C.cust_city, C.cust_state, C.cust_zip, I.inv_date, I.inv_total AS 'Largest Invoice'
FROM LGCUSTOMER C INNER JOIN LGINVOICE I ON C.CUST_CODE=I.CUST_CODE
WHERE C.cust_state='AL' AND I.inv_total = (SELECT MAX(I2.inv_total) FROM lginvoice I2 WHERE I2.cust_code = C.cust_code)
UNION SELECT C2.cust_code, C2.cust_fname, C2.cust_lname, C2.cust_street, C2.cust_city, C2.cust_state,
C2.cust_zip, null, 0 FROM lgcustomer C2 WHERE C2.cust_state = 'AL'
AND C2.cust_code NOT IN (SELECT I3.cust_code FROM lginvoice I3)
ORDER BY cust_lname, cust_fname