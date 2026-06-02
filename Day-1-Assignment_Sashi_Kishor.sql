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

select * from Products where ProductName like '%phone%';

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

select Category,max(Price) as Max_Price_By_Category from Products group by Category;

select Category,min(Price) as Min_Price_By_Category from Products group by Category;

select Category,avg(Price) as Avg_Price_By_Category from Products group by Category;

select c.CustomerName,sum(OI.Quantity*OI.UnitPrice) as Total_OrderAmount from Customer c join Orders O on c.CustomerID=O.CustomerID join OrderItem OI on O.OrderID=OI.OrderID group by c.CustomerName;

select p.ProductName,sum(OI.Quantity*OI.UnitPrice) as Total_Sales from Products p join OrderItem OI on p.ProductID=OI.ProductID group by p.ProductName;

select p.ProductName,sum(OI.Quantity) as Total_Quantity_Sold from Products p join OrderItem OI on p.ProductID=OI.ProductID group by p.ProductName;

select Category, COUNT(*) as ProductCount from Products group by Category having count(*) > 1;

select c.CustomerName,sum(OI.Quantity*OI.UnitPrice) as Total_OrderAmount from Customer c join Orders O on c.CustomerID=O.CustomerID join OrderItem OI on O.OrderID=OI.OrderID group by c.CustomerName having (OI.Quantity*OI.UnitPrice)>500000;

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


--basic subquery questions
insert into Customer (CustomerName, Email, MobileNo, City, Address) values
('poki', 'poki@gmail.com', 9876543219, 'Chennai', '123 Main St');

insert into Seller (SellerName, Email, MobileNo, City, Rating) values
('poki', 'poki@gmail.com', 9876543219, 'Chennai', 4.5);

select * from Products where Price>(select avg(Price) from Products);

select * from Products where StockQuantity <(select avg(StockQuantity) from Products);

select * from Customer c left join Orders o on c.CustomerID=o.CustomerID where OrderID in (select OrderID from Orders);

select * from Customer c left join Orders o on c.CustomerID=o.CustomerID where c.CustomerID not in (select CustomerID from Orders);

select * from Products p left join OrderItem OI on p.ProductID=OI.ProductID where p.ProductID in (select ProductID from OrderItem);

select * from Products p left join OrderItem OI on p.ProductID=OI.ProductID where p.ProductID not in(select ProductID from OrderItem);

select * from Seller s left join Products p on s.SellerID=p.SellerID where s.SellerID in (select SellerID from Products);

select * from Seller s left join Products p on s.SellerID=p.SellerID where s.SellerID not in (select SellerID from Products);

select * from Orders o  left join Customer c on o.CustomerID=c.CustomerID where c.CustomerID in (select CustomerID from Customer where City in ('Chennai'));

select * from Products p left join seller s on p.SellerID=s.SellerID where s.City in (select City from seller where City in ('Bangalore'));

--Subquery with IN / NOT IN

select * from Customer c left join Orders o on c.CustomerID=o.CustomerID where o.CustomerID in (select CustomerID from Orders);

select * from Customer c left join Orders o on c.CustomerID=o.CustomerID where c.CustomerID not in (select CustomerID from Orders);

select * from Seller s left join Products p on s.SellerID=p.SellerID where s.SellerID in (select SellerID from Products);

select * from Seller s left join Products p on s.SellerID=p.SellerID where s.SellerID not in (select SellerID from Products);

insert into Products (ProductName, Category, Price, StockQuantity, SellerID) values
('Mobile', 'Mobile', 15000.00, 20, 1);

insert into OrderItem (OrderID, ProductID, Quantity, UnitPrice) values
(1, 11, 2, 15000.00);

select * from Orders o left join OrderItem OI on o.OrderID=OI.OrderID join Products p on OI.ProductID=p.ProductID where p.Category in (select Category from Products where Category in('Mobile'));

select * from Orders o left join OrderItem OI on o.OrderID=OI.OrderID join Products p on OI.ProductID=p.ProductID where p.Category not in (select Category from Products where Category in('Laptop'));

--Subquery with Aggregate Functions

select * from Products where Price = (select max(Price) from Products );

select * from Products where Price = (select min(Price) from Products );

select * from Products where Price > (select avg(Price) from Products );

select * from Products where Price < (select avg(Price) from Products );

select *from Customer c left join (select o.CustomerID,sum(OI.Quantity*OI.UnitPrice) as Total 
from Orders o join OrderItem OI on o.OrderID=OI.OrderID group by o.CustomerID) v 
on c.CustomerID=v.CustomerID 
where Total>(select avg(Total) 
from (select sum(OI.Quantity*OI.UnitPrice) as Total from Orders o join OrderItem OI on o.OrderID=OI.OrderID group by o.CustomerID) t);

select * from Seller s left join
(select p.SellerID,sum(OI.Quantity*OI.UnitPrice) as Total from Products p join OrderItem OI on p.ProductID=OI.ProductID group by p.SellerID) v
on v.SellerID=s.SellerID
where v.Total>50000;

select * from Products p left join (select OI.ProductID,sum(Quantity) as sold_quantity from OrderItem OI group by OI.ProductID) Q 
on p.ProductID=Q.ProductID
where Q.sold_quantity>(select avg(sold_quantity) from (select OI.ProductID,sum(Quantity) as sold_quantity from OrderItem OI group by OI.ProductID) t);

select *from Customer c left join (select o.CustomerID,sum(OI.Quantity*OI.UnitPrice) as Total 
from Orders o join OrderItem OI on o.OrderID=OI.OrderID group by o.CustomerID) v 
on c.CustomerID=v.CustomerID 
where Total=(select max(Total) 
from (select sum(OI.Quantity*OI.UnitPrice) as Total from Orders o join OrderItem OI on o.OrderID=OI.OrderID group by o.CustomerID) t);

select * from Products p left join (select OI.ProductID,sum(Quantity*UnitPrice) as sold_quantity from OrderItem OI group by OI.ProductID) Q 
on p.ProductID=Q.ProductID
where Q.sold_quantity=(select max(sold_quantity) from (select sum(Quantity*UnitPrice) as sold_quantity from OrderItem OI group by OI.ProductID) t);

select * from Seller s left join
(select p.SellerID,sum(OI.Quantity*OI.UnitPrice) as Total from Products p join OrderItem OI on p.ProductID=OI.ProductID group by p.SellerID) v
on v.SellerID=s.SellerID
where v.Total=(select max(Total) from(select sum(OI.Quantity*OI.UnitPrice) as Total from Products p join OrderItem OI on p.ProductID=OI.ProductID group by p.SellerID)t);

--Correlated Subquery Questions

select * from Products p where Price > (select avg(Price) from Products where Category=p.Category);

select * from Products p where Price < (select avg(Price) from Products where Category=p.Category);

select * from Seller s join (select p.SellerID,COUNT(*) as total_products from Products p group by p.SellerID) b
on s.SellerID=b.SellerID
where b.total_products>2;

select * from Customer c join (select o.CustomerID,count(*) as total_orders from Orders o group by o.CustomerID ) ol
on c.CustomerID=ol.CustomerID where ol.total_orders>2;

insert into Orders (CustomerID, OrderDate, OrderStatus, PaymentMode, DeliveryCity) values
(1, '2024-01-06', 'Pending', 'Credit Card', 'Chennai');

select * from Orders o join (select OI.OrderID,sum(OI.Quantity*OI.UnitPrice) as total from OrderItem OI group by OI.OrderID) t
on o.OrderID=t.OrderID
where t.total>(select avg(total) from (select OI.OrderID,sum(OI.Quantity*OI.UnitPrice) as total from OrderItem OI group by OI.OrderID) s);

select * from Products p where StockQuantity>(select avg(StockQuantity) from Products where Category=p.Category);

select * from Seller s join(select SellerID,AVG(Price) as avg_price_per_seller from Products group by SellerID) t
on s.SellerID=t.SellerID
where t.avg_price_per_seller>(select avg(Price) from Products);

--EXISTS / NOT EXISTS Questions
select * from Customer c where exists (select * from Orders o where o.CustomerID=c.CustomerID);

select * from Customer c where not exists (select * from orders o where o.CustomerID=c.CustomerID);

select * from Products p where exists (select * from OrderItem OI where OI.ProductID=p.ProductID);

select * from Products p where not exists (select * from OrderItem OI where OI.ProductID=p.ProductID);

select * from Seller s where exists(select 1 from products p where s.SellerID=p.SellerID);

select * from Seller s where not exists(select 1 from products p where s.SellerID=p.SellerID);

select * from Customer c join Orders o on C.CustomerID=o.CustomerID join OrderItem OI on O.OrderID=OI.OrderID where exists(select 1 from Products p where p.ProductID=OI.ProductID and p.Category='Mobile');

select * from Customer c join Orders o on C.CustomerID=o.CustomerID join OrderItem OI on O.OrderID=OI.OrderID where not exists(select 1 from Products p where p.ProductID=OI.ProductID and p.Category='Laptop');

--Stored Procedure Assignment Questions

--Basic Stored Procedure Questions

create procedure GetProducts
as 
begin
	 select * from Products;
end;

create procedure GetCustomer
as
begin
	select * from Customer;
end;

create procedure GetOrders
as
begin
	select * from Orders;
end;

create procedure GetSeller
as
begin
	select * from Seller;
end;

create procedure GetOrderItems
as 
Begin
	select * from OrderItem;
end;

--Stored Procedure with Input Parameter

create procedure GetCustomerByID
@customerId int
as
Begin
	select*from Customer where CustomerID=@customerId;
end

exec GetCustomerByID 1;

create procedure GetProductByID
@ProductId int
as
begin 
	select* from Products where ProductID=@ProductId;
end;

create procedure GetSellerByID
@SellerId int
as
begin
	Select* from Seller where SellerID=@SellerId;
end;

create procedure GetOrdersByID
@OrderID int
as
begin
	select*from Orders where OrderID=@OrderID;
end;

create procedure GetCustomerByCity
@City varchar(20)
as
Begin
 Select* from Customer where City=@City;
end;


create procedure GetProductByCategory
@Category varchar(20)
as
begin 
	Select * from Products where Category=@Category;
end;

create procedure GetProductBySellerId
@SellerId int 
as
begin
	select*from Products where SellerID=@SellerId;
end;

create procedure GetOrdersByCustomerId
@CustomerId int
as
begin
	Select*from Orders where CustomerID=@CustomerId;
end;

create procedure GetOrderItemByOrderId
@OrderId int
as
begin
	select*from OrderItem where OrderID=@OrderId;
end;

create procedure GetProductHigherThanGiven
@Price int
as
begin
	Select*from Products where Price>@Price;
end;

create procedure AddCustomers
@CustomerName varchar(50),
@Email varchar(50),
@MobileNo bigint,
@City varchar(20),
@Address varchar(max)
as
begin
 insert into Customer(CustomerName,Email,MobileNo,City,Address)
 values(@CustomerName,@Email,@MobileNo,@City,@Address);
end;

create procedure AddSeller
@SellerName varchar(50),
@Email varchar(50),
@MobileNo bigint,
@City varchar(20),
@Rating decimal(3,2)=0.00
as
begin
	insert into Seller(SellerName,Email,MobileNo,City,Rating)
	values(@SellerName,@Email,@MobileNo,@City,@Rating);
end;

create procedure AddProducts
@ProductName varchar(50),
@Category varchar(250),
@Price decimal(10,2),
@StockQuantity int,
@SellerID int
as
begin
	insert into Products(ProductName,Category,Price,StockQuantity,SellerID)
	values(@ProductName,@Category,@Price,@StockQuantity,@SellerID);
end;

create procedure AddOrders
@CustomerID int,
@OrderStatus varchar(20),
@PaymentMode varchar(20),
@DeliveryCity varchar(20)
as
begin
 insert into Orders(CustomerID,OrderStatus,PaymentMode,DeliveryCity)
 values(@CustomerID,@OrderStatus,@PaymentMode,@DeliveryCity);
end;

create procedure AddOrderItems
@OrderID int,
@ProductID int,
@Quantity int,
@UnitPrice decimal(10,2)
as
begin
	insert into OrderItem(OrderID,ProductID,Quantity,UnitPrice)
	values(@OrderID,@ProductID,@Quantity,@UnitPrice);
end;

create procedure UpdateCityById
@City varchar(20),
@CustomerID int
as
begin
	update Customer set City=@City where CustomerID=@CustomerID;
end;

create procedure UpdateCustomerNumberByID
@Number bigint,
@customerId int
as
begin
 update Customer set MobileNo=@Number where CustomerID=@customerId;
end;

create procedure UpdateProductPriceByID
@Id int,
@price int
as
begin
	update Products set Price=@price where ProductID=@Id;
end;

create procedure UpdateQuantityByID
@Id int,
@Quantity int
as
begin
 update Products set StockQuantity=@Quantity where ProductID=@Id;
end;

create procedure UpdateOrderStatusByID
@Id int,
@Status  varchar(20)='Pending'
as
begin
	update Orders set OrderStatus=@Status where OrderID=@Id;
end;

create procedure UpdateSellerRatingByID
@Id int,
@Rating decimal(3,2)=0.00
as
begin
 update Seller set Rating=@Rating where SellerID=@Id;
end;

create procedure UpdateActiveStatusCustomer
@Id int,
@ActiveStatus bit=1
as
begin
	update Customer set IsActive=@ActiveStatus where CustomerID=@Id;
end;

create procedure UpdateActiveStatusSeller
@Id int,
@ActiveStatus bit=1
as
begin
 update Seller set IsActive=@ActiveStatus where SellerID=@Id;
end;

create procedure DeleteCustomerByID
@ID int
as
begin
	delete from Customer where CustomerID=@ID;
end;

create procedure DeleteSellerByID
@ID int
as
Begin
 delete from Seller where SellerID=@ID;
end;

create Procedure DeleteProductByID
@ID int
as
begin
 delete from Products where ProductID=@ID;
end;

create Procedure DeleteOrderByID
@ID int
as
begin
 Delete from Orders where OrderID=@ID;
end;

create procedure DeleteOrderItemByID
@ID int 
as
begin
 delete from OrderItem where OrderItemID=@ID;
end;

create procedure GetCustomerOrders
as
begin
 select*from Customer c full join Orders o on c.CustomerID=o.CustomerID;
end;

execute GetCustomerOrders;

create procedure GetSellerProducts
as
begin
 Select*from Seller s full join Products p on s.SellerID=p.SellerID;
end;

create procedure GetOrdersProduct
as
begin
 select*from OrderItem o full join Products p on o.ProductID=p.ProductID;
end;

create procedure TotalReport
as
begin 
 SELECT o.OrderID,c.CustomerID,c.CustomerName,s.SellerID,s.SellerName,p.ProductID,p.ProductName,OI.Quantity,OI.UnitPrice,
 (OI.Quantity * OI.UnitPrice) AS TotalAmount,o.OrderStatus,o.DeliveryCity FROM Orders o inner join Customer c on o.CustomerID = c.CustomerID inner join OrderItem OI 
 on o.OrderID = oi.OrderID inner join Products p on oi.ProductID = p.ProductID inner join Seller s on p.SellerID = s.SellerID ORDER BY o.OrderID;
end

create procedure CustomerTotalAmount
as
begin 
 select c.CustomerID,c.CustomerName,Sum(OI.Quantity*OI.UnitPrice) as totalamount from Customer c full join
 Orders o on c.CustomerID=o.CustomerID  join 
 OrderItem OI on OI.OrderID=o.OrderID  join
 Products p on p.ProductID=OI.ProductID  join
 Seller s on p.SellerID=s.SellerID
 group by c.CustomerID,c.CustomerName
 order by c.CustomerID
end

create procedure SellerTotalSales
as
begin
 select s.SellerID,s.SellerName,sum(OI.Quantity*OI.UnitPrice) as TotalSales from Seller s full join
 Products p on p.SellerID=s.SellerID
 left join OrderItem OI
 on p.ProductID=OI.ProductID
 group by s.SellerID,s.SellerName
 order by s.SellerID;
end;

create procedure ProductSales
as
begin
 select*from Products p join (select OI.ProductID,sum(Quantity) as TotalQuanitySold from OrderItem OI group by OI.ProductID) t
 on p.ProductID=t.ProductID;
end;

--Stored Procedure with Output Parameter

create procedure TotalCustomer
@Total int output
as
begin 
 select @Total=COUNT(*)from Customer;
end;

create procedure TotalProducts
@total int output
as
begin
 select @total=count(*)from Products;
end;

create procedure TotalOrders
@total int out
as
begin
 select @total=COUNT(*) from Orders;
end;

create procedure TotalSalesOfProductByID
@ID int,
@Total decimal(10,2) out
as
begin
 select @total=ISnull(sum(Quantity*UnitPrice),0.00)from OrderItem where ProductID=@ID;
end;

create procedure TotalCustomerSpent
@ID int,
@Total decimal(10,2) out
as
begin
 select @Total=isnull(sum(oi.Quantity*oi.UnitPrice),0.00) from Customer c join Orders o on c.CustomerID=o.CustomerID join OrderItem oi on o.OrderID=oi.OrderID where c.CustomerID=@ID; 
end;
