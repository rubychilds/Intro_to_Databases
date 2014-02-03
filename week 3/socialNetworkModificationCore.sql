-- 1. It's time for the seniors to graduate. Remove all 12th graders from Highschooler. 


DELETE FROM Highschooler
WHERE grade IS 12


-- 2. If two students A and B are friends, and A likes B but not vice-versa, remove the Likes tuple. 


DELETE FROM Likes
WHERE ID2 IN (
SELECT ID2 FROM Friend where Likes.ID1 = ID1) 
AND 
ID2 NOT IN
(
SELECT L.ID1 FROM LIKES L WHERE Likes.ID1 = L.ID2


-- 3. For all cases where A is friends with B, and B is friends with C, add a new friendship for the pair A and C. Do not add duplicate friendships, friendships that already exist, or friendships with oneself.