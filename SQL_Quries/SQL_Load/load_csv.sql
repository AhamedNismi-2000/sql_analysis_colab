-- Load Date To the Table According the decending order 

COPY  currencyexchange
FROM  'D:\Mine\SQL\sql_analysis_colab\csv_files\currencyexchange.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY customer
FROM 'D:\Mine\SQL\sql_analysis_colab\csv_files\customer.csv'
WITH  (FORMAT csv ,HEADER TRUE , DELIMITER ',' , ENCODING 'UTF8');

COPY date
FROM 'D:\Mine\SQL\sql_analysis_colab\csv_files\date.csv'
WITH (FORMAT csv , HEADER TRUE , DELIMITER ',',ENCODING'UTF8');

COPY public.product
FROM 'D:/Mine/SQL/sql_analysis_colab/csv_files/product.csv'
WITH (FORMAT csv, HEADER true, DELIMITER',', ENCODING'UTF8', NULL '\N');

COPY public.store
FROM 'D:\Mine\SQL\sql_analysis_colab\csv_files\store.csv'
WITH (FORMAT csv, HEADER true, DELIMITER',', ENCODING'UTF8', NULL '\N');

COPY public.sales
FROM 'D:\Mine\SQL\sql_analysis_colab\csv_files\sales.csv'
WITH (FORMAT csv, HEADER true, DELIMITER',', ENCODING'UTF8');


-- Check Whether The All Columns and Rows  are Loaded in to the Table
/*
SELECT COUNT(*) FROM currencyexchange
SELECT COUNT(*) FROM customer;
SELECT COUNT(*) FROM date;
SELECT COUNT(*) FROM product;
SELECT COUNT(*) FROM sales;
SELECT COUNT(*) FROM store;
*/



-- If any error while creating the table run below query to delete the table completely then crete table using 
-- create_table.sql file 
/*
DROP TABLE IF EXISTS 
   public.currencyexchange,
   public.sales,
   public.product,
   public.store,
   public."date",
   public.customer
   CASCADE;
*/   