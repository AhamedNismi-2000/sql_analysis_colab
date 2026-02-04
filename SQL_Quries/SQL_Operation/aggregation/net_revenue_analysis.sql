-- Find the Minimum  net revenue 2022- 2024

SELECT
     p.categoryname,
     ROUND(MIN(CASE WHEN s.orderdate BETWEEN '2022-01-01' AND '2023-12-31' THEN (s.quantity * s.netprice * s.exchangerate)::numeric END),2) AS min_net_revenue_2022,  
     ROUND(MIN(CASE WHEN s.orderdate BETWEEN '2023-01-01' AND '2024-12-31' THEN (s.quantity * s.netprice * s.exchangerate)::numeric END),2) AS min_net_revenue_2023,  
     ROUND(MIN(CASE WHEN s.orderdate BETWEEN '2024-01-01' AND '2025-12-31' THEN (s.quantity * s.netprice * s.exchangerate)::numeric END),2) AS min_net_revenue_2024
FROM sales s
LEFT JOIN product p ON p.productkey = s.productkey   
GROUP BY 
     p.categoryname ;        


-- Find the Maximum  net revenue 2022- 2024

SELECT
     p.categoryname,
     ROUND(MAX(CASE WHEN s.orderdate BETWEEN '2022-01-01' AND '2023-12-31' THEN (s.quantity * s.netprice * s.exchangerate)::numeric END),2) AS min_net_revenue_2022,  
     ROUND(MAX(CASE WHEN s.orderdate BETWEEN '2023-01-01' AND '2024-12-31' THEN (s.quantity * s.netprice * s.exchangerate)::numeric END),2) AS min_net_revenue_2023,  
     ROUND(MAX(CASE WHEN s.orderdate BETWEEN '2024-01-01' AND '2025-12-31' THEN (s.quantity * s.netprice * s.exchangerate)::numeric END),2) AS min_net_revenue_2024
FROM sales s
LEFT JOIN product p ON p.productkey = s.productkey   
GROUP BY 
     p.categoryname ;        


-- Find the Average  net revenue 2022- 2024

SELECT
     p.categoryname,
     ROUND(AVG(CASE WHEN s.orderdate BETWEEN '2022-01-01' AND '2023-12-31' THEN (s.quantity * s.netprice * s.exchangerate)::numeric END),2) AS min_net_revenue_2022,  
     ROUND(AVG(CASE WHEN s.orderdate BETWEEN '2023-01-01' AND '2024-12-31' THEN (s.quantity * s.netprice * s.exchangerate)::numeric END),2) AS min_net_revenue_2023,  
     ROUND(AVG(CASE WHEN s.orderdate BETWEEN '2024-01-01' AND '2025-12-31' THEN (s.quantity * s.netprice * s.exchangerate)::numeric END),2) AS min_net_revenue_2024
FROM sales s
LEFT JOIN product p ON p.productkey = s.productkey   
GROUP BY 
     p.categoryname ;        


-- Find All Revenue 2022 - 2024

SELECT
     p.categoryname,
     ROUND(AVG(CASE WHEN s.orderdate BETWEEN '2022-01-01' AND '2023-12-31' THEN (s.quantity * s.netprice * s.exchangerate)::numeric END),2) AS min_net_revenue_2022,  
     ROUND(AVG(CASE WHEN s.orderdate BETWEEN '2023-01-01' AND '2024-12-31' THEN (s.quantity * s.netprice * s.exchangerate)::numeric END),2) AS min_net_revenue_2023,  
     ROUND(AVG(CASE WHEN s.orderdate BETWEEN '2024-01-01' AND '2025-12-31' THEN (s.quantity * s.netprice * s.exchangerate)::numeric END),2) AS min_net_revenue_2024,
     ROUND(MAX(CASE WHEN s.orderdate BETWEEN '2022-01-01' AND '2023-12-31' THEN (s.quantity * s.netprice * s.exchangerate)::numeric END),2) AS min_net_revenue_2022,  
     ROUND(MAX(CASE WHEN s.orderdate BETWEEN '2023-01-01' AND '2024-12-31' THEN (s.quantity * s.netprice * s.exchangerate)::numeric END),2) AS min_net_revenue_2023,  
     ROUND(MAX(CASE WHEN s.orderdate BETWEEN '2024-01-01' AND '2025-12-31' THEN (s.quantity * s.netprice * s.exchangerate)::numeric END),2) AS min_net_revenue_2024,
     ROUND(MIN(CASE WHEN s.orderdate BETWEEN '2022-01-01' AND '2023-12-31' THEN (s.quantity * s.netprice * s.exchangerate)::numeric END),2) AS min_net_revenue_2022,  
     ROUND(MIN(CASE WHEN s.orderdate BETWEEN '2023-01-01' AND '2024-12-31' THEN (s.quantity * s.netprice * s.exchangerate)::numeric END),2) AS min_net_revenue_2023,  
     ROUND(MIN(CASE WHEN s.orderdate BETWEEN '2024-01-01' AND '2025-12-31' THEN (s.quantity * s.netprice * s.exchangerate)::numeric END),2) AS min_net_revenue_2024
FROM sales s
LEFT JOIN product p ON p.productkey = s.productkey   
GROUP BY 
     p.categoryname ;        

