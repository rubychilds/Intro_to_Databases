-- 1. Add the reviewer Roger Ebert to your database, with an rID of 209. 


INSERT INTO Reviewer(name, rID)
VALUES ('Roger Ebert',209);


INSERT INTO Reviewer values(209, 'Roger Ebert') <- simplier way, directly inserting samples


-- 2. Insert 5-star ratings by James Cameron for all movies in the database. Leave the review date as NULL. 


INSERT INTO Rating(rID, mID, stars, ratingDate  )
SELECT DISTINCT Reviewer.rID, Movie.mid, 5, null
FROM Movie, Reviewer
WHERE Reviewer.name = 'James Cameron'


-- 3. For all movies that have an average rating of 4 stars or higher, add 25 to the release year. (Update the existing tuples; don't insert new tuples.)


UPDATE Movie
SET year = year + 25
WHERE mID IN
(SELECT mID
    FROM Rating
    GROUP BY mID
    HAVING avg(stars) >= 4
)


-- 4. Remove all ratings where the movie's year is before 1970 or after 2000, and the rating is fewer than 4 stars. 


DELETE FROM Rating
WHERE mID IN
(SELECT R.mID
FROM movie M
JOIN Rating R on R.mID = M.mID
WHERE rating.stars < 4 AND (M.year < 1970 OR M.year > 2000)
)
