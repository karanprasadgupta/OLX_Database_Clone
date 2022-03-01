
-- view all active ads of users

Select u.phone,ad.adv_id,ad.adv_title
from users as u,advertisement as ad
where ad.is_active='Y' and ad.user_id=u.phone
Group by phone;


-- view  detailsof all products in the cars category whose manufacturing is more than 2000 and fuel type is petrol or hybrid and distance covered less than 150000

Select distinct ad.prdouct_id,ad.adv_title,p.idproduct,p.description,p.price,p.area_id,c.manufacturer,c.model_name,c.year_of_purchase,c.distance_covered,c.fuel
from cars as c, product as p, advertisement as ad
where c.distance_covered<=150000 and (c.fuel='Petrol' or c.fuel='Hybrid') and c.id_cars=p.idproduct and p.idproduct=ad.prdouct_id


-- A view of all product with all necessary basic details

create view all_products as
select concat(u.first_name,' ',u.last_name) as Product_Owner,ad.adv_title,ad.verification_status,p.description,cat.name,p.price,ad.is_active
from product as p, advertisement as ad, users as u,category as cat
where p.idproduct=ad.prdouct_id and ad.user_id=u.phone and p.category_id=cat.idcategory;


-- count user joining every year

select year(d.joining_date), count(*)
from users as d
Group by year(d.joining_date)
order by year(d.joining_date) desc;


-- show chat between two users

SET @user1 = '9835335356', @user2 = '9776132442';
select distinct *
from message as m
where (m.sender_id=@user1 and m.reciever_id=@user2) or (m.sender_id=@user2 and m.reciever_id=@user1)
order by m.timestamp; 


-- view average prie of product in category cars

select avg(price)
from product natural right outer join cars
where idproduct=id_cars;


-- verify a user i.e, update verification status 

UPDATE olx.users
set Status ='Verified'
where phone='9978515081';

-- create a role olxuser and give view permission on a view

CREATE USER 'olxuser'@'localhost’;
GRANT select ON all_products TO 'olxuser'@'localhost' WITH GRANT OPTION;
select * from all_products;

-- search most expensive product

with max_price(maxpr) as (select max(price) from product)
select * from all_products as ap,max_price
where ap.price=max_price.maxpr;

-- view product having 'some text' in description and price >20000;

select * 
from all_products as pr
where pr.description like '%integer%’
having pr.price>20000;
