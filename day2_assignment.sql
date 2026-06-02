--A. Basic Subquery Questions
SELECT * FROM Product WHERE Price > (SELECT AVG(Price) FROM Product);

SELECT * FROM Product WHERE StockQuantity < ( SELECT AVG(StockQuantity) FROM Product );

SELECT * FROM CustomerWHERE CustomerId IN (SELECT CustomerId FROM Orders);

SELECT * FROM Customer WHERE CustomerId NOT IN (SELECT CustomerId FROM Orders);
SELECT *
FROM Product
WHERE ProductId IN
(
    SELECT ProductId
    FROM OrderItem
);
SELECT *
FROM Product
WHERE ProductId NOT IN
(
    SELECT ProductId
    FROM OrderItem
);
SELECT *
FROM Seller
WHERE SellerId IN
(
    SELECT SellerId
    FROM Product
);
SELECT *
FROM Seller
WHERE SellerId NOT IN
(
    SELECT SellerId
    FROM Product
);
SELECT *
FROM Orders
WHERE CustomerId IN
(
    SELECT CustomerId
    FROM Customer
    WHERE City = 'Chennai'
);
SELECT *
FROM Product
WHERE SellerId IN
(
    SELECT SellerId
    FROM Seller
    WHERE City = 'Bangalore'
);

-- B. Subquery with IN / NOT IN

SELECT *
FROM Customer
WHERE CustomerId IN
(
    SELECT CustomerId
    FROM Orders
);
SELECT *
FROM Customer
WHERE CustomerId NOT IN
(
    SELECT CustomerId
    FROM Orders
);
SELECT *
FROM Product
WHERE ProductId IN
(
    SELECT ProductId
    FROM OrderItem
);
SELECT *
FROM Product
WHERE ProductId NOT IN
(
    SELECT ProductId
    FROM OrderItem
);
SELECT *
FROM Seller
WHERE SellerId IN
(
    SELECT SellerId
    FROM Product
);
SELECT *
FROM Seller
WHERE SellerId NOT IN
(
    SELECT SellerId
    FROM Product
);
SELECT *
FROM Orders
WHERE OrderId IN
(
    SELECT DISTINCT OI.OrderId
    FROM OrderItem OI
    WHERE OI.ProductId IN
    (
        SELECT ProductId
        FROM Product
        WHERE Category = 'Mobile'
    )
);
SELECT *
FROM Orders
WHERE OrderId NOT IN
(
    SELECT DISTINCT OI.OrderId
    FROM OrderItem OI
    WHERE OI.ProductId IN
    (
        SELECT ProductId
        FROM Product
        WHERE Category = 'Laptop'
    )
);

--C. Subquery with Aggregate Functions
SELECT *
FROM Product
WHERE Price =
(
    SELECT MAX(Price)
    FROM Product
);

SELECT *
FROM Product
WHERE Price =
(
    SELECT MIN(Price)
    FROM Product
);

SELECT *
FROM Product
WHERE Price >
(
    SELECT AVG(Price)
    FROM Product
);

SELECT *
FROM Product
WHERE Price <
(
    SELECT AVG(Price)
    FROM Product
);

SELECT C.*
FROM Customer C
WHERE C.CustomerId IN
(
    SELECT O.CustomerId
    FROM Orders O
    INNER JOIN OrderItem OI
        ON O.OrderId = OI.OrderId
    GROUP BY O.CustomerId
    HAVING SUM(OI.Quantity * OI.UnitPrice) >
    (
        SELECT AVG(OrderAmount)
        FROM
        (
            SELECT SUM(OI2.Quantity * OI2.UnitPrice) AS OrderAmount
            FROM Orders O2
            INNER JOIN OrderItem OI2
                ON O2.OrderId = OI2.OrderId
            GROUP BY O2.OrderId
        ) A
    )
);

SELECT S.*
FROM Seller S
WHERE S.SellerId IN
(
    SELECT P.SellerId
    FROM Product P
    INNER JOIN OrderItem OI
        ON P.ProductId = OI.ProductId
    GROUP BY P.SellerId
    HAVING SUM(OI.Quantity * OI.UnitPrice) > 50000
);

SELECT P.*
FROM Product P
WHERE P.ProductId IN
(
    SELECT ProductId
    FROM OrderItem
    GROUP BY ProductId
    HAVING SUM(Quantity) >
    (
        SELECT AVG(TotalQty)
        FROM
        (
            SELECT SUM(Quantity) AS TotalQty
            FROM OrderItem
            GROUP BY ProductId
        ) X
    )
);

SELECT C.*
FROM Customer C
WHERE C.CustomerId =
(
    SELECT TOP 1 O.CustomerId
    FROM Orders O
    INNER JOIN OrderItem OI
        ON O.OrderId = OI.OrderId
    GROUP BY O.CustomerId
    ORDER BY SUM(OI.Quantity * OI.UnitPrice) DESC
);

SELECT P.*
FROM Product P
WHERE P.ProductId =
(
    SELECT TOP 1 OI.ProductId
    FROM OrderItem OI
    GROUP BY OI.ProductId
    ORDER BY SUM(OI.Quantity * OI.UnitPrice) DESC
);

SELECT S.*
FROM Seller S
WHERE S.SellerId =
(
    SELECT TOP 1 P.SellerId
    FROM Product P
    INNER JOIN OrderItem OI
        ON P.ProductId = OI.ProductId
    GROUP BY P.SellerId
    ORDER BY SUM(OI.Quantity * OI.UnitPrice) DESC
);

--D. Correlated Subquery Questions

SELECT *
FROM Product P1
WHERE Price >
(
    SELECT AVG(P2.Price)
    FROM Product P2
    WHERE P2.Category = P1.Category
);

SELECT *
FROM Product P1
WHERE Price <
(
    SELECT AVG(P2.Price)
    FROM Product P2
    WHERE P2.Category = P1.Category
);

SELECT *
FROM Seller S
WHERE
(
    SELECT COUNT(*)
    FROM Product P
    WHERE P.SellerId = S.SellerId
) > 2;

SELECT *
FROM Customer C
WHERE
(
    SELECT COUNT(*)
    FROM Orders O
    WHERE O.CustomerId = C.CustomerId
) > 1;

SELECT *
FROM Orders O
WHERE
(
    SELECT SUM(OI.Quantity * OI.UnitPrice)
    FROM OrderItem OI
    WHERE OI.OrderId = O.OrderId
)
>
(
    SELECT AVG(OrderAmount)
    FROM
    (
        SELECT SUM(Quantity * UnitPrice) AS OrderAmount
        FROM OrderItem
        GROUP BY OrderId
    ) X
);

SELECT *
FROM Product P1
WHERE StockQuantity >
(
    SELECT AVG(P2.StockQuantity)
    FROM Product P2
    WHERE P2.Category = P1.Category
);

SELECT *
FROM Seller S
WHERE
(
    SELECT AVG(P.Price)
    FROM Product P
    WHERE P.SellerId = S.SellerId
)
>
(
    SELECT AVG(Price)
    FROM Product
);

-- E. EXISTS / NOT EXISTS Questions

SELECT *
FROM Customer C
WHERE EXISTS
(
    SELECT 1
    FROM Orders O
    WHERE O.CustomerId = C.CustomerId
);

SELECT *
FROM Customer C
WHERE NOT EXISTS
(
    SELECT 1
    FROM Orders O
    WHERE O.CustomerId = C.CustomerId
);

SELECT *
FROM Product P
WHERE EXISTS
(
    SELECT 1
    FROM OrderItem OI
    WHERE OI.ProductId = P.ProductId
);

SELECT *
FROM Product P
WHERE NOT EXISTS
(
    SELECT 1
    FROM OrderItem OI
    WHERE OI.ProductId = P.ProductId
);

SELECT *
FROM Seller S
WHERE EXISTS
(
    SELECT 1
    FROM Product P
    WHERE P.SellerId = S.SellerId
);

SELECT *
FROM Seller S
WHERE NOT EXISTS
(
    SELECT 1
    FROM Product P
    WHERE P.SellerId = S.SellerId
);

SELECT *
FROM Customer C
WHERE EXISTS
(
    SELECT 1
    FROM Orders O
    INNER JOIN OrderItem OI
        ON O.OrderId = OI.OrderId
    INNER JOIN Product P
        ON OI.ProductId = P.ProductId
    WHERE O.CustomerId = C.CustomerId
      AND P.Category = 'Mobile'
);

SELECT *
FROM Customer C
WHERE NOT EXISTS
(
    SELECT 1
    FROM Orders O
    INNER JOIN OrderItem OI
        ON O.OrderId = OI.OrderId
    INNER JOIN Product P
        ON OI.ProductId = P.ProductId
    WHERE O.CustomerId = C.CustomerId
      AND P.Category = 'Laptop'
);



--Part 8: Stored Procedure Assignment Questions
--A. Basic Stored Procedure Questions

CREATE PROCEDURE sp_GetAllCustomers
AS
BEGIN
    SELECT *
    FROM Customer;
END;
GO 
EXEC sp_GetAllCustomers;

CREATE PROCEDURE sp_GetAllProducts
AS
BEGIN
    SELECT *
    FROM Product;
END;
GO
EXEC sp_GetAllProducts;

CREATE PROCEDURE sp_GetAllSellers
AS
BEGIN
    SELECT *
    FROM Seller;
END;
GO
EXEC sp_GetAllSellers;

CREATE PROCEDURE sp_GetAllOrders
AS
BEGIN
    SELECT *
    FROM Orders;
END;
GO
EXEC sp_GetAllOrders;

CREATE PROCEDURE sp_GetAllOrderItems
AS
BEGIN
    SELECT *
    FROM OrderItem;
END;
GO
EXEC sp_GetAllOrderItems;

--B. Stored Procedure with Input Parameter

CREATE PROCEDURE sp_GetCustomerById
    @CustomerId INT
AS
BEGIN
    SELECT *
    FROM Customer
    WHERE CustomerId = @CustomerId;
END;
GO
EXEC sp_GetCustomerById 1;

CREATE PROCEDURE sp_GetProductById
    @ProductId INT
AS
BEGIN
    SELECT *
    FROM Product
    WHERE ProductId = @ProductId;
END;
GO EXEC sp_GetProductById 2;


CREATE PROCEDURE sp_GetSellerById
    @SellerId INT
AS
BEGIN
    SELECT *
    FROM Seller
    WHERE SellerId = @SellerId;
END;
GO
EXEC sp_GetSellerById 1;


CREATE PROCEDURE sp_GetOrderById
    @OrderId INT
AS
BEGIN
    SELECT *
    FROM Orders
    WHERE OrderId = @OrderId;
END;
GO EXEC sp_GetOrderById 3;


CREATE PROCEDURE sp_GetCustomersByCity
    @City VARCHAR(50)
AS
BEGIN
    SELECT *
    FROM Customer
    WHERE City = @City;
END;
GO EXEC sp_GetCustomersByCity 'Chennai';

CREATE PROCEDURE sp_GetProductsByCategory
    @Category VARCHAR(50)
AS
BEGIN
    SELECT *
    FROM Product
    WHERE Category = @Category;
END;
GO EXEC sp_GetProductsByCategory 'Mobile';
12) CREATE PROCEDURE sp_GetProductsBySellerId
    @SellerId INT
AS
BEGIN
    SELECT *
    FROM Product
    WHERE SellerId = @SellerId;
END;
GO EXEC sp_GetProductsBySellerId 1;
13) CREATE PROCEDURE sp_GetOrdersByCustomerId
    @CustomerId INT
AS
BEGIN
    SELECT *
    FROM Orders
    WHERE CustomerId = @CustomerId;
END;
GO EXEC sp_GetOrdersByCustomerId 2;
14) CREATE PROCEDURE sp_GetOrderItemsByOrderId
    @OrderId INT
AS
BEGIN
    SELECT *
    FROM OrderItem
    WHERE OrderId = @OrderId;
END;
GO EXEC sp_GetOrderItemsByOrderId 1;
15) CREATE PROCEDURE sp_GetProductsGreaterThanPrice
    @Price DECIMAL(12,2)
AS
BEGIN
    SELECT *
    FROM Product
    WHERE Price > @Price;
END;
GO EXEC sp_GetProductsGreaterThanPrice 50000;
C. Insert Stored Procedure Questions
16) CREATE PROCEDURE sp_InsertCustomer
    @CustomerName VARCHAR(100),
    @Email VARCHAR(100),
    @MobileNo VARCHAR(15),
    @City VARCHAR(50),
    @Address VARCHAR(255)
AS
BEGIN
    INSERT INTO Customer
    (
        CustomerName,
        Email,
        MobileNo,
        City,
        Address
    )
    VALUES
    (
        @CustomerName,
        @Email,
        @MobileNo,
        @City,
        @Address
    );
END;
GO 
EXEC sp_InsertCustomer
    'Ramesh Kumar',
    'ramesh@gmail.com',
    '9876543299',
    'Chennai',
    'T Nagar';
17) CREATE PROCEDURE sp_InsertSeller
    @SellerName VARCHAR(100),
    @Email VARCHAR(100),
    @MobileNo VARCHAR(15),
    @City VARCHAR(50),
    @Rating DECIMAL(3,2)
AS
BEGIN
    INSERT INTO Seller
    (
        SellerName,
        Email,
        MobileNo,
        City,
        Rating
    )
    VALUES
    (
        @SellerName,
        @Email,
        @MobileNo,
        @City,
        @Rating
    );
END;
GO
EXEC sp_InsertSeller
    'Smart Electronics',
    'smart@gmail.com',
    '9000000010',
    'Bangalore',
    4.5;
18) CREATE PROCEDURE sp_InsertProduct
    @ProductName VARCHAR(100),
    @Category VARCHAR(50),
    @Price DECIMAL(12,2),
    @StockQuantity INT,
    @SellerId INT
AS
BEGIN
    INSERT INTO Product
    (
        ProductName,
        Category,
        Price,
        StockQuantity,
        SellerId
    )
    VALUES
    (
        @ProductName,
        @Category,
        @Price,
        @StockQuantity,
        @SellerId
    );
END;
GO
EXEC sp_InsertProduct
    'Samsung Galaxy S24',
    'Mobile',
    75000,
    20,
    1;
19) CREATE PROCEDURE sp_InsertOrder
    @CustomerId INT,
    @PaymentMode VARCHAR(30),
    @DeliveryCity VARCHAR(50)
AS
BEGIN
    INSERT INTO Orders
    (
        CustomerId,
        PaymentMode,
        DeliveryCity
    )
    VALUES
    (
        @CustomerId,
        @PaymentMode,
        @DeliveryCity
    );
END;
GO
EXEC sp_InsertOrder
    1,
    'UPI',
    'Chennai';
20) CREATE PROCEDURE sp_InsertOrderItem
    @OrderId INT,
    @ProductId INT,
    @Quantity INT,
    @UnitPrice DECIMAL(12,2)
AS
BEGIN
    INSERT INTO OrderItem
    (
        OrderId,
        ProductId,
        Quantity,
        UnitPrice
    )
    VALUES
    (
        @OrderId,
        @ProductId,
        @Quantity,
        @UnitPrice
    );
END;
GO
EXEC sp_InsertOrderItem
    1,
    2,
    3,
    25000;
D. Update Stored Procedure Questions
21) CREATE PROCEDURE sp_UpdateCustomerCity
    @CustomerId INT,
    @City VARCHAR(50)
AS
BEGIN
    UPDATE Customer
    SET City = @City
    WHERE CustomerId = @CustomerId;
END;
GO
EXEC sp_UpdateCustomerCity 1, 'Bangalore';
22) CREATE PROCEDURE sp_UpdateCustomerMobile
    @CustomerId INT,
    @MobileNo VARCHAR(15)
AS
BEGIN
    UPDATE Customer
    SET MobileNo = @MobileNo
    WHERE CustomerId = @CustomerId;
END;
GO
EXEC sp_UpdateCustomerMobile 2, '9998887776';
23) CREATE PROCEDURE sp_UpdateProductPrice
    @ProductId INT,
    @Price DECIMAL(12,2)
AS
BEGIN
    UPDATE Product
    SET Price = @Price
    WHERE ProductId = @ProductId;
END;
GO
EXEC sp_UpdateProductPrice 3, 65000;
CREATE PROCEDURE sp_UpdateProductStock
    @ProductId INT,
    @StockQuantity INT
AS
BEGIN
    UPDATE Product
    SET StockQuantity = @StockQuantity
    WHERE ProductId = @ProductId;
END;
GO
EXEC sp_UpdateProductStock 2, 50;
25)CREATE PROCEDURE sp_UpdateOrderStatus
    @OrderId INT,
    @OrderStatus VARCHAR(30)
AS
BEGIN
    UPDATE Orders
    SET OrderStatus = @OrderStatus
    WHERE OrderId = @OrderId;
END;
GO EXEC sp_UpdateOrderStatus 1, 'Delivered';
26) CREATE PROCEDURE sp_UpdateSellerRating
    @SellerId INT,
    @Rating DECIMAL(3,2)
AS
BEGIN
    UPDATE Seller
    SET Rating = @Rating
    WHERE SellerId = @SellerId;
END;
GO EXEC sp_UpdateSellerRating 2, 4.8;
27) CREATE PROCEDURE sp_UpdateCustomerStatus
    @CustomerId INT,
    @IsActive BIT
AS
BEGIN
    UPDATE Customer
    SET IsActive = @IsActive
    WHERE CustomerId = @CustomerId;
END;
GO EXEC sp_UpdateCustomerStatus 3, 0;
28) CREATE PROCEDURE sp_UpdateSellerStatus
    @SellerId INT,
    @IsActive BIT
AS
BEGIN
    UPDATE Seller
    SET IsActive = @IsActive
    WHERE SellerId = @SellerId;
END;
GO EXEC sp_UpdateSellerStatus 4, 0;
E. Delete Stored Procedure Questions
29) CREATE PROCEDURE sp_DeleteCustomer
    @CustomerId INT
AS
BEGIN
    DELETE FROM Customer
    WHERE CustomerId = @CustomerId;
END;
GO EXEC sp_DeleteCustomer 5;
30) CREATE PROCEDURE sp_DeleteSeller
    @SellerId INT
AS
BEGIN
    DELETE FROM Seller
    WHERE SellerId = @SellerId;
END;
GO EXEC sp_DeleteSeller 4;
31) CREATE PROCEDURE sp_DeleteProduct
    @ProductId INT
AS
BEGIN
    DELETE FROM Product
    WHERE ProductId = @ProductId;
END;
GO EXEC sp_DeleteProduct 8;
32) CREATE PROCEDURE sp_DeleteOrder
    @OrderId INT
AS
BEGIN
    DELETE FROM Orders
    WHERE OrderId = @OrderId;
END;
GO EXEC sp_DeleteOrder 5;
33) CREATE PROCEDURE sp_DeleteOrderItem
    @OrderItemId INT
AS
BEGIN
    DELETE FROM OrderItem
    WHERE OrderItemId = @OrderItemId;
END;
GO EXEC sp_DeleteOrderItem 10;
F. Stored Procedure with Joins
34) CREATE PROCEDURE sp_CustomerWiseOrderDetails
AS
BEGIN
    SELECT
        C.CustomerId,
        C.CustomerName,
        O.OrderId,
        O.OrderDate,
        O.OrderStatus,
        O.PaymentMode
    FROM Customer C
    INNER JOIN Orders O
        ON C.CustomerId = O.CustomerId;
END;
GO EXEC sp_CustomerWiseOrderDetails;
35) CREATE PROCEDURE sp_SellerWiseProductDetails
AS
BEGIN
    SELECT
        S.SellerId,
        S.SellerName,
        P.ProductId,
        P.ProductName,
        P.Category,
        P.Price,
        P.StockQuantity
    FROM Seller S
    INNER JOIN Product P
        ON S.SellerId = P.SellerId;
END;
GO EXEC sp_SellerWiseProductDetails;
36) CREATE PROCEDURE sp_OrderWiseProductDetails
AS
BEGIN
    SELECT
        O.OrderId,
        P.ProductId,
        P.ProductName,
        OI.Quantity,
        OI.UnitPrice
    FROM Orders O
    INNER JOIN OrderItem OI
        ON O.OrderId = OI.OrderId
    INNER JOIN Product P
        ON OI.ProductId = P.ProductId;
END;
GO EXEC sp_OrderWiseProductDetails;
37) CREATE PROCEDURE sp_CompleteOrderReport
AS
BEGIN
    SELECT
        C.CustomerName,
        O.OrderId,
        O.OrderDate,
        P.ProductName,
        S.SellerName,
        OI.Quantity,
        OI.UnitPrice,
        (OI.Quantity * OI.UnitPrice) AS TotalAmount
    FROM Customer C
    INNER JOIN Orders O
        ON C.CustomerId = O.CustomerId
    INNER JOIN OrderItem OI
        ON O.OrderId = OI.OrderId
    INNER JOIN Product P
        ON OI.ProductId = P.ProductId
    INNER JOIN Seller S
        ON P.SellerId = S.SellerId;
END;
GO EXEC sp_CompleteOrderReport;
38) CREATE PROCEDURE sp_CustomerWiseTotalOrderAmount
AS
BEGIN
    SELECT
        C.CustomerId,
        C.CustomerName,
        SUM(OI.Quantity * OI.UnitPrice) AS TotalOrderAmount
    FROM Customer C
    INNER JOIN Orders O
        ON C.CustomerId = O.CustomerId
    INNER JOIN OrderItem OI
        ON O.OrderId = OI.OrderId
    GROUP BY
        C.CustomerId,
        C.CustomerName;
END;
GO EXEC sp_CustomerWiseTotalOrderAmount;
39) CREATE PROCEDURE sp_SellerWiseTotalSales
AS
BEGIN
    SELECT
        S.SellerId,
        S.SellerName,
        SUM(OI.Quantity * OI.UnitPrice) AS TotalSalesAmount
    FROM Seller S
    INNER JOIN Product P
        ON S.SellerId = P.SellerId
    INNER JOIN OrderItem OI
        ON P.ProductId = OI.ProductId
    GROUP BY
        S.SellerId,
        S.SellerName;
END;
GO EXEC sp_SellerWiseTotalSales;
40) CREATE PROCEDURE sp_ProductWiseSalesQuantity
AS
BEGIN
    SELECT
        P.ProductId,
        P.ProductName,
        SUM(OI.Quantity) AS TotalSalesQuantity
    FROM Product P
    INNER JOIN OrderItem OI
        ON P.ProductId = OI.ProductId
    GROUP BY
        P.ProductId,
        P.ProductName;
END;
GO EXEC sp_ProductWiseSalesQuantity;
H. Stored Procedure with Output Parameter
46) CREATE PROCEDURE sp_TotalCustomers
    @TotalCustomers INT OUTPUT
AS
BEGIN
    SELECT @TotalCustomers = COUNT(*)
    FROM Customer;
END;
GO 
DECLARE @Count INT;
EXEC sp_TotalCustomers @Count OUTPUT;
PRINT 'Total Customers = ' + CAST(@Count AS VARCHAR);
47) CREATE PROCEDURE sp_TotalProducts
    @TotalProducts INT OUTPUT
AS
BEGIN
    SELECT @TotalProducts = COUNT(*)
    FROM Product;
END;
GO
DECLARE @Count INT;
EXEC sp_TotalProducts @Count OUTPUT;
PRINT 'Total Products = ' + CAST(@Count AS VARCHAR);
48) CREATE PROCEDURE sp_TotalOrders
    @TotalOrders INT OUTPUT
AS
BEGIN
    SELECT @TotalOrders = COUNT(*)
    FROM Orders;
END;
GO
DECLARE @Count INT;
EXEC sp_TotalOrders @Count OUTPUT;
PRINT 'Total Orders = ' + CAST(@Count AS VARCHAR);
49) CREATE PROCEDURE sp_ProductTotalSales
    @ProductId INT,
    @TotalSales DECIMAL(18,2) OUTPUT
AS
BEGIN
    SELECT @TotalSales =
           ISNULL(SUM(Quantity * UnitPrice),0)
    FROM OrderItem
    WHERE ProductId = @ProductId;
END;
GO
DECLARE @Sales DECIMAL(18,2);
EXEC sp_ProductTotalSales
     @ProductId = 1,
     @TotalSales = @Sales OUTPUT;
PRINT 'Product Total Sales = ' + CAST(@Sales AS VARCHAR);
50) CREATE PROCEDURE sp_CustomerTotalPurchase
    @CustomerId INT,
    @TotalPurchase DECIMAL(18,2) OUTPUT
AS
BEGIN
    SELECT @TotalPurchase =
           ISNULL(SUM(OI.Quantity * OI.UnitPrice),0)
    FROM Orders O
    INNER JOIN OrderItem OI
        ON O.OrderId = OI.OrderId
    WHERE O.CustomerId = @CustomerId;
END;
GO DECLARE @Amount DECIMAL(18,2);
EXEC sp_CustomerTotalPurchase
     @CustomerId = 1,
     @TotalPurchase = @Amount OUTPUT;
PRINT 'Customer Total Purchase = ' + CAST(@Amount AS VARCHAR);


