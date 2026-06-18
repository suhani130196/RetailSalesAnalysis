--Create Table 
CREATE TABLE retail_sales (
	transactions_id INT,
	sale_date DATE,
	sale_time TIME, 
	customer_id INT,
	gender VARCHAR(15),
	age INT,
	category VARCHAR (35),
	quantiy	INT,
	price_per_unit FLOAT,
	cogs FLOAT,
	total_sale FLOAT
);

-- Import Retail_Sales_Data.csv into the table

--Data cleaning

SELECT * FROM retail_sales 
WHERE
	transactions_id	IS NULL OR sale_date IS NULL
	OR sale_time IS NULL OR customer_id	IS NULL OR gender IS NULL
	OR category IS NULL	OR quantiy IS NULL OR price_per_unit IS NULL OR cogs IS NULL 
	OR total_sale IS NULL; 

DELETE FROM retail_sales
WHERE
	transactions_id	IS NULL OR sale_date IS NULL OR sale_time IS NULL
	OR customer_id	IS NULL OR gender IS NULL OR category IS NULL
	OR quantiy IS NULL OR price_per_unit IS NULL
	OR cogs IS NULL OR total_sale IS NULL;