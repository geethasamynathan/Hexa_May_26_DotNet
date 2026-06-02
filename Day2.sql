use ecommerce_assignment_db;
go

-- part 7: subqueries

-- A.1
select * from product where price > (select avg(price) from product);

-- A.2
select * from product where stockquantity < (select avg(stockquantity) from product);

-- A.3
select * from customer where customerid in (select customerid from orders);

-- A.4
select * from customer where customerid not in (select customerid from orders);

-- A.5
select * from product where productid in (select productid from orderitem);

-- A.6
select * from product where productid not in (select productid from orderitem);

-- A.7
select * from seller where sellerid in (select sellerid from product);

-- A.8
select * from seller where sellerid not in (select sellerid from product);

-- A.9 (using reykjavik instead of chennai)
select * from orders where customerid in (select customerid from customer where city = 'Reykjavik');

-- A.10
select * from product where sellerid in (select sellerid from seller where city = 'Bangalore');


-- B.1
select * from customer where customerid in (select customerid from orders);

-- B.2
select * from customer where customerid not in (select customerid from orders);

-- B.3
select * from product where productid in (select productid from orderitem);

-- B.4
select * from product where productid not in (select productid from orderitem);

-- B.5
select * from seller where sellerid in (select sellerid from product);

-- B.6
select * from seller where sellerid not in (select sellerid from product);

-- B.7
select * from orders where orderid in (select orderid from orderitem where productid in (select productid from product where category = 'Mobile'));

-- B.8
select * from orders where orderid not in (select orderid from orderitem where productid in (select productid from product where category = 'Laptop'));


-- C.1
select * from product where price = (select max(price) from product);

-- C.2
select * from product where price = (select min(price) from product);

-- C.3
select * from product where price > (select avg(price) from product);

-- C.4
select * from product where price < (select avg(price) from product);

-- C.5
select * from customer where customerid in (
    select o.customerid from orders o join orderitem oi on o.orderid = oi.orderid 
    group by o.customerid having sum(oi.quantity * oi.unitprice) > 
    (select avg(total) from (select sum(quantity * unitprice) as total from orderitem group by orderid) as temp)
);

-- C.6
select * from seller where sellerid in (
    select p.sellerid from product p join orderitem oi on p.productid = oi.productid 
    group by p.sellerid having sum(oi.quantity * oi.unitprice) > 50000
);

-- C.7
select * from product where productid in (
    select productid from orderitem group by productid 
    having sum(quantity) > (select avg(qty) from (select sum(quantity) as qty from orderitem group by productid) as temp)
);

-- C.8
select top 1 c.* from customer c join orders o on c.customerid = o.customerid 
join orderitem oi on o.orderid = oi.orderid group by c.customerid, c.customername, c.email, c.mobileno, c.city, c.address, c.isactive, c.createddate 
order by sum(oi.quantity * oi.unitprice) desc;

-- C.9
select top 1 p.* from product p join orderitem oi on p.productid = oi.productid 
group by p.productid, p.productname, p.category, p.price, p.stockquantity, p.sellerid, p.createddate 
order by sum(oi.quantity * oi.unitprice) desc;

-- C.10
select top 1 s.* from seller s join product p on s.sellerid = p.sellerid 
join orderitem oi on p.productid = oi.productid 
group by s.sellerid, s.sellername, s.email, s.mobileno, s.city, s.rating, s.isactive 
order by sum(oi.quantity * oi.unitprice) desc;


-- D.1
select * from product p1 where price > (select avg(price) from product p2 where p1.category = p2.category);

-- D.2
select * from product p1 where price < (select avg(price) from product p2 where p1.category = p2.category);

-- D.3
select * from seller s where 2 < (select count(*) from product p where p.sellerid = s.sellerid);

-- D.4
select * from customer c where 1 < (select count(*) from orders o where o.customerid = c.customerid);

-- D.5
select * from orders o1 where (select sum(quantity * unitprice) from orderitem oi1 where oi1.orderid = o1.orderid) > 
(select avg(total) from (select sum(quantity * unitprice) as total from orderitem group by orderid) as temp);

-- D.6
select * from product p1 where stockquantity > (select avg(stockquantity) from product p2 where p1.category = p2.category);

-- D.7
select * from seller s where (select avg(price) from product p where p.sellerid = s.sellerid) > (select avg(price) from product);


-- E.1
select * from customer c where exists (select 1 from orders o where o.customerid = c.customerid);

-- E.2
select * from customer c where not exists (select 1 from orders o where o.customerid = c.customerid);

-- E.3
select * from product p where exists (select 1 from orderitem oi where oi.productid = p.productid);

-- E.4
select * from product p where not exists (select 1 from orderitem oi where oi.productid = p.productid);

-- E.5
select * from seller s where exists (select 1 from product p where p.sellerid = s.sellerid);

-- E.6
select * from seller s where not exists (select 1 from product p where p.sellerid = s.sellerid);

-- E.7
select * from customer c where exists (select 1 from orders o join orderitem oi on o.orderid = oi.orderid join product p on oi.productid = p.productid where o.customerid = c.customerid and p.category = 'Mobile');

-- E.8
select * from customer c where not exists (select 1 from orders o join orderitem oi on o.orderid = oi.orderid join product p on oi.productid = p.productid where o.customerid = c.customerid and p.category = 'Laptop');


-- part 8: stored procedures
go

-- A.1
create procedure sp_get_all_customers as begin select * from customer; end;
go
-- A.2
create procedure sp_get_all_products as begin select * from product; end;
go
-- A.3
create procedure sp_get_all_sellers as begin select * from seller; end;
go
-- A.4
create procedure sp_get_all_orders as begin select * from orders; end;
go
-- A.5
create procedure sp_get_all_orderitems as begin select * from orderitem; end;
go

-- B.1
create procedure sp_get_customer_by_id @id int as begin select * from customer where customerid = @id; end;
go
-- B.2
create procedure sp_get_product_by_id @id int as begin select * from product where productid = @id; end;
go
-- B.3
create procedure sp_get_seller_by_id @id int as begin select * from seller where sellerid = @id; end;
go
-- B.4
create procedure sp_get_order_by_id @id int as begin select * from orders where orderid = @id; end;
go
-- B.5
create procedure sp_get_customers_by_city @city varchar(50) as begin select * from customer where city = @city; end;
go
-- B.6
create procedure sp_get_products_by_category @cat varchar(50) as begin select * from product where category = @cat; end;
go
-- B.7
create procedure sp_get_products_by_seller @id int as begin select * from product where sellerid = @id; end;
go
-- B.8
create procedure sp_get_orders_by_customer @id int as begin select * from orders where customerid = @id; end;
go
-- B.9
create procedure sp_get_orderitems_by_order @id int as begin select * from orderitem where orderid = @id; end;
go
-- B.10
create procedure sp_get_products_by_price @price decimal(10,2) as begin select * from product where price > @price; end;
go

-- C.1
create procedure sp_insert_customer @id int, @name varchar(100), @email varchar(100), @mob varchar(15), @city varchar(50), @addr varchar(250) as begin insert into customer (customerid, customername, email, mobileno, city, address) values (@id, @name, @email, @mob, @city, @addr); end;
go
-- C.2
create procedure sp_insert_seller @id int, @name varchar(100), @email varchar(100), @mob varchar(15), @city varchar(50), @rat decimal(3,2) as begin insert into seller (sellerid, sellername, email, mobileno, city, rating) values (@id, @name, @email, @mob, @city, @rat); end;
go
-- C.3
create procedure sp_insert_product @id int, @name varchar(100), @cat varchar(50), @price decimal(10,2), @qty int, @sid int as begin insert into product (productid, productname, category, price, stockquantity, sellerid) values (@id, @name, @cat, @price, @qty, @sid); end;
go
-- C.4
create procedure sp_insert_order @id int, @cid int, @status varchar(50), @pay varchar(50), @city varchar(50) as begin insert into orders (orderid, customerid, orderstatus, paymentmode, deliverycity) values (@id, @cid, @status, @pay, @city); end;
go
-- C.5
create procedure sp_insert_orderitem @id int, @oid int, @pid int, @qty int, @uprice decimal(10,2) as begin insert into orderitem (orderitemid, orderid, productid, quantity, unitprice) values (@id, @oid, @pid, @qty, @uprice); end;
go

-- D.1
create procedure sp_update_cust_city @id int, @city varchar(50) as begin update customer set city = @city where customerid = @id; end;
go
-- D.2
create procedure sp_update_cust_mobile @id int, @mob varchar(15) as begin update customer set mobileno = @mob where customerid = @id; end;
go
-- D.3
create procedure sp_update_prod_price @id int, @price decimal(10,2) as begin update product set price = @price where productid = @id; end;
go
-- D.4
create procedure sp_update_prod_qty @id int, @qty int as begin update product set stockquantity = @qty where productid = @id; end;
go
-- D.5
create procedure sp_update_order_status @id int, @status varchar(50) as begin update orders set orderstatus = @status where orderid = @id; end;
go
-- D.6
create procedure sp_update_seller_rating @id int, @rat decimal(3,2) as begin update seller set rating = @rat where sellerid = @id; end;
go
-- D.7
create procedure sp_update_cust_active @id int, @status bit as begin update customer set isactive = @status where customerid = @id; end;
go
-- D.8
create procedure sp_update_seller_active @id int, @status bit as begin update seller set isactive = @status where sellerid = @id; end;
go

-- E.1
create procedure sp_delete_cust @id int as begin delete from customer where customerid = @id; end;
go
-- E.2
create procedure sp_delete_seller @id int as begin delete from seller where sellerid = @id; end;
go
-- E.3
create procedure sp_delete_product @id int as begin delete from product where productid = @id; end;
go
-- E.4
create procedure sp_delete_order @id int as begin delete from orders where orderid = @id; end;
go
-- E.5
create procedure sp_delete_orderitem @id int as begin delete from orderitem where orderitemid = @id; end;
go

-- F.1
create procedure sp_cust_order_details as begin select c.customername, o.* from customer c join orders o on c.customerid = o.customerid; end;
go
-- F.2
create procedure sp_seller_product_details as begin select s.sellername, p.* from seller s join product p on s.sellerid = p.sellerid; end;
go
-- F.3
create procedure sp_order_product_details as begin select o.orderid, p.productname, oi.quantity from orders o join orderitem oi on o.orderid = oi.orderid join product p on oi.productid = p.productid; end;
go
-- F.4
create procedure sp_complete_order_report as begin select c.customername, p.productname, s.sellername, oi.quantity, oi.unitprice, (oi.quantity * oi.unitprice) as totalamount from orders o join customer c on o.customerid = c.customerid join orderitem oi on o.orderid = oi.orderid join product p on oi.productid = p.productid join seller s on p.sellerid = s.sellerid; end;
go
-- F.5
create procedure sp_cust_total_amount as begin select c.customername, sum(oi.quantity * oi.unitprice) as total from customer c join orders o on c.customerid = o.customerid join orderitem oi on o.orderid = oi.orderid group by c.customername; end;
go
-- F.6
create procedure sp_seller_total_sales as begin select s.sellername, sum(oi.quantity * oi.unitprice) as totalsales from seller s join product p on s.sellerid = p.sellerid join orderitem oi on p.productid = oi.productid group by s.sellername; end;
go
-- F.7
create procedure sp_product_total_qty as begin select p.productname, sum(oi.quantity) as totalqty from product p join orderitem oi on p.productid = oi.productid group by p.productname; end;
go

-- H.1
create procedure sp_total_cust_count @total int output as begin select @total = count(*) from customer; end;
go
-- H.2
create procedure sp_total_prod_count @total int output as begin select @total = count(*) from product; end;
go
-- H.3
create procedure sp_total_order_count @total int output as begin select @total = count(*) from orders; end;
go
-- H.4
create procedure sp_prod_sales_amt @pid int, @total decimal(10,2) output as begin select @total = sum(quantity * unitprice) from orderitem where productid = @pid; end;
go
-- H.5
create procedure sp_cust_purchase_amt @cid int, @total decimal(10,2) output as begin select @total = sum(oi.quantity * oi.unitprice) from orders o join orderitem oi on o.orderid = oi.orderid where o.customerid = @cid; end;
go