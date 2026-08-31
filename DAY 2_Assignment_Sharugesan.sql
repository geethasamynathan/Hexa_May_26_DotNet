select * from customer;
select * from seller;
select * from product;
select * from orders;
select * from orderitem;

-- A. Basic Subquery Questions

-- 1. Products whose price is greater than average product price
select * from Product
where Price > (select avg(Price) from Product)

-- 2. Products whose stock quantity is less than average stock quantity
select * from Product
where StockQuantity < (select avg(StockQuantity) from Product)

-- 3. Customers who placed at least one order
select * from Customer
where CustomerId in (select CustomerId from Orders)

-- 4. Customers who have not placed any order
select * from Customer
where CustomerId not in (select CustomerId from Orders)

-- 5. Products that are ordered at least once
select * from Product
where ProductId in (select ProductId from OrderItem)

-- 6. Products that are not ordered by any customer
select * from Product
where ProductId not in (select ProductId from OrderItem)

-- 7. Sellers who are selling at least one product
select * from Seller
where SellerId in (select SellerId from Product)

-- 8. Sellers who are not selling any product
select * from Seller
where SellerId not in (select SellerId from Product)

-- 9. Orders placed by customers from Chennai
select * from Orders
where CustomerId in (
    select CustomerId from Customer where City = 'Chennai'
)

-- 10. Products sold by sellers from Bangalore
select * from Product
where SellerId in (
    select SellerId from Seller where City = 'Bangalore'
)




-- B. Subquery with IN / NOT IN

-- 11. Customer details for customers who have placed orders
select * from Customer
where CustomerId in (select CustomerId from Orders)

-- 12. Customer details for customers who have NOT placed any orders
select * from Customer
where CustomerId not in (select CustomerId from Orders)

-- 13. Product details available in OrderItem table
select * from Product
where ProductId in (select ProductId from OrderItem)

-- 14. Product details NOT available in OrderItem table
select * from Product
where ProductId not in (select ProductId from OrderItem)

-- 15. Seller details for sellers who have products
select * from Seller
where SellerId in (select SellerId from Product)

-- 16. Seller details for sellers who do NOT have any products
select * from Seller
where SellerId not in (select SellerId from Product)

-- 17. Orders that contain products from Mobile category
select * from Orders
where OrderId in (
    select oi.OrderId from OrderItem oi
    inner join Product p on oi.ProductId = p.ProductId
    where p.Category = 'Mobile'
)

-- 18. Orders that do NOT contain products from Laptop category
select * from Orders
where OrderId not in (
    select oi.OrderId from OrderItem oi
    inner join Product p on oi.ProductId = p.ProductId
    where p.Category = 'Laptop'
)


-- C. Subquery with Aggregate Functions

-- 19. Product details of the highest priced product
select * from Product
where Price = (select max(Price) from Product)

-- 20. Product details of the lowest priced product
select * from Product
where Price = (select min(Price) from Product)

-- 21. Products whose price is greater than average price
select * from Product
where Price > (select avg(Price) from Product)

-- 22. Products whose price is less than average price
select * from Product
where Price < (select avg(Price) from Product)

-- 23. Customers whose total order amount is greater than average order amount
select c.CustomerId, c.CustomerName, sum(oi.Quantity * oi.UnitPrice) as TotalAmount
from Customer c
join Orders o on c.CustomerId = o.CustomerId
join OrderItem oi on o.OrderId = oi.OrderId
group by c.CustomerId, c.CustomerName
having sum(oi.Quantity * oi.UnitPrice) > (
    select avg(OrderTotal) from (
        select sum(oi2.Quantity * oi2.UnitPrice) as OrderTotal
        from Orders o2
        join OrderItem oi2 on o2.OrderId = oi2.OrderId
        group by o2.CustomerId
    ) as AvgTable
)

-- 24. Sellers whose total sales amount is greater than 50000
select s.SellerId, s.SellerName
from Seller s
where (
    select sum(oi.Quantity * oi.UnitPrice)
    from Product p
    join OrderItem oi on p.ProductId = oi.ProductId
    where p.SellerId = s.SellerId
) > 50000

-- 25. Products whose total sold quantity is greater than average sold quantity
select * from Product
where ProductId in (
    select ProductId from OrderItem
    group by ProductId
    having sum(Quantity) > (
        select avg(TotalQty) from (
            select sum(Quantity) as TotalQty
            from OrderItem
            group by ProductId
        ) as AvgQty
    )
)

-- 26. Customer who has spent the highest total amount
select top 1 c.CustomerId, c.CustomerName, sum(oi.Quantity * oi.UnitPrice) as TotalSpent
from Customer c
join Orders o on c.CustomerId = o.CustomerId
join OrderItem oi on o.OrderId = oi.OrderId
group by c.CustomerId, c.CustomerName
order by TotalSpent desc

-- 27. Product that has generated the highest sales amount
select top 1 p.ProductId, p.ProductName, sum(oi.Quantity * oi.UnitPrice) as TotalSales
from Product p
join OrderItem oi on p.ProductId = oi.ProductId
group by p.ProductId, p.ProductName
order by TotalSales desc

-- 28. Seller who has generated the highest total sales
select top 1 s.SellerId, s.SellerName, sum(oi.Quantity * oi.UnitPrice) as TotalSales
from Seller s
join Product p on s.SellerId = p.SellerId
join OrderItem oi on p.ProductId = oi.ProductId
group by s.SellerId, s.SellerName
order by TotalSales desc




-- D. Correlated Subquery Questions

-- 29. Products whose price is greater than average price of same category
select * from Product p1
where Price > (
    select avg(Price) from Product p2
    where p2.Category = p1.Category
)

-- 30. Products whose price is less than average price of same category
select * from Product p1
where Price < (
    select avg(Price) from Product p2
    where p2.Category = p1.Category
)

-- 31. Sellers who have more than 2 products
select * from Seller s
where (
    select count(*) from Product p
    where p.SellerId = s.SellerId
) > 2

-- 32. Customers who have placed more than one order
select * from Customer c
where (
    select count(*) from Orders o
    where o.CustomerId = c.CustomerId
) > 1

-- 33. Orders whose amount is greater than average order amount of all orders
select * from Orders o
where (
    select sum(oi.Quantity * oi.UnitPrice)
    from OrderItem oi
    where oi.OrderId = o.OrderId
) > (
    select avg(OrderTotal) from (
        select sum(oi2.Quantity * oi2.UnitPrice) as OrderTotal
        from OrderItem oi2
        group by oi2.OrderId
    ) as Avg
)

-- 34. Products where stock quantity > average stock of same category
select * from Product p1
where StockQuantity > (
    select avg(StockQuantity) from Product p2
    where p2.Category = p1.Category
)

-- 35. Sellers whose average product price > overall average product price
select * from Seller s
where (
    select avg(Price) from Product p
    where p.SellerId = s.SellerId
) > (
    select avg(Price) from Product
)




-- E. EXISTS / NOT EXISTS Questions

-- 36. Customers who placed at least one order - using EXISTS
select * from Customer c
where exists (
    select 1 from Orders o
    where o.CustomerId = c.CustomerId
)

-- 37. Customers who have NOT placed any order - using NOT EXISTS
select * from Customer c
where not exists (
    select 1 from Orders o
    where o.CustomerId = c.CustomerId
)

-- 38. Products ordered at least once - using EXISTS
select * from Product p
where exists (
    select 1 from OrderItem oi
    where oi.ProductId = p.ProductId
)

-- 39. Products that are NOT ordered - using NOT EXISTS
select * from Product p
where not exists (
    select 1 from OrderItem oi
    where oi.ProductId = p.ProductId
)

-- 40. Sellers who have at least one product - using EXISTS
select * from Seller s
where exists (
    select 1 from Product p
    where p.SellerId = s.SellerId
)

-- 41. Sellers who do NOT have any product - using NOT EXISTS
select * from Seller s
where not exists (
    select 1 from Product p
    where p.SellerId = s.SellerId
)

-- 42. Customers who ordered any Mobile category product
select * from Customer c
where exists (
    select 1 from Orders o
    join OrderItem oi on o.OrderId = oi.OrderId
    join Product p on oi.ProductId = p.ProductId
    where o.CustomerId = c.CustomerId
    and p.Category = 'Mobile'
)

-- 43. Customers who never ordered any Laptop category product
select * from Customer c
where not exists (
    select 1 from Orders o
    join OrderItem oi on o.OrderId = oi.OrderId
    join Product p on oi.ProductId = p.ProductId
    where o.CustomerId = c.CustomerId
    and p.Category = 'Laptop'
)



-- PART 8: STORED PROCEDURES

-- A. Basic Stored Procedures

-- 1. Display all customer records
create procedure sp_GetAllCustomers
as
begin
    select * from Customer
end

exec sp_GetAllCustomers

-- 2. Display all product records
create procedure sp_GetAllProducts
as
begin
    select * from Product
end

exec sp_GetAllProducts

-- 3. Display all seller records
create procedure sp_GetAllSellers
as
begin
    select * from Seller
end

exec sp_GetAllSellers

-- 4. Display all order records
create procedure sp_GetAllOrders
as
begin
    select * from Orders
end

exec sp_GetAllOrders

-- 5. Display all order item records
create procedure sp_GetAllOrderItems
as
begin
    select * from OrderItem
end

exec sp_GetAllOrderItems



-- B. Stored Procedure with Input Parameter

-- 6. Customer details based on CustomerId
create procedure sp_GetCustomerById
    @CustomerId int
as
begin
    select * from Customer where CustomerId = @CustomerId
end

exec sp_GetCustomerById @CustomerId = 1

-- 7. Product details based on ProductId
create procedure sp_GetProductById
    @ProductId int
as
begin
    select * from Product where ProductId = @ProductId
end

exec sp_GetProductById @ProductId = 1001

-- 8. Seller details based on SellerId
create procedure sp_GetSellerById
    @SellerId int
as
begin
    select * from Seller where SellerId = @SellerId
end

exec sp_GetSellerById @SellerId = 101

-- 9. Order details based on OrderId
create procedure sp_GetOrderById
    @OrderId int
as
begin
    select * from Orders where OrderId = @OrderId
end

exec sp_GetOrderById @OrderId = 5001

-- 10. All customers from a given city
create procedure sp_GetCustomersByCity
    @City varchar(50)
as
begin
    select * from Customer where City = @City
end

exec sp_GetCustomersByCity @City = 'Chennai'

-- 11. All products from a given category
create procedure sp_GetProductsByCategory
    @Category varchar(50)
as
begin
    select * from Product where Category = @Category
end

exec sp_GetProductsByCategory @Category = 'Mobile'

-- 12. Products based on seller id
create procedure sp_GetProductsBySeller
    @SellerId int
as
begin
    select * from Product where SellerId = @SellerId
end

exec sp_GetProductsBySeller @SellerId = 101

-- 13. Orders based on customer id
create procedure sp_GetOrdersByCustomer
    @CustomerId int
as
begin
    select * from Orders where CustomerId = @CustomerId
end

exec sp_GetOrdersByCustomer @CustomerId = 1

-- 14. Order items based on order id
create procedure sp_GetOrderItemsByOrder
    @OrderId int
as
begin
    select * from OrderItem where OrderId = @OrderId
end

exec sp_GetOrderItemsByOrder @OrderId = 5001

-- 15. Products greater than a given price
create procedure sp_GetProductsAbovePrice
    @Price decimal(10,2)
as
begin
    select * from Product where Price > @Price
end

exec sp_GetProductsAbovePrice @Price = 50000



-- C. Insert Stored Procedures

-- 16. Insert a new customer
create procedure sp_InsertCustomer
    @CustomerId int,
    @CustomerName varchar(100),
    @Email varchar(100),
    @MobileNo varchar(15),
    @City varchar(50),
    @Address varchar(150),
    @IsActive bit
as
begin
    insert into Customer values (
        @CustomerId, @CustomerName, @Email,
        @MobileNo, @City, @Address, @IsActive, GETDATE()
    )
end

exec sp_InsertCustomer 6, 'Farhan', 'farhan@gmail.com', '9876541006', 'Delhi', 'Connaught Place', 1

-- 17. Insert a new seller
create procedure sp_InsertSeller
    @SellerId int,
    @SellerName varchar(100),
    @Email varchar(100),
    @MobileNo varchar(15),
    @City varchar(50),
    @Rating decimal(2,1),
    @IsActive bit
as
begin
    insert into Seller values (
        @SellerId, @SellerName, @Email,
        @MobileNo, @City, @Rating, @IsActive
    )
end

exec sp_InsertSeller 105, 'New Seller', 'newseller@gmail.com', '9500001005', 'Pune', 4.3, 1

-- 18. Insert a new product
create procedure sp_InsertProduct
    @ProductId int,
    @ProductName varchar(100),
    @Category varchar(50),
    @Price decimal(10,2),
    @StockQuantity int,
    @SellerId int
as
begin
    insert into Product values (
        @ProductId, @ProductName, @Category,
        @Price, @StockQuantity, @SellerId, GETDATE()
    )
end

exec sp_InsertProduct 1009, 'Wireless Keyboard', 'Accessories', 3500, 30, 101

-- 19. Insert a new order
create procedure sp_InsertOrder
    @OrderId int,
    @CustomerId int,
    @OrderStatus varchar(50),
    @PaymentMode varchar(50),
    @DeliveryCity varchar(100)
as
begin
    insert into Orders values (
        @OrderId, @CustomerId, GETDATE(),
        @OrderStatus, @PaymentMode, @DeliveryCity
    )
end

exec sp_InsertOrder 5006, 2, 'Pending', 'UPI', 'Bangalore'

-- 20. Insert a new order item
create procedure sp_InsertOrderItem
    @OrderItemId int,
    @OrderId int,
    @ProductId int,
    @Quantity int,
    @UnitPrice decimal(10,2)
as
begin
    insert into OrderItem values (
        @OrderItemId, @OrderId, @ProductId,
        @Quantity, @UnitPrice
    )
end

exec sp_InsertOrderItem 11, 5006, 1009, 1, 3500




-- D. Update Stored Procedures

-- 21. Update customer city
create procedure sp_UpdateCustomerCity
    @CustomerId int,
    @City varchar(50)
as
begin
    update Customer set City = @City
    where CustomerId = @CustomerId
end

exec sp_UpdateCustomerCity @CustomerId = 1, @City = 'Madurai'

-- 22. Update customer mobile number
create procedure sp_UpdateCustomerMobile
    @CustomerId int,
    @MobileNo varchar(15)
as
begin
    update Customer set MobileNo = @MobileNo
    where CustomerId = @CustomerId
end

exec sp_UpdateCustomerMobile @CustomerId = 1, @MobileNo = '9000000001'

-- 23. Update product price
create procedure sp_UpdateProductPrice
    @ProductId int,
    @Price decimal(10,2)
as
begin
    update Product set Price = @Price
    where ProductId = @ProductId
end

exec sp_UpdateProductPrice @ProductId = 1001, @Price = 80000

-- 24. Update product stock quantity
create procedure sp_UpdateProductStock
    @ProductId int,
    @StockQuantity int
as
begin
    update Product set StockQuantity = @StockQuantity
    where ProductId = @ProductId
end

exec sp_UpdateProductStock @ProductId = 1001, @StockQuantity = 25

-- 25. Update order status
create procedure sp_UpdateOrderStatus
    @OrderId int,
    @OrderStatus varchar(50)
as
begin
    update Orders set OrderStatus = @OrderStatus
    where OrderId = @OrderId
end

exec sp_UpdateOrderStatus @OrderId = 5002, @OrderStatus = 'Delivered'

-- 26. Update seller rating
create procedure sp_UpdateSellerRating
    @SellerId int,
    @Rating decimal(2,1)
as
begin
    update Seller set Rating = @Rating
    where SellerId = @SellerId
end

exec sp_UpdateSellerRating @SellerId = 101, @Rating = 4.9

-- 27. Update customer active status
create procedure sp_UpdateCustomerStatus
    @CustomerId int,
    @IsActive bit
as
begin
    update Customer set IsActive = @IsActive
    where CustomerId = @CustomerId
end

exec sp_UpdateCustomerStatus @CustomerId = 3, @IsActive = 0

-- 28. Update seller active status
create procedure sp_UpdateSellerStatus
    @SellerId int,
    @IsActive bit
as
begin
    update Seller set IsActive = @IsActive
    where SellerId = @SellerId
end

exec sp_UpdateSellerStatus @SellerId = 103, @IsActive = 0




-- E. Delete Stored Procedures

-- 29. Delete a customer
create procedure sp_DeleteCustomer
    @CustomerId int
as
begin
    delete from Customer where CustomerId = @CustomerId
end

exec sp_DeleteCustomer @CustomerId = 6

-- 30. Delete a seller
create procedure sp_DeleteSeller
    @SellerId int
as
begin
    delete from Seller where SellerId = @SellerId
end

exec sp_DeleteSeller @SellerId = 105

-- 31. Delete a product
create procedure sp_DeleteProduct
    @ProductId int
as
begin
    delete from Product where ProductId = @ProductId
end

exec sp_DeleteProduct @ProductId = 1009

-- 32. Delete an order
create procedure sp_DeleteOrder
    @OrderId int
as
begin
    delete from Orders where OrderId = @OrderId
end

exec sp_DeleteOrder @OrderId = 5006

-- 33. Delete an order item
create procedure sp_DeleteOrderItem
    @OrderItemId int
as
begin
    delete from OrderItem where OrderItemId = @OrderItemId
end

exec sp_DeleteOrderItem @OrderItemId = 11




-- F. Stored Procedures with Joins

-- 34. Customer-wise order details
create procedure sp_CustomerOrderDetails
as
begin
    select c.CustomerName, o.OrderId, o.OrderDate,
           o.OrderStatus, o.PaymentMode, o.DeliveryCity
    from Customer c
    inner join Orders o on c.CustomerId = o.CustomerId
    order by c.CustomerName
end

exec sp_CustomerOrderDetails

-- 35. Seller-wise product details
create procedure sp_SellerProductDetails
as
begin
    select s.SellerName, p.ProductName,
           p.Category, p.Price, p.StockQuantity
    from Seller s
    inner join Product p on s.SellerId = p.SellerId
    order by s.SellerName
end

exec sp_SellerProductDetails

-- 36. Order-wise product details
create procedure sp_OrderProductDetails
as
begin
    select o.OrderId, p.ProductName,
           oi.Quantity, oi.UnitPrice,
           (oi.Quantity * oi.UnitPrice) as TotalAmount
    from Orders o
    inner join OrderItem oi on o.OrderId = oi.OrderId
    inner join Product p on oi.ProductId = p.ProductId
    order by o.OrderId
end

exec sp_OrderProductDetails

-- 37. Complete order report
create procedure sp_CompleteOrderReport
as
begin
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
    order by c.CustomerName
end

exec sp_CompleteOrderReport

-- 38. Customer-wise total order amount
create procedure sp_CustomerTotalOrderAmount
as
begin
    select c.CustomerId, c.CustomerName,
           sum(oi.Quantity * oi.UnitPrice) as TotalOrderAmount
    from Customer c
    inner join Orders o on c.CustomerId = o.CustomerId
    inner join OrderItem oi on o.OrderId = oi.OrderId
    group by c.CustomerId, c.CustomerName
    order by TotalOrderAmount desc
end

exec sp_CustomerTotalOrderAmount

-- 39. Seller-wise total sales amount
create procedure sp_SellerTotalSales
as
begin
    select s.SellerId, s.SellerName,
           sum(oi.Quantity * oi.UnitPrice) as TotalSales
    from Seller s
    inner join Product p on s.SellerId = p.SellerId
    inner join OrderItem oi on p.ProductId = oi.ProductId
    group by s.SellerId, s.SellerName
    order by TotalSales desc
end

exec sp_SellerTotalSales

-- 40. Product-wise total sales quantity
create procedure sp_ProductTotalSalesQty
as
begin
    select p.ProductId, p.ProductName,
           sum(oi.Quantity) as TotalQuantitySold
    from Product p
    inner join OrderItem oi on p.ProductId = oi.ProductId
    group by p.ProductId, p.ProductName
    order by TotalQuantitySold desc
end

exec sp_ProductTotalSalesQty



-- H. Stored Procedures with Output Parameter

-- 41. Return total number of customers
create procedure sp_TotalCustomers
    @TotalCount int output
as
begin
    select @TotalCount = count(*) from Customer
end

declare @count int
exec sp_TotalCustomers @TotalCount = @count output
select @count as TotalCustomers

-- 42. Return total number of products
create procedure sp_TotalProducts
    @TotalCount int output
as
begin
    select @TotalCount = count(*) from Product
end

declare @count int
exec sp_TotalProducts @TotalCount = @count output
select @count as TotalProducts

-- 43. Return total number of orders
create procedure sp_TotalOrders
    @TotalCount int output
as
begin
    select @TotalCount = count(*) from Orders
end

declare @count int
exec sp_TotalOrders @TotalCount = @count output
select @count as TotalOrders

-- 44. Return total sales amount of a product
create procedure sp_ProductTotalSales
    @ProductId int,
    @TotalSales decimal(10,2) output
as
begin
    select @TotalSales = sum(Quantity * UnitPrice)
    from OrderItem
    where ProductId = @ProductId
end

declare @sales decimal(10,2)
exec sp_ProductTotalSales @ProductId = 1001, @TotalSales = @sales output
select @sales as TotalSales

-- 45. Return total purchase amount of a customer
create procedure sp_CustomerTotalPurchase
    @CustomerId int,
    @TotalAmount decimal(10,2) output
as
begin
    select @TotalAmount = sum(oi.Quantity * oi.UnitPrice)
    from Orders o
    inner join OrderItem oi on o.OrderId = oi.OrderId
    where o.CustomerId = @CustomerId
end

declare @amount decimal(10,2)
exec sp_CustomerTotalPurchase @CustomerId = 1, @TotalAmount = @amount output
select @amount as TotalPurchaseAmount