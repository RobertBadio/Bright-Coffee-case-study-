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
      WHEN (transaction_qty*unit_price) <=10 THEN '01.Low_Spenders'
      WHEN (transaction_qty*unit_price) BETWEEN 11 AND 30 THEN '02.Medium_Spenders'
      WHEN (transaction_qty*unit_price) BETWEEN 31 AND 100 THEN '03.High_Spenders'
      ELSE '04.Very High_Spenders'
      END AS Spend_classification,

--New collumn added for total revenue for our data and trnsaction 
transaction_qty*unit_price as Revenue
from workspace.default.bright_coffee_shop_sales_happy;

