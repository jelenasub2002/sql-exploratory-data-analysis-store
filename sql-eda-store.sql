
-- Exploring All Objects in the Database
SELECT * FROM INFORMATION_SCHEMA.TABLES

-- Explore All Columns in the Database
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'gold.dim_customers'

----------------------------------------------------------------------------------------
-- DIMENSIONS EXPLORATION

SELECT DISTINCT country FROM dbo.[gold.dim_customers]

SELECT DISTINCT category FROM dbo.[gold.dim_products]
SELECT DISTINCT category, subcategory FROM dbo.[gold.dim_products]
SELECT DISTINCT category, subcategory, product_name FROM dbo.[gold.dim_products]
ORDER BY 1,2,3

----------------------------------------------------------------------------------------
-- DATE EXPLORATION

SELECT 
MIN(order_date) AS first_order_date, 
MAX(order_date) AS last_order_date,
DATEDIFF(year, MIN(order_date), MAX(order_date)) AS order_range_in_years,
DATEDIFF(month, MIN(order_date), MAX(order_date)) AS order_range_in_months
FROM dbo.[gold.fact_sales]

-- Finding the youngest and oldest customer
SELECT 
MIN(birthdate) AS oldest_birthdate,
DATEDIFF(year, MIN(birthdate), GETDATE()) AS oldest_age,
MAX(birthdate) AS youngest_birthdate,
DATEDIFF(year, MAX(birthdate), GETDATE()) AS youngest_age
FROM dbo.[gold.dim_customers]

------------------------------------------------------------------------------------------------------
-- MEASURES EXPOLORATION

-- Sales
SELECT SUM(sales_amount) AS total_sales FROM dbo.[gold.fact_sales]

-- How many items are sold
SELECT SUM(quantity) AS total_quantity FROM dbo.[gold.fact_sales]

-- Average selling price
SELECT AVG(price) AS avg_price FROM dbo.[gold.fact_sales]

-- Total number of orders
SELECT COUNT(order_number) AS total_orders FROM dbo.[gold.fact_sales]
-- I don't want to count same orders twice
SELECT COUNT(DISTINCT order_number) AS total_orders FROM dbo.[gold.fact_sales]

-- Total number of products
SELECT COUNT(DISTINCT product_key) AS total_products FROM dbo.[gold.dim_products]

-- Total number of customers
SELECT COUNT(customer_key) AS total_customers FROM dbo.[gold.dim_customers]

-- total number of customers that had placed an order
SELECT COUNT(DISTINCT customer_key) AS total_customers FROM dbo.[gold.fact_sales]



-- REPORT that shows all key metrics
SELECT 'Total Sales' as measure_name, SUM(sales_amount) AS measure_value FROM dbo.[gold.fact_sales]
UNION ALL
SELECT 'Total Quantity', SUM(quantity) FROM dbo.[gold.fact_sales]
UNION ALL
SELECT 'Average Price', AVG(price) FROM dbo.[gold.fact_sales]
UNION ALL
SELECT 'Total Nr. Orders', COUNT(DISTINCT order_number) FROM dbo.[gold.fact_sales]
UNION ALL
SELECT 'Total Nr. Products', COUNT(product_name) FROM dbo.[gold.dim_products]
UNION ALL
SELECT 'Total Nr. Customers', COUNT(customer_key) FROM dbo.[gold.dim_customers]

----------------------------------------------------------------------------------------------------
-- MAGNITUDE ANALYSIS
