-- You must not change the next 2 lines or the table definition.

drop table if exists q1 cascade;

create table q1(
    luxury VARCHAR(45),
    l_count INTEGER
);

-- Do this for each of the views that define your intermediate steps.  
-- (But give them better names!) The IF EXISTS avoids generating an error 
-- the first time this file is imported.
DROP VIEW IF EXISTS PropertyWithLuxury CASCADE;

-- Define views for your intermediate steps here:
CREATE VIEW PropertyWithLuxury as
SELECT distinct luxury, count(p_id) as l_count 
FROM PropertyLuxury
Group by luxury;

-- Your query that answers the question goes below the "insert into" line:
--insert into q1
SELECT * FROM PropertyWithLuxury;
 
