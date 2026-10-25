CREATE DATABASE retail_sales_db;
USE retail_sales_db;
SHOW DATABASES;
SELECT COUNT(*) AS total_records
FROM retail_sales_cleaned;
SELECT *
FROM retail_sales_cleaned
LIMIT 5;
SELECT 
    MIN(`Order Date`) AS first_order_date,
    MAX(`Order Date`) AS last_order_date
FROM retail_sales_cleaned;
SELECT 
    COUNT(*) AS total_records,
    SUM(`Sales` IS NULL) AS null_sales,
    SUM(`Profit` IS NULL) AS null_profit,
    SUM(`Quantity` IS NULL) AS null_quantity
FROM retail_sales_cleaned;

#What are the total Sales, Total Profit, and Total Quantity sold?
SELECT
    ROUND(SUM(`Sales`), 2) AS Total_Sales,
    ROUND(SUM(`Profit`), 2) AS Total_Profit,
    SUM(`Quantity`) AS Total_Quantity
FROM retail_sales_cleaned;

#Which product category generates the highest Sales and Profit?
SELECT
    Category,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM retail_sales_cleaned
GROUP BY Category
ORDER BY Total_Sales DESC;

#Which region generates the highest Sales and Profit?
SELECT
    Region,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM retail_sales_cleaned
GROUP BY Region
ORDER BY Total_Sales DESC;

SELECT
    `Year`,
    `Month`,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM retail_sales_cleaned
GROUP BY `Year`, `Month`
ORDER BY 
    `Year`,
    CASE `Month`
        WHEN 'Jan' THEN 1
        WHEN 'Feb' THEN 2
        WHEN 'Mar' THEN 3
        WHEN 'Apr' THEN 4
        WHEN 'May' THEN 5
        WHEN 'Jun' THEN 6
        WHEN 'Jul' THEN 7
        WHEN 'Aug' THEN 8
        WHEN 'Sep' THEN 9
        WHEN 'Oct' THEN 10
        WHEN 'Nov' THEN 11
        WHEN 'Dec' THEN 12
    END;
    
#Which 5 products generate the highest sales?
SELECT
    `Product Name`,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM retail_sales_cleaned
GROUP BY `Product Name`
ORDER BY Total_Sales DESC
LIMIT 5;

#Which customers contribute the most to Sales?
SELECT
    `Customer Name`,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM retail_sales_cleaned
GROUP BY `Customer Name`
ORDER BY Total_Sales DESC
LIMIT 5;

#Which sub-categories are performing best in terms of Sales and Profit?
SELECT
    `Sub-Category`,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM retail_sales_cleaned
GROUP BY `Sub-Category`
ORDER BY Total_Sales DESC;

SELECT
    CASE
        WHEN Sales >= 1000 THEN 'High'
        WHEN Sales >= 500 THEN 'Medium'
        ELSE 'Low'
    END AS Sales_Category,
    COUNT(*) AS Number_of_Orders,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM retail_sales_cleaned
GROUP BY
    CASE
        WHEN Sales >= 1000 THEN 'High'
        WHEN Sales >= 500 THEN 'Medium'
        ELSE 'Low'
    END
ORDER BY Total_Sales DESC;

#Which categories have total Sales greater than 5,000?
SELECT
    Category,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM retail_sales_cleaned
GROUP BY Category
HAVING SUM(Sales) > 5000
ORDER BY Total_Sales DESC;

USE retail_sales_db;

#Finds the top 10 products and assigns a rank based on total Sales.
SELECT
    `Product Name`,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    RANK() OVER (ORDER BY SUM(Sales) DESC) AS Sales_Rank
FROM retail_sales_cleaned
GROUP BY `Product Name`
ORDER BY Sales_Rank
LIMIT 10;

#Calculate Profit Margin by Category.
SELECT
    Category,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND(
        SUM(Profit) / NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS Profit_Margin_Percent
FROM retail_sales_cleaned
GROUP BY Category
ORDER BY Profit_Margin_Percent DESC;

#Find Categories with Average Sales Above 100
SELECT
    Category,
    ROUND(AVG(Sales), 2) AS Average_Sales
FROM retail_sales_cleaned
GROUP BY Category
HAVING AVG(Sales) > 100
ORDER BY Average_Sales DESC;

#Count Orders by Region
SELECT
    Region,
    COUNT(*) AS Number_of_Records,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM retail_sales_cleaned
GROUP BY Region
ORDER BY Number_of_Records DESC;

#Monthly Sales Ranking
SELECT
    `Month`,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    DENSE_RANK() OVER (
        ORDER BY SUM(Sales) DESC
    ) AS Month_Rank
FROM retail_sales_cleaned
GROUP BY `Month`
ORDER BY Month_Rank;

SELECT
    COUNT(*) AS Total_Rows,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    SUM(Profit < 0) AS Negative_Profit_Rows,
    SUM(Sales < 0) AS Negative_Sales_Rows
FROM retail_sales_cleaned;

#Find the Most Profitable Sub-Categories
SELECT
    `Sub-Category`,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM retail_sales_cleaned
GROUP BY `Sub-Category`
ORDER BY Total_Profit DESC
LIMIT 5;

#Find Products with Sales Above the Average
SELECT
    `Product Name`,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM retail_sales_cleaned
GROUP BY `Product Name`
HAVING SUM(Sales) > (
    SELECT AVG(Sales)
    FROM retail_sales_cleaned
)
ORDER BY Total_Sales DESC;

#Compare Sales Categories
SELECT
    `Sales Category`,
    COUNT(*) AS Total_Records,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM retail_sales_cleaned
GROUP BY `Sales Category`
ORDER BY Total_Sales DESC;

#Use a CTE to Find Top 5 Customers
WITH CustomerSales AS (
    SELECT
        `Customer Name`,
        SUM(Sales) AS Total_Sales
    FROM retail_sales_cleaned
    GROUP BY `Customer Name`
)
SELECT
    `Customer Name`,
    ROUND(Total_Sales, 2) AS Total_Sales
FROM CustomerSales
ORDER BY Total_Sales DESC
LIMIT 5;

#Compare Sales and Profit by Year
SELECT
    `Year`,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    COUNT(*) AS Total_Records
FROM retail_sales_cleaned
GROUP BY `Year`
ORDER BY `Year`;

