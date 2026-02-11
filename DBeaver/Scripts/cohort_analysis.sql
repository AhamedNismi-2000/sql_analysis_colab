CREATE VIEW cohort_summary AS
WITH customer_revenue AS (
    SELECT
        s.customerkey,
        s.orderdate,
        ROUND(SUM(quantity * exchangerate * netprice)::numeric, 2) AS total_net_revenue,
        COUNT(s.orderkey) AS num_orders,
        c.countryfull,
        c.age,
        c.givenname,
        c.surname
    FROM sales s
    LEFT JOIN customer c  
        ON c.customerkey = s.customerkey
    GROUP BY 
        s.customerkey,
        s.orderdate,
        c.countryfull,
        c.age,
        c.givenname,
        c.surname
)

SELECT 
     customerkey, 
     orderdate,
     
     num_orders,
     total_net_revenue,
     CONCAT(TRIM(givenname),' ',TRIM(surname)) AS combined_name,
     age,
     countryfull,
     MIN(cr.orderdate) OVER (PARTITION BY cr.customerkey) AS first_order_date,
    EXTRACT(YEAR FROM MIN(orderdate) OVER (PARTITION BY customerkey)) AS cohort_year
FROM customer_revenue cr;




SELECT * FROM cohort_summary

-DROP VIEW cohort_summary 