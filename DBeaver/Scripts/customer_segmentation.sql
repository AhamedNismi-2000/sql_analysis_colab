WITH customer_ltv AS (
   SELECT
        customerkey,
        combined_name,
        ROUND(SUM(total_net_revenue)::numeric,2) AS total_ltv
      FROM cohort_summary
      GROUP BY 
        customerkey,
        combined_name

), customer_segmentation AS (
     SELECT 
     PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total_ltv) AS ltv_25th_percentile,
     PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total_ltv) AS ltv_75th_percentile
    FROM customer_ltv
)    

SELECT cltv.*,
        CASE 
        WHEN cltv.total_ltv < cs.ltv_25th_percentile THEN '3-Low Value'
        WHEN cltv.total_ltv <= cs.ltv_75th_percentile THEN '2-Medium Value'
        ELSE '1-High Value'
        END AS customer_segment 
        FROM customer_ltv cltv 
        CROSS JOIN customer_segmentation cs;