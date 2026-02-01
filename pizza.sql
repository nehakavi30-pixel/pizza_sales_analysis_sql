DROP TABLE IF EXISTS pizza;

create TABLE pizza (
			 order_details_id	INT PRIMARY KEY,
			 order_id INT,
			 pizza_id VARCHAR(45),
			 quantity INT 
			 );

CREATE TABLE orders (
			order_id  INT PRIMARY KEY,
			date      date not null,
			time      TIME not null
			);


CREATE TABLE pizza_types (
			 pizza_type_id	VARCHAR(15) PRIMARY KEY,
			 name	VARCHAR(60),
			 category	VARCHAR(20),
			 ingredients VARCHAR(150)
			 );

DROP TABLE if exists pizza_price;
CREATE TABLE pizza_price (
			 pizza_id VARCHAR(20),
			 pizza_type_id	VARCHAR(15),
			 size	VARCHAR(10),
			 price FLOAT
			 );

SELECT * FROM orders;


-----------------------------------------------------------------------------------------------------

-------Retrieve the total number of orders placed.-------------

SELECT count(*) FROM pizza as total_orders;

------------------------------------------------------------------------------------------

----Calculate the total revenue generated from pizza sales.

SELECT 
		round(sum(pizza.quantity * pizza_price.price):: numeric ,2) as total_sales
FROM 
	pizza 
	 JOIN
	pizza_price on pizza_price.pizza_id = pizza.pizza_id

----------------------------------------------------------------------------------------------

------Identify the highest-priced pizza.

select 
	pizza_types.name, pizza_price.price
FROM
	pizza_types
JOIN
	pizza_price ON pizza_price.pizza_type_id = pizza_types.pizza_type_id
ORDER BY price desc
LIMIT 1

------------------------------------------------------------------------------------------------

-------dentify the most common pizza size ordered.

SELECT
	pizza_price.size, count(pizza.order_details_id) as total_counts
FROM
	pizza_price
JOIN
	pizza ON pizza.pizza_id = pizza_price.pizza_id
GROUP BY pizza_price.size
ORDER BY total_counts DESC

-----------------------------------------------------------------------------------------

------List the top 5 most ordered pizza types along with their quantities.

SELECT
	sum(pizza.quantity), pizza_price.pizza_type_id AS top_5
FROM
	pizza
JOIN
	pizza_price ON pizza_price.pizza_id = pizza.pizza_id
GROUP BY pizza_price.pizza_type_id
ORDER BY top_5 DESC
LIMIT 5

------------------------------------------------------------------------------------------------

------Join the necessary tables to find the total quantity of each pizza category ordered

SELECT 
	pizza_types.category, sum(pizza.quantity) as quantity
FROM
	pizza_types
JOIN
	pizza on pizza_types.pizza_type_id = pizza_price.pizza_type_id
JOIN
	pizza on pizza.pizza_id = pizza_price.pizza_id
GROUP by pizza_types.category
ORDER by quantity 

--------------------------------------------------------------------------------------------------
