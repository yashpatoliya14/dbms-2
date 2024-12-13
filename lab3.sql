CREATE TABLE Departments (
 DepartmentID INT PRIMARY KEY,
 DepartmentName VARCHAR(100) NOT NULL UNIQUE,
 ManagerID INT NOT NULL,
 Location VARCHAR(100) NOT NULL
);
CREATE TABLE Employee (
 EmployeeID INT PRIMARY KEY,
 FirstName VARCHAR(100) NOT NULL,
 LastName VARCHAR(100) NOT NULL,
 DoB DATETIME NOT NULL,
 Gender VARCHAR(50) NOT NULL,
 HireDate DATETIME NOT NULL,
 DepartmentID INT NOT NULL,
 Salary DECIMAL(10, 2) NOT NULL,
 FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
-- Create Projects Table
CREATE TABLE Projects (
 ProjectID INT PRIMARY KEY,
 ProjectName VARCHAR(100) NOT NULL,
 StartDate DATETIME NOT NULL,
 EndDate DATETIME NOT NULL,
 DepartmentID INT NOT NULL,
 FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
INSERT INTO Departments (DepartmentID, DepartmentName, ManagerID, Location)
VALUES
 (1, 'IT', 101, 'New York'),
 (2, 'HR', 102, 'San Francisco'),
 (3, 'Finance', 103, 'Los Angeles'),
 (4, 'Admin', 104, 'Chicago'),
 (5, 'Marketing', 105, 'Miami');
INSERT INTO Employee (EmployeeID, FirstName, LastName, DoB, Gender, HireDate, DepartmentID,
Salary)
VALUES
 (101, 'John', 'Doe', '1985-04-12', 'Male', '2010-06-15', 1, 75000.00),
 (102, 'Jane', 'Smith', '1990-08-24', 'Female', '2015-03-10', 2, 60000.00),
 (103, 'Robert', 'Brown', '1982-12-05', 'Male', '2008-09-25', 3, 82000.00),
 (104, 'Emily', 'Davis', '1988-11-11', 'Female', '2012-07-18', 4, 58000.00),
 (105, 'Michael', 'Wilson', '1992-02-02', 'Male', '2018-11-30', 5, 67000.00);
INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate, DepartmentID)
VALUES
 (201, 'Project Alpha', '2022-01-01', '2022-12-31', 1),
 (202, 'Project Beta', '2023-03-15', '2024-03-14', 2),
 (203, 'Project Gamma', '2021-06-01', '2022-05-31', 3),
 (204, 'Project Delta', '2020-10-10', '2021-10-09', 4),
 (205, 'Project Epsilon', '2024-04-01', '2025-03-31', 5);

-- 1. Create Stored Procedure for Employee table As User enters either First Name or Last Name and based
--on this you must give EmployeeID, DOB, Gender & Hiredate.
create or alter proc pr_display_data
@fname varchar(50)=null,@lname varchar(50)= null
as
begin
	select * 
	from  Employee 
	where FirstName=@fname or LastName =@lname
end

pr_display_data @lname ='doe'
--2. Create a Procedure that will accept Department Name and based on that gives employees list who
--belongs to that department.
create or alter proc pr_display_data_by_deptname
@dname varchar(50)
as
begin
	select *
	from  Employee as e
	inner join Departments as d
	on d.DepartmentID=e.DepartmentID
	where d.DepartmentName=@dname
end
pr_display_data_by_deptname 'HR'


--3. Create a Procedure that accepts Project Name & Department Name and based on that you must give
--all the project related details.
create or alter proc pr_display_data_by_deptname_projectName
@dname varchar(50),
@pname varchar(50)
as
begin
	select *
	from  Projects as p
	inner join Departments as d
	on d.DepartmentID=p.DepartmentID
	where d.DepartmentName=@dname and p.ProjectName=@pname
end
pr_display_data_by_deptname_projectName 'IT','Project Alpha'


--4. Create a procedure that will accepts any integer and if salary is between provided integer, then those
--employee list comes in output.
create or alter proc pr_display_data_by_sal
@sal1 int,
@sal2 int
as
begin
	select *
	from  Employee 
	where Salary>@sal1 and Salary<@sal2
end

pr_display_data_by_sal 10000,100000

--5. Create a Procedure that will accepts a date and gives all the employees who all are hired on that date.
create or alter proc pr_display_data_by_date
@date datetime
as
begin
	select *
	from  Employee 
	where HireDate=@date
end

pr_display_data_by_date '2010-06-15'



---------------------------------------------------------b category----------------------------------------------------
--6. Create a Procedure that accepts Gender’s first letter only and based on that employee details will be
--served.
create or alter proc pr_display_data_by_gender
@gender varchar(50)
as
begin
	select *
	from  Employee 
	where Gender like @gender +'%'
end

pr_display_data_by_gender 'm'


--7. Create a Procedure that accepts First Name or Department Name as input and based on that employee
--data will come.
create or alter proc pr_display_data_by_fname_dname
@fname varchar(50),
@dname varchar(50)
as
begin
	select *
	from  Employee as e
	inner join Departments as d
	on e.DepartmentID=d.DepartmentID
	where e.FirstName=@fname or d.DepartmentName=@dname
end

pr_display_data_by_fname_dname 'John','IT'


--8. Create a procedure that will accepts location, if user enters a location any characters, then he/she will
--get all the departments with all data.

create or alter proc pr_display_data_by_location
@loc varchar(50)
as
begin
	select *
	from  Departments 
	where Location like '%' + @loc + '%'
end

pr_display_data_by_location 'SA'


-------------------------------------------------c category--------------------------------------------------------

--9. Create a procedure that will accepts From Date & To Date and based on that he/she will retrieve Project
--related data.

create or alter proc pr_display_data_by_date
@fromd datetime,
@tod datetime
as
begin
	select *
	from  Projects 
	where StartDate=@fromd and EndDate=@tod
end

pr_display_data_by_date '2022-01-01','2022-12-31'


--10. Create a procedure in which user will enter project name & location and based on that you must
--provide all data with Department Name, Manager Name with Project Name & Starting Ending Dates. 

create or alter proc pr_display_data_by_pname_loc
@pname varchar(50),
@loc varchar(50)
as
begin
	select p.ProjectName,d.DepartmentName,e.FirstName,p.StartDate,p.EndDate
	from  Employee as e
	inner join Departments as d
	on e.DepartmentID=d.DepartmentID
	inner join Projects as p
	on e.DepartmentID=p.DepartmentID
	where p.ProjectName=@pname and d.Location=@loc 
end

pr_display_data_by_pname_loc 'Project Alpha','New York'
