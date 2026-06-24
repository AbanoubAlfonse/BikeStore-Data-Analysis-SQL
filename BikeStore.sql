/* ============================================================
   NTI - BikeStore Project
   ============================================================ */

/* A. Explore Data
   Display all data on the tables
*/

select * from production.brands
select * from production.categories
select * from production.products order by model_year
select * from production.stocks order by quantity desc
select * from sales.customers order by state
select * from sales.order_items order by list_price desc
select * from sales.orders order by order_date desc
select * from sales.staffs
select * from sales.stores

--1- Which bike is most expensive?
select top 1 * from production.products order by list_price desc
--Trek Domane SLR 9 Disc - 2018 is the most expensive bike

--What could be the motive behind pricing this bike at the high price?
/*1- new model year
  2- expensive brand
  3- most relevent category
*/

--2- How many total customers does BikeStore have?
select count(customer_id) total_customers from sales.customers
--BikeStore have 1445 customers

--Would you consider people with order status 3 as customers?
select count(distinct order_id) / count(distinct customer_id) AS AOV 
from sales.orders
--the aov is 1

--3- How many stores does BikeStore have?
select count(store_id) #stores
from sales.stores
--BikeStore have 3 stores

--4- What is the total price spent per order?
--Hint:total price = list_price * quantity * (1-discount)
SELECT order_id,
SUM(list_price * quantity * (1-discount)) AS total_price
FROM sales.order_items
GROUP BY order_id

--5- What's the sales/revenue per store?
--Hint:Sales Revenue = list_price * quantity * (1-discount)
SELECT s.store_name,
SUM(i.list_price * i.quantity * (1-i.discount)) AS revenue
FROM sales.stores s
JOIN sales.orders o
ON s.store_id = o.store_id
JOIN sales.order_items i
ON o.order_id = i.order_id
GROUP BY s.store_name
ORDER BY revenue DESC

--6- Which category is most sold?
select distinct c.category_name,count(i.order_id) #orders
from sales.order_items i
join production.products p
on i.product_id = p.product_id
join production.categories c 
on c.category_id = p.category_id
group by c.category_name
order by #orders desc
--most sold category is Cruisers Bicycles

--7- Which category rejected more orders?
SELECT TOP 1
c.category_name,
COUNT(*) AS rejected_orders
FROM sales.orders o
JOIN sales.order_items i
ON o.order_id = i.order_id
JOIN production.products p
ON i.product_id = p.product_id
JOIN production.categories c
ON p.category_id = c.category_id
WHERE o.order_status = 3
GROUP BY c.category_name
ORDER BY rejected_orders DESC
--The most rejected category is Electric Bikes

--8- Which bike is the least sold?
select top 1 p.product_name,count(i.order_id) #orders
from production.products p
left outer join sales.order_items i
on p.product_id = i.product_id
group by p.product_name
order by #orders
--treck chechpoint id the least sold bike

--9- What's the full name of customer with ID 259?
select first_name + ' ' + last_name full_name 
from sales.customers where customer_id = 259

--10- What did customer 259 buy and when?
select * from sales.order_items i 
join sales.orders o on o.order_id = i.order_id
join production.products p on i.product_id = p.product_id
where customer_id = 259
/* in 1/1/2016 customer 259 had buy :
Electra Townie Original 7D EQ - Women's - 2016,
Trek Remedy 29 Carbon Frameset - 2016,
Surly Straggler - 2016,
Electra Townie Original 7D EQ - 2016 and
Trek Fuel EX 8 29 - 2016 */

-- What's the status of this order?
-- 4

--11- Which staff processed the order of customer 259?
select * from sales.order_items i 
join sales.orders o on o.order_id = i.order_id
join sales.staffs s on o.staff_id = s.staff_id
where customer_id = 259
--Mireya Copeland processed the order of customer 259

--And from which store?
select * from sales.order_items i 
join sales.orders o on o.order_id = i.order_id
join sales.stores s on o.store_id = s.store_id
where customer_id = 259
--customer 259 processed the order in Santa Cruz Bikes store

--12- How many staff does BikeStore have?
select count(staff_id) #staff from sales.staffs
--BikeStore have 10 staff

--Who seems to be the lead staff at BikeStore?
select * from sales.staffs where manager_id is null
--fabiola

--13- Which brand is the most liked?
select distinct brand_name, count(order_id) #orders
from production.brands b
join production.products p on b.brand_id = p.brand_id 
join sales.order_items i on p.product_id = i.product_id
group by brand_name
order by #orders desc
--most liked brand is Electra

--14- How many categories does BikeStore have?
select count(category_id) #categories from production.categories
--7

--Which one is the least liked?
select category_name ,count(order_id) #orders
from production.categories c
join production.products p on c.category_id = p.category_id
join sales.order_items i on p.product_id = i.product_id
group by category_name
order by #orders
--Electric Bikes is the least liked 

--15- Which store still has more products of the most liked brand?
select top 1 sr.store_name, SUM(sc.quantity) tot_quan
from sales.stores sr
join production.stocks sc on sr.store_id = sc.store_id
join production.products p on sc.product_id = p.product_id
join production.brands b on p.brand_id = b.brand_id
where b.brand_name = 'Electra'
GROUP BY sr.store_name
order by tot_quan desc
--Santa Cruz Bikes

--16- Which state is doing better in terms of sales?
select c.state, 
SUM(i.list_price * i.quantity * (1-i.discount)) AS sales
from sales.customers c 
join sales.orders o on c.customer_id = o.customer_id
join sales.order_items i on i.order_id = o.order_id
group by c.state
order by sales desc
--NY

--17- What's the discounted price of product ID 259?
select product_id,avg((1-discount) * list_price) discounted_price 
from sales.order_items
where product_id = 259
group by product_id
--1037

/*18- What's the product name, quantity, price, category,
model year and brand name of product number 44?*/
SELECT
p.product_name,
i.quantity,
i.list_price,
c.category_name,
p.model_year,
b.brand_name
FROM production.products p
JOIN sales.order_items i
ON p.product_id = i.product_id
JOIN production.categories c
ON p.category_id = c.category_id
JOIN production.brands b
ON p.brand_id = b.brand_id
WHERE p.product_id = 44

--19- What's the zip code of CA?
select distinct zip_code from sales.customers where state = 'ca'

--20- How many states does BikeStore operate in?
select count(distinct state) #states from sales.customers
--3

--21- How many bikes under the Children category were sold in the last 8 months?
SELECT SUM(i.quantity) AS bikes_sold
FROM sales.orders o
JOIN sales.order_items i
ON o.order_id = i.order_id
JOIN production.products p
ON i.product_id = p.product_id
JOIN production.categories c
ON p.category_id = c.category_id
WHERE c.category_name = 'Children Bicycles'
AND o.order_date >= DATEADD(MONTH,-8,(SELECT MAX(order_date) FROM sales.orders))
--22- What's the shipped date for the order from customer 523?
SELECT DISTINCT shipped_date
FROM sales.orders
WHERE customer_id = 523;
--3/1/2016

--23- How many orders are still pending?
select count(*) from sales.orders
where order_status = 1
--62

--24- What's the category name and brand name of 'Electra White Water 3i - 2018'?
select category_name, brand_name from production.products p
join production.categories c on p.category_id = c.category_id
join production.brands b on p.brand_id = b.brand_id
where product_name = 'Electra White Water 3i - 2018'
--Cruisers Bicycles, Electra