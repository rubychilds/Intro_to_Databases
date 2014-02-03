####### SOCIAL NETWORKS
--1. Find the names of all students who are friends with someone named Gabriel. 


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


-- 2. For every student who likes someone 2 or more grades younger than themselves, return that student's name and grade, and the name and grade of the student they like. 


SELECT DISTINCT H1.name, H1.grade, H2.name, H2.grade
FROM Likes
JOIN Highschooler H1 ON H1.ID = Likes.ID1
JOIN Highschooler H2 ON Likes.ID2 = H2.ID
AND H1.grade-1 > H2.grade


--3. For every pair of students who both like each other, return the name and grade of both students. Include each pair only once, with the two names in alphabetical order. 


SELECT H1.name, H1.grade, H2.name, H2.grade
FROM Likes
JOIN Highschooler H1 on H1.ID = Likes.ID1
JOIN Highschooler H2 on H2.ID = Likes.ID2
JOIN Likes L ON Likes.ID1 = L.ID2 AND Likes.ID2 = L.ID1
AND H1.name < H2.name


--4. Find names and grades of students who only have friends in the same grade. Return the result sorted by grade, then by name within each grade. 


SELECT name, grade
FROM Highschooler
WHERE ID NOT IN (SELECT ID1 FROM Highschooler H1, Highschooler H2, Friend
                 WHERE H1.ID=Friend.ID1 AND H2.ID=Friend.ID2 
                 AND H1.grade<>H2.grade)
ORDER BY grade, name


--5. Find the name and grade of all students who are liked by more than one other student.


SELECT name, grade
FROM Highschooler
WHERE ID in (SELECT ID2 FROM Likes
            GROUP BY ID2 HAVING Count(ID2) > 1)