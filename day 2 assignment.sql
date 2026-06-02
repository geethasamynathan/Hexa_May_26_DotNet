use ecommerce_assignment_db;
go

-- part 7: subqueries

-- a.1
select
    *
from product
where price > (
    select avg(price)
    from product
);

-- a.2
select
    *
from product
where stockquantity < (
    select avg(stockquantity)
    from product
);

-- a.3
select
    *
from customer
where customerid in (
    select customerid
    from orders
);

-- a.4
select
    *
from customer
where customerid not in (
    select customerid
    from orders
);

-- a.5
select
    *
from product
where productid in (
    select productid
    from orderitem
);

-- a.6
select
    *
from product
where productid not in (
    select productid
    from orderitem
);

-- a.7
select
    *
from seller
where sellerid in (
    select sellerid
    from product
);

-- a.8
select
    *
from seller
where sellerid not in (
    select sellerid
    from product
);

-- a.9 (using reykjavik instead of chennai)
select
    *
from orders
where customerid in (
    select customerid
    from customer
    where city = 'Reykjavik'
);

-- a.10
select
    *
from product
where sellerid in (
    select sellerid
    from seller
    where city = 'Bangalore'
);

-- b.1
select
    *
from customer
where customerid in (
    select customerid
    from orders
);

-- b.2
select
    *
from customer
where customerid not in (
    select customerid
    from orders
);

-- b.3
select
    *
from product
where productid in (
    select productid
    from orderitem
);

-- b.4
select
    *
from product
where productid not in (
    select productid
    from orderitem
);

-- b.5
select
    *
from seller
where sellerid in (
    select sellerid
    from product
);

-- b.6
select
    *
from seller
where sellerid not in (
    select sellerid
    from product
);

-- b.7
select
    *
from orders
where orderid in (
    select orderid
    from orderitem
    where productid in (
        select productid
        from product
        where category = 'Mobile'
    )
);

-- b.8
select
    *
from orders
where orderid not in (
    select orderid
    from orderitem
    where productid in (
        select productid
        from product
        where category = 'Laptop'
    )
);

-- c.1
select
    *
from product
where price = (
    select max(price)
    from product
);

-- c.2
select
    *
from product
where price = (
    select min(price)
    from product
);

-- c.3
select
    *
from product
where price > (
    select avg(price)
    from product
);

-- c.4
select
    *
from product
where price < (
    select avg(price)
    from product
);

-- c.5
select
    *
from customer
where customerid in (
    select
        o.customerid
    from orders o
    join orderitem oi
        on o.orderid = oi.orderid
    group by
        o.customerid
    having
        sum(oi.quantity * oi.unitprice) >
        (
            select avg(total)
            from (
                select
                    sum(quantity * unitprice) as total
                from orderitem
                group by
                    orderid
            ) as temp
        )
);

-- c.6
select
    *
from seller
where sellerid in (
    select
        p.sellerid
    from product p
    join orderitem oi
        on p.productid = oi.productid
    group by
        p.sellerid
    having
        sum(oi.quantity * oi.unitprice) > 50000
);

-- c.7
select
    *
from product
where productid in (
    select
        productid
    from orderitem
    group by
        productid
    having
        sum(quantity) >
        (
            select avg(qty)
            from (
                select
                    sum(quantity) as qty
                from orderitem
                group by
                    productid
            ) as temp
        )
);

-- c.8
select top 1
    c.*
from customer c
join orders o
    on c.customerid = o.customerid
join orderitem oi
    on o.orderid = oi.orderid
group by
    c.customerid,
    c.customername,
    c.email,
    c.mobileno,
    c.city,
    c.address,
    c.isactive,
    c.createddate
order by
    sum(oi.quantity * oi.unitprice) desc;

-- c.9
select top 1
    p.*
from product p
join orderitem oi
    on p.productid = oi.productid
group by
    p.productid,
    p.productname,
    p.category,
    p.price,
    p.stockquantity,
    p.sellerid,
    p.createddate
order by
    sum(oi.quantity * oi.unitprice) desc;

-- c.10
select top 1
    s.*
from seller s
join product p
    on s.sellerid = p.sellerid
join orderitem oi
    on p.productid = oi.productid
group by
    s.sellerid,
    s.sellername,
    s.email,
    s.mobileno,
    s.city,
    s.rating,
    s.isactive
order by
    sum(oi.quantity * oi.unitprice) desc;

-- d.1
select
    *
from product p1
where price > (
    select avg(price)
    from product p2
    where p1.category = p2.category
);

-- d.2
select
    *
from product p1
where price < (
    select avg(price)
    from product p2
    where p1.category = p2.category
);

-- d.3
select
    *
from seller s
where 2 < (
    select count(*)
    from product p
    where p.sellerid = s.sellerid
);

-- d.4
select
    *
from customer c
where 1 < (
    select count(*)
    from orders o
    where o.customerid = c.customerid
);

-- d.5
select
    *
from orders o1
where
    (
        select sum(quantity * unitprice)
        from orderitem oi1
        where oi1.orderid = o1.orderid
    ) >
    (
        select avg(total)
        from (
            select
                sum(quantity * unitprice) as total
            from orderitem
            group by
                orderid
        ) as temp
    );

-- d.6
select
    *
from product p1
where stockquantity > (
    select avg(stockquantity)
    from product p2
    where p1.category = p2.category
);

-- d.7
select
    *
from seller s
where
    (
        select avg(price)
        from product p
        where p.sellerid = s.sellerid
    ) >
    (
        select avg(price)
        from product
    );

-- e.1
select
    *
from customer c
where exists (
    select 1
    from orders o
    where o.customerid = c.customerid
);

-- e.2
select
    *
from customer c
where not exists (
    select 1
    from orders o
    where o.customerid = c.customerid
);

-- e.3
select
    *
from product p
where exists (
    select 1
    from orderitem oi
    where oi.productid = p.productid
);

-- e.4
select
    *
from product p
where not exists (
    select 1
    from orderitem oi
    where oi.productid = p.productid
);

-- e.5
select
    *
from seller s
where exists (
    select 1
    from product p
    where p.sellerid = s.sellerid
);

-- e.6
select
    *
from seller s
where not exists (
    select 1
    from product p
    where p.sellerid = s.sellerid
);

-- e.7
select * from customer c where exists (select 1 from orders o join orderitem oi on o.orderid = oi.orderid join product p on oi.productid = p.productid where o.customerid = c.customerid and p.category [...]

-- e.8
select * from customer c where not exists (select 1 from orders o join orderitem oi on o.orderid = oi.orderid join product p on oi.productid = p.productid where o.customerid = c.customerid and p.categ[...]

-- part 8: stored procedures
go

-- a.1
create procedure sp_get_all_customers
as
begin
    select
        *
    from customer;
end;
go

-- a.2
create procedure sp_get_all_products
as
begin
    select
        *
    from product;
end;
go

-- a.3
create procedure sp_get_all_sellers
as
begin
    select
        *
    from seller;
end;
go

-- a.4
create procedure sp_get_all_orders
as
begin
    select
        *
    from orders;
end;
go

-- a.5
create procedure sp_get_all_orderitems
as
begin
    select
        *
    from orderitem;
end;
go

-- b.1
create procedure sp_get_customer_by_id @id int
as
begin
    select
        *
    from customer
    where customerid = @id;
end;
go

-- b.2
create procedure sp_get_product_by_id @id int
as
begin
    select
        *
    from product
    where productid = @id;
end;
go

-- b.3
create procedure sp_get_seller_by_id @id int
as
begin
    select
        *
    from seller
    where sellerid = @id;
end;
go

-- b.4
create procedure sp_get_order_by_id @id int
as
begin
    select
        *
    from orders
    where orderid = @id;
end;
go

-- b.5
create procedure sp_get_customers_by_city @city varchar(50)
as
begin
    select
        *
    from customer
    where city = @city;
end;
go

-- b.6
create procedure sp_get_products_by_category @cat varchar(50)
as
begin
    select
        *
    from product
    where category = @cat;
end;
go

-- b.7
create procedure sp_get_products_by_seller @id int
as
begin
    select
        *
    from product
    where sellerid = @id;
end;
go

-- b.8
create procedure sp_get_orders_by_customer @id int
as
begin
    select
        *
    from orders
    where customerid = @id;
end;
go

-- b.9
create procedure sp_get_orderitems_by_order @id int
as
begin
    select
        *
    from orderitem
    where orderid = @id;
end;
go

-- b.10
create procedure sp_get_products_by_price @price decimal(10,2)
as
begin
    select
        *
    from product
    where price > @price;
end;
go

-- c.1
create procedure sp_insert_customer @id int, @name varchar(100), @email varchar(100), @mob varchar(15), @city varchar(50), @addr varchar(250) as begin insert into customer (customerid, customername, e[...]
go

-- c.2
create procedure sp_insert_seller @id int, @name varchar(100), @email varchar(100), @mob varchar(15), @city varchar(50), @rat decimal(3,2) as begin insert into seller (sellerid, sellername, email, mob[...]
go

-- c.3
create procedure sp_insert_product @id int, @name varchar(100), @cat varchar(50), @price decimal(10,2), @qty int, @sid int as begin insert into product (productid, productname, category, price, stockq[...]
go

-- c.4
create procedure sp_insert_order @id int, @cid int, @status varchar(50), @pay varchar(50), @city varchar(50) as begin insert into orders (orderid, customerid, orderstatus, paymentmode, deliverycity) v[...]
go

-- c.5
create procedure sp_insert_orderitem @id int, @oid int, @pid int, @qty int, @uprice decimal(10,2) as begin insert into orderitem (orderitemid, orderid, productid, quantity, unitprice) values (@id, @oi[...]
go

-- d.1
create procedure sp_update_cust_city @id int, @city varchar(50)
as
begin
    update customer
    set city = @city
    where customerid = @id;
end;
go

-- d.2
create procedure sp_update_cust_mobile @id int, @mob varchar(15)
as
begin
    update customer
    set mobileno = @mob
    where customerid = @id;
end;
go

-- d.3
create procedure sp_update_prod_price @id int, @price decimal(10,2)
as
begin
    update product
    set price = @price
    where productid = @id;
end;
go

-- d.4
create procedure sp_update_prod_qty @id int, @qty int
as
begin
    update product
    set stockquantity = @qty
    where productid = @id;
end;
go

-- d.5
create procedure sp_update_order_status @id int, @status varchar(50)
as
begin
    update orders
    set orderstatus = @status
    where orderid = @id;
end;
go

-- d.6
create procedure sp_update_seller_rating @id int, @rat decimal(3,2)
as
begin
    update seller
    set rating = @rat
    where sellerid = @id;
end;
go

-- d.7
create procedure sp_update_cust_active @id int, @status bit
as
begin
    update customer
    set isactive = @status
    where customerid = @id;
end;
go

-- d.8
create procedure sp_update_seller_active @id int, @status bit
as
begin
    update seller
    set isactive = @status
    where sellerid = @id;
end;
go

-- e.1
create procedure sp_delete_cust @id int
as
begin
    delete from customer
    where customerid = @id;
end;
go

-- e.2
create procedure sp_delete_seller @id int
as
begin
    delete from seller
    where sellerid = @id;
end;
go

-- e.3
create procedure sp_delete_product @id int
as
begin
    delete from product
    where productid = @id;
end;
go

-- e.4
create procedure sp_delete_order @id int
as
begin
    delete from orders
    where orderid = @id;
end;
go

-- e.5
create procedure sp_delete_orderitem @id int
as
begin
    delete from orderitem
    where orderitemid = @id;
end;
go

-- f.1
create procedure sp_cust_order_details
as
begin
    select
        c.customername,
        o.*
    from customer c
    join orders o
        on c.customerid = o.customerid;
end;
go

-- f.2
create procedure sp_seller_product_details
as
begin
    select
        s.sellername,
        p.*
    from seller s
    join product p
        on s.sellerid = p.sellerid;
end;
go

-- f.3
create procedure sp_order_product_details as begin select o.orderid, p.productname, oi.quantity from orders o join orderitem oi on o.orderid = oi.orderid join product p on oi.productid = p.productid; [...]
go

-- f.4
create procedure sp_complete_order_report as begin select c.customername, p.productname, s.sellername, oi.quantity, oi.unitprice, (oi.quantity * oi.unitprice) as totalamount from orders o join custome[...]
go

-- f.5
create procedure sp_cust_total_amount as begin select c.customername, sum(oi.quantity * oi.unitprice) as total from customer c join orders o on c.customerid = o.customerid join orderitem oi on o.order[...]
go

-- f.6
create procedure sp_seller_total_sales as begin select s.sellername, sum(oi.quantity * oi.unitprice) as totalsales from seller s join product p on s.sellerid = p.sellerid join orderitem oi on p.produc[...]
go

-- f.7
create procedure sp_product_total_qty
as
begin
    select
        p.productname,
        sum(oi.quantity) as totalqty
    from product p
    join orderitem oi
        on p.productid = oi.productid
    group by
        p.productname;
end;
go

-- h.1
create procedure sp_total_cust_count @total int output
as
begin
    select
        @total = count(*)
    from customer;
end;
go

-- h.2
create procedure sp_total_prod_count @total int output
as
begin
    select
        @total = count(*)
    from product;
end;
go

-- h.3
create procedure sp_total_order_count @total int output
as
begin
    select
        @total = count(*)
    from orders;
end;
go

-- h.4
create procedure sp_prod_sales_amt @pid int, @total decimal(10,2) output
as
begin
    select
        @total = sum(quantity * unitprice)
    from orderitem
    where productid = @pid;
end;
go

-- h.5
create procedure sp_cust_purchase_amt @cid int, @total decimal(10,2) output as begin select @total = sum(oi.quantity * oi.unitprice) from orders o join orderitem oi on o.orderid = oi.orderid where o.c[...]
go
