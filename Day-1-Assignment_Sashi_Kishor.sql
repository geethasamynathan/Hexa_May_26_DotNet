create database ECOMMERCE_ASSIGNMENT_DB;

use ECOMMERCE_ASSIGNMENT_DB;

create table Customer (
	CustomerID int primary key identity(1,1),
	CustomerName varchar(50) not null,
	Email varchar(50) not null unique,
	MobileNo bigint not null ,
	City varchar(20),
	Address varchar(250),
	IsActive bit default 1,
	CreatedDate datetime default getdate()
);


create table Seller (
	SellerID int primary key identity(1,1),
	SellerName varchar(50) not null,
	Email varchar(50) not null unique,
	MobileNo bigint not null ,
	City varchar(20),
	Rating decimal(3,2) default 0.00,
	IsActive bit default 1
);

create table Products (
	ProductID int primary key identity(1,1),
	ProductName varchar(50) not null,
	Category varchar(250),
	Price decimal(10,2) check(Price > 0) not null,
	StockQuantity int check(StockQuantity>=0) not null,
	SellerID int foreign key references Seller(SellerID),
	CreatedDate datetime default getdate()
);

create table Orders (
	OrderID int primary key identity(1,1),
	CustomerID int foreign key references Customer(CustomerID),
	OrderDate datetime default getdate(),
	OrderStatus varchar(20) default 'Pending',
	PaymentMode varchar(20),
	DeliveryCity varchar(20)
);

create table OrderItem (
	OrderItemID int primary key identity(1,1),
	OrderID int foreign key references Orders(OrderID),
	ProductID int foreign key references Products(ProductID),
	Quantity int check(Quantity>0) not null,
	UnitPrice decimal(10,2) not null
);

insert into Customer (CustomerName, Email, MobileNo, City, Address) values
('Michel', 'michel@gmail.com', 9876543210, 'Chennai', '123 Main St'),
('Madana', 'madan@gmail.com', 9876543211, 'Bangalore', '456 Park Ave'),
('kamaraj', 'raj@gmail.com', 9876543212, 'Hyderabad', '789 Oak St'),
('Kumar', 'kumar@gmail.com', 9876543213, 'Chennai', '321 Elm St'),
('Arun', 'arun@gmail.com', 9876543214, 'Bangalore', '654 Pine St');


insert into Seller (SellerName, Email, MobileNo, City, Rating) values
('rasa', 'rasa@gmail.com', 9876543215, 'Chennai', 4.5),
('kannu', 'kannu@gmail.com', 9876543216, 'Bangalore', 4.0),
('sundaresh', 'sundar@gmail.com', 9876543217, 'Hyderabad', 4.8),
('kamal', 'kamal@gmail.com', 9876543218, 'Chennai', 4.2);

insert into Products (ProductName, Category, Price, StockQuantity, SellerID) values
('Laptop', 'Electronics', 50000.00, 10, 1),
('Smartphone', 'Electronics', 20000.00, 20, 2),
('Headphones', 'Electronics', 3000.00, 15, 3),
('Camera', 'Electronics', 15000.00, 5, 4),
('Book', 'Books', 500.00, 50, 1),
('Table', 'Furniture', 2000.00, 10, 2),
('Chair', 'Furniture', 1000.00, 20, 3),
('Sofa', 'Furniture', 10000.00, 5, 4);

insert into Orders (CustomerID, OrderDate, OrderStatus, PaymentMode, DeliveryCity) values
(1, '2024-01-01', 'Pending', 'Credit Card', 'Chennai'),
(2, '2024-01-02', 'Shipped', 'Debit Card', 'Bangalore'),
(3, '2024-01-03', 'Delivered', 'Cash on Delivery', 'Hyderabad'),
(4, '2024-01-04', 'Cancelled', 'Credit Card', 'Chennai'),
(5, '2024-01-05', 'Pending', 'Debit Card', 'Bangalore');

insert into OrderItem (OrderID, ProductID, Quantity, UnitPrice) values
(1, 1, 1, 50000.00),
(1, 5, 2, 500.00),
(2, 2, 1, 20000.00),
(2, 6, 4, 2000.00),
(3, 3, 2, 3000.00),
(3, 7, 6, 1000.00),
(4, 4, 1, 15000.00),
(4, 8, 1, 10000.00),
(5, 1, 1, 50000.00),
(5, 5, 3, 500.00);

insert into Products (ProductName, Category, Price, StockQuantity, SellerID) values
('Laptop', 'Electronics', 50000.00, 10, 1);


update Customer set city='Coimbatore' where CustomerID=1;

update Products set Price=55000.00 where ProductID=1;

update Orders set OrderStatus='Shipped' where OrderID=1;

DELETE FROM Products
WHERE ProductId NOT IN
(SELECT ProductId FROM OrderItem);

select * from Customer;
select * from Seller;
select * from Products;
select * from Orders;
select * from OrderItem;

select * from Customer where City='Chennai';

select * from Customer where City not in('Chennai');

select* from Products where Price > 50000;

select * from Products where Price between 10000 and 60000;

select * from Products where Category in('Mobile','Laptop');

select * from Customer where CustomerName like 'A%';

select * from Customer where Email like '%gmail%';

select * from Products where ProductName like 'phone';

select* from Orders where OrderStatus='Delivered';

select * from Products where StockQuantity<10;

select * from Customer where MobileNo is not null;

select * from Products where Price not between 10000 and 60000;

select * from Customer where City in ('Chennai','Bangalore');

select * from Customer where City='Chennai' and IsActive=1;

select * from Customer where City in ('Hyderabad');

select city,count(*) as Total_Customer_By_City from Customer group by City;

select Category,count(ProductID) as Total_Products_By_Category from Products group by Category;

select Category, sum(StockQuantity) AS Total_Stock_By_Category FROM Products group by Category;

select Category,max(Price) as Max_Price_By_Category,Category from Products group by Category;

select Category,min(Price) as Min_Price_By_Category,Category from Products group by Category;

select Category,avg(Price) as Avg_Price_By_Category,Category from Products group by Category;

select c.CustomerName,sum(OI.Quantity*OI.UnitPrice) as Total_OrderAmount from Customer c join Orders O on c.CustomerID=O.CustomerID join OrderItem OI on O.OrderID=OI.OrderID group by c.CustomerName;

select p.ProductName,sum(OI.Quantity*OI.UnitPrice) as Total_Sales from Products p join OrderItem OI on p.ProductID=OI.ProductID group by p.ProductName;

select p.ProductName,sum(OI.Quantity) as Total_Quantity_Sold from Products p join OrderItem OI on p.ProductID=OI.ProductID group by p.ProductName;

select Category, COUNT(*) as ProductCount from Products group by Category having count(*) > 1;

select c.CustomerName,sum(OI.Quantity*OI.UnitPrice) as Total_OrderAmount from Customer c join Orders O on c.CustomerID=O.CustomerID join OrderItem OI on O.OrderID=OI.OrderID group by c.CustomerName having (OI.Quantity*OI.UnitPrice>50000);

select s.SellerName,count(p.ProductID) from Seller s left join Products p on s.SellerID=p.SellerID group by s.SellerName;

select s.SellerName,sum(OI.Quantity*OI.UnitPrice) as Total_Sales from Seller s join Products p on s.SellerID=p.SellerID join OrderItem OI on p.ProductID=OI.ProductID group by s.SellerName;

select orderstatus,count(*) as Total_Orders from Orders group by orderstatus;

select City,count(*) as Customer_Count from Customer group by City order by Customer_Count;

select * from Products order by Price;

select * from Products order by Price desc;

select * from Customer order by city asc, CustomerName desc;

select * from Orders order by OrderDate desc;

select * from Orders order by OrderStatus asc, OrderDate desc;

select top 3 * from Products order by Price desc;

select top 5 * from Customer order by CreatedDate desc;

select * from Customer order by IsActive,CustomerName;

select * from Customer c inner join Orders o on c.CustomerID=o.CustomerID;

select* from Products p inner join Seller s on p.SellerID=s.SellerID;

select * from Orders o inner join Products p on o.OrderID=p.ProductID;

select * from Customer c join Orders o on C.CustomerID=o.CustomerID join OrderItem OI on o.OrderID=OI.OrderID join Products P on OI.ProductID=P.ProductID;

select * from Customer c left join Orders o on c.CustomerID=o.CustomerID;

select * from Orders o right join Customer c on o.CustomerID=c.CustomerID;

select * from Orders o full outer join Customer c on o.CustomerID=c.CustomerID;

select * from Customer c cross join Orders o;

select * from Customer c left join Orders o on c.CustomerID=o.CustomerID where o.OrderID is null;

select*  from Products p left join OrderItem OI on p.ProductID=OI.ProductID where OI.OrderID is null;

select * from Seller s join Products p on s.SellerID=p.SellerID;

select * from Customer c join Orders o on c.CustomerID=o.CustomerID join OrderItem OI on o.OrderID=OI.OrderID join Products P on OI.ProductID=P.ProductID;

select o.OrderID,sum(OI.Quantity * OI.UnitPrice) as Total_Amount from Orders o join OrderItem OI on o.OrderID=OI.OrderID group by o.OrderID;

select s.sellerName,sum(OI.Quantity * OI.UnitPrice) as Total_Sales from Seller s join Products p on s.SellerID=p.SellerID join OrderItem OI on p.ProductID=OI.ProductID group by s.sellerName;

select p.ProductName,sum(OI.Quantity) as Total_Quantity_Sold from Products p join OrderItem OI on p.ProductID=OI.ProductID group by p.ProductName order by Total_Quantity_Sold desc;