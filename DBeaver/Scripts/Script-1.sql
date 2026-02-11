SELECT
cohort_year ,
ROUND(SUM(total_net_revenue)::numeric,2) AS total_revenue,
COUNT(DISTINCT customerkey) AS total_customers,
ROUND(SUM(total_net_revenue)::numeric / COUNT (DISTINCT customerkey),2) AS customer_revenue
FROM cohort_summary
WHERE orderdate = first_order_date
GROUP BY
cohort_year