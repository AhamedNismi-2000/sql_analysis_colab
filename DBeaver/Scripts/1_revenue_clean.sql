WITH sales_data AS (
   SELECT 
        customerkey,
        ROUND(SUM(quantity*exchangerate*netprice)::numeric,2)  AS netrevenue 
        FROM sales
        GROUP BY customerkey 
)
SELECT 
    ROUND(AVG(sd.netrevenue::numeric),2) AS avg_netrevenue_customer,
    ROUND(AVG(COALESCE(sd.netrevenue::numeric)),2) AS avg_netrevenue_all_customer
    FROM customer c 
    LEFT JOIN sales_data sd ON
    c.customerkey = sd.customerkey



