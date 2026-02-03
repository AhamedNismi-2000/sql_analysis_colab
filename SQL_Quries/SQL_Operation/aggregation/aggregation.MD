# 📊 Sales Analysis Queries

This repository contains SQL queries to analyze **customer counts, revenue, and product category performance** from the sales database. These queries focus on both overall and year-specific metrics, including pivot tables for continent-based customer distribution.

---

## 1️⃣ Total Customer Count by Order Date

```sql
SELECT
    orderdate,
    COUNT(customerkey) AS total_customer
FROM
    sales
GROUP BY
    orderdate
ORDER BY
    orderdate;
```

**Explanation:**

* Counts the **total number of orders** placed each day, including duplicate customers.
* Useful to see the daily order volume.

---

## 2️⃣ Unique Customer Count by Order Date

```sql
SELECT
    orderdate,
    COUNT(DISTINCT customerkey) AS total_customer
FROM
    sales
GROUP BY
    orderdate
ORDER BY
    orderdate;
```

**Explanation:**

* Counts **distinct customers** per day.
* Avoids counting the same customer multiple times on a single day.

---

## 3️⃣ Unique Customers in 2023

```sql
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
```

**Explanation:**

* Filters orders for **2023 only** and counts unique customers per day.

---

## 4️⃣ Unique Customers by Continent

```sql
SELECT DISTINCT
    continent,
    COUNT(DISTINCT customerkey) AS total_customer
FROM
    customer
GROUP BY
    continent
ORDER BY
    total_customer DESC;
```

**Explanation:**

* Shows the **number of unique customers** per continent.
* Sorted by descending order of customers.

---

## 5️⃣ Pivot Customers by Continent (2023)

```sql
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
```

**Explanation:**

* Creates a **pivot table** showing daily unique customers by continent.
* Helps analyze customer trends across regions.

**Visualization:**
![date vs continents](../../../images/customer_continent.png)
*The above image shows net revenue comparison per category between 2022 and 2023.*
---

## 6️⃣ Total Net Revenue by Day (2023)

```sql
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
```

**Explanation:**

* Calculates daily **net revenue** in 2023.
* `ROUND` used to display revenue up to 2 decimal places.

---

## 7️⃣ Total Net Revenue by Product Category (2023)

```sql
SELECT
     p.categoryname AS category_name,
     ROUND(SUM(s.quantity * s.netprice * s.exchangerate)::numeric,2) AS net_revenue
FROM
    sales s
LEFT JOIN  product p ON  s.productkey = p.productkey
WHERE s.orderdate BETWEEN  '2023-01-01' AND '2023-12-31'
GROUP BY
    p.categoryname
ORDER BY
    p.categoryname;
```

**Explanation:**

* Aggregates **net revenue by product category** in 2023.
* Useful to identify top-performing product categories.

---

## 8️⃣ Total Net Revenue by Category and Year (2022 vs 2023)

```sql
SELECT
    p.categoryname,
    ROUND(SUM(CASE WHEN s.orderdate BETWEEN '2022-01-01' AND '2022-12-31' THEN  (s.quantity * s.netprice * s.exchangerate)::numeric END ),2) AS total_net_revenue_2022,
    ROUND(SUM(CASE WHEN s.orderdate BETWEEN '2023-01-01' AND '2023-12-31' THEN (s.quantity * s.netprice * s.exchangerate)::numeric END),2) AS total_net_revenue_2023
FROM sales s
LEFT JOIN product p ON s.productkey = p.productkey
GROUP BY
    p.categoryname
ORDER BY
    p.categoryname;
```

**Explanation:**

* Compares **net revenue per product category** between 2022 and 2023.
* Useful for **year-over-year revenue analysis**.

**Visualization:**
![Category vs sales 2022 and 2023 ](../../../images/category_year.png)
*The above image shows net revenue comparison per category between 2022 and 2023.*

---

### 📌 Notes for Users

* Replace table names (`sales`, `customer`, `product`) if your database uses different names.
* Ensure `exchangerate` is correctly applied to convert to your desired currency.
* Pivot queries can be adjusted to include additional continents or regions.
* Images under each query can help users quickly interpret results.
