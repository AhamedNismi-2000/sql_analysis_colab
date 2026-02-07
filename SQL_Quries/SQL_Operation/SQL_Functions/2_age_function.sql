
-- AGE ('enddate' ,'startdate')

SELECT 
   AGE(deliverydate,orderdate)
   FROM sales

-- Find The Average Delivery Time for Orders 

SELECT 
   EXTRACT(YEAR FROM orderdate) AS order_year,
   ROUND(AVG(EXTRACT(DAY FROM AGE(deliverydate,orderdate))),2) AS average_delivery_days,
   ROUND(SUM(quantity * netprice *exchangerate)::numeric,2) AS net_revenue
   FROM sales 
   WHERE orderdate >=  CURRENT_DATE - INTERVAL'5 years '
   GROUP BY order_year
   ORDER BY order_year;

