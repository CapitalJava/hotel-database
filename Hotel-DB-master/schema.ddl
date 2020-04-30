--Constraints

--The constraint "all guests for a rental must be registered for full length of
--the rental" could not be enforced.
--The constraint "renter's age must be bigger than or equal to 18" could have
--been enforced by making a table with attributes renter_id, dob and rental_week
--then using 'CHECK' to check the constraint.
--However the table has a problem of redundancy (renter_id implies dob).So it 
--were not enforced even though it could have been enforced.


DROP SCHEMA IF EXISTS vacationschema cascade;
CREATE SCHEMA vacationschema;
SET search_path TO vacationschema;


-- About people involved in the activities

-- A person who own the property each with email address and a unique host_id 
-- Two different host and have the same email address
CREATE TABLE Host (
  host_id integer PRIMARY KEY,
  email varchar(30) NOT NULL
);

-- Guests's information, each guest have a unique guest_id,  
-- a name, a date of birth and a address
CREATE TABLE Guest (
  guest_id integer NOT NULL PRIMARY KEY,
  name varchar(45) NOT NULL,
  dob date NOT NULL,
  address varchar NOT NULL  
);



-- About properties

-- Properties' information, each with unique p_id, number_bathroom, 
-- number_bedroom, living capacity, host_id and address of the property
CREATE TABLE Property (
  p_id integer PRIMARY KEY,
  number_bathroom integer NOT NULL,
  number_bedroom integer NOT NULL,
  capacity integer NOT NULL,
  address varchar NOT NULL UNIQUE,
  host_id integer NOT NULL REFERENCES Host,
  CHECK (number_bedroom <= capacity)
) ;

-- Luxuries included in different properties with p_id of all properties 
-- and luxuries they have equipped
CREATE TABLE PropertyLuxury (
  p_id integer NOT NULL REFERENCES Property,
  luxury varchar(45) NOT NULL,
  PRIMARY KEY (p_id, luxury),
  CONSTRAINT Luxury CHECK (luxury in ('hot tub','daily cleaning','sauna',
  	'daily breakfast delivery','concierge service','laundry service'))
) ;

-- Price information of all properties in their booked weeks
CREATE TABLE PropertyPrice (
  p_id integer NOT NULL REFERENCES Property,
  week date NOT NULL,
  price float NOT NULL,
  PRIMARY KEY (p_id, week),
  CONSTRAINT Weekday CHECK (EXTRACT(DOW FROM week) = 6)
) ;

-- City properties' information each has p_id to indecates which properties 
-- belong to this category, walkability score and cloest type of transit
CREATE TABLE CityProperty (
  p_id integer PRIMARY KEY REFERENCES Property,
  walk float NOT NULL,
  type_transit varchar(10) NOT NULL,
  CONSTRAINT Walk CHECK (walk >= 0 AND walk <= 100),
  CONSTRAINT Type_Transit CHECK (type_transit in ('bus','LRT','subway', 'none'))
) ;

-- Water properties' information each has p_id to indecates which properties 
-- belong to this category, water type and if they ever had life gurad
CREATE TABLE WaterProperty (
  p_id integer NOT NULL REFERENCES Property,
  water_type varchar(10) NOT NULL,
  life_guard boolean NOT NULL,
  PRIMARY KEY(p_id, water_type),
  CONSTRAINT Water_Type CHECK (water_type in ('pool','beach','lake'))
) ;



-- Rental activities

-- Rental information, each has unique rental_id, p_id to indicates which 
-- property is rented out, renter_id for who rents that property and host_id
-- for who host that property
CREATE TABLE Rental (
   rental_id integer PRIMARY KEY,
   p_id integer NOT NULL REFERENCES Property, 
   renter_id integer NOT NULL REFERENCES Guest,
   card_num varchar(45) NOT NULL
);

-- Record all guests of each rental
CREATE TABLE RentalGuest (
  rental_id integer NOT NULL REFERENCES Rental,
  guest_id integer NOT NULL REFERENCES Guest,
  PRIMARY KEY(guest_id, rental_id)    
) ;

-- Each row indicates in which weeks the property is rent out with rental_id of 
-- that rental
CREATE TABLE RentalTerm (
  rental_id integer NOT NULL REFERENCES Rental,
  week date NOT NULL,
  PRIMARY KEY (rental_id, week),
  CONSTRAINT Weekday CHECK (EXTRACT(DOW FROM week) = 6)
) ;


-- About Ratings and comments

-- Ratings of properties, it has a rental_id, a guest_id indecates who rates 
-- the property and the rating of the property
CREATE TABLE RatingProperty (
  rental_id integer NOT NULL,
  guest_id integer NOT NULL,
  rating float NOT NULL,
  FOREIGN KEY (rental_id,guest_id) REFERENCES RentalGuest (rental_id,guest_id),
  PRIMARY KEY (rental_id,guest_id),
  CONSTRAINT Rating CHECK (rating >= 0 AND rating <= 5)
) ;

-- Ratings of hosts, with rental_id and the rating for the host of that rental
CREATE TABLE RatingHost (
  rental_id integer PRIMARY KEY REFERENCES Rental,
  rating float NOT NULL 
) ;

-- Comments left to hosts, with rental_id, guest_id for who gives the comment 
-- and the comment for the host of that rental
CREATE TABLE PropertyComment (
  rental_id integer NOT NULL,
  guest_id integer NOT NULL,
  comment varchar NOT NULL,
  FOREIGN KEY (rental_id,guest_id)
  	REFERENCES RatingProperty (rental_id,guest_id),
  PRIMARY KEY (rental_id, guest_id)
) ;


-- About Constraint

-- The table contains guest_num of every rental and the capacity of the property.
CREATE TABLE GuestNumCap (
  rental_id integer PRIMARY KEY REFERENCES Rental,
  guest_num integer NOT NULL,
  capacity integer NOT NULL,
  CHECK (guest_num <= capacity)
) ;










