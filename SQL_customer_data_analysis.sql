USE sql_store; 
-- Return all the coloms in the customers if customer id is
-- greater then 5
select customer_id, first_name, birth_date 
from customers
where customer_id > 5
order by first_name;
-- ================================================ 
-- Add a discount colomn in customers
select 
	first_name,
    last_name,
    points,
    (points + 10) / 100 as 'discount factor'
    
from customers;
-- =================================================
select distinct state 
from customers;
-- =================================================
-- Return all the products
-- name
-- unit price
-- new price(unit price*1.1)"""

select 
	name,
    unit_price,
    unit_price * 1.1 as 'new price'
from products;
-- =================================================
select *
from customers
where points > 3000;
select *
from customers
where state = 'va';
select *
from customers
where state != 'va';

-- -- where birth_date > '1990-01-01'

-- "Get the order placed in the year 2019"

select *
from orders
where order_date >= '2019-01-01';

select *
from customers
where birth_date > '1990-01-01' and points > 1000;


select *
from customers
where birth_date > '1990-01-01' or
	  (points > 1000 and state = 'va');

-- =================================================
-- From the order_items table,get the items
--    for order#6
--    where the total price is greater than 30"""
select * 
from order_items
where order_id = 6 and quantity * unit_price > 30;
-- =================================================

select * 
from customers
where state in ('va', 'fl', 'ga');

select * 
from customers
where state not in ('va', 'fl', 'ga');	
-- =================================================
-- Return the product with quantity in stock equal to 49, 38, 72
select *
from products
where quantity_in_stock in (49, 38, 72);
-- =================================================
-- Return customers born between 1/1/1990 and 1/1/2000
select *
from customers
where birth_date between '1990-01-01' and '2000-01-01';
-- =================================================
-- Return the last name start with b, followed by 6 letters and ends with y
select *
from customers
where last_name like 'b______y';
-- =================================================
select order_id, c.customer_id, first_name, order_date
from orders o
inner join customers c
	on o.customer_id = c.customer_id;
-- =================================================
select o.product_id, name, quantity, o.unit_price
from order_items o -- products p
join products p -- order_items o
	on p.product_id = o.product_id;
-- =================================================
use sql_invoicing;
-- Return date, invoice_id, amount, name, pay,ent method
select 
	payments.date,
    payments.invoice_id,
    payments.amount,
    clients.name,
    payment_methods.name as pay_method
from payments
join clients
	on payments.client_id = clients.client_id
    
join payment_methods 
	on payments.payment_method = payment_methods.payment_method_id;

-- ======================================================================
use sql_store;
-- Returnproduct_id, name, quantity
select 
	p.product_id,
    p.name,
    oi.quantity
from order_items oi 
right join products p
	on p.product_id = oi.product_id;
-- ======================================================================
-- Return customer_id, first_name, order_id, shipper
select c.customer_id, c.first_name, o.order_id, sh.name as shipper
from customers c
left join orders o
	on o.customer_id = c.customer_id
left join shippers sh
	on sh.shipper_id = o.shipper_id;
-- ======================================================================
-- Return order_date, order_id, shipper, status
select 
	o.order_date,
    o.order_id,
    c.first_name,
    sh.name as shipper,
    os.name as status
from orders o
left join customers c
	on c.customer_id = o.order_id
    
left join shippers sh
	on sh.shipper_id = o.shipper_id
    
left join order_statuses os
	on os.order_status_id = o.status

order by o.status;
-- =================================================
-- Return date, client, amount, pay_method
use sql_invoicing;
select 
	p.date,
    c.name as client,
    p.amount,
    pm.name as pay_method
from payments p
join clients c
	using (client_id)
    
join payment_methods pm
	on pm.payment_method_id = p.payment_method;
-- =================================================
use sql_store;

select 
	customer_id,
	first_name,
    points,
    'Bronze' as type
from customers
where points < 2000

union
select 
	customer_id,
	first_name,
    points,
    'Silver' as type
from customers
where points between 2000 and 3000

union
select 
	customer_id,
	first_name,
    points,
    'Gold' as type
from customers
where points > 3000

order by first_name;
-- ==================================================================   