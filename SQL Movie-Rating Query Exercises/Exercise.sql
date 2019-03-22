Q1
Find the titles of all movies directed by Steven Spielberg. 

A1
select title 
from Movie
where director = 'Steven Spielberg'


Q2
Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order. 

A2
select distinct year 
from Movie m join Rating r
on m.mID = r.mID
where r.stars = 4 or r.stars = 5
order by year

Q3
Find the titles of all movies that have no ratings. 

A3
select title
from Movie 
where mID not in ( select mID from Rating )

Q4
Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a NULL value for the date. 

A4
select name 
from Reviewer rv join Rating rt
on rv.rID = rt.rID 
where ratingDate is null



Q5
Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars. 

A5
select rv.name,m.title,rt.stars,rt.ratingDate 
from Movie m,Rating rt, Reviewer rv
where m.mID = rt.mID
and rv.rID = rt.rID
order by rv.name,m.title,rt.stars


Q6
For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, return the reviewer's name and the title of the movie. 

A6
select rv.name,m.title
from Reviewer rv,Movie m,(select r1.rID,r1.mID from Rating r1, Rating r2 
where r2.stars > r1.stars and r2.ratingDate > r1.ratingDate  and r1.rID = r2.rID and r1.mID = r2.mID) as T
where T.mID = m.mID and T.rID = rv.rID



Q7
For each movie that has at least one rating, find the highest number of stars that movie received. Return the movie title and number of stars. Sort by movie title. 


A7
select m.title,max(rt.stars)
from Movie m,Rating rt
where rt.mID in (select rt2.mID from Rating rt2 group by mID having count(*) >=1 )
and m.mID = rt.mID 
group by rt.mID
order by title


Q8
For each movie, return the title and the 'rating spread', that is, the difference between highest and lowest ratings given to that movie. Sort by rating spread from highest to lowest, then by movie title. 

A8
select title, max(stars) - min(stars) as ratingSpread
from Rating rt,Movie m
where m.mID = rt.mID
group by m.mID 
order by ratingspread desc,title



Q9
Find the difference between the average rating of movies released before 1980 and the average rating of movies released after 1980. (Make sure to calculate the average rating for each movie, then the average of those averages for movies before 1980 and movies after. Don't just calculate the overall average rating before and after 1980.) 

select (select avg(stars)
from (select m.mID,avg(stars) as stars ,year
from Rating rt, movie m
where rt.mID = m.mID
group by m.mID) as T
where year < 1980 ) 
- (select avg(stars)
from (select m.mID,avg(stars) as stars ,year
from Rating rt, movie m
where rt.mID = m.mID
group by m.mID) as T
where year > 1980)  
