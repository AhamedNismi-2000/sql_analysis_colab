/*  
• Syntax:
SELECT
window_function() OVER (
PARTITION BY artition expression
) AS window_column_alias
FROM table name;

OVER( ) : Defines the window for the function. It can include PARTITION BY and other functions.
PARTITION BY : Divides the result set into partitions. The function is then applied to each partition.

*/

WITH netrevenue_day AS(
    SELECT 
         orderdate,
         orderkey *10 + linenumber AS order_line_item,
         ROUND((quantity*netprice*exchangerate)::numeric ,2) AS netrevenue,
         SUM(ROUND((quantity*netprice*exchangerate)::numeric ,2)) OVER(PARTITION BY orderdate ) AS daily_net_revenue
         FROM sales 
)
SELECT *, ROUND((nd.netrevenue*100 /nd.daily_net_revenue)::numeric ,2) AS percentage_daily_revenue
FROM netrevenue_day AS nd

LIMIT 30;


-- A cohort year is the year when a group of people (or customers/users) 
--first started something  usually when they first signed up, purchased, or joined.

    WITH yearly_chohort AS (
        SELECT DISTINCT
        customerkey,
        EXTRACT(YEAR FROM MIN(orderdate) OVER(PARTITION BY customerkey))AS chohort_year
        FROM sales
    )
    SELECT 
    yc.customerkey,
    yc.chohort_year,
    EXTRACT(YEAR FROM orderdate) AS order_year,
    SUM(ROUND((quantity*netprice*exchangerate)::numeric,2)) AS net_revenue
    FROM sales s LEFT JOIN yearly_chohort yc
    ON yc.customerkey = s.customerkey
    GROUP BY    yc.customerkey,yc.chohort_year,EXTRACT(YEAR FROM orderdate)



-- Using  For Chohort Year 

WITH yearly_chohort AS (
    SELECT DISTINCT
        customerkey,
        EXTRACT(YEAR FROM MIN(orderdate) OVER (PARTITION BY customerkey)) AS chohort_year,
        EXTRACT(YEAR FROM orderdate) AS order_year
        FROM sales 
)
SELECT DISTINCT
     chohort_year,
     order_year,
     COUNT(customerkey) OVER (PARTITION BY chohort_year , order_year) AS num_customers
     FROM yearly_chohort 
    ORDER BY chohort_year,order_year


    /*  
    Window Functions run AFTER GROUP BY
When using window functions in SQL, it's not recommended to combine them directly with
GROUP BY . This is because:
• Conflicting Aggregations: GROUP BY collapses rows into groups, but window functions
operate on individual rows while maintaining access to the full dataset. This can lead to
unexpected results or errors.
• Better Alternatives: Use Common Table Expressions (CTEs) or subqueries to first
apply the window function, then perform GROUP BY in a separate step for clarity and
correctness.
    */

-- In Here if Need to Perform Group By Firstly Do CTE Then Make Group it Using Outer Query
 WITH customer_order AS (
        SELECT 
            customerkey,
            ROUND((quantity*netprice*exchangerate)::numeric,2) AS order_value,
            COUNT(*) OVER (PARTITION BY customerkey) AS total_orders
         FROM sales
 )   

 SELECT 
      customerkey,
      ROUND(AVG(order_value),2) AS net_revenue,
      total_orders   
  FROM customer_order 
  GROUP BY customerkey,total_orders


-- Without CTE You Can See the Conflict Between Window Function And Group BY 

        SELECT 
            customerkey,
            ROUND(AVG((quantity*netprice*exchangerate)::numeric),2) AS total_revenue,
            COUNT(*) OVER (PARTITION BY customerkey) AS total_orders
         FROM sales
         GROUP BY customerkey

-- Customer LTV 

    WITH yearly_cohort AS (
    SELECT
         customerkey,
    EXTRACT(YEAR FROM MIN(orderdate)) AS cohort_year,
         ROUND(SUM(quantity * netprice * exchangerate)::numeric ,2) AS customer_ltv
    FROM
          sales
    GROUP BY
          customerkey

    )

    SELECT *,
     ROUND(AVG(customer_ltv) OVER (PARTITION BY cohort_year), 2) AS avg_ltv_per_cohort

    FROM
          yearly_cohort

-- When Filter Out the Window Function using WHERE clause it filter before the window function 
 

SELECT 
     customerkey,
     EXTRACT(YEAR FROM MIN(orderdate) OVER (PARTITION BY customerkey)) AS chohort_year
FROM sales 
WHERE orderdate >= '2020-01-01'

-- if you want to filter after window function use CTE or subquery

WITH chohort AS ( 
SELECT 
     customerkey,
     EXTRACT(YEAR FROM MIN(orderdate) OVER (PARTITION BY customerkey)) AS chohort_year
FROM sales 
)
SELECT 
 * FROM chohort 
WHERE chohort_year >= '2020'

