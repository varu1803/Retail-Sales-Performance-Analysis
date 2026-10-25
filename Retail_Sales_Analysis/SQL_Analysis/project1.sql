USE retail_sales_db;

SELECT
    COUNT(*) AS Total_Records,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    SUM(Quantity) AS Total_Quantity
FROM retail_sales_final;

SELECT *
FROM retail_sales_final
LIMIT 5;

DESCRIBE retail_sales_final;

SELECT Sales, Profit, Quantity
FROM retail_sales_final
LIMIT 10;

USE retail_sales_db;

SELECT COUNT(*) AS Total_Rows
FROM retail_sales_final;

SHOW TABLES;

use retail_sales_cleaned_final;

SELECT COUNT(*) AS Total_Rows
FROM retail_sales_cleaned_final; 

USE retail_sales_db;

SELECT
    COUNT(*) AS Total_Records,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    SUM(Quantity) AS Total_Quantity
FROM retail_sales_cleaned_final;

