-- You must not change the next 2 lines or the table definition.

drop table if exists q3 cascade;

create table q3(
    avg_rating FLOAT,
    highest_price FLOAT,
    email VARCHAR(30)
);

-- Do this for each of the views that define your intermediate steps.  
-- (But give them better names!) The IF EXISTS avoids generating an error 
-- the first time this file is imported.
DROP VIEW IF EXISTS HostAverageRating CASCADE;
DROP VIEW IF EXISTS HighestAvg CASCADE;
DROP VIEW IF EXISTS HostHighestAvg CASCADE;
DROP VIEW IF EXISTS PropertyRentingInfo CASCADE;
DROP VIEW IF EXISTS HostRentingHighestPrice CASCADE;
DROP VIEW IF EXISTS Final CASCADE;


-- Define views for your intermediate steps here:
CREATE VIEW HostAverageRating as
SELECT Property.host_id as host_id, avg(rating) as avg_rating
FROM RatingHost, Rental, Property
WHERE RatingHost.rental_id = Rental.rental_id and Rental.p_id = Property.p_id
GROUP BY Property.host_id;

CREATE VIEW HighestAvg as
SELECT max(avg_rating) as highest_rating
FROM HostAverageRating;

CREATE VIEW HostHighestAvg as
SELECT host_id, avg_rating
FROM HostAverageRating, HighestAvg
WHERE avg_rating = highest_rating;

CREATE VIEW PropertyRentingInfo as
SELECT RentalTerm.rental_id as rental_id, 
Rental.p_id as p_id, RentalTerm.week as week, 
PropertyPrice.price as price
FROM RentalTerm, Rental, PropertyPrice
WHERE RentalTerm.rental_id = Rental.rental_id and
Rental.p_id = PropertyPrice.p_id and RentalTerm.week = PropertyPrice.week;

CREATE VIEW HostRentingHighestPrice as
SELECT Property.host_id as host_id, max(price) as highest_price
FROM PropertyRentingInfo, Property
WHERE PropertyRentingInfo.p_id = Property.p_id
GROUP BY Property.host_id;

CREATE VIEW Final as
SELECT email, avg_rating, highest_price
FROM HostHighestAvg, HostRentingHighestPrice, Host
WHERE HostHighestAvg.host_id = HostRentingHighestPrice.host_id 
and HostRentingHighestPrice.host_id = Host.host_id;


-- Your query that answers the question goes below the "insert into" line:
--insert into q3
SELECT * FROM Final;







