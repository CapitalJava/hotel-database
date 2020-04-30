-- You must not change the next 2 lines or the table definition.

drop table if exists q2 cascade;

create table q2(
    at_capacity Boolean,
    avg_rating FLOAT,
    num_rental FLOAT
);

-- Do this for each of the views that define your intermediate steps.  
-- (But give them better names!) The IF EXISTS avoids generating an error 
-- the first time this file is imported.
DROP VIEW IF EXISTS AtCapacityProperty;
DROP VIEW IF EXISTS NotAtCapacityProperty CASCADE;
DROP VIEW IF EXISTS AtCapacityPropertyAvgRating CASCADE;
DROP VIEW IF EXISTS NotAtCapacityPropertyAvgRating CASCADE;
DROP VIEW IF EXISTS AtCapacityFinal CASCADE;
DROP VIEW IF EXISTS NotAtCapacityFinal CASCADE;
DROP VIEW IF EXISTS Final CASCADE;

-- Define views for your intermediate steps here:
CREATE VIEW AtCapacityProperty as
SELECT Property.p_id, Rental.Rental_id, count(RentalGuest.guest_id)
FROM RentalGuest, Rental, Property
WHERE RentalGuest.rental_id = Rental.rental_id and
Rental.p_id = Property.p_id
Group by Property.p_id, Rental.Rental_id
Having count(RentalGuest.guest_id) = Property.capacity;

--Select * from AtCapacityProperty;


CREATE VIEW NotAtCapacityProperty as
SELECT Property.p_id, Rental.rental_id, count(RentalGuest.guest_id)
FROM RentalGuest, Rental, Property
WHERE RentalGuest.rental_id = Rental.rental_id and
Rental.p_id = Property.p_id
Group by Property.p_id, Rental.Rental_id
Having count(RentalGuest.guest_id) < Property.capacity;

--Select * from NotAtCapacityProperty;


CREATE VIEW AtCapacityPropertyAvgRating as
SELECT AtCapacityProperty.p_id, AtCapacityProperty.rental_id, rating
FROM AtCapacityProperty, RatingProperty, Rental
Where AtCapacityProperty.rental_id = Rental.rental_id and
Rental.rental_id = RatingProperty.rental_id and
AtCapacityProperty.p_id = Rental.p_id;

--Select * from AtCapacityPropertyAvgRating;


CREATE VIEW NotAtCapacityPropertyAvgRating as
SELECT NotAtCapacityProperty.p_id, NotAtCapacityProperty.rental_id, rating 
FROM NotAtCapacityProperty, RatingProperty, Rental
Where NotAtCapacityProperty.rental_id = Rental.rental_id and
Rental.rental_id = RatingProperty.rental_id and
NotAtCapacityProperty.p_id = Rental.p_id;

--Select * from NotAtCapacityPropertyAvgRating;


CREATE VIEW AtCapacityFinal as
SELECT True as at_capacity, avg(rating), count(distinct rental_id) as num_rental
FROM AtCapacityPropertyAvgRating
Group By at_capacity;

--Select * from AtCapacityFinal;

CREATE VIEW NotAtCapacityFinal as
SELECT False as at_capacity, avg(rating),count(distinct rental_id) as num_rental
FROM NotAtCapacityPropertyAvgRating
Group By at_capacity;

--Select * from NotAtCapacityFinal;

CREATE VIEW Final as
(Select * From AtCapacityFinal) 
Union 
(Select * From NotAtCapacityFinal);

-- Your query that answers the question goes below the "insert into" line:
--insert into q2
SELECT * FROM Final;

