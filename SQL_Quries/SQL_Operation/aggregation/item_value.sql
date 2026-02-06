-- Analyse the Items Worth and Categorize Those 

SELECT
     orderdate,
     netprice,
     quantity,
CASE WHEN quantity >= 2 AND netprice>= 100  THEN 'Multiple High Value Order'    
     WHEN netprice>= 100  THEN 'Single High Value Item'   
     WHEN quantity>= 2  THEN 'Multiple Standard  Items'      
ELSE 'Single Standard item'
END AS order_type  
FROM sales 
ORDER BY netprice DESC,quantity DESC;  



-- Analyse the Netrevenue and Categorize into Several types 
WITH median_value AS (
     SELECT 
          
          ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY (quantity*netprice*exchangerate))::numeric ,2 ) AS median 
     FROM sales
     WHERE orderdate BETWEEN '2022-01-01'  AND '2023-12-31'
          
)
SELECT * FROM median_value 

  WHEN median_revenue AS(
    SELECT orderdate,
    ROUND(SUM(CASE WHEN (quantity*netprice*exchangerate)::numeric  < mv.median AND 
    WHERE orderdate BETWEEN '2022-01-01' AND '2022-12-31' 
    THEN  (quantity*netprice*exchangerate)::numeric )) AS low_new_revenue_2022 ;
  )
  FROM sales s
  LEFT JOIN product p ON s.productkey=p.productkey,
  median_value
  GROUP BY orderdate