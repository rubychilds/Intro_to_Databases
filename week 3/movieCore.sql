
--1. Find the titles of all movies directed by Steven Spielberg. 


SELECT title
FROM Movie
WHERE director='Steven Spielberg'
ORDER BY title ASC



-- 2. Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order.


SELECT DISTINCT year
FROM Movie, rating
WHERE Movie.mID = rating.mID and stars > 3
ORDER BY year ASC

-- Alternative:
SELECT DISTINCT year
FROM Movie
NATURAL JOIN rating
WHERE  stars > 3
ORDER BY year ASC


-- 3. Find the titles of all movies that have no ratings. 


SELECT DISTINCT title
FROM Movie
WHERE Movie.mID NOT IN (SELECT DISTINCT mID FROM rating)

-- Alternative
SELECT title 
FROM Movie
LEFT JOIN Rating On Movie.mID = Rating.mID
WHERE rID IS NULL


-- 4. Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a NULL value for the date


SELECT DISTINCT Reviewer.name
FROM rating, Reviewer
WHERE rating.rID = Reviewer.rID and rating.ratingDate IS NULL

SELECT DISTINCT Reviewer.name
FROM Reviewer
NATURAL JOIN Rating ON rating.rID = Reviewer.rID
WHERE rating.ratingDate IS NULL

-- 5. Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars. 



SELECT DISTINCT Reviewer.name, Movie.title, rating.stars, rating.ratingDate
FROM Reviewer, Movie, rating
WHERE Reviewer.rID = rating.rID and Movie.mID = rating.mid


-- 6. For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, return the reviewer's name and the title of the movie. 


SELECT DISTINCT name, title
FROM Movie, Reviewer, rating R1, rating R2
WHERE R1.mID = Movie.mID 
and Reviewer.rID = R1.rID
and R1.rID = R2.rID
and R1.mID = R2.mID
and R1.ratingDate < R2.ratingDate
and R1.stars < R2.stars


-- 7. For each movie that has at least one rating, find the highest number of stars that movie received. Return the movie title and number of stars. Sort by movie title


SELECT title, max(stars)
FROM Rating NATURAL JOIN
GROUP BY mID
ORDER BY title ASC


-- 8. List movie titles and average ratings, from highest-rated to lowest-rated. If two or more movies have the same average rating, list them in alphabetical order


SELECT DISTINCT title, avg(rating.stars)
FROM Movie, rating
WHERE Movie.mID = rating.mID
GROUP BY rating.mID
ORDER BY avg(stars) DESC, title;


-- 9. Find the names of all reviewers who have contributed three or more ratings. (As an extra challenge, try writing the query without HAVING or without COUNT.)


SELECT name 
FROM rating
NATURAL JOIN Reviewer
GROUP BY rID
HAVING count(name) >2

SELECT DISTINCT name
FROM Review
NATURAL JOIN (
	SELECT R1.rID AS rID
	FROM Rating AS R1
	JOIN Rating AS R2 
	JOIN Rating AS R3
	WHERE R1.rID = R2.rID AND R3.rID = R2.rID and R1.rID = R3.rID 
	AND (R1.mID <> R2.mID or R1.stars <> R2.stars or R1.ratingDate <> R2.ratingDate)
	AND (R3.mID <> R2.mID or R3.stars <> R2.stars or R3.ratingDate <> R2.ratingDate)
	AND (R3.mID <> R1.mID or R3.stars <> R1.stars or R3.ratingDate <> R1.ratingDate)



