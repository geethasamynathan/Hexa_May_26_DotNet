
-- ECOMMERCE ASSIGNMENT (MSSQL)

-- 1. CREATE DATABASE

CREATE DATABASE ECOMMERCE_ASSIGNMENT_DB;
GO
USE ECOMMERCE_ASSIGNMENT_DB;
GO

-- 2. CREATE TABLES

CREATE TABLE Customer
(
CustomerId INT CONSTRAINT PK_Customer PRIMARY KEY,
CustomerName VARCHAR(60) NOT NULL,
Email VARCHAR(100) CONSTRAINT UQ_Customer_Email UNIQUE NOT NULL,
MobileNo VARCHAR(15) NOT NULL,
City VARCHAR(40) NOT NULL,
Address VARCHAR(150) NOT NULL,
IsActive BIT DEFAULT 1,
CreatedDate DATE DEFAULT GETDATE()
);

CREATE TABLE Seller
(
SellerId INT CONSTRAINT PK_Seller PRIMARY KEY,
SellerName VARCHAR(60) NOT NULL,
Email VARCHAR(100) CONSTRAINT UQ_Seller_Email UNIQUE NOT NULL,
MobileNo VARCHAR(15) NOT NULL,
City VARCHAR(40) NOT NULL,
Rating DECIMAL(3,2) CHECK(Rating BETWEEN 1 AND 5),
IsActive BIT DEFAULT 1
);

CREATE TABLE Product
(
ProductId INT CONSTRAINT PK_Product PRIMARY KEY,
ProductName VARCHAR(100) NOT NULL,
Category VARCHAR(40) NOT NULL,
Price DECIMAL(10,2) CHECK(Price > 0),
StockQuantity INT CHECK(StockQuantity >= 0),
SellerId INT,
CreatedDate DATE DEFAULT GETDATE(),
CONSTRAINT FK_Product_Seller
FOREIGN KEY (SellerId)
REFERENCES Seller(SellerId)
);

CREATE TABLE Orders
(
OrderId INT CONSTRAINT PK_Orders PRIMARY KEY,
CustomerId INT,
OrderDate DATE DEFAULT GETDATE(),
OrderStatus VARCHAR(20) DEFAULT 'Pending',
PaymentMode VARCHAR(20) NOT NULL,
DeliveryCity VARCHAR(40) NOT NULL,
CONSTRAINT FK_Orders_Customer
FOREIGN KEY(CustomerId)
REFERENCES Customer(CustomerId)
);

CREATE TABLE OrderItem
(
OrderItemId INT CONSTRAINT PK_OrderItem PRIMARY KEY,
OrderId INT,
ProductId INT,
Quantity INT CHECK(Quantity > 0),
UnitPrice DECIMAL(10,2) NOT NULL,
CONSTRAINT FK_OrderItem_Order
FOREIGN KEY(OrderId)
REFERENCES Orders(OrderId),

CONSTRAINT FK_OrderItem_Product
FOREIGN KEY(ProductId)
REFERENCES Product(ProductId)
);

-- 3. INSERT RECORDS

INSERT INTO Customer
(CustomerId,CustomerName,Email,MobileNo,City,Address,IsActive)
VALUES
(201,'Arjun','arjun@gmail.com','9876543210','Coimbatore','RS Puram',1),
(202,'Karthik','karthik@gmail.com','9876543211','Chennai','T Nagar',1),
(203,'Meena','meena@yahoo.com','9876543212','Salem','Five Roads',1),
(204,'Priya','priya@gmail.com','9876543213','Madurai','KK Nagar',0),
(205,'Suresh','suresh@hotmail.com','9876543214','Trichy','Cantonment',1);

INSERT INTO Seller
(SellerId,SellerName,Email,MobileNo,City,Rating,IsActive)
VALUES
(11,'Digital Hub','digitalhub@gmail.com','9000011111','Chennai',4.6,1),
(12,'Smart Electronics','smart@gmail.com','9000011112','Coimbatore',4.4,1),
(13,'Laptop Point','laptoppoint@gmail.com','9000011113','Bangalore',4.8,1),
(14,'City Mart','citymart@gmail.com','9000011114','Madurai',4.2,1);

INSERT INTO Product
(ProductId,ProductName,Category,Price,StockQuantity,SellerId)
VALUES
(601,'Samsung Galaxy','Mobile',32000,20,12),
(602,'Lenovo IdeaPad','Laptop',52000,8,13),
(603,'Bluetooth Headset','Electronics',1800,30,11),
(604,'Wooden Chair','Furniture',2500,15,14),
(605,'OnePlus Nord','Mobile',28000,12,12),
(606,'HP Printer','Electronics',7500,6,13),
(607,'Dining Table','Furniture',12000,4,14),
(608,'Travel Bag','Accessories',1500,25,11);

INSERT INTO Orders
(OrderId,CustomerId,OrderDate,OrderStatus,PaymentMode,DeliveryCity)
VALUES
(3001,201,'2026-05-01','Delivered','UPI','Coimbatore'),
(3002,202,'2026-05-03','Pending','Card','Chennai'),
(3003,203,'2026-05-05','Delivered','Cash','Salem'),
(3004,205,'2026-05-07','Pending','UPI','Trichy'),
(3005,201,'2026-05-09','Delivered','Card','Coimbatore');

INSERT INTO OrderItem
(OrderItemId,OrderId,ProductId,Quantity,UnitPrice)
VALUES
(1,3001,601,1,32000),
(2,3001,603,2,1800),
(3,3002,602,1,52000),
(4,3002,606,1,7500),
(5,3003,605,1,28000),
(6,3003,608,2,1500),
(7,3004,607,1,12000),
(8,3004,603,1,1800),
(9,3005,601,1,32000),
(10,3005,604,2,2500);

-- 4. UPDATE & DELETE

UPDATE Customer
SET City='Erode'
WHERE CustomerId=205;

UPDATE Product
SET Price=30000
WHERE ProductId=605;

UPDATE Orders
SET OrderStatus='Delivered'
WHERE OrderId=3002;

DELETE FROM Product
WHERE ProductId=608;

-- 5. DISPLAY ALL RECORDS

SELECT * FROM Customer;
SELECT * FROM Seller;
SELECT * FROM Product;
SELECT * FROM Orders;
SELECT * FROM OrderItem;

-- 6. BASIC FILTER QUERIES

SELECT * FROM Customer WHERE City='Chennai';

SELECT * FROM Customer WHERE City<>'Chennai';

SELECT * FROM Product WHERE Price>50000;

SELECT * FROM Product
WHERE Price BETWEEN 10000 AND 60000;

SELECT * FROM Product
WHERE Category IN ('Mobile','Laptop');

SELECT * FROM Customer
WHERE CustomerName LIKE 'A%';

SELECT * FROM Customer
WHERE Email LIKE '%gmail%';

SELECT * FROM Product
WHERE ProductName LIKE '%Phone%';

SELECT * FROM Orders
WHERE OrderStatus='Delivered';

SELECT * FROM Product
WHERE StockQuantity<10;

SELECT * FROM Customer
WHERE MobileNo IS NOT NULL;

SELECT * FROM Product
WHERE Price NOT BETWEEN 10000 AND 50000;

SELECT * FROM Customer
WHERE City IN ('Chennai','Coimbatore');

SELECT * FROM Customer
WHERE City='Chennai'
AND IsActive=1;
SELECT * FROM Customer
WHERE City<>'Madurai';

-- 7. GROUP BY QUERIES

SELECT City,
COUNT(*) AS TotalCustomers
FROM Customer
GROUP BY City;

SELECT Category,
COUNT(*) AS TotalProducts
FROM Product
GROUP BY Category;


SELECT Category,
SUM(StockQuantity) AS TotalStock
FROM Product
GROUP BY Category;

SELECT Category,
MAX(Price) AS MaximumPrice
FROM Product
GROUP BY Category;

SELECT Category,
MIN(Price) AS MinimumPrice
FROM Product
GROUP BY Category;


SELECT Category,
AVG(Price) AS AveragePrice
FROM Product
GROUP BY Category;

SELECT O.CustomerId,
SUM(OI.Quantity*OI.UnitPrice) AS TotalOrderAmount
FROM Orders O
INNER JOIN OrderItem OI
ON O.OrderId=OI.OrderId
GROUP BY O.CustomerId;

SELECT ProductId,
SUM(Quantity*UnitPrice) AS TotalSales
FROM OrderItem
GROUP BY ProductId;

SELECT ProductId,
SUM(Quantity) AS TotalQuantitySold
FROM OrderItem
GROUP BY ProductId;


SELECT Category,
COUNT(ProductId) AS ProductCount
FROM Product
GROUP BY Category
HAVING COUNT(ProductId)>1;


SELECT O.CustomerId,
SUM(OI.QuantityOI.UnitPrice) AS TotalAmount
FROM Orders O
INNER JOIN OrderItem OI
ON O.OrderId=OI.OrderId
GROUP BY O.CustomerId
HAVING SUM(OI.QuantityOI.UnitPrice)>50000;


SELECT SellerId,
COUNT(ProductId) AS TotalProducts
FROM Product
GROUP BY SellerId;


SELECT P.SellerId,
SUM(OI.Quantity*OI.UnitPrice) AS SellerSales
FROM Product P
JOIN OrderItem OI
ON P.ProductId=OI.ProductId
GROUP BY P.SellerId;

SELECT OrderStatus,
COUNT(*) AS OrderCount
FROM Orders
GROUP BY OrderStatus;


SELECT City,
COUNT(*) AS CustomerCount
FROM Customer
GROUP BY City
ORDER BY CustomerCount DESC;

-- 8. ORDER BY QUERIES

SELECT * FROM Product
ORDER BY Price ASC;


SELECT * FROM Product
ORDER BY Price DESC;


SELECT * FROM Customer
ORDER BY City ASC, CustomerName ASC;


SELECT * FROM Orders
ORDER BY OrderDate DESC;


SELECT * FROM Product
ORDER BY Category ASC, Price DESC;


SELECT TOP(3) *
FROM Product
ORDER BY Price DESC;


SELECT TOP(5) *
FROM Orders
ORDER BY OrderDate DESC;


SELECT *
FROM Customer
ORDER BY IsActive DESC, CustomerName ASC;


-- 9. JOIN QUERIES

SELECT O.*,C.CustomerName,C.Email
FROM Orders O
INNER JOIN Customer C
ON O.CustomerId=C.CustomerId;


SELECT P.*,S.SellerName,S.City
FROM Product P
INNER JOIN Seller S
ON P.SellerId=S.SellerId;


SELECT OI.*,P.ProductName,P.Category
FROM OrderItem OI
INNER JOIN Product P
ON OI.ProductId=P.ProductId;


SELECT
O.OrderId,
C.CustomerName,
O.OrderDate,
P.ProductName,
OI.Quantity,
OI.UnitPrice,
S.SellerName
FROM Orders O
JOIN Customer C
ON O.CustomerId=C.CustomerId
JOIN OrderItem OI
ON O.OrderId=OI.OrderId
JOIN Product P
ON OI.ProductId=P.ProductId
JOIN Seller S
ON P.SellerId=S.SellerId;


SELECT C.CustomerId,
C.CustomerName,
O.OrderId
FROM Customer C
LEFT JOIN Orders O
ON C.CustomerId=O.CustomerId;


SELECT O.OrderId,
O.OrderStatus,
C.CustomerName
FROM Orders O
RIGHT JOIN Customer C
ON O.CustomerId=C.CustomerId;


SELECT C.CustomerName,
O.OrderId
FROM Customer C
FULL OUTER JOIN Orders O
ON C.CustomerId=O.CustomerId;


SELECT C.CustomerName,
P.ProductName
FROM Customer C
CROSS JOIN Product P;


SELECT C.*
FROM Customer C
LEFT JOIN Orders O
ON C.CustomerId=O.CustomerId
WHERE O.OrderId IS NULL;


SELECT P.*
FROM Product P
LEFT JOIN OrderItem OI
ON P.ProductId=OI.ProductId
WHERE OI.OrderItemId IS NULL;


SELECT S.SellerName,
P.ProductName,
P.Price
FROM Seller S
LEFT JOIN Product P
ON S.SellerId=P.SellerId;


SELECT C.CustomerName,
P.ProductName
FROM Customer C
JOIN Orders O
ON C.CustomerId=O.CustomerId
JOIN OrderItem OI
ON O.OrderId=OI.OrderId
JOIN Product P
ON OI.ProductId=P.ProductId;


SELECT OrderId,
SUM(Quantity*UnitPrice) AS TotalAmount
FROM OrderItem
GROUP BY OrderId;



SELECT S.SellerName,
SUM(OI.Quantity*OI.UnitPrice) AS TotalSales
FROM Seller S
JOIN Product P
ON S.SellerId=P.SellerId
JOIN OrderItem OI
ON P.ProductId=OI.ProductId
GROUP BY S.SellerName;


SELECT P.ProductName,
SUM(OI.Quantity) AS TotalQuantitySold
FROM Product P
JOIN OrderItem OI
ON P.ProductId=OI.ProductId
GROUP BY P.ProductName;

