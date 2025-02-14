-- Create the Customers table
CREATE TABLE Customers (
 Customer_id INT PRIMARY KEY,
 Customer_Name VARCHAR(250) NOT NULL,
 Email VARCHAR(50) UNIQUE
);

-- Create the Orders table
CREATE TABLE Orders (
 Order_id INT PRIMARY KEY,
 Customer_id INT,
 Order_date DATE NOT NULL,
 FOREIGN KEY (Customer_id) REFERENCES Customers(Customer_id)
);



--1. Handle Divide by Zero Error and Print message like: Error occurs that is - Divide by zero error.
begin try
	declare @ans decimal(5,2)
	set @ans = 1/0
end try
begin catch
	print error_message()
end catch

--2. Try to convert string to integer and handle the error using try…catch block.
begin try
	declare @ans decimal(5,2),@temp varchar(50)
	set @temp = 'yash'
	set @ans = cast(@temp as int)
end try
begin catch
	print error_message()
end catch


--3. Create a procedure that prints the sum of two numbers: take both numbers as integer & handle
--exception with all error functions if any one enters string value in numbers otherwise print result.

create proc pr_sum_two 
  @n1 varchar(50) ,@n2 varchar(50) 
as
begin 
	begin try
	declare @ans int
		set @ans = cast(@n1  as int ) + cast(@n2  as int )
		print @ans
	end try
	begin catch
		print error_message()
	end catch
end

exec pr_sum_two 12,'yahs'

--4. Handle a Primary Key Violation while inserting data into customers table and print the error details
--such as the error message, error number, severity, and state.

	begin try
	declare @ans int
		insert into Customers values
		(1,'mann mavani','mannmavani@gmail.com')
	end try
	begin catch
		print error_message()
		print error_number()
		print error_severity()
		print error_state()
	end catch


--5. Throw custom exception using stored procedure which accepts Customer_id as input & that throws
--Error like no Customer_id is available in database.


create proc pr_find 
  @id int 
as
begin 
	begin try
	declare @ans int
		if not exists (select Customer_id from Customers where Customer_id = @id)
			throw 50000,'Primary key available',0
	end try
	begin catch
		print error_message()
		print error_number()
		print error_state()
	end catch
end

exec pr_find 2


--Part – B

--6. Handle a Foreign Key Violation while inserting data into Orders table and print appropriate error
--message.
	
	
	begin try
	declare @ans int
		insert into Orders values
		(1,2,'1996-05-08')
	end try
	begin catch
		print error_message()
		print error_number()
		print error_severity()
		print error_state()
	end catch


--7. Throw custom exception that throws error if the data is invalid.
create proc pr_data 
  @age int 
as
begin 
	begin try
		if @age<18
			throw 50000,'Age must be grater than 18',0
	end try
	begin catch
		print error_message()
		print error_number()
		print error_state()
	end catch
end

exec pr_data 19

--8. Create a Procedure to Update Customer’s Email with Error Handling
create proc pr_update 
  @email varchar(50) ,@id int
as
begin 
	begin try
		if not exists (select Customer_id from Customers where Customer_id = @id)
			throw 50002 , 'Id is not found' , 0
		if exists (select Email from Customers where Email = @email)
			throw 50001 , 'Email is already exists' , 0

		Update Customers
		set Email = @email
		where Customer_id = @id 
	end try
	begin catch
		print error_message()
		print error_number()
		print error_state()
	end catch
end
select * from Customers
exec pr_update 'mannmavani1@gmail.com',1



--Part – C
--9. Create a procedure which prints the error message that “The Customer_id is already taken. Try another
--one”.
create proc pr_id 
 @id int
as
begin 
	begin try
		if exists (select Customer_id from Customers where Customer_id = @id)
			throw 50002 , 'The Customer_id is already taken. Try another one' , 0
		
	end try
	begin catch
		print error_message()
		print error_number()
		print error_state()
	end catch
end

exec pr_id 2

--10. Handle Duplicate Email Insertion in Customers Table.

create proc pr_email_dup 
 @email varchar(50)
as
begin 
	begin try
		if exists (select Email from Customers where Email = @email)
			throw 50001 , 'Email is already exists' , 0
	end try
	begin catch
		print error_message()
		print error_number()
		print error_state()
	end catch
end

exec pr_email_dup 'mannmavani2@gmail.com'
