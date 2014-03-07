# Q1 
# Write an instead-of trigger that enables updates to the title attribute of view LateRating. 

create trigger MyTrigger
    instead of update of title on LateRating
    for each row 
    when new.mID = old.mID
    begin
    update Movie
    set title = new.title
    where mid = old.mID;
    end;

# Q2 
# Write an instead-of trigger that enables updates to the stars attribute of view LateRating. 

create trigger MyTrigger
    instead of update of stars on LateRating
    for each row 
    when new.mID = old.mID and new.ratingDate = old.ratingDate
    begin
    update Rating
    set stars = new.stars
    where ratingDate = old.ratingDate
    and mID = old.mID;
    end;

# Q3
# Write an instead-of trigger that enables updates to the mID attribute of view LateRating. 

create trigger MyTrigger
    instead of update of mid on LateRating
    for each row 
    when new.mID <> old.mID
    begin
    update Movie set mID = new.mID where title = old.title;
    update Rating set mID = new.mID where mID = old.mID;
    end;

# Q4 
# Write an instead-of trigger that enables deletions from view HighlyRated. 

create trigger MyTrigger
    instead of delete on HighlyRated
    for each row 
    begin
    delete from Rating 
    where mID = old.mID and stars > 3;
    end;

# Q5 
# Write an instead-of trigger that enables deletions from view HighlyRated. 

create trigger MyTrigger
    instead of delete on HighlyRated
    for each row 
    begin
    update Rating set stars = 3
    where mID = old.mID and stars > 3;
    end;

