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
               ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY (quantity*netprice*exchangerate))::numeric,2 ) AS median 
          FROM sales
          WHERE orderdate BETWEEN '2022-01-01'  AND '2023-12-31'
               
     )

     SELECT 
          p.categoryname, 
          SUM(CASE WHEN ROUND((quantity*netprice*exchangerate)::numeric ,2) < mv.median AND 
          orderdate BETWEEN '2022-01-01' AND '2022-12-31' THEN ROUND((quantity*netprice*exchangerate)::numeric ,2) END ) AS low_revenue_2022,

          SUM(CASE WHEN ROUND((quantity*netprice*exchangerate)::numeric ,2 ) >= mv.median 
          AND orderdate BETWEEN '2022-01-01' AND '2022-12-31' THEN ROUND((quantity*netprice*exchangerate)::numeric ,2) END ) AS high_revenue2022,
          
          SUM(CASE WHEN ROUND((quantity*netprice*exchangerate)::numeric ,2 ) < mv.median 
          AND orderdate BETWEEN '2023-01-01' AND '2023-12-31' THEN ROUND((quantity*netprice*exchangerate)::numeric ,2) END ) AS low_revenue2023,

          SUM(CASE WHEN ROUND((quantity*netprice*exchangerate)::numeric ,2 ) >= mv.median 
          AND orderdate BETWEEN '2023-01-01' AND '2023-12-31' THEN ROUND((quantity*netprice*exchangerate)::numeric ,2) END ) AS high_revenue2023

          FROM sales s
          LEFT JOIN product p ON p.productkey = s.productkey,
          median_value AS mv
          GROUP BY  p.categoryname;


          --    Query For Checking Purpose










          
    


-- Categorize the sales items into High, medium, Low 
     WITH percentile AS ( 
     SELECT 
         
          PERCENTILE_CONT(.25) WITHIN GROUP (ORDER BY ROUND((quantity*exchangerate*netprice)::numeric,2)) AS percentile_25_revenue,
          PERCENTILE_CONT(.75) WITHIN GROUP (ORDER BY ROUND((quantity*exchangerate*netprice)::numeric,2)) AS percentile_75_revenue
          FROM sales s
          WHERE orderdate BETWEEN '2022-01-01' AND '2023-12-31'
     )     

     SELECT 
     p.categoryname,
     CASE 
     WHEN ROUND((quantity*netprice*exchangerate)::numeric,2) <= prtl.percentile_25_revenue  THEN '3-Low'
     WHEN ROUND((quantity*netprice*exchangerate)::numeric,2) >= prtl.percentile_75_revenue  THEN  '1-High'
     ELSE '2-Medium' END AS revenue_tier,
     SUM(ROUND((s.quantity*s.exchangerate*s.netprice)::numeric ,2)) AS total_revenue 

     FROM sales s LEFT JOIN product p ON 
     p.productkey = s.productkey,
     percentile prtl
     GROUP BY p.categoryname,revenue_tier;