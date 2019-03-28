Q1
Find the names of all reviewers who rated Gone with the Wind. 

A1
select distinct name 
from Movie m,Rating rt, Reviewer rv
where m.mID = rt.mID
and rv.rID = rt.rID
and m.title = 'Gone with the Wind'



Q2
For any rating where the reviewer is the same as the director of the movie, return the reviewer name, movie title, and number of stars. 

A2
select rv.name,m.title,rt.stars
from Movie m, Reviewer rv, Rating rt
where m.mID = rt.mID and rv.rID = rt.rID 
and rv.name = m.director



Q3
Return all reviewer names and movie names together in a single list, alphabetized. (Sorting by the first name of the reviewer and first word in the title is fine; no need for special processing on last names or removing "The".) 

A3
select title
from movie
union 
select name 
from reviewer


Q4
Find the titles of all movies not reviewed by Chris Jackson. 

A4
select title
from  Movie 
where mID not in ( select rt.mID from  Movie m, Reviewer rv, Rating rt
where m.mID = rt.mID and rv.rID = rt.rID and name = 'Chris Jackson')


Q5
For all pairs of reviewers such that both reviewers gave a rating to the same movie, return the names of both reviewers. Eliminate duplicates, don't pair reviewers with themselves, and include each pair only once. For each pair, return the names in the pair in alphabetical order. 


A5
select distinct r1.name,r2.name from (Rating rt join Reviewer rv on rt.rID = rv.rID ) as r1 , (Rating rt join Reviewer rv on rt.rID = rv.rID ) as r2
where r1.mID = r2.mID and r1.name < r2.name


Q6
For each rating that is the lowest (fewest stars) currently in the database, return the reviewer name, movie title, and number of stars. 

A6
select rv.name, m.title, rt.stars
from Movie m, Reviewer rv, Rating rt
where m.mID = rt.mID and rv.rID = rt.rID and rt.stars = (select min(stars) from Rating)

Q7
List movie titles and average ratings, from highest-rated to lowest-rated. If two or more movies have the same average rating, list them in alphabetical order. 

A7
select m.title, avg(rt.stars) as rat
from Rating rt, Movie m
where m.mID = rt.mID
group by rt.mID
order by rat desc,m.title


Q8
Find the names of all reviewers who have contributed three or more ratings. (As an extra challenge, try writing the query without HAVING or without COUNT.) 

A8
select rv.name
from Reviewer rv, Rating rt
where rv.rID = rt.rID
group by rt.rID 

Q9
Some directors directed more than one movie. For all such directors, return the titles of all movies directed by them, along with the director name. Sort by director name, then movie title. (As an extra challenge, try writing the query both with and without COUNT.) 

A9
select title, director from movie where 
director in (select director from movie
group by director having count(*) = 2)
order by director,title


Q10
Find the movie(s) with the highest average rating. Return the movie title(s) and average rating. (Hint: This query is more difficult to write in SQLite than other systems; you might think of it as finding the highest average rating and then choosing the movie(s) with that average rating.) 

A10
select title,rat from (select m.title, avg(rt.stars) as rat
from Rating rt, Movie m
where m.mID = rt.mID
group by rt.mID)
where rat = (select max(rat2) from (select avg(rt.stars) as rat2
from Rating rt, Movie m
where m.mID = rt.mID
group by rt.mID))

Q11
Find the movie(s) with the lowest average rating. Return the movie title(s) and average rating. (Hint: This query may be more difficult to write in SQLite than other systems; you might think of it as finding the lowest average rating and then choosing the movie(s) with that average rating.) 

A11
select title,rat from (select m.title, avg(rt.stars) as rat
from Rating rt, Movie m
where m.mID = rt.mID
group by rt.mID)
where rat = (select min(rat2) from (select avg(rt.stars) as rat2
from Rating rt, Movie m
where m.mID = rt.mID
group by rt.mID))


Q12
For each director, return the director's name together with the title(s) of the movie(s) they directed that received the highest rating among all of their movies, and the value of that rating. Ignore movies whose director is NULL. 

A12
select m.director,m.title, max(stars)
from movie m, rating r
where m.mID = r.mID and m.director is not null
group by m.director
having count(*) = 3
