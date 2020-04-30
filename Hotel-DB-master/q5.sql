-- You must not change the next 2 lines or the table definition.

drop table if exists q5 cascade;

create table q5(
    p_id INTEGER,
    highest FLOAT,
    lowest FLOAT,
    range FLOAT,
    star VARCHAR(5)
);

-- Do this for each of the views that define your intermediate steps.  
-- (But give them better names!) The IF EXISTS avoids generating an error 
-- the first time this file is imported.
DROP VIEW IF EXISTS PropertyRentingInfo CASCADE;
DROP VIEW IF EXISTS PropertyRentingPriceAnalysis CASCADE;
DROP VIEW IF EXISTS HighestRange CASCADE;
DROP VIEW IF EXISTS Final CASCADE;


-- Define views for your intermediate steps here:
CREATE VIEW PropertyRentingInfo as
SELECT RentalTerm.rental_id as rental_id, 
Rental.p_id as p_id, RentalTerm.week as week, 
PropertyPrice.price as price
FROM RentalTerm, Rental, PropertyPrice
WHERE RentalTerm.rental_id = Rental.rental_id and
Rental.p_id = PropertyPrice.p_id and RentalTerm.week = PropertyPrice.week;


CREATE VIEW PropertyRentingPriceAnalysis as
SELECT p_id, max(price) as highest, min(price) as lowest, 
(max(price) - min(price)) as range
FROM PropertyRentingInfo
GROUP BY p_id;


CREATE VIEW HighestRange as
SELECT max(range) as highest_range, '*' as star
FROM PropertyRentingPriceAnalysis;

CREATE VIEW Final as
SELECT p_id, highest, lowest, range, star
FROM PropertyRentingPriceAnalysis LEFT JOIN HighestRange
ON PropertyRentingPriceAnalysis.range = HighestRange.highest_range;

-- Your query that answers the question goes below the "insert into" line:
--insert into q5
SELECT * FROM Final;


