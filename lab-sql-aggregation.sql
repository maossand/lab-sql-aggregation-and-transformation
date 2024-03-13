## CHALLENGE 1
## 		1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
USE sakila;

SELECT max(length) as max_duration, min(length) as min_duration FROM film; ##option 1

SELECT title AS film_title, length ##we can see which movies have either the min or max length
FROM film
WHERE length = (SELECT MAX(length) FROM film)
   OR length = (SELECT MIN(length) FROM film);

## 		1.2. Express the average movie duration in hours and minutes. Don't use decimals.
## Hint: Look for floor and round functions.

SELECT title AS film_title, ROUND(length / 60, 1) as length_hours ##we can see which movies have either the min or max length
FROM film;

SELECT COUNT(*), ROUND(AVG(length) / 60 , 1) as avg_duration FROM film;

## You need to gain insights related to rental dates:

## 2.1 Calculate the number of days that the company has been operating.
## Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the 
## rental_date column from the latest date.

SELECT DATEDIFF(MAX(rental_date),MIN(rental_date)) as operating_time_dyas from rental;
##DATEDIFF takes the dfifference between the days in the respective format

## 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. 
## Return 20 rows of results.

SELECT *, 
SUBSTRING(rental_date, 6, 2) as rental_month, 
SUBSTRING(rental_date, 9, 2) as rental_weekday
FROM rental
LIMIT 20;

## 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' 
## or 'workday', depending on the day of the week.
## Hint: use a conditional expression.

SELECT *,
MONTHNAME(rental_date) as rent_month,
DAYNAME(rental_date) as rent_day,
IF (DAYNAME(rental_date)="saturday" or "sunday", "weekend", "weekday") as dayname
FROM rental;

## 3. You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.

SELECT title, IFNULL(rental_duration, "Not Available") as rental_duration
FROM film;

## Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
## Hint: Look for the IFNULL() function.
## 

##CHALLENGE 2
## Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
## 1.1 The total number of films that have been released.

SELECT COUNT(*) as total_films
FROM film
GROUP BY release_year;

## 1.2 The number of films for each rating.

SELECT rating, COUNT(*) as total_films
FROM film
GROUP BY rating;

## 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.

SELECT rating, COUNT(*) as total_films
FROM film
GROUP BY rating
ORDER BY total_films DESC;

## Using the film table, determine:
## 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.

SELECT rating, ROUND(AVG(length),2) as avg_duration
FROM film
GROUP BY rating
ORDER BY rating DESC;

## 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.

SELECT rating, ROUND(AVG(length),2) as avg_duration
FROM film
GROUP BY rating
HAVING AVG(length) / 60 > 2
ORDER BY rating DESC;

## Bonus: determine which last names are not repeated in the table actor.

SELECT DISTINCT last_name as non_repeated_last_names
FROM actor;
