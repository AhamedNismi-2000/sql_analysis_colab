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
     EXTRACT(YEAR  FROM orderdate) order_year,
     EXTRACT(MONTH FROM orderdate) order_month,
     EXTRACT(DAY   FROM orderdate) order_day
FROM sales 
ORDER BY RANDOM()
LIMIT 10 ;     


-- Extract Order Date And Order Month From Date 

SELECT 
      EXTRACT(YEAR FROM orderdate) AS order_year,
      EXTRACT(MONTH FROM orderdate) AS order_month,
      SUM(ROUND((quantity*exchangerate*netprice)::numeric,2))
FROM sales 
GROUP BY  order_year, order_month
ORDER BY  order_year DESC, order_month DESC

-- CURRENT_DATE () , NOW()
SELECT CURRENT_DATE
SELECT NOW();



-- Find Order Date Before 5 Years 

SELECT  
     p.categoryname,
     s.orderdate
     FROM sales s
     LEFT JOIN product p ON p.productkey= s.productkey
     WHERE 
     EXTRACT(YEAR FROM orderdate ) >= EXTRACT(YEAR FROM CURRENT_DATE)-5 
     GROUP BY p.categoryname , s.orderdate 
     ORDER BY p.categoryname , s.orderdate ;  
     
 -- Find Exact Five Years From Current Date 

SELECT 
    p.categoryname,
    s.orderdate
    FROM sales s LEFT JOIN product p
    ON p.productkey = s.productkey
    WHERE orderdate >= CURRENT_DATE - INTERVAL '5 years' 
    ORDER BY p.categoryname , s.orderdate ;  