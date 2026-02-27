CREATE TABLE pizza_sales (
    pizza_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    pizza_name_id VARCHAR(50) NOT NULL,
    quantity INT NOT NULL,
    order_date DATE NOT NULL,
    order_time TIME NOT NULL,
    unit_price DECIMAL(8,2) NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    pizza_size VARCHAR(50),
    pizza_category VARCHAR(50),
    pizza_ingredients varchar(200),
    pizza_name VARCHAR(100)
);

select * from pizza_sales limit 10;

SELECT *
FROM information_schema.columns
WHERE table_name = 'pizza_sales';

--------creating a new column for total pizzza price
alter table pizza_sales
add column total_pizza_price numeric;

update pizza_sales
set total_pizza_price = quantity * unit_price;

-----------sum of all the total pizza

select sum(total_pizza_price) as total_revenue from pizza_sales;

--------calculate the average order ammount
select (sum(total_price)/ count(distinct order_id)) from pizza_sales;

--------total pizzas sold 
select sum(quantity) from pizza_sales;

--------total order
select count(distinct order_id) from pizza_sales;

---------average pizzas per order
select (cast(sum(quantity) as decimal(10,2))/cast(count(distinct order_id)as decimal(10,2))) from pizza_sales;


----------total numbers of order each day in a year
SELECT 
    TO_CHAR(order_date, 'Day') AS day_name,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY TO_CHAR(order_date, 'Day')
ORDER BY total_orders DESC;

----------total number of orders each day 
select order_date, count(distinct order_id) from pizza_sales
group by order_date
order by order_date asc;

-----------total number of order per month
SELECT 
    EXTRACT(MONTH FROM order_date) AS month,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY month
ORDER BY month;


---------percentage of sales by category
select pizza_category, (sum(total_price))*100 / (select (sum(total_price)) from pizza_sales)
from pizza_sales
group by pizza_category
order by pizza_category;


--------percentage of sales by pizza size
select pizza_size, (sum(total_price))*100 / (select (sum(total_price)) from pizza_sales)
from pizza_sales
group by pizza_size
order by pizza_size;


--------top 5 best sellers by revenue, total quantity, total order
select pizza_name, sum(total_price) from pizza_sales 
group by pizza_name
order by pizza_name desc
limit 5;

select pizza_name, sum(quantity) from pizza_sales 
group by pizza_name
order by pizza_name desc
limit 5;

select pizza_name, count(distinct order_id) from pizza_sales 
group by pizza_name
order by pizza_name desc
limit 5;

--------top 5 worst sellers by revenue, total quantity, total order
select pizza_name, sum(total_price) from pizza_sales 
group by pizza_name
order by pizza_name asc
limit 5;












