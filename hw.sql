-- 1. List all customers who live in Texas (use JOINs)
SELECT first_name, last_name, district
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON city.city_id = address.city_id
WHERE district = 'Texas';

-- 2. Get all payments above $6.99 with the Customer's Full Name
SELECT first_name, last_name, amount
FROM customer 
INNER JOIN payment 
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99
ORDER BY amount ASC;

-- 3. Show all customers names who have made payments over $175(use subqueries)
SELECT first_name, last_name
FROM customer 
WHERE customer_id IN (
    SELECT customer_id
    FROM payment 
    GROUP BY customer_id 
    HAVING SUM(amount) > 175
    ORDER BY SUM(amount) DESC
);

-- 4. List all customers that live in Nepal (use the city table)
SELECT first_name, last_name, country
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON city.city_id = address.city_id
INNER JOIN country
ON country.country_id = city.country_id
WHERE country = 'Nepal';

-- 5. Which staff member had the most transactions?

-- Jon Stephens = 7304 transactions 
SELECT first_name, last_name, (
    SELECT COUNT(staff_id) AS transactions
    FROM payment
    WHERE staff_id = 2
)
FROM staff
WHERE staff_id = 2;

-- Mike Hillyer = 7294 transactions 
SELECT first_name, last_name, (
    SELECT COUNT(staff_id) AS transactions
    FROM payment
    WHERE staff_id = 1
)
FROM staff
WHERE staff_id = 1;


-- 6. How many movies of each rating are there?

-- I know this answer is wrong. I just didn't know what else to do. 
-- It seems like all the needed info is only in one table.
-- It's obvious all these answers could've been written in a regular query such as this one:

SELECT rating, COUNT(rating) as movies_rated_PG
FROM film
WHERE rating = 'PG'
GROUP BY rating;

-- ALL 5 RATINGS IN THEIR OWN SUBQUERIES: 
-- R has 195 movies 
SELECT DISTINCT rating, (
    SELECT COUNT(rating) as movies_rated_R
    FROM film
    WHERE rating = 'R'
)
FROM film
WHERE rating = 'R';

-- PG-13 has 223 movies 
SELECT DISTINCT rating, (
    SELECT COUNT(rating) as movies_rated_PG_13
    FROM film
    WHERE rating = 'PG-13'
)
FROM film
WHERE rating = 'PG-13';

-- NC-17 has 209 movies 
SELECT DISTINCT rating, (
    SELECT COUNT(rating) as movies_rated_NC_17
    FROM film
    WHERE rating = 'NC-17'
)
FROM film
WHERE rating = 'NC-17';

-- G has 179 movies 
SELECT DISTINCT rating, (
    SELECT COUNT(rating) as movies_rated_G
    FROM film
    WHERE rating = 'G'
)
FROM film
WHERE rating = 'G';

-- PG has 194 movies 
SELECT DISTINCT rating, (
    SELECT COUNT(rating) as movies_rated_PG
    FROM film
    WHERE rating = 'PG'
)
FROM film
WHERE rating = 'PG';

-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT first_name, last_name
FROM customer 
WHERE customer_id IN (
    SELECT customer_id
    FROM payment 
    WHERE amount > 6.99
);

-- 8. How many free rentals did our stores give away?

-- Is this a trick question? :(

-- The amount of $0.00 doesn't exist in payment so,
-- how can a rental be recognized as free? And even if $0.00 
-- was in there I still wouldn't know how to put two tables together. 
-- Since it seems like all the needed info is in one table.


-- Counted NULL return dates in a suquery bc idk what to do at this point:
-- UNNECESSARY SUBQUERY OF COUNTED NULLS:
SELECT DISTINCT return_date, (
    SELECT COUNT(*) AS FREE_RENTALS
    FROM rental
    WHERE return_date IS NULL
)
FROM rental
WHERE return_date IS NULL;