-- QUERY 1: View first 10 rows

SELECT *
FROM workspace.default.bright_coffee_shop_sales_happy
LIMIT 10;


-- QUERY 2: Distinct store locations

SELECT DISTINCT store_location
FROM workspace.default.bright_coffee_shop_sales_happy

-- QUERY 3: Select specific columns

SELECT DISTINCT transaction_id,
       product_category,
       unit_price
FROM workspace.default.bright_coffee_shop_sales_happy
LIMIT 20;


-- QUERY 4: Column alias

SELECT product_category AS Category,
       unit_price AS Price
FROM workspace.default.bright_coffee_shop_sales_happy
LIMIT 100;


-- QUERY 5: Filter with WHERE

SELECT *
FROM workspace.default.bright_coffee_shop_sales_happy
WHERE product_category = 'Coffee';



-- QUERY 6: WHERE with AND

SELECT *
FROM workspace.default.bright_coffee_shop_sales_happy
WHERE product_category = 'Coffee beans'
AND unit_price > 10;


-- QUERY 7: Minimum price

SELECT MIN(unit_price) AS Min_Price
FROM workspace.default.bright_coffee_shop_sales_happy

-- QUERY 8: Maximum price

SELECT MAX(unit_price) AS Min_Price
FROM workspace.default.bright_coffee_shop_sales_happy

-- QUERY 9: WHERE with OR

SELECT *
FROM `workspace`.`default`.`bright_coffee_shop_8pm`
WHERE product_category = 'Coffee'
OR product_category = 'Tea';


-- QUERY 10: WHERE with IN

SELECT *
FROM workspace.default.bright_coffee_shop_sales_happy
WHERE product_category IN ('Coffee', 'Tea');


-- QUERY 11: Sorting results

SELECT product_category,
       unit_price
FROM workspace.default.bright_coffee_shop_sales_happy
ORDER BY unit_price DESC;


-- QUERY 12: Count transactions

SELECT COUNT(*)
FROM workspace.default.bright_coffee_shop_sales_happy

-- QUERY 13: Total sales

SELECT SUM(transaction_qty * unit_price) AS Total_Sales
FROM workspace.default.bright_coffee_shop_sales_happy

-- QUERY 14: Min & Max price

SELECT MIN(unit_price) AS cheapest_item,
       MAX(unit_price) AS most_expensive_item
FROM workspace.default.bright_coffee_shop_sales_happy

-- QUERY 15: Sales per category

SELECT product_category,
       SUM(transaction_qty * unit_price) AS Total_Sales
FROM workspace.default.bright_coffee_shop_sales_happy
GROUP BY product_category
ORDER BY Total_Sales DESC;


--product category checking (9 product category)
select distinct product_category 
from workspace.default.bright_coffee_shop_sales_happy

--checking product category details (80 different product details)
select distinct product_detail
from workspace.default.bright_coffee_shop_sales_happy

--Combining or BIG DATA TABLE EXPORT

select 
      transaction_id,
      transaction_time, 
      transaction_date,
      transaction_qty,
      store_id,
      store_location,
      product_id,
      unit_price,
      product_category,
      product_type,
      product_detail,

--Adding Other collums for better insites and better interpretations of our data.each bellow added as new column 
dayname(transaction_date) as Day_name, 
monthname(transaction_date) as Month_name,
dayofmonth(transaction_date) as Date_of_month, 

--ADDING CASE STATEMENTS FOR WEEKDAYS, WEEKENDS 
CASE 
      WHEN dayname(transaction_date) IN ('Sun','Sat') THEN 'Weekend'
      ELSE 'Weekday' 
END AS Day_classification,

--ADDING TIME BUCKETS AS NEW COLLUMN
CASE 
      WHEN date_format(transaction_time,'HH:MM:SS') BETWEEN '05:00:00' AND '08:59:59' THEN '01.Morning Rush'
      WHEN date_format(transaction_time,'HH:MM:SS') BETWEEN '09:00:00' AND '10:59:59' THEN '02.Morming'
      WHEN date_format(transaction_time,'HH:MM:SS') BETWEEN '11:00:00' AND '14:59:59' THEN '03.Afternoon'
      WHEN date_format(transaction_time,'HH:MM:SS') BETWEEN '15:00:00' AND '18:59:59' THEN '04.Evening'
      ELSE '05.Night'
      END AS Time_classification,

--Spend buckets.. high spenders and low spenders.
CASE 
      WHEN (transaction_qty*unit_price) <=50 THEN '01.Low_Spenders'
      WHEN (transaction_qty*unit_price) BETWEEN 51 AND 200 THEN '02.Medium_Spenders'
      WHEN (transaction_qty*unit_price) BETWEEN 201 AND 300 THEN '03.High_Spenders'
      ELSE '04.Very High_Spenders'
      END AS Spend_classification
from workspace.default.bright_coffee_shop_sales_happy;

--New collumn added for total revenue for our data and trnsaction 
transaction_qty*unit_price as Total_revenue
from workspace.default.bright_coffee_shop_sales_happy;







