-- DATE_TRUNC Function 
/* This Function use for cut values which we want */

SELECT 
     DATE_TRUNC('month',orderdate)::DATE AS order_month,
     SUM(ROUND((quantity*exchangerate*netprice)::numeric ,2)) AS netrevenue,
     COUNT(DISTINCT customerkey) AS unique_customer 

FROM sales
GROUP BY order_month
ORDER BY unique_customer DESC;

--- Extract The Values From The date 

SELECT 
     orderdate,
     TO_CHAR(orderdate ,'YYYY')
FROM sales     


SELECT
     TO_CHAR(orderdate ,'YYYY-MM') AS order_month,
     SUM(ROUND((quantity*netprice*exchangerate)::numeric,2)) AS netrevenue,
     COUNT(DISTINCT customerkey ) AS unique_cutomer
    
FROM sales      
GROUP BY order_month


-- DATE_PART()

SELECT 
     orderdate,
     DATE_PART('year', orderdate) AS order_year,
     DATE_PART('month', orderdate) AS order_month,
     DATE_PART('day', orderdate) AS order_day
FROM sales 
ORDER BY RANDOM()  -- Return Random Output Instead of return ASC or DESC 
LIMIT 10 ;     

-- Use EXTRACT()
SELECT 
     orderdate,
     EXTRACT (YEAR  FROM orderdate) order_year,
     EXTRACT (MONTH FROM orderdate) order_month,
     EXTRACT (DAY   FROM orderdate) order_day
FROM sales 
ORDER BY RANDOM()
LIMIT 10 ;     