--Part – A
--1. Write a function to print "hello world".
create or alter function fn_hello()
returns varchar(50)
as
begin
	return 'hello world'
end

select dbo.fn_hello()

--2. Write a function which returns addition of two numbers.
create or alter function fn_addition(
	@n1 int,
	@n2 int
)
returns int
as
begin
	declare @ans int

	set @ans = @n1 + @n2
	return @ans
end

select dbo.fn_addition(12 , 12)


--3. Write a function to check whether the given number is ODD or EVEN.
create or alter function fn_oddAndEven(
	@n int
)
returns varchar(50)
as
begin
	declare @ans varchar(50)
	
	if @n%2=0
		set @ans = 'even'
	
	else
		set @ans = 'odd'
	return @ans
end

select dbo.fn_oddAndEven(13)


--4. Write a function which returns a table with details of a person whose first name starts with B.
create or alter function fn_showFirstName()
returns table
as
return(
	select firstname from Person where FirstName like 'B%'
)

select * from dbo.fn_showFirstName()

--5. Write a function which returns a table with unique first names from the person table.
create or alter function fn_showFirstNameUnique()
returns table
as
return(
	select distinct firstname from Person 
)

select * from dbo.fn_showFirstNameUnique()

--6. Write a function to print number from 1 to N. (Using while loop)
create or alter function fn_whileOneToN(
	@n int 
)
returns varchar(50)
as
begin
	declare @i int , @ans varchar(50)

	set @i = 1
	set @ans = ''
	while @i<=@n
	begin	
		set @ans  = @ans + cast(@i as varchar(50))
		set @i = @i + 1
	end
	return @ans
end

select dbo.fn_whileOneToN(6)

--7. Write a function to find the factorial of a given integer
create or alter function fn_Fac(
	@n int 
)
returns int
as
begin
	
	if @n = 1
		return 1

	return @n * dbo.fn_Fac(@n - 1)
	
end

select dbo.fn_Fac(3)


--Part – B

--8. Write a function to compare two integers and return the comparison result. (Using Case statement)
create or alter function fn_intCompare(
	@n1 int, 
	@n2 int 
)
returns varchar(50)
as
begin

	return case
		when @n1>@n2 then cast(@n1 as varchar(50))+ ' is big'
		else cast(@n2 as varchar(50))+ ' is big'
	end
end

select dbo.fn_intCompare(6,12)
--9. Write a function to print the sum of even numbers between 1 to 20.
create or alter function fn_1to20()
returns int
as
begin
	declare @sum int , @i int 
	set @i = 1
	set @sum = 0
	while @i <= 20
	begin
		if @i%2=0
			set @sum = @sum + @i

		set @i = @i + 1
	end
	return @sum
end

select dbo.fn_1to20()

--10. Write a function that checks if a given string is a palindrome.
create or alter function fn_palindrome(
	@str varchar(50)
)
returns bit
as
begin
	if @str = reverse(@str)
		return 1;
	
	return 0;
end

select dbo.fn_palindrome('kishihsi')


--Part – C
--11. Write a function to check whether a given number is prime or not.
create or alter function fn_isPrime(
	@n int
)
returns bit
as
begin
	declare @count int , @i int 
	set @i = 1
	set @count = 0
	while @i <= @n
	begin
		if @n%@i=0
			set @count = @count + 1

		set @i = @i + 1
	end
	if @count = 2 
		return 1
		
	return 0
end

select dbo.fn_isPrime(7)


--12. Write a function which accepts two parameters start date & end date, and returns a difference in days.
create or alter function fn_diffdate(
	@sd date,
	@ed date 
)
returns int
as
begin
	return datediff(DAY,@sd,@ed)
end

select dbo.fn_diffdate('2005-07-01' , '2005-08-14')


--13. Write a function which accepts two parameters year & month in integer and returns total days each
--year.
create or alter function fn_yearAndMonth(
	@year int,
	@month int
)
returns int
as
begin
	declare @date varchar(50),@fdate date,@noDay int

	set @date  = cast(@year as varchar(50)) + '-' + cast(@month as varchar(50)) + '-1'
	set @fdate = cast(@date as date)
	set @noDay = day(eomonth(@fdate))

	return @noDay
end

select dbo.fn_yearAndMonth(2000,02)


--14. Write a function which accepts departmentID as a parameter & returns a detail of the persons.
create or alter function fn_detail_persons(
	@did int 
)
returns table
as
return (
	select * 
	from person
	where DepartmentID = @did
)
select *from dbo.fn_detail_persons(1)

--15. Write a function that returns a table with details of all persons who joined after 1-1-1991.
create or alter function fn_detail_join(
)
returns table
as
return (
	select * 
	from person
	where JoiningDate>'1991-01-01'
)
select *from dbo.fn_detail_join()

