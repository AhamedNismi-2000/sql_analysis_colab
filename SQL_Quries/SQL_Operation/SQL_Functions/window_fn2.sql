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

-- First Values , Last Value , NTH Value 

    WITH monthly_revenue AS ( 
    SELECT   
        TO_CHAR(orderdate ,'YYYY-MM') AS month ,
        ROUND(SUM(quantity*exchangerate*netprice)::numeric ,2) AS total_revenue
        FROM sales
        WHERE EXTRACT(YEAR FROM orderdate) = 2023
        GROUP BY  TO_CHAR(orderdate ,'YYYY-MM')
        ORDER BY  TO_CHAR(orderdate ,'YYYY-MM')
    )
    SELECT *,
    FIRST_VALUE(total_revenue) OVER(ORDER BY month) AS first_month_revenue,
    LAST_VALUE(total_revenue)  OVER (ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_month_revenue,
    NTH_VALUE(total_revenue,3)  OVER (ORDER BY month ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS third_month_revenue
    FROM monthly_revenue


-- LAG()  , LEAD()

    WITH monthly_revenue AS ( 
    SELECT   
        TO_CHAR(orderdate ,'YYYY-MM') AS month ,
        ROUND(SUM(quantity*exchangerate*netprice)::numeric ,2) AS total_revenue
        FROM sales
        WHERE EXTRACT(YEAR FROM orderdate) = 2023
        GROUP BY  TO_CHAR(orderdate ,'YYYY-MM')
        ORDER BY  TO_CHAR(orderdate ,'YYYY-MM')
    )

     SELECT * ,
     LAG(total_revenue) OVER (ORDER BY month) AS previous_month_revenue,
     ROUND((total_revenue -  LAG(total_revenue) OVER (ORDER BY month))*100 / LAG(total_revenue) OVER (ORDER BY month),2) AS month_growth
     FROM monthly_revenue 


-- Frame  Window Function  For  ROWS 


    WITH monthly_revenue AS ( 
    SELECT   
        TO_CHAR(orderdate ,'YYYY-MM') AS month ,
        ROUND(SUM(quantity*exchangerate*netprice)::numeric ,2) AS total_revenue
        FROM sales
        WHERE EXTRACT(YEAR FROM orderdate) = 2023
        GROUP BY  TO_CHAR(orderdate ,'YYYY-MM')
        ORDER BY  TO_CHAR(orderdate ,'YYYY-MM')
    )

    SELECT 
          month,
          total_revenue,
          ROUND(AVG(total_revenue) OVER( ORDER BY month ROWS BETWEEN CURRENT ROW AND CURRENT ROW),2) AS net_revenue_current
    FROM monthly_revenue 
    GROUP BY month,total_revenue