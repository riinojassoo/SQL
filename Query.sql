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