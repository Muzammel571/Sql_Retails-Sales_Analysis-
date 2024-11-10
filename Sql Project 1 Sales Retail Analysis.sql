
--- Retails Sales Analyis---------------------------
SELECT
*
FROM [Retail Sales Analysis].[dbo].[SQL Retail Sales Analysis] ;
-------------------------------------------------------------------------------------------------
--* First we need to read data means what column we have information they had in Column Table
--Data Cleaning---------------
-- 1. we check is there any null values in any colum
Select
*
FROM [Retail Sales Analysis].[dbo].[SQL Retail Sales Analysis]
Where transactions_id IS NULL
      OR sale_date IS NULL
	  OR sale_time IS NULL
	  OR customer_id IS NULL
	  OR gender IS Null
	  OR age IS NUll
	  OR category IS Null
	  OR quantiy IS null
	  OR price_per_unit IS Null
	  OR cogs IS NULL
	  OR total_sale IS Null;	
---if we check in database found null values we will delete it or replace with any information if needed
--So now we are deleting for no needed in data base---
--Syntax
Delete from [Retail Sales Analysis].[dbo].[SQL Retail Sales Analysis]
Where transactions_id IS NULL
      OR sale_date IS NULL
	  OR sale_time IS NULL
	  OR customer_id IS NULL
	  OR gender IS Null
	  OR age IS NUll
	  OR category IS Null
	  OR quantiy IS null
	  OR price_per_unit IS Null
	  OR cogs IS NULL
	  OR total_sale IS Null; 
-- Data Exploration
Select
*
From [Retail Sales Analysis].[dbo].[SQL Retail Sales Analysis];
--How Many sales we have completed from 2022 to 2023
Select
COUNT(total_sale) As Total_Retail_Sales
From [Retail Sales Analysis].[dbo].[SQL Retail Sales Analysis];--------------------------------------------------------------------------------------
--How Many Unique Customer customer we have in Database  from 2022 to 2023
Select 
COUNT (	Distinct customer_id) As total_customer
From [Retail Sales Analysis].[dbo].[SQL Retail Sales Analysis];--------------------------------------------------------------------------------------
--How Many Unique Category customer we have in Database  from 2022 to 2023
Select 
COUNT (	Distinct category) As total_customer
From [Retail Sales Analysis].[dbo].[SQL Retail Sales Analysis];
--Please specify  Unique Category name we have in Database  from 2022 to 2023
Select 
Distinct category As total_customer
From [Retail Sales Analysis].[dbo].[SQL Retail Sales Analysis];

-----Data Analysis & Business Problem & Answeres
--1.Write a query to retrieve all column for sales made on '2022-11-05'
--find  All sales made on '2022-11-05'
Select
*
From [Retail Sales Analysis].[dbo].[SQL Retail Sales Analysis]
Where sale_date = '2022-11-05';
---------------------------------------------------------------------------------------------------
--2. Write a query to retrive all transactions where category is 'Clothing' and the quantity sold is more than 3
--in month of Nov 2022
--find : The all transaction in Clothing Category and sole quantity more than 3 in Nov Month
Select
transactions_id,
category,
SUM(TRY_CAST(quantiy AS INT)) AS total_quantity---New How to change Data Type-------
FROM [Retail Sales Analysis].[dbo].[SQL Retail Sales Analysis]
Where category = 'Clothing'
And MONTH (sale_date) = 11
And YEAR  (sale_date) = 2022
AND quantiy >= 3
GROUP BY transactions_id, category;
---------------------------------------------------------------------------------------------------
--3. write a sql query to calculate total sales for each category.
--Find : The  total sales for all category. 
Select
category,
Sum (TRY_Cast(total_sale AS INT )) As Final_Sales, ---New How to change Data Type-------
Count (TRY_Cast(total_sale AS INT )) As Total_Count
FROM [Retail Sales Analysis].[dbo].[SQL Retail Sales Analysis]
Group by  category ;
---------------------------------------------------------------------------------------------------
--4. Write a Sql query to find Average age of customer who purchased items from Beauty Category
--Find : The Average age of customer purchase from Beauty Category
Select
Avg (TRY_CAST(age AS INT )) AS Average_age_of_Customer,
category
FROM [Retail Sales Analysis].[dbo].[SQL Retail Sales Analysis] 
Where category = 'Beauty' 
Group by category ;
---------------------------------------------------------------------------------------------------
--5. Write a Sql query to find all transactions where total_Sales is greater than 1000
--Find : All Tranasactions which total_sales is more than 1000
--Syntax  :
Select
transactions_id,
Sum (Try_Cast (total_sale AS int)) AS Net_sales
FROM [Retail Sales Analysis].[dbo].[SQL Retail Sales Analysis]
Where total_sale > 1000
Group by transactions_id ;
---------------------------------------------------------------------------------------------------
--6. Write a sql query to find total number of transactions made by each gender in each category
--find : Total number of transactions done by gender in each category.
---Syntax :
Select
category,
gender,
Count (Try_Cast(transactions_id AS INT )) AS total_number
FROM [Retail Sales Analysis].[dbo].[SQL Retail Sales Analysis]
Group by category,gender ;

--7.write a sql query to calculate the average sales for each Month .find Out best selling month in each year.
--find : The Average sales for each Month and find best selling in each year.
--Syntax :
WITH MonthlyAverageSales AS (
    SELECT
        YEAR(sale_date) AS total_year,
        MONTH(sale_date) AS total_month,
        AVG(TRY_CAST(total_sale AS INT)) AS Average_Sales_Month
    FROM [Retail Sales Analysis].[dbo].[SQL Retail Sales Analysis]
    GROUP BY YEAR(sale_date), MONTH(sale_date)
)

SELECT *
FROM (
    SELECT
        total_year,
        total_month,
        Average_Sales_Month,
        ROW_NUMBER() OVER (PARTITION BY total_year ORDER BY Average_Sales_Month DESC) AS month_rank
    FROM MonthlyAverageSales
) AS ranked_sales
WHERE month_rank = 1;

--8. Write a Query to find the top 5 Customer based on highest total sales
--find : Top 5 Customer on High Sales
--Syntax:
Select
Top 5
Customer_id,
SUM (TRY_CAST (total_sale AS int)) As Highest_Sales
FROM [Retail Sales Analysis].[dbo].[SQL Retail Sales Analysis]
GROUP By Customer_id
ORDER by  Highest_Sales Desc ;

--9. Write a sql query to find number of unique customer who purchased items from each category
--Find : Find  number Unique Customer, purchased from each category.
Select
category,
Count (Distinct customer_id )As No_of_unique_customer
FROM [Retail Sales Analysis].[dbo].[SQL Retail Sales Analysis]
Group By category ;

--10. Write a sql query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17 , Evening >17.
SELECT
    CASE
        WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS number_of_orders
FROM [Retail Sales Analysis].[dbo].[SQL Retail Sales Analysis]
GROUP BY
    CASE
        WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END;
---End Project-------------------------------------------------------------------------------------



















 








 













































 

























 

 





















