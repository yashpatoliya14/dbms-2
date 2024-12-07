create database CSE_4A_113
--tables schema and insert query
-- Create Tables
CREATE TABLE Artists (
 Artist_id INT PRIMARY KEY,
 Artist_name NVARCHAR(50)
);

CREATE TABLE Albums (
 Album_id INT PRIMARY KEY,
 Album_title NVARCHAR(50),
 Artist_id INT,
 Release_year INT,
 FOREIGN KEY (Artist_id) REFERENCES Artists(Artist_id)
);

CREATE TABLE Songs (
 Song_id INT PRIMARY KEY,
 Song_title NVARCHAR(50),
 Duration DECIMAL(4, 2),
 Genre NVARCHAR(50),
 Album_id INT,
 FOREIGN KEY (Album_id) REFERENCES Albums(Album_id)
);

-- Insert Data into Artists Table
INSERT INTO Artists (Artist_id, Artist_name) VALUES
(1, 'Aparshakti Khurana'),
(2, 'Ed Sheeran'),
(3, 'Shreya Ghoshal'),
(4, 'Arijit Singh'),
(5, 'Tanishk Bagchi');

-- Insert Data into Albums Table
INSERT INTO Albums (Album_id, Album_title, Artist_id, Release_year) VALUES (1007, 'Album7', 1, 2015),
(1001, 'Album1', 1, 2019),
(1002, 'Album2', 2, 2015),
(1003, 'Album3', 3, 2018),
(1004, 'Album4', 4, 2020),
(1005, 'Album5', 2, 2020),
(1006, 'Album6', 1, 2009);

-- Insert Data into Songs Table
INSERT INTO Songs (Song_id, Song_title, Duration, Genre, Album_id) VALUES
(101, 'Zaroor', 2.55, 'Feel good', 1001),
(102, 'Espresso', 4.10, 'Rhythmic', 1002),
(103, 'Shayad', 3.20, 'Sad', 1003),
(104, 'Roar', 4.05, 'Pop', 1002),
(105, 'Everybody Talks', 3.35, 'Rhythmic', 1003),
(106, 'Dwapara', 3.54, 'Dance', 1002),
(107, 'Sa Re Ga Ma', 4.20, 'Rhythmic', 1004),
(108, 'Tauba', 4.05, 'Rhythmic', 1005),
(109, 'Perfect', 4.23, 'Pop', 1002),
(110, 'Good Luck', 3.55, 'Rhythmic', 1004);


--1. Retrieve a unique genre of songs.
select distinct Genre 
from Songs

--2. Find top 2 albums released before 2010.
select top 2 * 
from Albums
where Release_year<2010

--3. Insert Data into the Songs Table. (1245, �Zaroor�, 2.55, �Feel good�, 1005)
insert into Songs values 
(1245, 'Zaroor', 2.55, 'Feel good', 1005)

--4. Change the Genre of the song �Zaroor� to �Happy�
update Songs
set Genre = 'happy'
where Song_title = 'Zaroor'
select * from Songs

--5. Delete an Artist �Ed Sheeran�
delete from Artists 
where Artist_name='Ed Sheeran'

--6. Add a New Column for Rating in Songs Table. [Ratings decimal(3,2)]
alter table Songs 
add Rating decimal(3,1)

--7. Retrieve songs whose title starts with 'S'.
select Song_title
from Songs
where Song_title like 'S%'

--8. Retrieve all songs whose title contains 'Everybody'.
select *
from Songs
where Song_title like '%Everybody%'

--9. Display Artist Name in Uppercase.
select upper("Artist_name")
from Artists

--10. Find the Square Root of the Duration of a Song �Good Luck�
select square("Duration")
from Songs
where Song_title='Good Luck'

--11. Find Current Date.
select GETDATE()

--12. Find the number of albums for each artist.
select Artist_name , count(*)
from Artists as a
inner join Albums as al
on a.Artist_id=al.Artist_id
group by Artist_name

--13. Retrieve the Album_id which has more than 5 songs in it.
select a.Album_id, count(*)
from Songs as s
inner join Albums as a
on s.Album_id=a.Album_id
group by a.Album_id
having COUNT(*)>5


--14. Retrieve all songs from the album 'Album1'. (using Subquery)
select * 
from Songs
where Album_id IN (select Album_id from Albums where Album_title='Album1')

--15. Retrieve all albums name from the artist �Aparshakti Khurana� (using Subquery)
select * 
from Albums 
where Artist_id IN (select Artist_id from Artists where Artist_name='Aparshakti Khurana')

--16. Retrieve all the song titles with its album title.
select a.Album_title, s.Song_title
from Songs as s
inner join Albums as a
on s.Album_id=a.Album_id

--17. Find all the songs which are released in 2020.
select * 
from Songs as s
inner join Albums as a
on s.Album_id=a.Album_id
where a.Release_year=2020

--18. Create a view called �Fav_Songs� from the songs table having songs with song_id 101-105.
create view Fav_Songs 
as
select * 
from Songs 
where Song_id between 101 and 105

select * from Fav_Songs
--19. Update a song name to �Jannat� of song having song_id 101 in Fav_Songs view.
update Fav_Songs
set Song_title='Jannat'
where Song_id=101

--20. Find all artists who have released an album in 2020.
select * 
from Albums as a
inner join Artists as ar
on a.Artist_id=ar.Artist_id
where a.Release_year=2020 

--21. Retrieve all songs by Shreya Ghoshal and order them by duration. 
select * 
from Songs as s
inner join Albums as a
on a.Album_id=s.Album_id
inner join Artists as ar
on a.Artist_id=ar.Artist_id
where  ar.Artist_name='Shreya Ghoshal'

---------------------------------------------------------B category---------------------------------------

--22. Retrieve all song titles by artists who have more than one album.
select ar.Artist_name,s.Song_title
from Songs as s
inner join Albums as a
on a.Album_id=s.Album_id
inner join Artists as ar
on a.Artist_id=ar.Artist_id
group by ar.Artist_name,s.Song_title
having count(DISTINCT a.Album_id)>1

--23. Retrieve all albums along with the total number of songs.
select a.Album_title,COUNT(*)
from Songs as s
inner join Albums as a
on a.Album_id=s.Album_id
group by a.Album_title

--24. Retrieve all songs and release year and sort them by release year.
select a.Album_title,a.Release_year
from Albums as a
order by a.Release_year

--25. Retrieve the total number of songs for each genre, showing genres that have more than 2 songs.
select count(*),genre
from Songs 
group by genre
having COUNT(*)>2


--26. List all artists who have albums that contain more than 3 songs.
select Artist_name,Album_title
from Artists as ar
inner join Albums as a
on ar.Artist_id=a.Artist_id
inner join Songs as s
on s.Album_id=a.Album_id
group by Artist_name,Album_title
having COUNT(s.Song_id)>2


--------------------------------------------- c category----------------------------------------------

--27. Retrieve albums that have been released in the same year as 'Album4'
select Album_title
from Albums as a
where Release_year in (select Release_year from Albums where Album_title='Album4')

--28. Find the longest song in each genre
select Genre,max(len(Song_title))
from Songs
group by Genre
--29. Retrieve the titles of songs released in albums that contain the word 'Album' in the title.
select s.Song_titlefrom Songs as sinner join Albums as aon a.Album_id=s.Album_idwhere a.Album_title like '%Album%'--30. Retrieve the total duration of songs by each artist where total duration exceeds 15 minutes.select ar.Artist_name,sum(s.Duration)from Songs as sinner join Albums as aon a.Album_id=s.Album_idinner join Artists as aron ar.Artist_id=a.Artist_idgroup by ar.Artist_namehaving sum(s.Duration)>15