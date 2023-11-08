create table Categories(
	category_id int primary key,
    category_name text);
    
create table Products(
	product_id int primary key,
    product_name text,
	category_id int ,
	price int,
    foreign key (category_id) references Categories(category_id));
    
create table Customers(
	customer_id int primary key,
    customer_name text,
    email text);
    
create table Orders(
	order_id int primary key,
	customer_id int ,
	order_date date,
    foreign key (customer_id) references Customers(customer_id));
    
create table OrderDetails(
	order_detail_id int primary key,
	order_id int ,
    foreign key (order_id) references Orders(order_id),
	product_id int,
    foreign key (product_id) references Products(product_id),
    quantity int);
    

-- 1    
select Products.*, OrderDetails.quantity from Products
inner join OrderDetails on Products.product_id = OrderDetails.product_id;

-- 2
select OrderDetails.order_id, sum(Products.price * OrderDetails.quantity) as total_price
from OrderDetails
inner join Products on Products.product_id = OrderDetails.product_id 
group by OrderDetails.order_id = 2;


-- 3
select Products.* from Products
left join OrderDetails on Products.product_id = OrderDetails.product_id
where OrderDetails.order_detail_id is null; 

-- 4
select category_name, count(Products.product_id)
from Categories
inner join Products on Categories.category_id = Products.category_id
group by category_name;

-- 5
select Customers.customer_name, count(OrderDetails.quantity) as total_orderd
from Customers
inner join Orders on Customers.customer_id = Orders.customer_id
inner join OrderDetails on Orders.order_id = OrderDetails.order_id 
group by Customers.customer_name;

-- 6
select Categories.category_name, count(Products.product_id) as product_count
from Categories
inner join Products on Products.category_id = Categories.category_id
group by Categories.category_name;

-- 7
select Categories.category_name, sum(OrderDetails.quantity) as total_ordered
from Categories 
inner join Products on Categories.category_id = Products.category_id
inner join OrderDetails on Products.product_id = OrderDetails.product_id
group by Categories.category_name; 

-- 8
select Customers.customer_name, count(OrderDetails.quantity) as total_ordered
from Customers
inner join Orders on Orders.customer_id = Customers.customer_id
inner join OrderDetails on Orders.order_id = OrderDetails.order_id
group by Customers.customer_name order by total_ordered desc 
limit 3;

-- 9
select Customers.customer_id, Customers.customer_name , count(*) as total_order from Customers
inner join Orders on Customers.customer_id = Orders.customer_id
group by customer_id
having date(order_date) between 1 and 31;

-- 10
select OrderDetails.product_id , sum(OrderDetails.quantity) as total_ordered
from OrderDetails
inner join Products on Products.product_id = OrderDetails.product_id
group by OrderDetails.product_id
order by total_ordered DESC
limit 1;



