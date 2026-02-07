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