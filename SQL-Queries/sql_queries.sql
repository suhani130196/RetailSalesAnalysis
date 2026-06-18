--Data Analysis & Bussiness key problems & Answers

-- 1. Total sales number of transactions on 2022-11-05. 
SELECT 
COUNT(*) AS total_sales from retail_sales
where sale_date='2022-11-05';


--2. Transactions in clothing category, quantity soled is more than 4 in month of november. 

SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
  AND quantiy >= 4;

-- 3. Total sales for each category

SELECT
	category, 
	SUM(total_sale) as net_sales, 
	COUNT(*) as total_order
FROM retail_sales
GROUP BY category
ORDER BY total_order DESC; 

-- 4. Average age of customer who purchased item from beauty category

SELECT ROUND (AVG(age), 1) 
	as average_age
FROM retail_sales
WHERE category = 'Beauty';

--5. Transactions where total sales is greater than 1000

SELECT * FROM retail_sales
WHERE total_sale > 1000;

-- 6. Total number of transcations (transaction_id) made by each gender in each category. 

SELECT 
    category,
	gender,
    COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY gender, category
ORDER By category;

--7. Calculate average sale for each month. Find out best selling month in each year. 

SELECT  
	year, 
	month, 
	avg_sale
FROM 
(
SELECT  
	EXTRACT (YEAR FROM sale_date) as year, 
	EXTRACT (MONTH FROM sale_date) as month, 
	AVG(total_sale) as avg_sale,	
	RANK() OVER (PARTITION BY EXTRACT (YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rnk
FROM retail_sales
GROUP BY 1,2
) AS t1
WHERE rnk = 1

--8. Number of unique customers who purchased items from each category. 

SELECT 
	category, 
	COUNT(DISTINCT customer_id) as cnt_unique_cs
from retail_sales
group by category;

--9. Order analysis by shift 
WITH hourly_sale
AS 
(
SELECT *, 
	CASE 
		WHEN EXTRACT (HOUR FROM sale_time) < 12 then 'Morning'
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

--End of Project. 