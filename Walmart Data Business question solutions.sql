--------- sql business problem questions ------------

select *
from walmart_sales ws 

-------- Feature Engineering: This will help use generate some new columns from existing ones. ---------
------ Added name of day for each order_date for further analysis -------------

alter table walmart_sales 
add column day_name varchar(20)

update walmart_sales 
set day_name = dayname(order_date) 


------ Added time of day i.e, morning, afternoon and evening for each order_date for further analysis -------------

alter table walmart_sales 
add column time_of_day varchar(15)

update walmart_sales 
set time_of_day = (
	case 
	when order_Time between '00:00:00' and '12:00:00' then 'Morning'
	when order_Time between '12:01:00' and '16:00:00' then 'Afternoon'
	else 'Evening'
	end
)

------ Added name of month for each order_date for further analysis -------------

alter table walmart_sales 
add column month_name varchar(20)

update walmart_sales 
set month_name = monthname(order_date) 


------------------------- Generic Question -----------------------
---------------- How many unique cities does the data have? ------------------------

select distinct city
from walmart_sales ws 

---------------------------- In which city is each branch? ------------------------------

select distinct City ,Branch
from walmart_sales ws 
order by branch


-- select order_Date,order_Time  ,dayname(order_Date) ,
-- case 
-- 	when order_Time between '02:00:00' and '11:00:00' then 'morning'
-- 	when order_Time between '11:01:00' and '16:30:00' then 'afternoon'
-- 	else 'evening'
-- 	end as time_of_day,
-- monthname(order_Date) 
-- from walmart_sales ws 


------------------------ Product Related Analysis questions ------------------------------
-- How many unique product lines does the data have?

select distinct Product_line 
from walmart_sales ws 

-- What is the most common payment method?

select Payment
from (
select Payment ,count(invoice_ID),dense_rank() over (order by count(invoice_ID) desc) as rnk
from walmart_sales ws 
group by Payment ) a
where rnk =1

-- What is the most selling product line?

with ProductLineOrders as (
select Product_line ,count(invoice_ID) as OrderCount 
from walmart_sales ws 
group by Product_line
order by OrderCount desc) 


select Product_line
from ProductLineOrders
where OrderCount = (select max(OrderCount) from ProductLineOrders)

-- What is the total revenue by month?

select month_name ,round(sum(Total),1) as total_rev
from walmart_sales ws 
group by 1
order by 2 desc

-- What month had the largest COGS?

select month_name ,round(sum(cogs),1) as largestCogs
from walmart_sales ws 
group by 1
order by 2 desc
limit 1

-- What product line had the largest revenue?

select Product_line , round(sum(Total),1) as largestRevenue 
from walmart_sales ws 
group by 1
order by largestRevenue desc


-- What is the city with the largest revenue?

select City , round(sum(Total),1) as largestRevenue
from walmart_sales ws 
group by 1
order by 2 desc

-- What product line had the largest VAT?

select Product_line ,round(sum(Vat),2) as largestVAT
from walmart_sales ws 
group by 1
order by 2 desc

-- Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales --------------
---------- 1st approach is by comparing with avg revenue of total  ------------
with Averagerevenue as (
select *,
avg(Total) over () as avgRevenue 
from walmart_sales ws )

select * ,Product_line,
case when total > avgRevenue then 'Good'
else 'Bad'
end as status
from Averagerevenue

---------- 1st approach is by comparing with avg revenue of each productline  ------------
with avg_rev_per_productline as (
select *,
avg(Total) over (partition by Product_line) as avgRevProductLine 
from walmart_sales ws 
)
select *,Product_line,total,avgRevProductLine,
case when total > avgRevProductLine then 'Good'
else 'Bad'
end as status
from avg_rev_per_productline



-- Which branch sold more products than average product sold?


select branch, avg(Quantity) as avg_qnty_per_branch
from walmart_sales ws 
group by 1
having avg(Quantity) > (select avg(quantity) 
from walmart_sales ws2 )


-- What is the most common product line by gender?

select Gender,Product_line
from (
select Gender , Product_line ,count(*),
dense_rank() over (partition by Gender order by count(*) desc) as rnk
from walmart_sales ws 
group by 1,2) a 
where rnk =1


-- What is the average rating of each product line?

select Product_line , avg(Rating) as avgRating 
from walmart_sales ws 
group by 1
order by 2 desc


-------------------------------- Sales ---------------------------------------------------------------------
-- Number of sales made in each time of the day per weekday

select day_name , time_of_day  , count(*)  as total_no_sales
from walmart_sales ws 
group by 1,2
order by 1


-- Which of the customer types brings the most revenue?

select Customer_type , round(sum(Total),2) as revenue 
from walmart_sales ws 
group by 1
order by 2 desc

-- Which city has the largest tax percent/ VAT (Value Added Tax)?

select City , avg(Vat) as avg_VAT_per_ctiy 
from walmart_sales ws 
group by 1
order by 2 desc

-- Which customer type pays the most in VAT?

select Customer_type , round(avg(Vat),2) as total_VAT 
from walmart_sales ws 
group by 1
order by 2 desc

-------------------------------- Customer --------------------------------------------------------
-- How many unique customer types does the data have?

select distinct Customer_type 
from walmart_sales ws 

-- How many unique payment methods does the data have?

select distinct Payment  
from walmart_sales ws 

-- What is the most common customer type?

select Customer_type
from (
select Customer_type , count(*) as cnt,
dense_rank() over (order by count(*) desc) as rnk
from walmart_sales ws 
group by 1
) a
where rnk =1

-- Which customer type buys the most?

select Customer_type , count(*) as cnt
from walmart_sales ws 
group by 1

-- What is the gender of most of the customers?

select Gender  , count(*) as cnt
from walmart_sales ws 
group by 1
order by 2 desc

-- What is the gender distribution per branch?

select Branch ,Gender  , count(*) as cnt
from walmart_sales ws 
group by 1,2
order by 1 asc,3 desc


-- Which time of the day do customers give most ratings?

select time_of_day , round(avg(Rating),2) as avgrating
from walmart_sales ws 
group by 1
order by 2 desc

-- Which time of the day do customers give most ratings per branch?

select Branch ,time_of_day , round(avg(Rating),2) as avgrating
from walmart_sales ws 
group by 1,2
order by 1 asc, 3 desc


-- Which day fo the week has the best avg ratings?

select day_name  , round(avg(Rating),2) as avgrating
from walmart_sales ws 
group by 1
order by 2 desc


-- Which day of the week has the best average ratings per branch?

select Branch ,day_name , round(avg(Rating),2) as avgrating
from walmart_sales ws 
group by 1,2
order by 1 asc, 3 desc



-- Revenue And Profit Calculations
-- $ COGS = unitsPrice * quantity $
-- 
-- $ VAT = 5% * COGS $
-- 
-- VAT is added to the COGS and this is what is billed to the customer.
-- $ total(gross_sales) = VAT + COGS $
-- 
-- $ grossProfit(grossIncome) = total(gross_sales) - COGS $
-- 
-- Gross Margin is gross profit expressed in percentage of the total(gross profit/revenue)
-- 
-- $ \text{Gross Margin} = \frac{\text{gross income}}{\text{total revenue}} $
