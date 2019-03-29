Q1
Find the names of all students who are friends with someone named Gabriel. 

A1
select name from highschooler where ID in (
select f.ID2 from friend f join highschooler h on f.ID1 = h.ID 
where name = 'Gabriel')

Q2
For every student who likes someone 2 or more grades younger than themselves, return that student's name and grade, and the name and grade of the student they like. 

A2
select H1.name, H1.grade, H2.name, H2.grade 
from Highschooler H1 JOIN Likes ON H1.ID = Likes.ID1 
JOIN Highschooler H2 ON H2.ID = Likes.ID2 
where (H1.grade - H2.grade) >= 2

Q3
For every pair of students who both like each other, return the name and grade of both students. Include each pair only once, with the two names in alphabetical order. 

A3
select T.name,T.grade,T2.name,T2.grade
from (likes l1 join highschooler h on h.ID = l1.ID1 join highschooler h2 on h2.ID = l1.ID2 ) as T , (likes l1 join highschooler h on h.ID = l1.ID1 join highschooler h2 on h2.ID = l1.ID2 ) as T2
where T.ID1 = T2.ID2 and T.ID2 = T2.ID1 and T.name < T2.name 

Q4
Find all students who do not appear in the Likes table (as a student who likes or is liked) and return their names and grades. Sort by grade, then by name within each grade. 

A4
select name, grade 
from highschooler 
where ID not in (select ID1 from Likes union select ID2 from Likes)

Q5
For every situation where student A likes student B, but we have no information about whom B likes (that is, B does not appear as an ID1 in the Likes table), return A and B's names and grades. 

A5
select h1.name,h1.grade,h2.name,h2.grade
from likes l1 join highschooler h1 on h1.ID = l1.ID1 join highschooler h2 on h2.ID = l1.ID2  
where h2.ID not in ( select ID1 from Likes)

Q6
Find names and grades of students who only have friends in the same grade. Return the result sorted by grade, then by name within each grade. 

A6
select name, grade
from highschooler where 
ID not in (select h.ID from highschooler h,friend f,highschooler h2
where h.ID = f.ID1 and h2.ID = f.ID2 and h.grade <> h2.grade)
order by grade,name

Q7
For each student A who likes a student B where the two are not friends, find if they have a friend C in common (who can introduce them!). For all such trios, return the name and grade of A, B, and C. 

A7
select distinct H1.name, H1.grade, H2.name, H2.grade, H3.name, H3.grade
from Highschooler H1, Likes, Highschooler H2, Highschooler H3, Friend F1, Friend F2
where H1.ID = Likes.ID1 and Likes.ID2 = H2.ID and
  H2.ID not in (select ID2 from Friend where ID1 = H1.ID) and
  H1.ID = F1.ID1 and F1.ID2 = H3.ID and
  H3.ID = F2.ID1 and F2.ID2 = H2.ID;
  
 Q8
  Find the difference between the number of students in the school and the number of different first names. 

A8
select (select count(*) from highschooler) - ( select  count(distinct name) from highschooler ) 

Q9
Find the name and grade of all students who are liked by more than one other student. 


A9
select name, grade
from highschooler 
where ID in (select ID2
from likes
group by ID2 
having count(*) > 1)

