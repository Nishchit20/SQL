use ORG

--1. Scalar Function with 2 parameters - any concept
create function addition(@a int,@b int)
returns int
as
begin
	return @a + @b
end;

select dbo.addition(5,10) as result;


--2. Procedure with OUTPUT parameter
select * from Worker;

--creating the procedure to sum thr salary > 100000
create procedure Totalsalary(@total int OUTPUT)
as
Begin
	Select @total=sum(Salary) from Worker where SALARY>100000;
End;

Declare @sum int
exec Totalsalary @sum OUTPUT
Print @sum


--3. Trigger to restrict DML access between 6:00PM to 10.00AM
select * from Bonus;

create trigger dmlTrigger
on Bonus 
FOR INSERT, UPDATE, DELETE
as
begin
	if ((DATEPART(HH,GETDATE())>17) or (DATEPART(HH,GETDATE())<10))
	BEGIN
		print 'You cannot perform DML into the Bonus table between 6:00PM to 10.00AM'
		Rollback transaction 
	END
end


--4. Server-scope trigger to restrict DDL access
create trigger serverddl
on ALL Server
For Create_Table,Alter_Table,Drop_Table
as
Begin
	Print 'You cannot perform DDL on any Database'
	Rollback Transaction
End

--cannot acces the database
create table table1(
	names int,
	place varchar(20)
);

--disable trigger
Disable trigger serverddl on ALL SERVER



--5. Working of explicit transaction with Save transaction

select * from interns

BEGIN TRANSACTION
	insert into interns values(1010,'Danny');
	update interns set IName='Allen' where ID=1006;
	--SAVEPOINT
	SAVE TRANSACTION insertUpdate
	delete from interns where ID=1002;
	ROLLBACK TRANSACTION insertUpdate
COMMIT TRANSACTION


--6. Difference between throw and Raiserror in exception handling

create procedure DivideByZero
@n1 int,
@n2 int
as
BEGIN	
	Declare @Result int
	SET @Result = 0
	IF(@n2=0)
	BEGIN
		RAISERROR('Cannot Divide By Zero',16,127) --RaiseError with the intensity mentioned
	END
	ELSE
	BEGIN
		SET @Result=@n1/@n2
		PRINT 'Value is:' + CAST(@Result as varchar)
	END
END

EXEC DivideByZero 5,0


--exception hamdling
create procedure DivideByZeroTryCatchBlock
@n1 int,
@n2 int
as
BEGIN	
	Declare @Result int
	SET @Result = 0
	BEGIN TRY
		BEGIN
			IF(@n2=0)
			THROW 50001,'Cannot Divide By Zero',1 -- Throwing an exception
			SET @Result=@n1/@n2
			PRINT 'Value is:' + CAST(@Result as varchar)
		END
	END TRY
	BEGIN CATCH
		PRINT ERROR_NUMBER()
		PRINT ERROR_MESSAGE()
		PRINT ERROR_SEVERITY()
		PRINT ERROR_STATE()		
	END CATCH
END


execute DivideByZeroTryCatchBlock 5,0