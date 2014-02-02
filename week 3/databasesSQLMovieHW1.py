


2.
SELECT DISTINCT year
FROM Movie, rating
WHERE Movie.mID = rating.mID and stars > 3
ORDER BY year ASC

Alternative:
SELECT DISTINCT year
FROM Movie
NATURAL JOIN rating
WHERE  stars > 3
ORDER BY year ASC

3.
SELECT DISTINCT title
FROM Movie
WHERE Movie.mID NOT IN (SELECT DISTINCT mID FROM rating)

Alternative
SELECT title 
FROM Movie
LEFT JOIN Rating On Movie.mID = Rating.mID
WHERE rID IS NULL

4.
SELECT DISTINCT Reviewer.name
FROM rating, Reviewer
WHERE rating.rID = Reviewer.rID and rating.ratingDate IS NULL

SELECT DISTINCT Reviewer.name
FROM Reviewer
NATURAL JOIN Rating ON rating.rID = Reviewer.rID
WHERE rating.ratingDate IS NULL

5.
SELECT DISTINCT Reviewer.name, Movie.title, rating.stars, rating.ratingDate
FROM Reviewer, Movie, rating
WHERE Reviewer.rID = rating.rID and Movie.mID = rating.mid

6.
SELECT DISTINCT name, title
FROM Movie, Reviewer, rating R1, rating R2
WHERE R1.mID = Movie.mID 
and Reviewer.rID = R1.rID
and R1.rID = R2.rID
and R1.mID = R2.mID
and R1.ratingDate < R2.ratingDate
and R1.stars < R2.stars

7.
SELECT title, max(stars)
FROM Rating NATURAL JOIN
GROUP BY mID
ORDER BY title ASC

8. 
SELECT DISTINCT title, avg(rating.stars)
FROM Movie, rating
WHERE Movie.mID = rating.mID
GROUP BY rating.mID
ORDER BY avg(stars) DESC, title;

9.
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


####### SOCIAL NETWORKS
1.
SELECT name 
FROM Highschooler
JOIN Friend on Highschooler.id = Friend.id1
JOIN Highschooler H2 on H2.id = Freind.id2
where H2.name = 'Gabriel'

SELECT name
FROM Highschooler
WHERE ID IN (SELECT ID1 FROM Friend WHERE ID2 IN 
        (SELECT H1.ID FROM Highschooler H1 WHERE name = 'Gabriel'))
      or 
      ID in (SELECT ID2 FROM Friend WHERE ID1 IN
      (SELECT H2.ID FROM Highschooler H2 WHERE name = 'Gabriel'));


2. 

#### Modification
INSERT INTO Reviewer values(209, 'Roger Ebert') <- simplier way, directly inserting samples

4. DELETE FROM Rating
where stars > 4
FROM
(

	)


#### Modification 2




