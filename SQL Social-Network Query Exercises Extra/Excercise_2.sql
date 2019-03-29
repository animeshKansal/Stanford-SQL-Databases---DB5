Q1
For every situation where student A likes student B, but student B likes a different student C, return the names and grades of A, B, and C. 

A1
select H1.name, H1.grade, H2.name, H2.grade, H3.name, H3.grade
from Likes L1, Likes L2, Highschooler H1, Highschooler H2, Highschooler H3
where L1.ID2 = L2.ID1
and L2.ID2 <> L1.ID1
and L1.ID1 = H1.ID and L1.ID2 = H2.ID and L2.ID2 = H3.ID

Q2
Find those students for whom all of their friends are in different grades from themselves. Return the students' names and grades. 

A2
select name, grade
from Highschooler h1
where not grade in 
(select grade 
from (Highschooler h2 join friend on h2.id=id1) a 
where a.id2=h1.id)
                    
Q3
What is the average number of friends per student? (Your result should be just one number.) 

A3
select avg(c) from (select count(*) as c
from friend
group by ID1)

Q4
Find the number of students who are either friends with Cassandra or are friends of friends of Cassandra. Do not count Cassandra, even though technically she is a friend of a friend. 

A4
select count(id2) from friend where id1 in (
  select id2 from friend where id1 in (select id from highschooler where name='Cassandra')
)
and id1 not in (select id from highschooler where name='Cassandra')

Q5
Find the name and grade of the student(s) with the greatest number of friends. 

A5
select h.name, h.grade from highschooler h, friend f where
h.id = f.id1 group by f.id1 having count(f.id2) = (
select max(r.c) from
(select count(id2) as c from friend group by id1) as r)
