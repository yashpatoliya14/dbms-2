-- Create the Products table
CREATE TABLE Products (
 Product_id INT PRIMARY KEY,
 Product_Name VARCHAR(250) NOT NULL,
 Price DECIMAL(10, 2) NOT NULL
);
-- Insert data into the Products table
INSERT INTO Products (Product_id, Product_Name, Price) VALUES
(1, 'Smartphone', 35000),
(2, 'Laptop', 65000),
(3, 'Headphones', 5500),
(4, 'Television', 85000),
(5, 'Gaming Console', 32000);



--1. Create a cursor Product_Cursor to fetch all the rows from a products table.
declare Product_Cursor cursor
for select Product_Name,Price from Products 

open Product_Cursor
declare @pname varchar(60),@pPrice int
fetch next from Product_Cursor into @pname,@pPrice

while @@FETCH_STATUS = 0
begin 
	print concat(@pname,'  ',@pPrice) 
	fetch next from Product_Cursor into @pname,@pPrice
end

close Product_Cursor
deallocate Product_Cursor


--2. Create a cursor Product_Cursor_Fetch to fetch the records in form of ProductID_ProductName.
--(Example: 1_Smartphone)
declare @pId int,@pname varchar(50)
declare Product_Cursor_Fetch cursor
for select Product_Name,Product_id from Products 

open Product_Cursor_Fetch

fetch next from Product_Cursor_Fetch into @pname,@pId

while @@FETCH_STATUS = 0
begin 
	print concat(@pId,'_',@pname) 
	fetch next from Product_Cursor_Fetch into @pname,@pId
end

close Product_Cursor_Fetch
deallocate Product_Cursor_Fetch



--3. Create a Cursor to Find and Display Products Above Price 30,000.
declare @pId int,@pname varchar(50)
declare Product_Cursor_Fetch cursor
for 
	select Product_Name,Product_id 
	from Products 
	where Price >30000

open Product_Cursor_Fetch

fetch next from Product_Cursor_Fetch into @pname,@pId

while @@FETCH_STATUS = 0
begin 
	print concat(@pId,'_',@pname) 
	fetch next from Product_Cursor_Fetch into @pname,@pId
end

close Product_Cursor_Fetch
deallocate Product_Cursor_Fetch


--4. Create a cursor Product_CursorDelete that deletes all the data from the Products table

declare @pId int
declare Product_CursorDelete cursor
for 
	select Product_id 
	from Products 

open Product_CursorDelete

fetch next from Product_CursorDelete into @pId

while @@FETCH_STATUS = 0
begin 

	delete from products 
	where Product_id = @pId

	fetch next from Product_CursorDelete into @pId
end

close Product_CursorDelete
deallocate Product_CursorDelete

-------------------------------------B--------------------------------------------

--5. Create a cursor Product_CursorUpdate that retrieves all the data from the products table and increases
--the price by 10%.
declare @pId int
declare Product_CursorUpdate  cursor
for 
	select Product_id 
	from Products 

open Product_CursorUpdate

fetch next from Product_CursorUpdate into @pId

while @@FETCH_STATUS = 0
begin 

	update Products
	set Price =  Price + Price * 0.1
	where Product_id=@pId

	fetch next from Product_CursorUpdate into @pId
end

close Product_CursorUpdate
deallocate Product_CursorUpdate


	select * from Products 

--6. Create a Cursor to Rounds the price of each product to the nearest whole number.


declare @pId int
declare Product_CursorUpdate  cursor
for 
	select Product_id 
	from Products 

open Product_CursorUpdate

fetch next from Product_CursorUpdate into @pId

while @@FETCH_STATUS = 0
begin 

	update Products
	set Price =  Round(Price , 0)
	where Product_id=@pId

	fetch next from Product_CursorUpdate into @pId
end

close Product_CursorUpdate
deallocate Product_CursorUpdate


-------------------------------c----------------------------------------------------------------------------------------
--7. Create a cursor to insert details of Products into the NewProducts table if the product is “Laptop”
--(Note: Create NewProducts table first with same fields as Products table)

CREATE TABLE NewProducts (
 Product_id INT PRIMARY KEY,
 Product_Name VARCHAR(250) NOT NULL,
 Price DECIMAL(10, 2) NOT NULL
);

declare @pId int,@product varchar(40),@price int
declare Product_CursorUpdate1  cursor
for 
	select Product_id,Product_Name,Price 
	from Products 
	where Product_Name = 'Laptop'
	
open Product_CursorUpdate1

fetch next from Product_CursorUpdate1 into @pId,@product,@price

while @@FETCH_STATUS = 0
begin 

	insert into NewProducts values (@pId,@product,@price)
	
	fetch next from Product_CursorUpdate1 into @pId,@product,@price
end

close Product_CursorUpdate1
deallocate Product_CursorUpdate1


select * from NewProducts


--8. Create a Cursor to Archive High-Price Products in a New Table (ArchivedProducts), Moves products
--with a price above 50000 to an archive table, removing them from the original Products table.

CREATE TABLE ArchivedProducts (
 Product_id INT PRIMARY KEY,
 Product_Name VARCHAR(250) NOT NULL,
 Price DECIMAL(10, 2) NOT NULL
);

declare @pId int,@product varchar(40),@price int
declare Product_CursorUpdate1  cursor
for 
	select Product_id,Product_Name,Price
	from Products 
	where Price > 50000
	
open Product_CursorUpdate1

fetch next from Product_CursorUpdate1 into @pId,@product,@price

while @@FETCH_STATUS = 0
begin 

	insert into ArchivedProducts values (@pId,@product,@price)
	delete from Products 
	where Product_id =  @pId

	fetch next from Product_CursorUpdate1 into @pId,@product,@price
end

close Product_CursorUpdate1
deallocate Product_CursorUpdate1


select * from NewProducts
select * from Products





