-----Exploratory Data Analysis (EDA)-----------------------

--Generic Question---

1) select distinct city from sales

2)select distinct branch from sales

3)select distinct city, branch from sales

---Product-----

1)select distinct product_line from sales

2)select payment,count(payment) from sales group by payment
  order by count(payment) desc
  
3)select product_line,count(product_line) from sales group by product_line
  order by count(product_line) desc
  
4)select month_name,sum(total) as total_revenue
from sales group by month_name order by total_revenue desc

5)select month_name,sum(cogs) as cogs
from sales group by month_name order by cogs desc

6)select product_line,sum(total) as total_revenue
from sales group by product_line order by total_revenue desc

7)select city,sum(total) as total_revenue
from sales group by city order by total_revenue desc

8)select product_line,avg(cogs*0.05) as vat
from sales group by product_line order by vat desc

9)select branch,sum(quantity) as qty from sales 
group by branch
having sum(quantity)>(select avg(quantity) from sales)

10)
select product_line,gender,count(gender) as count
from sales group by product_line,gender
order by count desc

11)select product_line,
   round(cast (avg(rating) as decimal),2) avg_rating from sales
    group by product_line
    order by avg_rating desc
	
12)Select product_line,avg(quantity),
case when avg(quantity)>5.5 then 'Good'
else 'Bad' end as sales
from sales group by product_line

select avg(quantity) from sales
	
-----Sales---

1)select time_of_day,
  count(*) as total_sales
  from sales where day_name like ('%sunday%')
  group by time_of_day order by total_sales desc

2)select customer_type,
  sum(total) as total_revenue
  from sales  
  group by customer_type order by total_revenue desc
  
 3)select city,
  avg(cogs*0.05) as vat
  from sales  
  group by city order by vat desc
  
 4)select customer_type,
  avg(tax_pct) as vat
  from sales  
  group by customer_type order by vat desc


-----Customer----------

1)select distinct customer_type from sales 

2)select distinct payment from sales 

3)select customer_type, count(customer_type) 
from sales group by customer_type order by  count(customer_type) desc

4)select customer_type, count(*) 
from sales group by customer_type order by  count(*) 

5)select gender, count(*) as cnt 
from sales group by gender order by  count(*) desc

6)select branch,gender, count(gender) 
from sales group by branch,gender order by  branch,count(gender) desc

7)select time_of_day,avg(rating)
from sales group by time_of_day order by  avg(rating) desc

8)select branch,time_of_day,avg(rating)
from sales group by branch,time_of_day order by  branch,avg(rating) desc

9)select day_name,avg(rating)
from sales group by day_name order by  avg(rating) desc

10)select branch,day_name,avg(rating)
from sales where branch='B' group by 
branch,day_name order by branch, avg(rating) desc

select * from sales

----Feature Engineering: This will help use generate some new columns--------------------


--1)time_of_day
ALTER TABLE SALES
ADD COLUMN time_of_day  text

update sales
set time_of_day=case when time between '00:00:00' and '12:00:00' Then 'Morning'
     when time between '12:01:00' and '16:00:00' Then 'Afternoon'
	 else 'Evening' end 
	 

--2)day_name
ALTER TABLE SALES
ADD COLUMN day_name  text

update sales
set day_name=to_char(date,'day') 

--3)Month_name
ALTER TABLE SALES
ADD COLUMN month_name  text

update sales
set month_name=to_char(date,'month') 

---------------Creating Table-------------------------------------------------

CREATE TABLE sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT,
    total DECIMAL(12, 4) NOT NULL,
    date DATE NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT,
    gross_income DECIMAL(12, 4),
    rating FLOAT
);

COPY sales
FROM 'C:\Users\Dell\Documents\2023\Data analysis projects\Project-8\Dataset\WalmartSalesData.csv'
CSV HEADER;