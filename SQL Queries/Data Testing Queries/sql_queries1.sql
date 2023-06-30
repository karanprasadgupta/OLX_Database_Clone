
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

-- create trigger if expected price is less than 0
CREATE TRIGGER `before_insert_on_books` BEFORE INSERT ON
`book`
FOR EACH ROW BEGIN
if new.expected_price<=0 then
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Please enter a valid price!!!';
end if;
END

-- create trigger if distance covered is less than 0
CREATE TRIGGER `before_insert_on_cars` BEFORE INSERT ON
`cars`
FOR EACH ROW BEGIN
if new.distance_covered<0 then
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Check distance covered!!!';
end if;
END

-- create trigger if size of television is less than 0
CREATE TRIGGER `before_insert_on_television` BEFORE INSERT ON
`television`
FOR EACH ROW BEGIN
if new.size<0 then
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Check size!!!';
end if;
END

-- using joins to view the tables describing each product along with their ad table for complete information view

select a.ad_id,a.owner_id,b.manufacturer,b.year_of_purchase,
b.distace_covered,b.model_name, b.fuel_type,a.buyer_id from advertisement a
inner join car b on a.ad_id=b.product_id;


-- for books

select a.ad_id,a.owner_id,b.title,b.condition,b.author_name,
a.buyer_id from advertisement a inner join book b on
a.advt_id=b.product_id;
