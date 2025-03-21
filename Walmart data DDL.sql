create database if not exists walmart_data;

show databases;

use walmart_data;

-- drop table walmart_sales

create table walmart_sales
(
invoice_ID	varchar(30) not null primary key,
Branch varchar(5) not null,
City varchar(30) not null,
Customer_type varchar(30) not null,
Gender varchar(10) not null,
Product_line varchar(80) not null,
unit_price decimal(10,2) not null,
Quantity int not null,
Vat float not null,
Total float not null,
order_Date date not null,
order_Time time not null,
Payment varchar(20) not null,
cogs float not null,
gross_margin_percentage float not null,
gross_income float not null,
Rating Float not null
)

