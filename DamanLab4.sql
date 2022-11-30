create database website;
use website;
create table supplier(
supp_id int primary key , supp_name varchar(50) not null, supp_city varchar(50) not null,
 supp_phone varchar(50) not null);
create table customer(
cus_id int primary key , cus_name varchar(20) not null, cus_city varchar(30) not null,
 cus_phone varchar(10) not null, cus_gender char);
create table category(
cat_id int primary key , cat_name varchar(20) not null);
create table product(
pro_id int primary key , pro_name varchar(20) not null default "dummy", pro_desc varchar(60), 
cat_id int, foreign key(cat_id) references category(cat_id));  
create table supplier_pricing(
pricing_id int primary key,  pro_id int, supp_id int, supp_price int default 0,
foreign key(pro_id) references product(pro_id),
foreign key(supp_id) references supplier(supp_id));
create table orders(
ord_id int primary key, ord_amount int not null, ord_date date not null, 
cus_id int, pricing_id int, 
foreign key(cus_id) references customer(cus_id),
foreign key(pricing_id) references supplier_pricing(pricing_id));
create table rating(
rat_id int primary key, ord_id int, rat_ratstars int not null,
foreign key(ord_id) references orders(ord_id));

insert into supplier values(1,"Rajesh Retails","Delhi",'1234567890');
insert into supplier values(2,"Apprio Ltd","Mumbai",'2589631470');
insert into supplier values(3,"Knome products","Bangalore",'9785462315');
insert into supplier values(4,"Bansal Retails","Kochi",'8975463285');
insert into supplier values(5,"Mittal Ltd","Lucknow",'7898456532');

insert into customer values(1,"Aakash","Delhi",'9999999999','M');
insert into customer values(2,"Aman","Noida",'9785463215','M');
insert into customer values(3,"Neha","Mumbai",'9999999999','F');
insert into customer values(4,"Megha","Kolkata",'9994562399','F');
insert into customer values(5,"Pulkit","Lucknow",'7895999999','M');

insert into category values(1,"BOOKS");
insert into category values(2,"GAMES");
insert into category values(3,"GROCERIES");
insert into category values(4,"ELECTRONICS");
insert into category values(5,"CLOTHES");

insert into product values(1,"GTA V","Windows 7 and above with i5 processor and 8GB RAM",2);
insert into product values(2,"TSHIRT","SIZE-L with Black, Blue and White variations",5);
insert into product values(3,"ROG LAPTOP"," Windows 10 with 15inch screen, i7 processor 1TB SSD",4);
insert into product values(4,"OATS"," Highly Nutritious from Nestle",3);
insert into product values(5,"HARRY POTTER","Best Collection of all time by J.K Rowling",1);
insert into product values(6,"MILK","1L Toned MIlk",3);
insert into product values(7,"Boat Earphones","1.5 Meter long Dolby Atmos",4);
insert into product values(8,"Jeans	Stretchable","Denim Jeans with various sizes and color",5);
insert into product values(9,"Project IGI","compatible with windows 7 and above",2);
insert into product values(10,"Hoodie","Black GUCCI for 13 yrs and above",5);
insert into product values(11,"Rich Dad Poor Dad","Written by Robert Kiyosaki	",1);
insert into product values(12,"Train Your Brain","By Shireen Stephen",1);

insert into supplier_pricing values(1,1,2,1500);
insert into supplier_pricing values(2,3,5,30000);
insert into supplier_pricing values(3,5,1,3000);
insert into supplier_pricing values(4,2,3,2500);
insert into supplier_pricing values(5,4,1,1000);
insert into supplier_pricing values(6,12,2,780);
insert into supplier_pricing values(7,12,4,789);
insert into supplier_pricing values(8,3,1,31000);
insert into supplier_pricing values(9,1,5,1450);
insert into supplier_pricing values(10,4,2,999);
insert into supplier_pricing values(11,7,3,549);
insert into supplier_pricing values(12,7,4,529);

insert into orders values(101,1500,'2021-10-12',3,5);
insert into orders values(102,1000,'2021-10-12',3,5);
insert into orders values(103,30000,'2021-09-16',3,5);
insert into orders values(104,1500,'2021-10-05',3,5);
insert into orders values(105,3000,'2021-08-16',3,5);
insert into orders values(106,1450,'2021-08-18',3,5);
insert into orders values(107,1500,'2021-09-01',3,5);
insert into orders values(108,789,'2021-09-07',3,5);
insert into orders values(109,780,'2021-01-10',3,5);
insert into orders values(110,3000,'2021-09-10',3,5);
insert into orders values(111,2500,'2021-09-15',3,5);
insert into orders values(112,1000,'2021-09-16',3,5);
insert into orders values(113,789,'2021-09-16',3,5);
insert into orders values(114,31000,'2021-09-16',3,5);
insert into orders values(115,1000,'2021-09-16',3,5);
insert into orders values(116,99,'2021-09-17',3,5);

insert into rating values(1,101,4);
insert into rating values(2,102,3);
insert into rating values(3,103,1);
insert into rating values(4,104,2);
insert into rating values(5,105,4);
insert into rating values(6,106,3);
insert into rating values(7,107,4);
insert into rating values(8,108,4);
insert into rating values(9,109,3);
insert into rating values(10,110,5);
insert into rating values(11,111,3);
insert into rating values(12,112,4);
insert into rating values(13,113,2);
insert into rating values(14,114,1);
insert into rating values(15,115,1);
insert into rating values(16,116,0);

select cus_name, cus_gender, ord_amount
from cutomer, orders where 
customer.cus_id=orders.cus_id 
group by cus_gender having
ord_amount>3000;

select product pro_name,orders. * from orders, supplier_pricing,
 product where orders.pricing_id=supplier_pricing.pricing_id and
 supplier_pricing.pro_id=product.pro_id and
 orders.cus_id =2;

select supplier . * from
supplier where
supplier.supp_id in
(select supp_id from supplier_pricing group by
supp_id having count (supp_id) >1);

select cat_id, pro_id , supp_pricing from 
category, supplier_pricing, product where 
category.cat_id=product.cat_id and
product.pro_id=supplier_pricing.pro_id
group by category.cat_id;

select product.pro_id, prodcut pro_name from
orders, supplier_pricing, product where
product.pro_id=supplier_pricing.pro_id and
supplier_pricing.pricing_id=orders.pricing_id and
ord_date > "2021-10-05";

select customer.cusname_name,customer.cus_gender from
customer where customer.cus_name like 'A%' or 
customer.cus_name like'%A';


select report.supp_id.report supp_name,report Average,
case
when report .Average=5 then 'Excellent Service'
when report .Average>4 then 'Excellent Service'
when report .Average>2 then 'Excellent Service'
else'Poor Service'
end as Type_of_Service from 
supplier;








