use zomato_analysis;

select * from zomatasql;
ALTER TABLE zomatasql
DROP COLUMN Datekey_Opening;

# Build a Calendar Table using the Columns Datekey_Opening
select * from zomatasql;
alter table zomatasql
add column datekey_column date;


UPDATE zomatasql
SET datekey_column = STR_TO_DATE(CONCAT(`Year Opening`, '-', `Month Opening`, '-', `day Opening`), '%Y-%m-%d');

##Q2 
select year(datekey_column) years,
month(datekey_column) months,
day (datekey_column) days,
monthname(datekey_column) monthname,quarter(datekey_column) as quarter,
concat(year(datekey_column),'_',monthname(datekey_column)) yearmonth,
weekday(datekey_column) weekday,
dayname(datekey_column) dayname,

case when monthname(datekey_column) in ('January','February','March') then 'Q1'
WHEN monthname(Datekey_column) in ('April','May','June') then 'Q2'
WHEN monthname(Datekey_column) in ('July','August','September') then 'Q3'
else 'Q4' end as quarters,

case when monthname(datekey_column)='January' then 'FM1O'
when monthname(datekey_column)='January' then 'FM11'
when monthname(datekey_column)='February' then 'FM12'
when monthname(datekey_column)='March' then 'FM1'
when monthname(datekey_column)='April' then 'FM2'
when monthname(datekey_column)= 'May' then 'FM3'
when monthname(datekey_column)='June' then 'FM4'
when monthname(datekey_column)='July' then 'FM5'
when monthname(datekey_column)='August' then 'FM6'
when monthname(datekey_column)='September' then 'FM7'
when monthname(datekey_column)='October' then 'FM8'
when monthname(datekey_column)='November' then 'FM9'
when monthname(datekey_column)='December' then 'FM10'
END Financial_Months

from zomatasql;

###Find the number of Restuarants based on cities and country.
select c.Countryname,zo.City,count(zo.RestaurantID) as no_of_Restaurant
from zomatasql zo inner join country c 
on zo.CountryCode = c.CountryID
group by c.Countryname , zo.City;

SELECT
    c.Countryname,
    zo.City,
    COUNT(zo.RestaurantID) AS NumberOfRestaurants
FROM
    zomatasql zo
INNER JOIN
    country c ON zo.CountryCode = c.CountryID
GROUP BY
    c.Countryname, zo.City;


#4.Numbers of Resturants opening based on Year , Quarter , Month.
select year(datekey_opening)year,quarter(datekey_opening)quarter,monthname(datekey_opening)monthname,count(RestaurantID) as no_of_restaurantid
from zomatasql group by year(datekey_opening), quarter(datekey_opening),monthname(datekey_opening)
order by year(datekey_opening),quarter(datekey_opening),monthname(datekey_opening);


##Count of Resturants based on Averagw Ratings
select case when rating <=2 then '0-2' when rating <=3 then '2-3' when rating <=4 then '3-4' when rating <=5 then '4-5' end rating_range, count(RestaurantId)
from zomatasql
group by rating_range
order by rating_range;

##Create bucket based on average price of reasonable size and find out how many resturants falls in each buckets
select case when price_range = 1 then '0-500' when price_range = 2 then '500-3000' when price_range = 3 then '3000-10000' when price_range = 4 then '>10000' 
end price_range,
count(RestaurantID)
from zomatasql
group by Price_range
order by Price_range;


##Percentage of restaurants based on 'Has_online_delivery'
select has_online_delivery, concat(round(count(has_online_delivery/100),1),'%') percentage
from zomatasql
group by Has_Online_delivery;

##Percentage of restaurants based on 'has_table_booking'
select has_table_booking, concat(round(count(has_table_booking/100),1),'%') percentage
from zomatasql
group by Has_Table_booking;

