-- 1).  Count The Total Customer
SELECT
    orderdate,
    COUNT(customerkey) AS total_customer
FROM
    sales
GROUP BY
    orderdate
ORDER BY
    orderdate;

-- 2). Coount The Unique Customer
SELECT
    orderdate,
    COUNT(DISTINCT customerkey) AS total_customer
FROM
    sales
GROUP BY
    orderdate
ORDER BY
    orderdate;

-- 3). Calculate only for orders in 2023.
SELECT
    orderdate,
    COUNT(DISTINCT customerkey) AS total_customer
FROM
    sales
WHERE
    orderdate BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY
    orderdate
ORDER BY
    orderdate;

-- 4).  Count Unique Continent 
SELECT DISTINCT
    continent,
    COUNT(DISTINCT customerkey) AS total_customer
FROM
    customer
GROUP BY
    continent
ORDER BY
    total_customer DESC;

-- 5). Pivot the data by the unique number of customers who ordered between 2023-01-01 and 2023-12-31 by the continent.
SELECT
    s.orderdate,
    COUNT(DISTINCT CASE WHEN c.continent = 'Europe' THEN s.customerkey END) AS eu_customers,
    COUNT(DISTINCT CASE WHEN c.continent = 'North America' THEN s.customerkey END) AS na_customers,
    COUNT(DISTINCT CASE WHEN c.continent = 'Australia' THEN s.customerkey END) AS au_customers
FROM
    sales s
    LEFT JOIN customer c ON s.customerkey = c.customerkey
WHERE
    s.orderdate BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY
    s.orderdate
ORDER BY
    s.orderdate;

-- 6).  Total Net Revenue by Day in 2023

SELECT
    orderdate,
    ROUND(SUM(quantity * netprice * exchangerate)::numeric, 2) AS net_revenue
FROM
   sales
WHERE
    orderdate BETWEEN  '2023-01-01' AND '2023-12-31'
GROUP BY
    orderdate
ORDER BY
     orderdate;
