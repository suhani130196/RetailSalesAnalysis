--Data exploration

-- 1. Determine the total number of records in the dataset.
SELECT COUNT (*) as total_sales from retail_sales;
-- 2. Find out how many unique customers are in the dataset.
SELECT COUNT (DISTINCT customer_id) as total_sales from retail_sales;
-- 3. Identify all unique product categories in the dataset.
SELECT DISTINCT category from retail_sales;