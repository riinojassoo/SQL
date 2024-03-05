--loome db (aktiveeri F5-ga - peab ka enne rea selectima)
create database TARge23SQL

--db valimine
use TARge23SQL

--db kustutamine
drop database TARge23SQL

--tabeli loomine
create table Gender
(
Id int not null primary key,
Gender nvarchar(10) not null
)

--andmete sisestamine
insert into Gender (Id, Gender)
values (1, 'Male'),
(2, 'Female'),
(3, 'Unknown')

--vaatame tabeli sisu
select * from Gender

--loome uue tabeli
create table Person
(
Id int not null primary key,
Name nvarchar(30),
Email nvarchar(30),
GenderId int
)

--andmete sisestamine
insert into Person (Id, Name, Email, GenderId) values
(1, 'Superman', 's@s.com', 1),
(2, 'Wonderwoman', 'w@w.com', 2),
(3, 'Batman', 'b@b.com', 1),
(4, 'Aquaman', 'a@a.com', 1),
(5, 'Catwoman', 'c@c.com', 2),
(6, 'Antman', 'ant"ant.com', 1),
(7, NULL, NULL, 3)

--vaadake Person tabeli andmeid
select * from Person

--v��rv�tme �henduse loomine kahe tabeli vahel
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id)

--kui sisestad uue rea andmeid ja ei ole sisestanud GenderId-d 
--alla v��rtust, siis see automaatselt sisestab sellelele reale 
--v��rtuse 3 e unknown

alter table Person
add constraint DF_persons_GenderId
default 3 for GenderId

--sisestame andmed
insert into Person (Id, Name, Email)
values (9, 'Ironman', 'i@i.com')

select * from Person

--lisame uue veeru 
alter table Person
add Age nvarchar(10)

--lisame nr piirangu vanuse sisestamisel 
alter table Person
add constraint CK_Person_age check (Age > 0 and Age < 155)

--sisestame uue rea andmeid
insert into Person (Id, Name, Email, GenderId, Age)
values (10, 'Kalevipoeg', 'k@k.com', 1, 30)

--muudame koodiga andmeid
update Person
set Age = 35
where Id = 9

select * from Person

--sisestame muutuja City nvarchar(50)
alter table Person
add City nvarchar(50)

--sisestame City veergu andmeid
update Person
set City = 'Kaljuvald'
where Id = 10

select * from Person

--k�ik, kes elavad Gothami linnas 
select * from Person where City = 'Gotham'
--k�ik, kes ei ela Gothamis, kolm versiooni
select * from Person where City <> 'Gotham'
select * from Person where City != 'Gotham'
select * from Person where not City = 'Gotham'

--n�itab teatud vanusega inimesi
select * from Person where Age = 120 or Age = 50 or Age = 19
select * from Person where Age in (120, 50, 19)

--n�itab teatud vanusevahemikus olevaid inimesi
-- ka 22 ja 31 aastaseid
select * from Person where Age between 22 and 31

--wildcard e n�itab k�ik n-t�hega linnad
select * from Person where City like 'n%'

--k�ik emailid, kus on @-m�rk sees
select * from Person where Email like '%@%'

--n�itab Emaile, kus ei ole @-m�rki sees
select * from Person where Email not like '%@%'

--n�itab, kellel on emailis ees ja peale @-m�rki ainult �ks m�rk
select * from Person where Email like '_@_.com'

update Person
set Email = 'bat@bat.com'
where Id = 3

--k�ik, kellel nimes ei ole esimene t�ht W, A, C
select * from Person where name like '[^WAZ]%'
select * from Person

--kes elavad Gothamis ja New Yorkis
select * from Person where (City = 'Gotham' or City = 'New York')

--k�ik, kes elavad v�lja toodud linnades ja on vanemad kui 29
select * from Person where (City = 'Gotham' or City = 'New York')
and Age >= 30

--kuvab t�hestikulises j�rjekorras inimesi ja v�tab aluseks nime
select * from Person order by Name
--kuvab vastupidises j�rjekorras
select * from Person order by Name desc

--v�tab 3 esimest rida
select top 3 * from Person

--kolm esimest, aga tabeli j�rjestus on Age ja siis Name
select * from Person
select top 3 Age, Name from Person

--n�ita esimene 50% tabeli sisust
select top 50 percent * from Person

--j�rjestab vanuse j�rgi isikud
select * from Person order by cast(Age as int) desc

--05.03.2024
--k�ikide isikute koondvanus
select sum(cast(Age as int)) from Person

--kuvab k�ige nooremat isikut
select min(cast(Age as int)) from Person
--kuvab k�ige vanemat isikut
select max(cast(Age as int)) from Person

--n�eme konkreetsetes linnades olevate isikute koondvanust
select City, sum(cast(Age as int)) as TotalAge from Person group by City

--kuidas saab koodiga muuta andmet��pi ja selle pikkust
alter table Person
alter column Age int

--kuvab esimeses reas v�lja toodud j�rjestuses jamuudab Age-i TotalAge-ks
--j�rjestab Citys olevate nimede j�rgi ja siis GenderID j�rgi
select City, GenderId, sum(Age) as TotalAge from Person
group by City, GenderId
order by City

insert into Person values
(11, 'Robin', 'robin@r.com', 1, 29, 'Gotham')

--n�itab ridade arvu tabelis
select count(*) from Person
select * from Person

--n�itab tulemust mitu inimest on GenderID v��rtusega 1 konkreetses linnas
--arvutab vanuse kokku selles linnas 
select GenderId, City, sum(Age) as TotalAge, count(Id) as [Total Person(s)]
from Person
where GenderId = '1'
group by GenderId, City

--n�itab �ra inimeste koondvanuse, mis on �le 41 aasta ja kui palju neid igas linnas elab
--eristab inimeste soo �ra
select GenderId, City, sum(Age) as TotalAge, count(Id)
as [Total Person(s)]
from Person
group by GenderId, City having sum(Age) > 41

--loome tabelid Employees ja department
create table Department
(
Id int not null primary key,
DepartmentName nvarchar(50),
Location nvarchar(50),
DepartmentHead nvarchar(50)
)

create table Employees
(
Id int not null primary key,
Name nvarchar(50),
Gender nvarchar(50),
Salary nvarchar(50),
DepartmentId int
)

--sisestage 10 rida andmeid tabelisse
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (1, 'Tom', 'Male', 4000, 1),
(2, 'Pam', 'Female', 3000, 3),
(3, 'John', 'Male', 3500, 1),
(4, 'Sam', 'Male', 4500, 2),
(5, 'Todd', 'Male', 2800, 2),
(6, 'Ben', 'Male', 7000, 1),
(7, 'Sara', 'Female', 4800, 3),
(8, 'Valarie', 'Female', 5500, 1),
(9, 'James', 'Male', 6500, NULL),
(10, 'Russell', 'Male', 8800, NULL)

select * from Employees

--sisestage 4 rida andmeid tabelisse
insert into Department(Id, DepartmentName, Location, DepartmentHead)
values (1, 'IT', 'London', 'Rick'),
(2, 'Payroll', 'Delhi', 'Ron'),
(3, 'HR', 'New York', 'Christie'),
(4, 'Other Department', 'Sydney', 'Cinderella')

select * from Department

--left join
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id

--arvutab k�ikide palgad kokku Employees tabelis
select sum(cast(Salary as int)) from Employees
--min palk
select min(cast(Salary as int)) from Employees
--�he kuu palga saaja linnade l�ikes
select Location, sum(cast(Salary as int)) as TotalSalary
from Employees
left join Department 
on Employees.DepartmentId = Department.Id 
group by Location

alter table Employees
add City nvarchar(30)

select * from Employees
--kirjutame info tabelisse iga rea kohta eraldi ehk 1 oli london jne
update Employees
set City = 'New York'
where Id = 10

--n�itab erinevust palgafondi osas nii linnade kui ka soo osas
select City, Gender, sum(cast(Salary as int)) as TotalSalary from Employees
group by City, Gender
--sama p�ring nagu eelmine, aga linnad on t�hestikulises j�rjekorras
select City, Gender, sum(cast(Salary as int)) as TotalSalary from Employees
group by City, Gender
order by City

--loeb �ra ridade arvu Employees tabelis
select count(*) from Employees

--mitu t��tajat on soo ja linna kaupa
select Gender, City,
count(Id) as [Total Employee(s)]
from Employees
group by Gender, City

--kuvab ainult k�ik naised linnade kaupa
select Gender, City,
count(Id) as [Total Employee(s)]
from Employees
where Gender = 'Female'
group by Gender, City

--kuvab ainult k�ik mehed linnade kaupa
--ja kasutame having
select Gender, City,
count(Id) as [Total Employee(s)]
from Employees
group by Gender, City
having Gender = 'Male'

--see ei t��ta sest piirang tuleb
select * from Employees where sum(cast(Salary as int)) > 4000
--lahendus
select Gender, City, sum(cast(Salary as int)) as TotalSalary, count(Id)
as [Total Employee(s)]
from Employees group by Gender, City
having sum(cast(Salary as int)) > 4000

--loome tabeli, milles hakatakse automaatselt nummerdama Id-d
create table Test1
(
Id int identity(1,1),
Value nvarchar(20)
)

insert into Test1 values('X')
select * from Test1
