USE ORG;

CREATE TABLE Worker (
	WORKER_ID INT NOT NULL PRIMARY KEY,
	FIRST_NAME CHAR(25),
	LAST_NAME CHAR(25),
	SALARY INT,
	JOINING_DATE DATETIME,
	DEPARTMENT CHAR(25)
);

Select * from Worker;

INSERT INTO Worker 
	(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
		(001, 'Monika', 'Arora', 100000, '2020-02-14 09:00:00', 'HR'),
		(002, 'Niharika', 'Verma', 80000, '2011-06-14 09:00:00', 'Admin'),
		(003, 'Vishal', 'Singhal', 300000, '2020-02-14 09:00:00', 'HR'),
		(004, 'Amitabh', 'Singh', 500000, '2020-02-14 09:00:00', 'Admin'),
		(005, 'Vivek', 'Bhati', 500000, '2011-06-14 09:00:00', 'Admin'),
		(006, 'Vipul', 'Diwan', 200000, '2011-06-14 09:00:00', 'Account'),
		(007, 'Satish', 'Kumar', 75000, '2020-01-14 09:00:00', 'Account'),
		(008, 'Geetika', 'Chauhan', 90000, '2011-04-14 09:00:00', 'Admin');


CREATE TABLE Bonus (
	WORKER_REF_ID INT,
	BONUS_AMOUNT INT,
	BONUS_DATE DATETIME,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Bonus 
	(WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
		(001, 5000, '2020-02-16'),
		(002, 3000, '2011-06-16'),
		(003, 4000, '2020-02-16'),
		(001, 4500, '2020-02-16'),
		(002, 3500, '2011-06-15');

Select * from Bonus;


CREATE TABLE Title (
	WORKER_REF_ID INT,
	WORKER_TITLE CHAR(25),
	AFFECTED_FROM DATETIME,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Title 
	(WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
 (001, 'Manager', '2016-02-20 00:00:00'),
 (002, 'Executive', '2016-06-11 00:00:00'),
 (008, 'Executive', '2016-06-11 00:00:00'),
 (005, 'Manager', '2016-06-11 00:00:00'),
 (004, 'Asst. Manager', '2016-06-11 00:00:00'),
 (007, 'Executive', '2016-06-11 00:00:00'),
 (006, 'Lead', '2016-06-11 00:00:00'),
 (003, 'Lead', '2016-06-11 00:00:00');

 Select * from Title;

 




 /*Task1*/

 /*1*/
 Select FIRST_NAME as WORKER_NAME from Worker; 

 /*2*/
 Select UPPER(FIRST_NAME) as FIRST_NAME  from Worker;

 /*3*/
 Select DISTINCT DEPARTMENT from Worker;

 /*4*/
 Select SUBSTRING(FIRST_NAME,1,3) from Worker;

 /*5*/
 Select  DISTINCT DEPARTMENT, len(DEPARTMENT) as Count from worker;

 /*6*/
 Select CONCAT(FIRST_NAME,'',LAST_NAME) as COMPLETE_NAME from Worker; 

 /*7*/
 Select * from Worker where FIRST_NAME='Vipul' or FIRST_NAME='Satish'; 

 /*8*/
 Select * from Worker where DEPARTMENT='Admin';

 /*9*/
 Select * from Worker where FIRST_NAME like '%a';
 
 /*10*/
  Select * from Worker where FIRST_NAME like '%a%';








 /*Task-2*/


 /*1*/
 create synonym emp for Worker; 

 Select * from emp;
 Select * from Worker;

 Select * from sys.synonyms 



 /*2*/
--INDEX

--create a clustered index on demo table
create clustered index ind_TID on demo(TID);

--create a non clustered index on demo table
create index ind_TName on demo(TName);

select * from Worker;

--Filtered index
create index ind on Worker(Department) where Department='Account';

select * from Worker where Department='Account';


  /*3*/
-- a.Simple View
Select * from Worker;

--Create the view
create view Worker_View
as
Select * from Worker where DEPARTMENT='Account';

--Retrieve the view
Select * from Worker_View;

--insert into a simple view - will automatically reflect the changes in the original table
insert into Worker_View values(009, 'Nish', 'Shetty', 200000, '2011-06-14 09:00:00', 'Account');

--update in a simple view
update Worker_View set SALARY=50000 where WORKER_ID=006;

--delete in a simple view
delete from Worker_View where WORKER_ID=009;


--b. Complex View

--Result of 2 tables - using join clause
Select w.WORKER_ID ,w.FIRST_NAME,b.WORKER_REF_ID,b.BONUS_AMOUNT
from Worker as w inner join Bonus as b on w.WORKER_ID=b.WORKER_REF_ID;

create view Worker_bonus
as
Select w.WORKER_ID ,w.FIRST_NAME,b.WORKER_REF_ID,b.BONUS_AMOUNT
from Worker as w inner join Bonus as b on w.WORKER_ID=b.WORKER_REF_ID;

Select * from Worker_bonus;
Select * from Worker;

--insert in a complex view
insert into Worker_bonus values(009, 'Nish', 'Shetty', 200000, '2011-06-14 09:00:00', 'Account');

--update in a complex view
update Bonus set  WORKER_REF_ID=006 where BONUS_AMOUNT=50000 ;

--delete in a complex view
delete from Worker_bonus where WORKER_REF_ID=009;


/*4*/
--SEQUENCE

create table demo
(
TID int,
TName varchar(20)
);

create sequence TraineeID as int start with 100 increment by 2;

insert into demo values(NEXT VALUE FOR TraineeID,'John');
insert into demo values(NEXT VALUE FOR TraineeID,'Sam');
insert into demo values(NEXT VALUE FOR TraineeID,'Paul');
insert into demo values(NEXT VALUE FOR TraineeID,'James');

select * from demo

create table demo1
(
TID int,
TName varchar(20)
)

insert into demo1 values(NEXT VALUE FOR TraineeID,'John');
insert into demo1 values(NEXT VALUE FOR TraineeID,'Sam');
insert into demo1 values(NEXT VALUE FOR TraineeID,'Paul');
insert into demo1 values(NEXT VALUE FOR TraineeID,'James');

select * from demo
select * from demo1

--TRUNCATE
truncate table demo1

--ALTER THE SEQUENCE AND RESET THE VALUE
alter sequence TraineeID restart with 1000 increment by 1

--drop sequence
drop sequence TraineeID



/*String Function*/

Select * from Worker;

create function Fn_WorByID(@worid int)
returns table
as
return(select * from Worker where WORKER_ID=@worid)

--call the function 
Select * from Fn_WorByID(11);

create function Fn_SearchWorker()
-- should match with the actual table (no of col,seq of col,datatype of col)
returns @EmpTable Table(EmpID int,EmpName varchar(20),EmpAge int)
as
begin
--insert into select 
	insert into @EmpTable
		select EID,EName,EAge from Worker;
	return
end

--call the function
select * from dbo.Fn_SearchWorker();
--update dbo.Fn_SearchEmployee() -- Multi-statement

update dbo.Fn_SearchEmployee() set EmpAge=24 where EmpID=11--Object 'dbo.Fn_SearchEmployee' cannot be modified.



/*Math Function*/

create function Fn_Square(@a int)
returns int
as
begin
	return @a * @a
end

--call the function
select dbo.Fn_Square(5) as Result;

select * from demo;

select dbo.Fn_Square(TID),TName from demo;

select dbo.Fn_Square(WORKER_ID),FIRST_NAME from Worker;

/*DateTime Function*/
--scalar function to calculate the datediff
create function Fn_datediff(@DateField Date)
returns int
as
begin
	Declare @days int --declaration of the table variable
	Set @days=datediff(day,@DateField,Getdate()) --assigning the difference in days to @days
	return @days
end

alter function Fn_datediff(@DateField Date)
returns int
as
begin
	Declare @month int --declaration of the table variable
	Set @month=datediff(month,@DateField,Getdate()) --assigning the difference in month to @month
	return @month
end

alter function Fn_datediff(@DateField Date)
returns int
as
begin
	Declare @year int --declaration of the table variable
	Set @year=datediff(year,@DateField,Getdate()) --assigning the difference in year to @year
	return @year
end


--Select Clause
--select TID,TName,DOJ,dbo.Fn_datediff(DOJ) as 'Days Elapsed' from demo;
--where clause
--select TID,TName,DOJ,dbo.Fn_datediff(DOJ) as 'Days Elapsed' from demo where dbo.Fn_datediff(DOJ)>0;

--select dbo.Fn_datediff('02/20/2000') as 'Age'



