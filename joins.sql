-- postgres -D /usr/local/var/postgres

CREATE TABLE stats(
id SERIAL PRIMARY KEY,
recorded TIMESTAMP DEFAULT current_date,
inches int,
drought boolean NOT NULL,
city varchar(80)
);

SELECT *
FROM stats;

INSERT INTO stats (recorded, inches, drought, city)
VALUES ('1997-10-02', 20, true, 'Chicago'),
('1997-10-12', 10, true, 'Chicago'),
('2001-11-02', 1, false, 'Detroit'),
('2010-08-05', 3, true, 'Detroit'),
('2010-07-06', 0, false, 'Detroit'),
('2016-09-20', 3, true, 'Las Vegas');

SELECT count(id)
FROM stats;

SELECT MIN(inches), MAX(inches)
FROM stats
WHERE city = 'Detroit';

SELECT SUM(inches)
FROM stats
WHERE city = 'Detroit';

SELECT *
FROM stats
ORDER BY city DESC, inches DESC;

SELECT city, count(*)
FROM stats
GROUP BY city;

SELECT city
FROM stats
GROUP BY city;

SELECT city, SUM(inches)
FROM stats
GROUP BY city;

SELECT city, SUM(inches)
FROM stats
GROUP BY city;



DROP TABLE people;

CREATE TABLE people(
id SERIAL PRIMARY KEY,
first_name varchar(80),
last_name varchar(80)
);

INSERT INTO people (first_name, last_name)
VALUES ('Andy','Wolff'),
('Levi', 'Kohout'),
('Elisa','Lee');

SELECT *
FROM people;

CREATE TABLE jobs(
id SERIAL PRIMARY KEY,
title varchar(80),
people_id int REFERENCES people
);

INSERT INTO jobs (title, people_id)
VALUES ('Baker', 2);

INSERT INTO jobs (title, people_id)
VALUES ('Baker', 1),
('Lawyer',2),
('Magician', 3),
('Teller', 1),
('Bouncer', 1),
('Teller', 1);

SELECT *
FROM jobs;

SELECT * 
FROM people
JOIN jobs
ON people.id = jobs.people_id;

SELECT * 
FROM people
JOIN jobs
ON people.id = jobs.people_id
WHERE first_name = 'Levi';

UPDATE people
SET first_name = 'Levy'
WHERE first_name = 'Levi';

SELECT people.id, first_name, last_name, title
FROM people
JOIN jobs
ON people.id = jobs.people_id
WHERE first_name = 'Levy';

SELECT *
FROM people
JOIN jobs
ON people.id = jobs.people_id
WHERE title = 'Baker';

SELECT *
FROM people
JOIN jobs
ON people.id = jobs.people_id
WHERE lower(title) = lower('baker');

SELECT *
FROM people
JOIN jobs
ON people.id = jobs.people_id
WHERE title LIKE '%a%';

SELECT title, COUNT(people_id)
FROM people
JOIN jobs
ON people.id = jobs.people_id
GROUP BY title;

SELECT *
FROM people;

ALTER TABLE jobs
DROP COLUMN people_id;

SELECT *
FROM people;

SELECT *
FROM jobs;


-- Remove duplicate rows
DELETE FROM jobs
WHERE id = 3
OR id = 8;

CREATE TABLE people_jobs (
people_id int REFERENCES people,
job_id int REFERENCES jobs,
PRIMARY KEY(people_id, job_id) -- The combination can only exist once
);

SELECT *
FROM people_jobs;

INSERT INTO people_jobs
VALUES
(2,2),
(3,4),
(1,4),
(2,5),
(3,6);

INSERT INTO people_jobs
VALUES (3,7);

SELECT *
FROM jobs;

SELECT *
FROM people
JOIN people_jobs ON people.id = people_jobs.people_id
JOIN jobs ON people_jobs.job_id = jobs.id;

SELECT *
FROM people_jobs
JOIN jobs ON people_jobs.job_id = jobs.id;

SELECT *
FROM people
JOIN people_jobs ON people.id = people_jobs.people_id
JOIN jobs ON people_jobs.job_id = jobs.id
WHERE first_name = 'Andy';

INSERT INTO people_jobs
VALUES ((SELECT id
FROM people
WHERE first_name = 'Andy'),
(SELECT id
FROM jobs
WHERE title ILIKE '%ake%'
LIMIT 1));

INSERT INTO people
VALUES (4, 'Jeff', 'Miller');

SELECT *
FROM people
JOIN people_jobs ON people.id = people_jobs.people_id
JOIN jobs ON people_jobs.job_id = jobs.id;


SELECT *
FROM people
LEFT JOIN people_jobs ON people.id = people_jobs.people_id
LEFT JOIN jobs ON people_jobs.job_id = jobs.id;

INSERT INTO jobs(title)
VALUES('Instructor');




SELECT *
FROM people
LEFT JOIN people_jobs ON people.id = people_jobs.people_id
LEFT JOIN jobs ON people_jobs.job_id = jobs.id;

SELECT *
FROM people
LEFT JOIN people_jobs ON people.id = people_jobs.people_id
RIGHT JOIN jobs ON people_jobs.job_id = jobs.id;




