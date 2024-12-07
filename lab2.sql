-- Create Department Table
CREATE TABLE Department (
 DepartmentID INT PRIMARY KEY,
 DepartmentName VARCHAR(100) NOT NULL UNIQUE
);

--insert dep
create or alter procedure pr_insert_Department
 @did int, @dname varchar(50)
as
begin
	insert into Department values(@did , @dname);
end


--update dep
create or alter procedure pr_update_Department
 @did int,@dname varchar(50)
as
begin
	update Department
	set DepartmentName=@dname
	where DepartmentID = @did 
end

--delete dep
create or alter procedure pr_delete_Department
 @did int
as
begin
	delete from Department
	where DepartmentID = @did 
end

pr_insert_Department 1,'Admin'
pr_insert_Department 2,'IT'
pr_insert_Department 3,'HR'
pr_insert_Department 4,'Acount'
pr_update_Department 4,'Account'
pr_delete_Department 3

select * from Department 

-- Create Designation Table

CREATE TABLE Designation (
 DesignationID INT PRIMARY KEY,
 DesignationName VARCHAR(100) NOT NULL UNIQUE
);


--insert des
create or alter procedure pr_insert_Designation
 @dsid int, @dsname varchar(50)
as
begin
	insert into Designation values(@dsid , @dsname);
end
--update des
create or alter procedure pr_update_Designation
 @dsid int,@dsname varchar(50)
as
begin
	update Designation
	set DesignationName=@dsname
	where DesignationID = @dsid 
end

--delete des
create or alter procedure pr_delete_Designation
 @dsid int
as
begin
	delete from Designation
	where DesignationID = @dsid 
end

pr_update_Designation 11,'Robber'
pr_insert_Designation 11,'Jobber'
pr_insert_Designation 12,'Welder'
pr_insert_Designation 13,'Clerk'
pr_insert_Designation 14,'Manager'
pr_insert_Designation 15,'CEO'

select * from Designation

-- Create Person Table
CREATE TABLE Person (
 PersonID INT PRIMARY KEY IDENTITY(101,1),
 FirstName VARCHAR(100) NOT NULL,
 LastName VARCHAR(100) NOT NULL,
 Salary DECIMAL(8, 2) NOT NULL,
 JoiningDate DATETIME NOT NULL,
 DepartmentID INT NULL,
 DesignationID INT NULL,
 FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
 FOREIGN KEY (DesignationID) REFERENCES Designation(DesignationID)
);

--insert per
create or alter procedure pr_insert_Person
  @fn varchar(40),@ln varchar(40),@sal DECIMAL(8, 2),@jd datetime,@did int,@dsid int
as
begin
	insert into Person values (@fn,@ln,@sal,@jd,@did,@dsid);
end


--update per
create or alter procedure pr_update_Person
 @pid int,@fname varchar(50),@lname varchar(50),@sal DECIMAL(8, 2),@jd datetime,@did int,@dsid int
as
begin
	update Person
	set FirstName=@fname,LastName= @lname,Salary = @sal, JoiningDate = @jd, DesignationID = @dsid , DepartmentID = @did
	where PersonID = @pid 
end

--delete des
create or alter procedure pr_delete_Person
 @pid int
as
begin
	delete from Person
	where PersonID = @pid 
end

pr_insert_Person  'Rahul' ,'Anshu', 56000, '1990-01-01' ,1 ,12
pr_insert_Person 'Hardik', 'Hinsu', 18000, '1990-09-25', 2,11
pr_insert_Person 'Bhavin' ,'Kamani', 25000, '1991-05-14' ,NULL, 11
pr_insert_Person 'Bhoomi', 'Patel', 39000, '2014-02-20', 1, 13
pr_insert_Person 'Rohit', 'Rajgor', 17000, '1990-07-23', 2, 15
pr_insert_Person 'Priya', 'Mehta', 25000, '1990-10-18', 2, NULL
pr_insert_Person 'Neha', 'Trivedi', 18000, '2014-02-20', 3, 15
pr_update_Person 107,'Neha', 'Trivedi', 19000, '2014-02-20', 3, 15
pr_insert_Person 'Neha', 'Trivedi', 19000, '2014-02-20', 3, 15
pr_delete_Person 108

select * from Person

--2. Department, Designation & Person Table�s SELECTBYPRIMARYKEY
create or alter procedure pr_SELECTBYPRIMARYKEY_person
 @pid int
as
begin

	select *
	from Person as p
	where p.PersonID=@pid
end

pr_SELECTBYPRIMARYKEY_person 101

create or alter procedure pr_SELECTBYPRIMARYKEY_Dept
 @did int
as
begin

	select *
	from Department 
	where DepartmentID=@did
end

pr_SELECTBYPRIMARYKEY_Dept 1

create or alter procedure pr_SELECTBYPRIMARYKEY_Design
 @dsid int
as
begin

	select *
	from Designation
	where DesignationID=@dsid
end

pr_SELECTBYPRIMARYKEY_Design 11

--3. Department, Designation & Person Table�s (If foreign key is available then do write join and take
--columns on select list)
create or alter procedure pr_full
as
begin

	select *
	from Person as p
	inner join Department as d
	on d.DepartmentID = p.DepartmentID
	inner join Designation as ds
	on ds.DesignationID = p.DesignationID
	
end

pr_full

--4. Create a Procedure that shows details of the first 3 persons.

create or alter procedure pr_detail
as
begin

	select top 3 *
	from Person 
	
end

pr_detail



-------------------------------------------------b Categroy----------------------------

--5. Create a Procedure that takes the department name as input and returns a table with all workers
--working in that department.

create or alter procedure pr_get_person
@dname varchar(40)
as
begin 
	select * 
	from Person as p
	inner join Department as d
	on p.DepartmentID = d.DepartmentID
	where d.DepartmentName = @dname
end

pr_get_person 'IT'

--6. Create Procedure that takes department name & designation name as input and returns a table with
--worker’s first name, salary, joining date & department name.
create or alter procedure pr_get_person_ds
@dname varchar(40),@dsname varchar(50)
as
begin 
	select p.salary,p.FirstName,p.JoiningDate,d.DepartmentName 
	from Person as p
	inner join Department as d
	on p.DepartmentID = d.DepartmentID
	inner join Designation as ds
	on p.DesignationID = ds.DesignationID
	where d.DepartmentName = @dname and ds.DesignationName = @dsname
end
pr_get_person_ds 'IT','Jobber'

--7. Create a Procedure that takes the first name as an input parameter and display all the details of the
--worker with their department & designation name.

create or alter procedure pr_get_person_fn
@fname varchar(40)
as
begin 
	select p.salary,p.FirstName,p.JoiningDate,d.DepartmentName,ds.DesignationName 
	from Person as p
	inner join Department as d
	on p.DepartmentID = d.DepartmentID
	inner join Designation as ds
	on p.DesignationID = ds.DesignationID
	where p.FirstName = @fname
end

pr_get_person_fn 'Rahul'

--8. Create Procedure which displays department wise maximum, minimum & total salaries.
create or alter procedure pr_salary
as
begin 
	select d.DepartmentName,max(p.salary),min (p.Salary),sum(p.salary) 
	from Person as p
	inner join Department as d
	on p.DepartmentID = d.DepartmentID
	group by d.DepartmentName
end

pr_salary 

--9. Create Procedure which displays designation wise average & total salaries.


create or alter procedure pr_avg
as
begin 
	select sum(p.salary),avg(p.salary),ds.DesignationName 
	from Person as p
	inner join Designation as ds
	on p.DesignationID = ds.DesignationID
	group by ds.DesignationName
end

pr_avg

-----------------------------------------------------c category------------------------------------
--10. Create Procedure that Accepts Department Name and Returns Person Count.
create or alter procedure pr_count
@dname varchar(40)
as
begin 
	select d.DepartmentName,count(*)
	from Person as p
	inner join Department as d
	on p.DepartmentID = d.DepartmentID
	group by d.DepartmentName
	having d.DepartmentName = @dname
end
pr_count 'IT'
--11. Create a procedure that takes a salary value as input and returns all workers with a salary greater than
--input salary value along with their department and designation details.
create or alter procedure pr_take_salary_return_detail
@sal int
as
begin 
	select p.salary,d.DepartmentName,ds.DesignationName 
	from Person as p
	inner join Department as d
	on p.DepartmentID = d.DepartmentID
	inner join Designation as ds
	on p.DesignationID = ds.DesignationID
	where p.salary>@sal
end
pr_take_salary_return_detail '2'

--12. Create a procedure to find the department(s) with the highest total salary among all departments.
create or alter procedure pr_return_highest_salary
as
begin 
	select max(p.salary)
	from Person as p
	inner join Department as d
	on p.DepartmentID = d.DepartmentID
end
pr_return_highest_salary 

--13. Create a procedure that takes a designation name as input and returns a list of all workers under that
--designation who joined within the last 10 years, along with their department.
create or alter procedure pr_take_designationName
@dsname varchar(40)
as
begin 
	select d.DepartmentName,p.FirstName
	from Person as p
	inner join Designation as ds
	on p.DesignationID = ds.DesignationID
	inner join Department as d
	on p.DepartmentID = d.DepartmentID
	where ds.DesignationName = @dsname and datediff(year,p.JoiningDate,getdate())<=10
end

pr_take_designationName 'Clerk'
--14. Create a procedure to list the number of workers in each department who do not have a designation
--assigned.
create or alter procedure pr_get_null
as
begin 
	select p.FirstName,d.DepartmentName
	from Person as p
	inner join Department as d
	on p.DepartmentID = d.DepartmentID
	where p.DesignationID is null
end

pr_get_null
--15. Create a procedure to retrieve the details of workers in departments where the average salary is above
--12000.
create or alter procedure pr_retrieve
as
begin 
	select p.FirstName,d.DepartmentName
	from Person as p
	inner join Department as d
	on p.DepartmentID = d.DepartmentID
	inner join Designation as ds
	on p.DesignationID = ds.DesignationID
	group by d.DepartmentName,p.FirstName
	having avg(p.salary)>12000
end

pr_retrieve