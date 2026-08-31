-- Create database
create DATABASE ECOMMERCE_ASSIGNMENT_DB

-- Use the database
USE ECOMMERCE_ASSIGNMENT_DB

-- Create Customer table
create table Customer (
    CustomerId int PRIMARY KEY,
    CustomerName varchar(100) not null,
    Email varchar(100) not null,
    MobileNo varchar(15) not null,
    City varchar(50),
    Address varchar(150),
    IsActive bit DEFAULT 1,
    CreatedDate date DEFAULT GETDATE()
)

-- Create Seller table
create table Seller (
    SellerId int PRIMARY KEY,
    SellerName varchar(100) not null,
    Email varchar(100) not null,
    MobileNo varchar(15) not null,
    City varchar(50),
    Rating decimal(2,1),
    IsActive bit
)

-- Create Product table
create table Product (
    ProductId int PRIMARY KEY,
    ProductName varchar(100) not null,
    Category varchar(50),
    Price decimal(10,2) not null,
    StockQuantity int not null,
    SellerId int not null,
    CreatedDate date,
    FOREIGN KEY (SellerId) references Seller(SellerId)
)

-- Create Orders table
create table Orders (
    OrderId int PRIMARY KEY,
    CustomerId int not null,
    OrderDate date,
    OrderStatus varchar(50),
    PaymentMode varchar(50),
    DeliveryCity varchar(100) not null,
    FOREIGN KEY (CustomerId) references Customer(CustomerId)
)

-- Create OrderItem table
create table OrderItem (
    OrderItemId int PRIMARY KEY,
    OrderId int not null,
    ProductId int not null,
    Quantity int,
    UnitPrice decimal(10,2),
    FOREIGN KEY (OrderId) references Orders(OrderId),
    FOREIGN KEY (ProductId) references Product(ProductId)
)

-- Add unique constraint on Customer email
alter table Customer add CONSTRAINT UQ_Customer_Email UNIQUE(Email)

-- Add unique constraint on Seller email
alter table Seller add CONSTRAINT UQ_Seller_Email UNIQUE(Email)

-- Add NOT NULL constraints
alter table Customer alter column CustomerName varchar(100) not null
alter table Seller alter column SellerName varchar(100) not null
alter table Product alter column ProductName varchar(100) not null
alter table Orders alter column DeliveryCity varchar(100) not null

-- Add CHECK constraint for product price > 0
alter table Product add CONSTRAINT CHK_Price CHECK (Price > 0)

-- Add CHECK constraint for stock quantity >= 0
alter table Product add CONSTRAINT CHK_Stock CHECK (StockQuantity >= 0)

-- Add CHECK constraint for order quantity > 0
alter table OrderItem add CONSTRAINT CHK_Quantity CHECK (Quantity > 0)

-- Add DEFAULT for order date
alter table Orders add CONSTRAINT DF_OrderDate DEFAULT GETDATE() FOR OrderDate

-- Add DEFAULT for order status
alter table Orders add CONSTRAINT DF_OrderStatus DEFAULT 'Pending' FOR OrderStatus

-- Add DEFAULT for customer active status
alter table Customer add CONSTRAINT DF_IsActive DEFAULT 1 FOR IsActive


--  Insert 5 customer records
insert into Customer values
(1, 'Arjun', 'arjun@gmail.com', '9876541001', 'Chennai', 'T Nagar', 1, GETDATE()),
(2, 'Bhavna', 'bhavna@yahoo.com', '9876541002', 'Bangalore', 'Koramangala', 1, GETDATE()),
(3, 'Carthi', 'carthi@gmail.com', '9876541003', 'Madurai', 'Anna Nagar', 1, GETDATE()),
(4, 'Divya', 'divya@gmail.com', '9876541004', 'Hyderabad', 'Hitech City', 1, GETDATE()),
(5, 'Edwin', 'edwin@gmail.com', '9876541005', 'Chennai', 'Adyar', 1, GETDATE())

-- Insert 4 seller records
insert into Seller values
(101, 'Ram Stores', 'ram@gmail.com', '9500001001', 'Chennai', 4.5, 1),
(102, 'Sri Traders', 'sri@gmail.com', '9500001002', 'Bangalore', 4.8, 1),
(103, 'Tech Zone', 'techzone@gmail.com', '9500001003', 'Mumbai', 4.2, 1),
(104, 'Smart Shop', 'smart@gmail.com', '9500001004', 'Delhi', 4.6, 1)

-- Insert 8 product records
insert into Product values
(1001, 'iPhone 15', 'Mobile', 78000, 20, 101, GETDATE()),
(1002, 'Samsung S24', 'Mobile', 65000, 15, 101, GETDATE()),
(1003, 'Dell Laptop', 'Laptop', 55000, 10, 102, GETDATE()),
(1004, 'MacBook Air', 'Laptop', 115000, 8, 102, GETDATE()),
(1005, 'Boat Earphones', 'Accessories', 2500, 50, 103, GETDATE()),
(1006, 'Apple Watch', 'Wearables', 45000, 12, 103, GETDATE()),
(1007, 'iPad Air', 'Tablet', 60000, 7, 104, GETDATE()),
(1008, 'Sony Camera', 'Electronics', 85000, 5, 104, GETDATE())

-- Insert 5 order records
insert into Orders values
(5001, 1, GETDATE(), 'Delivered', 'UPI', 'Chennai'),
(5002, 2, GETDATE(), 'Pending', 'Card', 'Bangalore'),
(5003, 3, GETDATE(), 'Shipped', 'Net Banking', 'Madurai'),
(5004, 4, GETDATE(), 'Delivered', 'UPI', 'Hyderabad'),
(5005, 5, GETDATE(), 'Pending', 'Cash On Delivery', 'Chennai')

-- Insert 10 order item records
insert into OrderItem values
(1, 5001, 1001, 1, 78000),
(2, 5001, 1005, 2, 2500),
(3, 5002, 1003, 1, 55000),
(4, 5002, 1006, 1, 45000),
(5, 5003, 1002, 1, 65000),
(6, 5003, 1007, 1, 60000),
(7, 5004, 1004, 1, 115000),
(8, 5004, 1005, 3, 2500),
(9, 5005, 1008, 1, 85000),
(10, 5005, 1006, 2, 45000)

-- Update one customer city
update Customer set City = 'Trichy' where CustomerId = 4

--  Update one product price
update Product set Price = 70000 where ProductId = 1002

-- Update one order status
update Orders set OrderStatus = 'Delivered' where OrderId = 5005

-- Delete product not used in any order item
delete from Product where ProductId not in (
    select ProductId from OrderItem
)

-- Select all from all tables
select * from Customer
select * from Seller
select * from Product
select * from Orders
select * from OrderItem


-- Customers from Chennai
select * from Customer where City = 'Chennai'

-- Customers NOT from Chennai
select * from Customer where City != 'Chennai'

--  Products with price > 50000
select * from Product where Price > 50000

-- Products with price between 10000 and 60000
select * from Product where Price between 10000 and 60000

-- Products from Mobile or Laptop category
select * from Product where Category = 'Mobile' or Category = 'Laptop'

-- Customers whose name starts with A
select * from Customer where CustomerName like 'A%'

-- Customers whose email contains gmail
select * from Customer where Email like '%gmail%'

--  Products whose name contains Phone
select * from Product where ProductName like '%Phone%'

--  Orders with status Delivered
select * from Orders where OrderStatus = 'Delivered'

-- Products where stock quantity < 10
select * from Product where StockQuantity < 10

-- Customers where mobile number is not null
select * from Customer where MobileNo is not null

--  Products where price is NOT between 10000 and 50000
select * from Product where Price not between 10000 and 50000

--  Customers from Chennai or Bangalore
select * from Customer where City in ('Chennai', 'Bangalore')

--  Customers from Chennai AND active
select * from Customer where City = 'Chennai' and IsActive = 1

--  Customers except from Hyderabad
select * from Customer where City != 'Hyderabad'









--  Total customers city-wise
select City, count(*) as TotalCustomers from Customer group by City

--  Total products category-wise
select Category, count(*) as TotalProducts from Product group by Category

--  Total stock quantity category-wise
select Category, sum(StockQuantity) as TotalStock from Product group by Category

--  Maximum product price category-wise
select Category, max(Price) as MaxPrice from Product group by Category

--  Minimum product price category-wise
select Category, min(Price) as MinPrice from Product group by Category

-- Average product price category-wise
select Category, avg(Price) as AvgPrice from Product group by Category

-- Total order amount customer-wise
select c.CustomerId, c.CustomerName, sum(oi.Quantity * oi.UnitPrice) as TotalOrderAmount
from Customer c
join Orders o on c.CustomerId = o.CustomerId
join OrderItem oi on o.OrderId = oi.OrderId
group by c.CustomerId, c.CustomerName

--  Total sales product-wise
select p.ProductId, p.ProductName, sum(oi.Quantity * oi.UnitPrice) as TotalSales
from Product p
join OrderItem oi on p.ProductId = oi.ProductId
group by p.ProductId, p.ProductName

-- Total quantity sold product-wise
select p.ProductId, p.ProductName, sum(oi.Quantity) as TotalQtySold
from Product p
join OrderItem oi on p.ProductId = oi.ProductId
group by p.ProductId, p.ProductName

-- Categories having more than 1 product
select Category, count(*) as TotalProducts
from Product
group by Category
having count(*) > 1

-- Customers whose total order amount > 50000
select c.CustomerId, c.CustomerName, sum(oi.Quantity * oi.UnitPrice) as TotalAmount
from Customer c
join Orders o on c.CustomerId = o.CustomerId
join OrderItem oi on o.OrderId = oi.OrderId
group by c.CustomerId, c.CustomerName
having sum(oi.Quantity * oi.UnitPrice) > 50000

-- Seller-wise total number of products
select s.SellerId, s.SellerName, count(p.ProductId) as TotalProducts
from Seller s
join Product p on s.SellerId = p.SellerId
group by s.SellerId, s.SellerName

-- Seller-wise total sales amount
select s.SellerId, s.SellerName, sum(oi.Quantity * oi.UnitPrice) as TotalSales
from Seller s
join Product p on s.SellerId = p.SellerId
join OrderItem oi on p.ProductId = oi.ProductId
group by s.SellerId, s.SellerName

-- Order status-wise order count
select OrderStatus, count(*) as TotalOrders from Orders group by OrderStatus

-- City-wise customer count sorted by highest
select City, count(*) as CustomerCount
from Customer
group by City
order by CustomerCount desc




-- Products by price ascending
select * from Product order by Price asc

-- Products by price descending
select * from Product order by Price desc

-- Customers by city and name ascending
select * from Customer order by City asc, CustomerName asc

-- Orders by order date descending
select * from Orders order by OrderDate desc

-- Products by category ascending and price descending
select * from Product order by Category asc, Price desc

-- Top 3 highest priced products
select top 3 * from Product order by Price desc

-- Top 5 recent orders
select top 5 * from Orders order by OrderDate desc

-- Customers sorted by active status and name
select * from Customer order by IsActive desc, CustomerName asc






-- Orders with customer details - INNER JOIN
select o.*, c.CustomerName, c.Email
from Orders o
inner join Customer c on o.CustomerId = c.CustomerId

--Products with seller details - INNER JOIN
select p.*, s.SellerName, s.City
from Product p
inner join Seller s on p.SellerId = s.SellerId

--Order items with product details - INNER JOIN
select oi.*, p.ProductName, p.Category
from OrderItem oi
inner join Product p on oi.ProductId = p.ProductId

-- Complete order report - customer, order, product, seller
select
c.CustomerName,
o.OrderId,
o.OrderDate,
o.OrderStatus,
p.ProductName,
s.SellerName,
oi.Quantity,
oi.UnitPrice,
(oi.Quantity * oi.UnitPrice) as TotalAmount
from Customer c
inner join Orders o on c.CustomerId = o.CustomerId
inner join OrderItem oi on o.OrderId = oi.OrderId
inner join Product p on oi.ProductId = p.ProductId
inner join Seller s on p.SellerId = s.SellerId

-- All customers and their orders - LEFT JOIN
select c.CustomerId, c.CustomerName, o.OrderId, o.OrderStatus
from Customer c
left join Orders o on c.CustomerId = o.CustomerId

-- All orders and customers - RIGHT JOIN
select o.OrderId, o.OrderStatus, c.CustomerId, c.CustomerName
from Orders o
right join Customer c on o.CustomerId = c.CustomerId

-- All customers and all orders - FULL OUTER JOIN
select c.CustomerName, o.OrderId
from Customer c
full outer join Orders o on c.CustomerId = o.CustomerId

-- All combinations of customers and products - CROSS JOIN
select c.CustomerName, p.ProductName
from Customer c
cross join Product p

-- Customers who have NOT placed any order
select c.* from Customer c
left join Orders o on c.CustomerId = o.CustomerId
where o.OrderId is null

-- Products that are NOT ordered
select p.* from Product p
left join OrderItem oi on p.ProductId = oi.ProductId
where oi.OrderItemId is null

-- Seller-wise product list
select s.SellerName, p.ProductName, p.Category, p.Price
from Seller s
inner join Product p on s.SellerId = p.SellerId
order by s.SellerName

-- Customer-wise ordered products
select c.CustomerName, o.OrderId, p.ProductName, oi.Quantity, oi.UnitPrice
from Customer c
inner join Orders o on c.CustomerId = o.CustomerId
inner join OrderItem oi on o.OrderId = oi.OrderId
inner join Product p on oi.ProductId = p.ProductId
order by c.CustomerName

-- Order-wise total amount
select o.OrderId, sum(oi.Quantity * oi.UnitPrice) as TotalAmount
from Orders o
inner join OrderItem oi on o.OrderId = oi.OrderId
group by o.OrderId

-- Seller-wise total sales
select s.SellerId, s.SellerName, sum(oi.Quantity * oi.UnitPrice) as TotalSales
from Seller s
inner join Product p on s.SellerId = p.SellerId
inner join OrderItem oi on p.ProductId = oi.ProductId
group by s.SellerId, s.SellerName

-- Product-wise total sales quantity
select p.ProductId, p.ProductName, sum(oi.Quantity) as TotalQuantitySold
from Product p
inner join OrderItem oi on p.ProductId = oi.ProductId
group by p.ProductId, p.ProductName