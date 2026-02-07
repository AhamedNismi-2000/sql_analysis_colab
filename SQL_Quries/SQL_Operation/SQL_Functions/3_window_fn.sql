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
    yc.chohort_year,
    EXTRACT(YEAR FROM orderdate),
    SUM(ROUND((quantity*netprice*exchangerate)::numeric,2)) AS net_revenue
    FROM sales s LEFT JOIN yearly_chohort yc
    ON yc.customerkey = s.customerkey
    GROUP BY   yc.chohort_year,EXTRACT(YEAR FROM orderdate)