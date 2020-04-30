insert into host values
(1, 'luke@gmail.com'),
(2, 'leia@gmail.com'),
(3, 'han@gmail.com');

insert into guest values
(1, 'Darth Vader', '1985-12-06', 'Death Star'),
(2, 'Leia, Princess', '2001-10-05', 'Alderaan'),
(3, 'Romeo Montague','1988-05-11','Verona'),
(4, 'Juliet Capulet', '1991-07-24', 'Verona'),
(5, 'Mercutio', '1988-03-03', 'Verona'),
(6, 'Chewbacca', '1998-09-15', 'Kashyyyk');




insert into property values
(1, 3, 1, 6, 'Tatooine', 1),
(2, 1, 1, 2, 'Alderaan', 2),
(3, 2, 1, 3, 'Corellia', 3),
(4, 2, 1, 2, 'Verona', 2),
(5, 2, 2, 4, 'Florence', 3),
(6, 1, 1, 2, 'Toronto', 1);

insert into propertyluxury values
(1, 'hot tub'),
(1, 'daily cleaning'),
(2, 'sauna'),
(2, 'hot tub'),
(2, 'daily cleaning'),
(3, 'daily breakfast delivery'),
(3, 'concierge service'),
(4, 'laundry service'),
(5, 'hot tub'),
(6, 'sauna'),
(6, 'laundry service'),
(6, 'hot tub'),
(6, 'daily cleaning'),
(6, 'concierge service');

insert into propertyprice values
(2, '2019-01-05', 580),
(3, '2019-01-12', 750),
(3, '2019-01-19', 750),
(2, '2019-01-12', 600),
(5, '2019-01-05', 1000),
(5, '2019-01-12', 1220);

insert into cityproperty values
(3, 20, 'bus');

insert into waterproperty values
(2, 'lake', false);




insert into rental values
(1, 2, 1, '3466704824219330'),
(2, 3, 2, '6011253896008199'),
(3, 2, 3, '5446447451075463'),
(4, 5, 5, '4666153163329984'),
(5, 5, 6, '6011624297465933');

insert into rentalguest values
(1, 1),
(1, 2),
(2, 2),
(2, 3),
(2, 4),
(3, 3),
(3, 4),
(4, 5),
(4, 3),
(4, 1),
(5, 6),
(5, 2);

insert into rentalterm values
(1, '2019-01-05'),
(2, '2019-01-12'),
(3, '2019-01-12'),
(4, '2019-01-05'),
(5, '2019-01-12');





insert into ratingproperty values
(1, 2, 5),
(1, 1, 2),
(2, 3, 5),
(2, 4, 5),
(2, 2, 1),
(3, 4, 5),
(4, 5, 1),
(4, 3, 1),
(5, 6, 3);


insert into ratinghost values
(1, 2),
(2, 5),
(3, 3),
(4, 4), 
(5, 4);

insert into propertycomment values
(1, 1, 'Looks like she hides rebel scum here.'),
(2, 2, 'A bit scruffy, could do with more regular housekeeping'),
(5, 6, 'Fantastic, arggg');

insert into guestnumcap values
(1, 2, 2),
(2, 3, 3),
(3, 2, 2),
(4, 3, 3),
(5, 2, 4);




