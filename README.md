# Walmart Data SQL Analysis
This project aims to explore the Walmart Sales data to understand top performing branches and products, sales trend of of different products, customer behaviour. The aims is to study how sales strategies can be improved and optimized. The dataset was obtained from the [Kaggle Walmart Sales Forecasting Competition](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting/data?select=sampleSubmission.csv.zip).
# Purposes Of The Project
The major aim of thie project is to gain insight into the sales data of Walmart to understand the different factors that affect sales of the different branches.
# About the Data
The dataset was obtained from the Kaggle Walmart Sales Forecasting Competition. This dataset contains sales transactions from a three different branches of Walmart, respectively located in Mandalay, Yangon and Naypyitaw. The data contains 17 columns and 1000 rows:
[Check the entire Data and it's DDL](https://github.com/ishitva17/Walmart-Data-SQL-Analysis/blob/main/Walmart%20data%20DDL.sql)

# Analysis List

## 1. Product Analysis
> Conduct analysis on the data to understand the different product lines, the products lines performing best and the product lines that need to be improved.

## 2. Sales Analysis
> This analysis aims to answer the question of the sales trends of product. The result of this can help use measure the effectiveness of each sales strategy the business applies and what modifications are needed to gain more sales.

## 3. Customer Analysis
> This analysis aims to uncover the different customers segments, purchase trends and the profitability of each customer segment.


# Business Questions To Answer

## Generic Question
1. How many unique cities does the data have?
2. In which city is each branch?

## Product
1. How many unique product lines does the data have?
2. What is the most common payment method?
3. What is the most selling product line?
4. What is the total revenue by month?
5. What month had the largest COGS?
6. What product line had the largest revenue?
7. What is the city with the largest revenue?
8. What product line had the largest VAT?
9. Fetch each product line and add a column to those product lines showing **"Good"**, **"Bad"**. Good if it's greater than average sales.
10. Which branch sold more products than the average product sold?
11. What is the most common product line by gender?
12. What is the average rating of each product line?

## Sales
1. Number of sales made in each time of the day per weekday
2. Which of the customer types brings the most revenue?
3. Which city has the largest tax percent/VAT (**Value Added Tax**)?
4. Which customer type pays the most in VAT?

## Customer
1. How many unique customer types does the data have?
2. Which of the customer types brings the most revenue?
3. Which city has the largest tax percent/ VAT (Value Added Tax)?
4. Which customer type pays the most in VAT? Customer
5. How many unique customer types does the data have?
6. How many unique payment methods does the data have?
7. What is the most common customer type?
8. Which customer type buys the most?
9. What is the gender of most of the customers?
10. What is the gender distribution per branch?
11. Which time of the day do customers give most ratings?
12. Which time of the day do customers give most ratings per branch?
13. Which day fo the week has the best avg ratings?
14. Which day of the week has the best average ratings per branch?
