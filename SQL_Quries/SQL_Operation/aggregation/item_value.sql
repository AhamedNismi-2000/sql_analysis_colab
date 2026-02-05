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

