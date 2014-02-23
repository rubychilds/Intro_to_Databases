# Q1
# Write a trigger that makes new students named 'Friendly' automatically like everyone else in their grade. That is, after the trigger runs, we should have ('Friendly', A) in the Likes table for every other Highschooler A in the same grade as 'Friendly'.

CREATE TRIGGER
AFTER INSERT ON Highschooler
FOR EACH ROW WHEN (new.name = 'Friendly')
	BEGIN INSERT INTO Likes 
	SELECT new.id , id 
	FROM Highschooler 
	WHERE new.grade = grade and id <> new.id; 
END;

# Q2
# Write one or more triggers to manage the grade attribute of new Highschoolers. If the inserted tuple has a value less than 9 or greater than 12, change the value to NULL. On the other hand, if the inserted tuple has a null value for grade, change it to 9. 

CREATE TRIGGER t1
AFTER INSERT ON Highschooler
FOR EACH ROW WHEN (new.grade < 9 or new.grade > 12)
	BEGIN UPDATE Highschooler 
	SET grade=NULL 
	WHERE id=new.id; 
end;
|
CREATE TRIGGER t2
AFTER INSERT ON Highschooler
FOR EACH ROW WHEN (new.grade is null)
	BEGIN UPDATE Highschooler 
	SET grade=9 
	WHERE id=new.id; 
end;

# Q3
# Write a trigger that automatically deletes students when they graduate, i.e., when their grade is updated to exceed 12

CREATE TRIGGER g
AFTER UPDATE OF grade ON Highschooler
FOR EACH ROW WHEN new.grade > 12
	BEGIN DELETE FROM Highschooler 
	WHERE id=new.id; 
end;