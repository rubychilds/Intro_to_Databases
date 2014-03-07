# Q1
# Write one or more triggers to maintain symmetry in friend relationships. Specifically, if (A,B) is deleted from Friend, then (B,A) should be deleted too. If (A,B) is inserted into Friend then (B,A) should be inserted too. Don't worry about updates to the Friend table. 


CREATE TRIGGER T1
AFTER DELETE ON Friend
FOR EACH ROW
BEGIN
DELETE FROM Friend WHERE ID1 = old.ID2 and ID2 = old.ID1;
END;
|
CREATE TRIGGER T2
AFTER INSERT ON Friend
FOR EACH ROW
BEGIN
INSERT INTO Friend VALUES(new.ID2, new.ID1);
END;

# Q2
# Write a trigger that automatically deletes students when they graduate, i.e., when their grade is updated to exceed 12. In addition, write a trigger so when a student is moved ahead one grade, then so are all of his or her friends. 

CREATE TRIGGER T1
AFTER UPDATE ON Highschooler
FOR EACH ROW
BEGIN
DELETE FROM Highschooler WHERE grade > 12;
END;
|
CREATE TRIGGER T2
AFTER UPDATE ON Highschooler
FOR EACH ROW
BEGIN
UPDATE Highschooler SET grade = grade + 1 
WHERE ID in 
(SELECT ID2 from Friend WHERE ID1 = new.ID);
END;

# Q3  
# Write a trigger to enforce the following behavior: If A liked B but is updated to A liking C instead, and B and C were friends, make B and C no longer friends. Don't forget to delete the friendship in both directions, and make sure the trigger only runs when the "liked" (ID2) person is changed but the "liking" (ID1) person is not changed. 

CREATE TRIGGER likeTrigger 
AFTER UPDATE ON likes 
WHEN exists(SELECT * FROM friend WHERE id1=new.id2 AND id2=old.id2) 
    AND new.id1 = old.id1 AND NOT new.id2 = old.id2 
BEGIN 
    DELETE FROM friend WHERE id1=new.id2 AND id2=old.id2; 
    DELETE FROM friend WHERE id1=old.id2 AND id2=new.id2; 
END;



