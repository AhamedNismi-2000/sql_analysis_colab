
COPY  currencyexchange
FROM  'D:\Mine\SQL\sql_analysis_colab\csv_files\currencyexchange.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY customer
FROM 'D:\Mine\SQL\sql_analysis_colab\csv_files\customer.csv'
WITH  (FORMAT csv ,HEADER TRUE , DELIMITER ',' , ENCODING 'UTF8');



