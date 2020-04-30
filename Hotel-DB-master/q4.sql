-- You must not change the next 2 lines or the table definition.

drop table if exists q4 cascade;

create table q4(
    water_avg FLOAT,
    city_avg FLOAT,
    other_avg FLOAT
);

-- Do this for each of the views that define your intermediate steps.  
-- (But give them better names!) The IF EXISTS avoids generating an error 
-- the first time this file is imported.
DROP VIEW IF EXISTS ExtraGuests CASCADE;
DROP VIEW IF EXISTS ExtraGuestsProperty CASCADE;
DROP VIEW IF EXISTS ExtraGuestsWaterProperty CASCADE;
DROP VIEW IF EXISTS ExtraGuestsCityProperty CASCADE;
DROP VIEW IF EXISTS ExtraGuestsOtherProperty CASCADE;
DROP VIEW IF EXISTS WaterTypeCount CASCADE;
DROP VIEW IF EXISTS WaterTypeAverage CASCADE;
DROP VIEW IF EXISTS CityTypeCount CASCADE;
DROP VIEW IF EXISTS CityTypeAverage CASCADE;
DROP VIEW IF EXISTS OtherTypeCount CASCADE;
DROP VIEW IF EXISTS OtherTypeAverage CASCADE;
DROP VIEW IF EXISTS Final CASCADE;

-- Define views for your intermediate steps here:
CREATE VIEW ExtraGuests as
(SELECT rental_id, guest_id FROM RentalGuest) EXCEPT
(SELECT rental_id, renter_id as guest_id From Rental); 

CREATE VIEW ExtraGuestsProperty as
SELECT Rental.rental_id as rental_id, guest_id, p_id
From Rental, ExtraGuests
WHERE Rental.rental_id = ExtraGuests.rental_id;

CREATE VIEW ExtraGuestsWaterProperty as
SELECT DISTINCT rental_id, guest_id, ExtraGuestsProperty.p_id as p_id
FROM ExtraGuestsProperty, WaterProperty
WHERE ExtraGuestsProperty.p_id = WaterProperty.p_id;

CREATE VIEW ExtraGuestsCityProperty as
SELECT rental_id, guest_id, ExtraGuestsProperty.p_id as p_id
FROM ExtraGuestsProperty, CityProperty
WHERE ExtraGuestsProperty.p_id = CityProperty.p_id;

CREATE VIEW ExtraGuestsOtherProperty as
((SELECT * FROM ExtraGuestsProperty) EXCEPT
(SELECT * FROM ExtraGuestsWaterProperty)) EXCEPT
(SELECT * FROM ExtraGuestsCityProperty);

CREATE VIEW WaterTypeCount as
SELECT COUNT(guest_id) as guest_num
FROM ExtraGuestsWaterProperty
GROUP BY rental_id;


CREATE VIEW WaterTypeAverage as
SELECT avg(guest_num) as water_avg
FROM WaterTypeCount;

CREATE VIEW CityTypeCount as
SELECT COUNT(guest_id) as guest_num
FROM ExtraGuestsCityProperty
GROUP BY rental_id;

CREATE VIEW CityTypeAverage as
SELECT avg(guest_num) as city_avg
FROM CityTypeCount;

CREATE VIEW OtherTypeCount as
SELECT COUNT(guest_id) as guest_num
FROM ExtraGuestsOtherProperty
GROUP BY rental_id;

CREATE VIEW OtherTypeAverage as
SELECT avg(guest_num) as other_avg
FROM OtherTypeCount;

CREATE VIEW Final as
SELECT city_avg, water_avg, other_avg
FROM WaterTypeAverage, CityTypeAverage, OtherTypeAverage;

-- Your query that answers the question goes below the "insert into" line:
--insert into q4
Select * FROM Final;
