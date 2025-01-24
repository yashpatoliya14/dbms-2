-- Creating PersonInfo Table
CREATE TABLE PersonInfo (
 PersonID INT PRIMARY KEY,
 PersonName VARCHAR(100) NOT NULL,
 Salary DECIMAL(8,2) NOT NULL,
 JoiningDate DATETIME NULL,
 City VARCHAR(100) NOT NULL,
 Age INT NULL,
 BirthDate DATETIME NOT NULL
);
-- Creating PersonLog Table
CREATE TABLE PersonLog (
 PLogID INT PRIMARY KEY IDENTITY(1,1),
 PersonID INT NOT NULL,
 PersonName VARCHAR(250) NOT NULL,
 Operation VARCHAR(50) NOT NULL,
 UpdateDate DATETIME NOT NULL
);

drop table PersonLog,PersonInfo

--1. Create a trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo table to display
--a message “Record is Affected.”

create trigger tr_msg
on PersonInfo
after insert, update, delete
as
begin
	Print 'Record is Affected'
end

insert into PersonInfo values (101,'yash',20,'1991-08-08','rajkot',19,'1980-08-08')


--2. Create a trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo table. For that,
--log all operations performed on the person table into PersonLog.
create trigger tr_insert_log
on PersonInfo
after insert
as
begin
	declare @pid int ,@pname varchar(50)
	
	select @pid = PersonID,@pname = PersonName from inserted 
	insert into PersonLog values (@pid,@pname,'insert',getdate())
	select * from inserted
	select * from PersonLog
end
insert into PersonInfo values (102,'yash',20,'1991-08-08','rajkot',19,'1980-08-08')

create trigger tr_delete_log
on PersonInfo
after delete
as
begin
	declare @pid int ,@pname varchar(50)
	
	select @pid = PersonID,@pname = PersonName from deleted
	insert into PersonLog values (@pid,@pname,'delete',getdate())
	select * from deleted
	select * from PersonLog
end
insert into PersonInfo values (105,'om',20,'1991-08-02','rajkot',19,'1980-08-02')
insert into PersonInfo values (106,'om',20,'1991-08-02','rajkot',19,'1980-08-02')
insert into PersonInfo values (107,'om',20,'1991-08-02','rajkot',19,'1980-08-02')

delete from PersonInfo

create trigger tr_update_log
on PersonInfo
after update
as
begin
	declare @pid1 int ,@pname1 varchar(50)
	declare @pid2 int ,@pname2 varchar(50)
	
	select @pid1 = PersonID,@pname1 = PersonName from deleted
	select @pid2 = PersonID,@pname2 = PersonName from inserted
	insert into PersonLog values (@pid1,@pname1,'delete',getdate())
	insert into PersonLog values (@pid2,@pname2,'inserted',getdate())
	select * from deleted
	select * from inserted
	select * from PersonLog
end

update PersonInfo
set PersonName = 'avi'
where PersonID = 102 


--3. Create an INSTEAD OF trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo
--table. For that, log all operations performed on the person table into PersonLog.
create trigger tr_insert_log_instead
on PersonInfo
instead of  insert
as
begin
	declare @pid int ,@pname varchar(50)
	
	select @pid = PersonID,@pname = PersonName from inserted 
	insert into PersonLog values (@pid,@pname,'insert',getdate())
	select * from inserted
	select * from PersonLog
end
insert into PersonInfo values (103,'yash',20,'1991-08-08','rajkot',19,'1980-08-08')
select * from PersonInfo


create trigger tr_delete_log_instead
on PersonInfo
instead of delete
as
begin
	declare @pid int ,@pname varchar(50)
	
	select @pid = PersonID,@pname = PersonName from deleted
	insert into PersonLog values (@pid,@pname,'delete',getdate())
	select * from deleted
	select * from PersonLog
end
insert into PersonInfo values (105,'om',20,'1991-08-02','rajkot',19,'1980-08-02')
insert into PersonInfo values (106,'om',20,'1991-08-02','rajkot',19,'1980-08-02')
insert into PersonInfo values (107,'om',20,'1991-08-02','rajkot',19,'1980-08-02')

delete from PersonInfo

create trigger tr_update_log_instead
on PersonInfo
instead of update
as
begin
	declare @pid1 int ,@pname1 varchar(50)
	declare @pid2 int ,@pname2 varchar(50)
	
	select @pid1 = PersonID,@pname1 = PersonName from deleted
	select @pid2 = PersonID,@pname2 = PersonName from inserted
	insert into PersonLog values (@pid1,@pname1,'delete',getdate())
	insert into PersonLog values (@pid2,@pname2,'inserted',getdate())
	select * from deleted
	select * from inserted
	select * from PersonLog
end

update PersonInfo
set PersonName = 'avi'
where PersonID = 102 


--4. Create a trigger that fires on INSERT operation on the PersonInfo table to convert person name into
--uppercase whenever the record is inserted.
create trigger tr_insert_validate
on PersonInfo
after  insert
as
begin
	declare @pid int
	
	select @pid = PersonID from inserted 
	update PersonInfo
	set PersonName = upper(PersonName)
	where PersonID = @pid

	select * from PersonInfo
end
insert into PersonInfo values (105,'yash',20,'1991-08-08','rajkot',19,'1980-08-08')
select * from PersonInfo


--5. Create trigger that prevent duplicate entries of person name on PersonInfo table.
create trigger tr_insert_dup
on PersonInfo
instead of  insert
as
begin
	
	insert into PersonInfo(PersonID,PersonName,Salary,JoiningDate,City,Age,BirthDate)
	select 
	PersonID,PersonName,Salary,JoiningDate,City,Age,BirthDate
	from inserted 
	where PersonName not in (Select PersonName from PersonInfo )
end
insert into PersonInfo values (112,'avii',20,'1991-08-08','rajkot',19,'1980-08-08')
select * from PersonInfo


--6. Create trigger that prevent Age below 18 years.
create trigger tr_insert_age
on PersonInfo
instead of  insert
as
begin
	
	insert into PersonInfo(PersonID,PersonName,Salary,JoiningDate,City,Age,BirthDate)
	select 
	PersonID,PersonName,Salary,JoiningDate,City,Age,BirthDate
	from inserted 
	where Age > 18
end
insert into PersonInfo values (112,'avii',20,'1991-08-08','rajkot',17,'1980-08-08')
select * from PersonInfo


--Part – B
--7. Create a trigger that fires on INSERT operation on person table, which calculates the age and update
--that age in Person table.
create trigger tr_insert_age_calculate
on PersonInfo
instead of  insert
as
begin
	
	insert into PersonInfo(PersonID,PersonName,Salary,JoiningDate,City,Age,BirthDate)
	select 
	PersonID,PersonName,Salary,JoiningDate,City,Datediff(year,BirthDate,getdate()),BirthDate
	from inserted 
end

insert into PersonInfo(PersonID,PersonName,Salary,JoiningDate,City,BirthDate) 
values (116,'avii',10000,'1991-08-08','rajkot','2005-08-08')
select * from PersonInfo

--8. Create a Trigger to Limit Salary Decrease by a 10%.
create trigger tr_insert_age_calculate
on PersonInfo
instead of update
as
begin
	declare @salary1 int , @salary2 int ,@id int
	select	@salary1 = Salary,@id = PersonID
	from deleted 
	
	select	@salary2 = Salary
	from inserted 
	
	if(@salary2>@salary1*0.9)
	begin
		update PersonInfo
		set Salary = @salary2
		where PersonID = @id 
	end
	else
	begin
		print 'not updated'
	end
	
end

update PersonInfo
set Salary = 8000
where PersonID =116

select * from PersonInfo

--Part – C
--9. Create Trigger to Automatically Update JoiningDate to Current Date on INSERT if JoiningDate is NULL
--during an INSERT.
create trigger tr_insert_age_calculate
on PersonInfo
instead of  insert
as
begin
	declare @jdate datetime, @id int,@name varchar(50) @sal int, @city varchar(50) ,@age int , @bdate datetime    
	select	@jdate = JoiningDate, @id = PersonID, @name =  PersonName,  @sal = Salary,@city = City, @age = Age , @bdate = BirthDate
	from inserted 
	
	if(@jdate is null)
	begin
		insert into PersonInfo(@id,@name,@sal,getdate(),@city,@age,@bdate)
	end
	else
	begin
		insert into PersonInfo(@id,@name,@sal,@jdate,@city,@age,@bdate)
	end
end

insert into PersonInfo(PersonID,PersonName,Salary,JoiningDate,City,BirthDate) 
values (116,'avii',10000,'1991-08-08','rajkot','2005-08-08')
select * from PersonInfo

select * from PersonInfo



--10. Create DELETE trigger on PersonLog table, when we delete any record of PersonLog table it prints
--‘Record deleted successfully from PersonLog’.
create trigger tr_delete
on PersonLog
after  delete
as
begin
	print 'Record deleted successfully from PersonLog'
end




