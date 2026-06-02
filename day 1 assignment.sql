use master;
go

drop database if exists ecommerce_assignment_db;
go

create database ecommerce_assignment_db;
go

use ecommerce_assignment_db;
go

create table customer (
    customerid int primary key,
    customername varchar(100) not null,
    email varchar(100) unique not null,
    mobileno varchar(15),
    city varchar(50),
    address varchar(250),
    isactive bit default 1,
    createddate date default getdate()
);
go

create table seller (
    sellerid int primary key,
    sellername varchar(100) not null,
    email varchar(100) unique not null,
    mobileno varchar(15),
    city varchar(50),
    rating decimal(3,2),
    isactive bit default 1
);
go

create table product (
    productid int primary key,
    productname varchar(100) not null,
    category varchar(50) not null,
    price decimal(10,2) not null check(price > 0),
    stockquantity int not null check(stockquantity >= 0),
    sellerid int,
    createddate date default getdate(),
    foreign key (sellerid) references seller(sellerid)
);
go

create table orders (
    orderid int primary key,
    customerid int,
    orderdate date default getdate(),
    orderstatus varchar(50) default 'Pending',
    paymentmode varchar(50),
    deliverycity varchar(50),
    foreign key (customerid) references customer(customerid)
);
go

create table orderitem (
    orderitemid int primary key,
    orderid int,
    productid int,
    quantity int not null check(quantity > 0),
    unitprice decimal(10,2) not null,
    foreign key (orderid) references orders(orderid),
    foreign key (productid) references product(productid)
);
go

insert into customer (customerid, customername, email, mobileno, city, address) values 
(1, 'Thorfinn Karlsefni', 'true.warrior@gmail.com', '1112223333', 'Reykjavik', 'Vinland Farm'),
(2, 'Eren Yeager', 'freedom@email.com', '9999999999', 'Shiganshina', 'Wall Maria District'),
(3, 'Tanjiro Kamado', 'sun.breathing@gmail.com', '8888888888', 'Tokyo', 'Butterfly Mansion'),
(4, 'Levi Ackerman', 'clean.freak@email.com', '7777777777', 'Underground', 'Scout Regiment HQ'),
(5, 'Ryland Grace', 'astrophage@gmail.com', null, 'Tau Ceti', 'Hail Mary Ship');

insert into seller (sellerid, sellername, email, mobileno, city, rating) values 
(1, 'Tech Haven', 'contact@techhaven.com', '1112223333', 'Chennai', 4.5),
(2, 'Gadget World', 'sales@gadgetworld.com', '2223334444', 'Bangalore', 4.8),
(3, 'Home Essentials', 'info@homeessentials.com', '3334445555', 'Delhi', 4.2),
(4, 'Mega Mart', 'support@megamart.com', '4445556666', 'Mumbai', 4.0);

insert into product (productid, productname, category, price, stockquantity, sellerid) values 
(1, 'Smart Phone X', 'Mobile', 55000.00, 15, 1),
(2, 'Gaming Laptop', 'Laptop', 85000.00, 5, 2),
(3, 'Budget Phone Y', 'Mobile', 15000.00, 50, 1),
(4, 'Wireless Earbuds', 'Accessories', 3000.00, 100, 2),
(5, 'Office Chair', 'Furniture', 12000.00, 8, 3),
(6, 'Desk Lamp', 'Furniture', 1500.00, 20, 3),
(7, 'Ultra Phone Z', 'Mobile', 95000.00, 12, 1),
(8, 'Unused Blender', 'Appliance', 4500.00, 5, 4);

insert into orders (orderid, customerid, orderstatus, paymentmode, deliverycity) values 
(1, 1, 'Delivered', 'Credit Card', 'Reykjavik'),
(2, 2, 'Pending', 'UPI', 'Shiganshina'),
(3, 3, 'Shipped', 'Net Banking', 'Tokyo'),
(4, 4, 'Delivered', 'Cash on Delivery', 'Underground'),
(5, 1, 'Processing', 'Credit Card', 'Reykjavik');

insert into orderitem (orderitemid, orderid, productid, quantity, unitprice) values 
(1, 1, 1, 1, 55000.00),
(2, 1, 4, 2, 3000.00),
(3, 2, 2, 1, 85000.00),
(4, 2, 6, 1, 1500.00),
(5, 3, 3, 2, 15000.00),
(6, 4, 7, 1, 95000.00),
(7, 4, 4, 1, 3000.00),
(8, 5, 5, 4, 12000.00),
(9, 5, 1, 1, 55000.00),
(10, 3, 6, 2, 1500.00);
go

update customer set city = 'Pune' where customerid = 5;

update product set price = 14500.00 where productid = 3;

update orders set orderstatus = 'Shipped' where orderid = 2;

delete from product where productid = 8; 
go

select * from customer;

select * from seller;

select * from product;

select * from orders;

select * from orderitem;

select * from customer where city = 'Reykjavik';

select * from customer where city != 'Reykjavik';

select * from product where price > 50000;

select * from product where price between 10000 and 60000;

select * from product where category in ('Mobile', 'Laptop');

select * from customer where customername like 'T%';

select * from customer where email like '%gmail%';

select * from product where productname like '%Phone%';

select * from orders where orderstatus = 'Delivered';

select * from product where stockquantity < 10;

select * from customer where mobileno is not null;

select * from product where price not between 10000 and 50000;

select * from customer where city in ('Reykjavik', 'Shiganshina');

select * from customer where city = 'Reykjavik' and isactive = 1;

select * from customer where city != 'Tokyo';

select city, count(customerid) as totalcustomers from customer group by city;

select category, count(productid) as totalproducts from product group by category;

select category, sum(stockquantity) as totalstock from product group by category;

select category, max(price) as maxprice from product group by category;

select category, min(price) as minprice from product group by category;

select category, avg(price) as avgprice from product group by category;

select orders.customerid, sum(orderitem.quantity * orderitem.unitprice) as totalamount 
from orders
join orderitem on orders.orderid = orderitem.orderid
group by orders.customerid;

select productid, sum(quantity * unitprice) as totalsales from orderitem group by productid;

select productid, sum(quantity) as totalquantitysold from orderitem group by productid;

select category from product group by category having count(productid) > 1;

select orders.customerid 
from orders
join orderitem on orders.orderid = orderitem.orderid
group by orders.customerid 
having sum(orderitem.quantity * orderitem.unitprice) > 50000;

select sellerid, count(productid) as totalproducts from product group by sellerid;

select product.sellerid, sum(orderitem.quantity * orderitem.unitprice) as totalsales 
from product
join orderitem on product.productid = orderitem.productid
group by product.sellerid;

select orderstatus, count(orderid) as ordercount from orders group by orderstatus;

select city, count(customerid) as customercount from customer group by city order by customercount desc;

select * from product order by price asc;

select * from product order by price desc;

select * from customer order by city asc, customername asc;

select * from orders order by orderdate desc;

select * from product order by category asc, price desc;

select top 3 * from product order by price desc;

select top 5 * from orders order by orderdate desc;

select * from customer order by isactive desc, customername asc;

select * from orders inner join customer on orders.customerid = customer.customerid;

select * from product inner join seller on product.sellerid = seller.sellerid;

select * from orderitem inner join product on orderitem.productid = product.productid;

select customer.customername, orders.orderid, orders.orderdate, product.productname, seller.sellername, orderitem.quantity, orderitem.unitprice
from orders
inner join customer on orders.customerid = customer.customerid
inner join orderitem on orders.orderid = orderitem.orderid
inner join product on orderitem.productid = product.productid
inner join seller on product.sellerid = seller.sellerid;

select * from customer left join orders on customer.customerid = orders.customerid;

select * from orders right join customer on orders.customerid = customer.customerid;

select * from customer full outer join orders on customer.customerid = orders.customerid;

select * from customer cross join product;

select customer.* from customer left join orders on customer.customerid = orders.customerid 
where orders.orderid is null;

select product.* from product left join orderitem on product.productid = orderitem.productid 
where orderitem.orderitemid is null;

select seller.sellername, product.productname 
from seller 
left join product on seller.sellerid = product.sellerid 
order by seller.sellername;

select customer.customername, product.productname 
from customer
join orders on customer.customerid = orders.customerid
join orderitem on orders.orderid = orderitem.orderid
join product on orderitem.productid = product.productid
order by customer.customername;

select orderid, sum(quantity * unitprice) as totalamount from orderitem group by orderid;

select seller.sellername, sum(orderitem.quantity * orderitem.unitprice) as totalsales
from seller
left join product on seller.sellerid = product.sellerid
left join orderitem on product.productid = orderitem.productid
group by seller.sellername;

select product.productname, sum(orderitem.quantity) as totalquantitysold
from product
left join orderitem on product.productid = orderitem.productid
group by product.productname;
