Q1
It's time for the seniors to graduate. Remove all 12th graders from Highschooler. 

A1
delete from highschooler
where grade = 12

Q2
If two students A and B are friends, and A likes B but not vice-versa, remove the Likes tuple. 

A2
delete from likes
where ID2 in (
  select ID2
  from friend
  where friend.ID1 = likes.ID1
) and ID2 not in (
  select L.ID1
  from Likes L
  where L.ID2 = Likes.ID1)
  
  Q3
  For all cases where A is friends with B, and B is friends with C, add a new friendship for the pair A and C. 
  Do not add duplicate friendships, friendships that already exist, or friendships with oneself.
  (This one is a bit challenging; congratulations if you get it right.) 
  
  A3
 insert into friend
select distinct F1.ID1, F2.ID2
from friend F1, friend F2
where F1.ID2 = F2.ID1 and F1.ID1 <> F2.ID2 and F1.ID1 NOT IN (
  select F3.ID1
  from friend F3
  where F3.ID2 = F2.ID2)
  
