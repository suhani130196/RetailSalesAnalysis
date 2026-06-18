## Project Overview:

**Project Title**: Retail Sales Analysis.

This project analyzes a retail sales dataset using SQL to uncover customer purchasing patterns, product performance, and sales trends. The analysis focuses on identifying high-performing product categories, understanding customer demographics, and evaluating transaction patterns across different time periods.

## Objectives:

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure:

### Database Setup\*\*:

1. Database Creation: The project starts by creating a database named retail_sales_db.
2. Table Creation: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
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
```

## Analysis & Exploration

### Data Exploration & Cleaning:

1. **Null Value Check**: Check for any null values in the dataset and delete records with missing data.
2. **Record Count**: Determine the total number of records in the dataset.
3. **Customer Count**: Find out how many unique customers are in the dataset.
4. **Category Count**: Identify all unique product categories in the dataset.

### **Data Analysis & Findings:**

#### 1. Identify total number of sales on 2022-11-05.

```sql
SELECT
COUNT(\*) AS total_sales from retail_sales
where sale_date='2022-11-05';
```

#### 2. Identify transactions in clothing category, quantity soled is more than 4 in month of november.

```sql
SELECT \*
FROM retail_sales
WHERE category = 'Clothing'
AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
AND quantiy >= 4;
```

#### 3. Identify total sales for each category

```sql
SELECT
category,
SUM(total_sale) as net_sales,
COUNT(\*) as total_order
FROM retail_sales
GROUP BY category
ORDER BY total_order DESC;
```

#### 4. Identify average age of customer who purchased item from beauty category

```sql
SELECT ROUND (AVG(age), 1)
as average_age
FROM retail_sales
WHERE category = 'Beauty';
```

#### 5. Identify transactions where total sales is greater than 1000

```sql
SELECT \* FROM retail_sales
WHERE total_sale > 1000;
```

#### 6. Identify total number of transcations (transaction_id) made by each gender in each category.

```sql
SELECT category, gender, COUNT(\*) AS total_transactions
FROM retail_sales
GROUP BY gender, category
ORDER By category;
```

#### 7. Calculate the average sales for each month and identify the top-selling month, along with its average sales, for each year.

```sql
SELECT year, month, avg_sale
FROM
(
SELECT
 EXTRACT (YEAR FROM sale_date) as year,
EXTRACT (MONTH FROM sale_date) as month,
AVG(total_sale) as avg_sale,
RANK() OVER (PARTITION BY EXTRACT (YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
FROM retail_sales
GROUP BY 1,2
) AS t1
WHERE rank = 1
```

#### 8. Identify total number of unique customers who purchased items from each category.

```sql
SELECT
category,
COUNT(DISTINCT customer_id) as unique_customer_count
from retail_sales
group by category;
```

#### 9. Count the number of orders for each shift (Morning, Afternoon, and Evening) to identify the peak sales period during the day.

```sql
WITH hourly*sale
AS
(
SELECT *,
CASE
WHEN EXTRACT (HOUR FROM sale*time) < 12 then 'Morning'
WHEN EXTRACT (HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
else 'Evening'
END as shift
FROM retail_sales
)
SELECT
shift,
COUNT(*) as total_orders
FROM hourly_sale
GROUP BY shift
ORDER BY total_orders DESC
```

## Key Insights:

1. **Clothing** is the most popular product category with the highest number of orders & net sale which suggests that the company’s revenue **heavily dependent on apparel products**.
2. Clothing attracts the **largest number of unique customers indicating strong market reach.**
3. **Beauty products** are primarily purchased by **female customers**, with an average customer age ~ **40 years**.
4. **July 2022 recorded the highest average sales ($541.34)** among all months.
5. **Evening hours** show the highest transaction volume, indicating peak shopping time.

SQL Concepts used:

- Joins, Aggregations (`SUM`, `AVG`, `COUNT`), CTE, Date functions, Ranking functions.
