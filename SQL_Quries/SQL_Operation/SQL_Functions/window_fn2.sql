-- Window Function Using Order By 
SELECT 
    customerkey,
    orderdate,

    ROUND((quantity*netprice*exchangerate)::numeric ,2) AS net_revenue,

    COUNT(*) OVER (
        PARTITION BY customerkey 
        ORDER BY orderdate
    ) AS running_order_count,

    ROUND(AVG((quantity*netprice*exchangerate)::numeric) OVER(PARTITION BY customerkey ORDER BY orderdate),2) AS running_average_revenue

FROM sales;


-- Rank Functions 
WITH row_numbering AS( 
SELECT
  ROW_NUMBER() OVER (PARTITION BY orderdate ORDER BY orderdate,orderkey,linenumber) AS row_num ,
  * FROM sales
)
SELECT *
FROM row_numbering
WHERE orderdate> '2015-01-01'
LIMIT 10;


-- Rank Function Analysis 
SELECT
     customerkey,
     COUNT(*) AS total_orders,
     ROW_NUMBER() OVER(ORDER BY COUNT(*) DESC) AS total_order_row,
     RANK() OVER(ORDER BY COUNT(*) DESC) AS total_rank_order,
     DENSE_RANK() OVER(ORDER BY COUNT(*) DESC) AS total_dense_rank
     FROM sales
     GROUP BY customerkey