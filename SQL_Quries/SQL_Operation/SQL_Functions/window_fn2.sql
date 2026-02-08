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
