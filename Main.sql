/*
  Database Administration Project
  Tutor: Ray Williams
*/

-- Setup config for IDE (Mac Users only)IDE
create user Database_administration_2019 identified by pass1234;

grant connect to Database_administration_2019;

grant create session to Database_administration_2019;

grant create table to Database_administration_2019 with admin option;

create tablespace data datafile '/Users/marc/Documents/Oracle' size 500M; -- Datafile location is unique to machine

alter database default tablespace users;

alter user Database_administration_2019 quota unlimited on USERS;


-- Section A - Database Application Requirements

-- 1
create table Customer(
  ID_number number primary key not null,
  FirstName varchar(50),
  LastName varchar(50),
  Gender char(1),
  DOB date
);

create table Address(
  ID_number number references Customer(ID_number),
  AddressID number primary key not null,
  Street_number number,
  Street_name varchar(100),
  Other_details varchar(250),
  Parish varchar(50),
  Postal_code number
);

create table CustomerMobile(
  ID_number number references Customer(ID_number),
  MobileNumber number
);

create table MailType(
  TypeID number primary key not null ,
  Cost_per_pound number,
  Name varchar(100)
);

create table Mail(
  ID_number number references Customer(ID_number),
  TypeID number references MailType(TypeID),
  SenderID number primary key not null,
  RecipientID number,
  DateReceived date,
  DateAssigned date,
  DateDelivered date,
  Weight number,
  StatusID number references Status(StatusID),
  Cost number)

  partition by range (DateReceived) interval (numtoyminterval(1,'Month'))
  (
    partition p0 values less than (to_date('1-1-2030','DD-MM-YYYY'))
  );
  
create table Status(
  StatusID number primary key not null,
  StatusType varchar(20)
);

create table Employee(
  TRN number(9) primary key not null,
  FirstName varchar(20),
  LastName varchar(20),
  DOB date,
  Gender char(1)
);

-- Additional Tables (These tables can vary depending on what we choose to work with)
create table AuditData(
  Audit_ID number primary key not null,
  Audit_name varchar(100),
  TIMESTAMP date
);

create table LogReport(
  LogID number primary key not null,
  Log_name varchar(100),
  TIMESTAMP date
);

-------------------------------------------------------------------------------

---Number A3----

-- Creation of roles, i granted the dba role to database_administration_2019 so the account can do everything 
grant dba to database_administration_2019;

connect database_administration_2019/pass1234


-- Role creation number 3

create role Viewing not identified; -- role for selecting tables

create role Modification not identified; -- role for dml statments

create role Administration not identified; -- role for admin purposes

-- Privileges granted to Viewing role

grant select on Customer to Viewing;

grant select on CustomerMobile to Viewing;

grant select on MailType to Viewing;

grant select on Mail to Viewing;

grant select on Employee to Viewing;

grant select on AuditData to Viewing;

grant select on status to Viewing;

Grant select on AuditMail to Viewing; 

--Privileges granted to Administration role

grant create user to Administration with admin option;

grant alter user to Administration with admin option;

grant drop user to Administration with admin option;

grant CREATE ANY TABLE to Administration with admin option;

grant select any table to Administration with admin option;

grant alter any table to Administration with admin option;

grant drop any table to Administration with admin option;

grant create role to Administration with admin option;

grant create any view to Administration with admin option;

grant CREATE Session to Administration with admin option;

--Privileges granted to Modification role

grant execute any procedure to Modification;

-------------------------------------------------------------------------------

----- Number A4------

connect database_administration_2019/pass1234
-------------
-- Inserts --
-------------
-- insert into customer table

Create or replace procedure sp_insertCustomer(P_ID_number in number,P_FirstName in varchar,
  P_LastName in varchar, P_Gender in char, P_DOB in date)
as
begin
--Check the day of the week and if current time between 6am -7pm fmday is used to get day without blankspaces
-- fm removes the 0 or blank spaces of days when they are returned
if (TO_CHAR(sysdate, 'fmDAY')= 'WEDNESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	insert into database_administration_2019.Customer(ID_number ,FirstName ,LastName ,Gender,DOB)
	values
	(P_ID_number ,P_FirstName ,P_LastName ,P_Gender,P_DOB);
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'MONDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	insert into database_administration_2019.Customer(ID_number ,FirstName ,LastName ,Gender,DOB)
	values
	(P_ID_number ,P_FirstName ,P_LastName ,P_Gender,P_DOB);
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'TUESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	insert into database_administration_2019.Customer(ID_number ,FirstName ,LastName ,Gender,DOB)
	values
	(P_ID_number ,P_FirstName ,P_LastName ,P_Gender,P_DOB);
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'THURSDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	insert into database_administration_2019.Customer(ID_number ,FirstName ,LastName ,Gender,DOB)
	values
	(P_ID_number ,P_FirstName ,P_LastName ,P_Gender,P_DOB);
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'FRIDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	insert into database_administration_2019.Customer(ID_number ,FirstName ,LastName ,Gender,DOB)
	values
	(P_ID_number ,P_FirstName ,P_LastName ,P_Gender,P_DOB);
	
End if;
end if;
End if;
end if;
End if;

End sp_insertCustomer;
/

--How to execute the procedure

--EXECUTE database_administration_2019.sp_insertCustomer(7,'WEDNESDAY','Check','M',TO_DATE('1996/03/05', 'yyyy/mm/dd '));


--insert into CustomerMobile

Create or replace procedure sp_insertCustomerMobile (P_ID_number in number,P_MobileNumber in number)
as
begin

if (TO_CHAR(sysdate, 'fmDAY')= 'WEDNESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	insert into database_administration_2019.CustomerMobile(ID_number,MobileNumber)
	values
	(P_ID_number , P_MobileNumber );
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'MONDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	insert into database_administration_2019.CustomerMobile(ID_number,MobileNumber)
	values
	(P_ID_number , P_MobileNumber );
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'TUESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	insert into database_administration_2019.CustomerMobile(ID_number,MobileNumber)
	values
	(P_ID_number , P_MobileNumber );
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'THURSDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	insert into database_administration_2019.CustomerMobile(ID_number,MobileNumber)
	values
	(P_ID_number , P_MobileNumber );
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'FRIDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	insert into database_administration_2019.CustomerMobile(ID_number,MobileNumber)
	values
	(P_ID_number , P_MobileNumber );
	
End if;
end if;
End if;
end if;
End if;

End sp_insertCustomerMobile;
/

--insert into mailtype


Create or replace procedure sp_insertMailType (P_TypeID in number , P_Cost_per_pound in number,
  P_Name in varchar)
as
begin

if (TO_CHAR(sysdate, 'fmDAY')= 'WEDNESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	insert into database_administration_2019.MailType(TypeID,Cost_per_pound,Name)
	values
	(P_TypeID , P_Cost_per_pound,P_Name );
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'MONDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	insert into database_administration_2019.MailType(TypeID,Cost_per_pound,Name)
	values
	(P_TypeID , P_Cost_per_pound,P_Name );
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'TUESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	insert into database_administration_2019.MailType(TypeID,Cost_per_pound,Name)
	values
	(P_TypeID , P_Cost_per_pound,P_Name );
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'THURSDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	insert into database_administration_2019.MailType(TypeID,Cost_per_pound,Name)
	values
	(P_TypeID , P_Cost_per_pound,P_Name );
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'FRIDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	insert into database_administration_2019.MailType(TypeID,Cost_per_pound,Name)
	values
	(P_TypeID , P_Cost_per_pound,P_Name );
	
End if;
end if;
End if;
end if;
End if;

End sp_insertMailType;
/

--insert into employee

 
 Create or replace procedure sp_insertEmployee(P_TRN in number ,P_FirstName in varchar2,P_LastName in varchar2,P_DOB in date, P_Gender in char)
as
begin

if (TO_CHAR(sysdate, 'fmDAY')= 'WEDNESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	insert into database_administration_2019.Employee(TRN,FirstName ,LastName ,DOB , Gender)
	values
	(P_TRN,P_FirstName ,P_LastName ,P_DOB , P_Gender );
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'MONDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	insert into database_administration_2019.Employee(TRN,FirstName ,LastName ,DOB , Gender)
	values
	(P_TRN,P_FirstName ,P_LastName ,P_DOB , P_Gender );
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'TUESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	insert into database_administration_2019.Employee(TRN,FirstName ,LastName ,DOB , Gender)
	values
	(P_TRN,P_FirstName ,P_LastName ,P_DOB , P_Gender );
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'THURSDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	insert into database_administration_2019.Employee(TRN,FirstName ,LastName ,DOB , Gender)
	values
	(P_TRN,P_FirstName ,P_LastName ,P_DOB , P_Gender );
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'FRIDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	insert into database_administration_2019.Employee(TRN,FirstName ,LastName ,DOB , Gender)
	values
	(P_TRN,P_FirstName ,P_LastName ,P_DOB , P_Gender );
	
End if;
end if;
End if;
end if;
End if;

End sp_insertEmployee;
/

--insert into Address

 
 Create or replace procedure sp_insertAddress(P_ID_number in number,P_AddressID in number ,P_Street_number in number,
 P_Street_name in varchar ,P_Other_details in varchar,P_Parish in varchar,P_Postal_code in number)
as
begin

if (TO_CHAR(sysdate, 'fmDAY')= 'WEDNESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	insert into database_administration_2019.Address(ID_number ,AddressID ,Street_number , Street_name  ,Other_details ,Parish ,Postal_code )
	values
	(P_ID_number ,P_AddressID ,P_Street_number , P_Street_name  ,P_Other_details ,P_Parish ,P_Postal_code );
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'MONDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	insert into database_administration_2019.Address(ID_number ,AddressID ,Street_number , Street_name  ,Other_details ,Parish ,Postal_code )
	values
	(P_ID_number ,P_AddressID ,P_Street_number , P_Street_name  ,P_Other_details ,P_Parish ,P_Postal_code );
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'TUESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	insert into database_administration_2019.Address(ID_number ,AddressID ,Street_number , Street_name  ,Other_details ,Parish ,Postal_code )
	values
	(P_ID_number ,P_AddressID ,P_Street_number , P_Street_name  ,P_Other_details ,P_Parish ,P_Postal_code );
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'THURSDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	insert into database_administration_2019.Address(ID_number ,AddressID ,Street_number , Street_name  ,Other_details ,Parish ,Postal_code )
	values
	(P_ID_number ,P_AddressID ,P_Street_number , P_Street_name  ,P_Other_details ,P_Parish ,P_Postal_code );
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'FRIDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	insert into database_administration_2019.Address(ID_number ,AddressID ,Street_number , Street_name  ,Other_details ,Parish ,Postal_code )
	values
	(P_ID_number ,P_AddressID ,P_Street_number , P_Street_name  ,P_Other_details ,P_Parish ,P_Postal_code );
	
End if;
end if;
End if;
end if;
End if;

End sp_insertAddress;
/

--insert into Mail

 
 Create or replace procedure sp_insertMail(P_ID_number in number ,P_TypeID in number ,P_SenderID in number ,P_RecipientID in number,P_DateReceived in date, 
 P_DateAssigned in date, P_DateDelivered in date, P_Weight in number,P_StatusID in number )
as

	totalCost number;
	rating number;
	
begin

--Geting the cost per pound from mailtype table 
SELECT Cost_per_pound INTO rating FROM database_administration_2019.MailType where TypeID = P_TypeID ;

--calculating the total cost of mail using weight and cost per pound
totalCost:=rating*P_weight;
	

if (TO_CHAR(sysdate, 'fmDAY')= 'WEDNESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	insert into database_administration_2019.Mail(ID_number ,TypeID ,SenderID ,RecipientID ,DateReceived , DateAssigned , DateDelivered , Weight ,StatusID,cost )
	values
	(P_ID_number ,P_TypeID ,P_SenderID ,P_RecipientID ,P_DateReceived , P_DateAssigned , P_DateDelivered , P_Weight ,P_StatusID,totalcost);
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'MONDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	insert into database_administration_2019.Mail(ID_number ,TypeID ,SenderID ,RecipientID ,DateReceived , DateAssigned , DateDelivered , Weight ,StatusID,cost )
	values
	(P_ID_number ,P_TypeID ,P_SenderID ,P_RecipientID ,P_DateReceived , P_DateAssigned , P_DateDelivered , P_Weight ,P_StatusID,totalcost);
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'TUESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	insert into database_administration_2019.Mail(ID_number ,TypeID ,SenderID ,RecipientID ,DateReceived , DateAssigned , DateDelivered , Weight ,StatusID,cost )
	values
	(P_ID_number ,P_TypeID ,P_SenderID ,P_RecipientID ,P_DateReceived , P_DateAssigned , P_DateDelivered , P_Weight ,P_StatusID,totalcost);
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'THURSDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	insert into database_administration_2019.Mail(ID_number ,TypeID ,SenderID ,RecipientID ,DateReceived , DateAssigned , DateDelivered , Weight ,StatusID,cost )
	values
	(P_ID_number ,P_TypeID ,P_SenderID ,P_RecipientID ,P_DateReceived , P_DateAssigned , P_DateDelivered , P_Weight ,P_StatusID,totalcost);
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'FRIDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	insert into database_administration_2019.Mail(ID_number ,TypeID ,SenderID ,RecipientID ,DateReceived , DateAssigned , DateDelivered , Weight ,StatusID,cost )
	values
	(P_ID_number ,P_TypeID ,P_SenderID ,P_RecipientID ,P_DateReceived , P_DateAssigned , P_DateDelivered , P_Weight ,P_StatusID,totalcost);
	
End if;
end if;
End if;
end if;
End if;

End sp_insertMail;
/


--Insert to Status


Create or replace procedure sp_insertStatus(P_StatusID in number ,P_StatusType in varchar)
as
begin

if (TO_CHAR(sysdate, 'fmDAY')= 'WEDNESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	insert into database_administration_2019.Status(StatusID ,StatusType )
	values
	(P_StatusID ,P_StatusType );
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'MONDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	insert into database_administration_2019.Status(StatusID ,StatusType )
	values
	(P_StatusID ,P_StatusType );
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'TUESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	insert into database_administration_2019.Status(StatusID ,StatusType )
	values
	(P_StatusID ,P_StatusType );
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'THURSDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	insert into database_administration_2019.Status(StatusID ,StatusType )
	values
	(P_StatusID ,P_StatusType );
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'FRIDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	insert into database_administration_2019.Status(StatusID ,StatusType )
	values
	(P_StatusID ,P_StatusType );
	
End if;
end if;
End if;
end if;
End if;

End sp_insertStatus;
/

----------------------------------------
---Delete STOREPROCEDURES---------------
----------------------------------------

---Delete from Status

Create or replace procedure sp_DeleteStatus(P_StatusID in number)
as
begin

if (TO_CHAR(sysdate, 'fmDAY')= 'WEDNESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	DELETE FROM database_administration_2019.Status
	where
	StatusID = P_StatusID;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'MONDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	DELETE FROM database_administration_2019.Status
	where
	StatusID = P_StatusID;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'TUESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	DELETE FROM database_administration_2019.Status
	where
	StatusID = P_StatusID;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'THURSDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	DELETE FROM database_administration_2019.Status
	where
	StatusID = P_StatusID;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'FRIDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	DELETE FROM database_administration_2019.Status
	where
	StatusID = P_StatusID;
	
End if;
end if;
End if;
end if;
End if;

End sp_DeleteStatus;
/

---Delete from Customer

Create or replace procedure sp_DeleteCustomer(P_ID_number in number)
as
begin

if (TO_CHAR(sysdate, 'fmDAY')= 'WEDNESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	DELETE FROM database_administration_2019.Customer
	where
	ID_number = P_ID_number;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'MONDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	DELETE FROM database_administration_2019.Customer
	where
	ID_number = P_ID_number;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'TUESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	DELETE FROM database_administration_2019.Customer
	where
	ID_number = P_ID_number;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'THURSDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	DELETE FROM database_administration_2019.Customer
	where
	ID_number = P_ID_number;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'FRIDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	DELETE FROM database_administration_2019.Customer
	where
	ID_number = P_ID_number;
	
End if;
end if;
End if;
end if;
End if;

End sp_DeleteCustomer;
/


---Delete from Address

Create or replace procedure sp_DeleteAddress(P_AddressID in number)
as
begin

if (TO_CHAR(sysdate, 'fmDAY')= 'WEDNESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	DELETE FROM database_administration_2019.Address
	where
	AddressID = P_AddressID;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'MONDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	DELETE FROM database_administration_2019.Address
	where
	AddressID = P_AddressID;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'TUESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	DELETE FROM database_administration_2019.Address
	where
	AddressID = P_AddressID;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'THURSDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	DELETE FROM database_administration_2019.Address
	where
	AddressID = P_AddressID;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'FRIDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	DELETE FROM database_administration_2019.Address
	where
	AddressID = P_AddressID;
	
End if;
end if;
End if;
end if;
End if;

End sp_DeleteAddress;
/



---Delete from CustomerMobile

Create or replace procedure sp_DeleteCustomerMobile(P_ID_number in number)
as
begin

if (TO_CHAR(sysdate, 'fmDAY')= 'WEDNESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	DELETE FROM database_administration_2019.CustomerMobile
	where
	ID_number= P_ID_number;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'MONDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	DELETE FROM database_administration_2019.CustomerMobile
	where
	ID_number= P_ID_number;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'TUESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	DELETE FROM database_administration_2019.CustomerMobile
	where
	ID_number= P_ID_number;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'THURSDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	DELETE FROM database_administration_2019.CustomerMobile
	where
	ID_number= P_ID_number;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'FRIDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	DELETE FROM database_administration_2019.CustomerMobile
	where
	ID_number= P_ID_number;
	
End if;
end if;
End if;
end if;
End if;

End sp_DeleteCustomerMobile;
/


---Delete from MailType

Create or replace procedure sp_DeleteMailType(P_TypeID in number)
as
begin

if (TO_CHAR(sysdate, 'fmDAY')= 'WEDNESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	DELETE FROM database_administration_2019.MailType
	where
	TypeID= P_TypeID;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'MONDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	DELETE FROM database_administration_2019.MailType
	where
	TypeID= P_TypeID;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'TUESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	DELETE FROM database_administration_2019.MailType
	where
	TypeID= P_TypeID;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'THURSDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	DELETE FROM database_administration_2019.MailType
	where
	TypeID= P_TypeID;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'FRIDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	DELETE FROM database_administration_2019.MailType
	where
	TypeID= P_TypeID;
	
End if;
end if;
End if;
end if;
End if;

End sp_DeleteMailType;
/


---Delete from Mail

Create or replace procedure sp_DeleteMail(P_ID_number in number)
as
begin

if (TO_CHAR(sysdate, 'fmDAY')= 'WEDNESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	DELETE FROM database_administration_2019.Mail
	where
	ID_number= P_ID_number;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'MONDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	DELETE FROM database_administration_2019.Mail
	where
	ID_number= P_ID_number;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'TUESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	DELETE FROM database_administration_2019.Mail
	where
	ID_number= P_ID_number;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'THURSDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	DELETE FROM database_administration_2019.Mail
	where
	ID_number= P_ID_number;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'FRIDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	DELETE FROM database_administration_2019.Mail
	where
	ID_number= P_ID_number;
	
End if;
end if;
End if;
end if;
End if;

End sp_DeleteMail;
/


---Delete from Employee

Create or replace procedure sp_DeleteEmployee(P_TRN in number)
as
begin

if (TO_CHAR(sysdate, 'fmDAY')= 'WEDNESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	DELETE FROM database_administration_2019.Employee
	where
	TRN= P_TRN;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'MONDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	DELETE FROM database_administration_2019.Employee
	where
	TRN= P_TRN;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'TUESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	DELETE FROM database_administration_2019.Employee
	where
	TRN= P_TRN;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'THURSDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	DELETE FROM database_administration_2019.Employee
	where
	TRN= P_TRN;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'FRIDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	DELETE FROM database_administration_2019.Employee
	where
	TRN= P_TRN;
	
End if;
end if;
End if;
end if;
End if;

End sp_DeleteEmployee;
/

------------------------
---UPDATE PROCEDURES----
------------------------

---Update to Customer


Create or replace procedure sp_UpdateCustomer(P_ID_number in number,P_FirstName in varchar,
  P_LastName in varchar, P_Gender in char, P_DOB in date)
as
begin
--Check the day of the week and if current time between 6am -7pm fmday is used to get day without blankspaces
if (TO_CHAR(sysdate, 'fmDAY')= 'WEDNESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	UPDATE database_administration_2019.Customer
	SET FirstName = P_FirstName,
    LastName = P_LastName,
	Gender = P_Gender,
	DOB = P_DOB
	WHERE ID_number = P_ID_number;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'MONDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	UPDATE database_administration_2019.Customer
	SET FirstName = P_FirstName,
    LastName = P_LastName,
	Gender = P_Gender,
	DOB = P_DOB
	WHERE ID_number = P_ID_number;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'TUESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	UPDATE database_administration_2019.Customer
	SET FirstName = P_FirstName,
    LastName = P_LastName,
	Gender = P_Gender,
	DOB = P_DOB
	WHERE ID_number = P_ID_number;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'THURSDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	UPDATE database_administration_2019.Customer
	SET FirstName = P_FirstName,
    LastName = P_LastName,
	Gender = P_Gender,
	DOB = P_DOB
	WHERE ID_number = P_ID_number;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'FRIDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	UPDATE database_administration_2019.Customer
	SET FirstName = P_FirstName,
    LastName = P_LastName,
	Gender = P_Gender,
	DOB = P_DOB
	WHERE ID_number = P_ID_number;
	
End if;
end if;
End if;
end if;
End if;

End sp_UpdateCustomer;
/

EXECUTE database_administration_2019.sp_UpdateCustomer(1,'Ryan','Newman','M',TO_DATE('1996/03/05', 'yyyy/mm/dd '));

----UPDATE to customerMobile

Create or replace procedure sp_UpdateCustomerMobile (P_ID_number in number,P_MobileNumber in number)
as
begin

if (TO_CHAR(sysdate, 'fmDAY')= 'WEDNESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	UPDATE database_administration_2019.CustomerMobile
	SET MobileNumber = P_MobileNumber
	WHERE ID_number = P_ID_number;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'MONDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	UPDATE database_administration_2019.CustomerMobile
	SET MobileNumber = P_MobileNumber
	WHERE ID_number = P_ID_number;
		
Else if (TO_CHAR(sysdate, 'fmDAY')= 'TUESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	UPDATE database_administration_2019.CustomerMobile
	SET MobileNumber = P_MobileNumber
	WHERE ID_number = P_ID_number;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'THURSDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	UPDATE database_administration_2019.CustomerMobile
	SET MobileNumber = P_MobileNumber
	WHERE ID_number = P_ID_number;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'FRIDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	UPDATE database_administration_2019.CustomerMobile
	SET MobileNumber = P_MobileNumber
	WHERE ID_number = P_ID_number;
	
End if;
end if;
End if;
end if;
End if;

End sp_UpdateCustomerMobile;
/

-- update to mailtype


Create or replace procedure sp_UpdateMailType (P_TypeID in number , P_Cost_per_pound in number,
  P_Name in varchar)
as
begin

if (TO_CHAR(sysdate, 'fmDAY')= 'WEDNESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	UPDATE database_administration_2019.mailtype
	SET Cost_per_pound = P_Cost_per_pound,
	Name = P_Name
	WHERE TypeID = P_TypeID;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'MONDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	UPDATE database_administration_2019.mailtype
	SET Cost_per_pound = P_Cost_per_pound,
	Name = P_Name
	WHERE TypeID = P_TypeID;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'TUESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	UPDATE database_administration_2019.mailtype
	SET Cost_per_pound = P_Cost_per_pound,
	Name = P_Name
	WHERE TypeID = P_TypeID;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'THURSDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	UPDATE database_administration_2019.mailtype
	SET Cost_per_pound = P_Cost_per_pound,
	Name = P_Name
	WHERE TypeID = P_TypeID;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'FRIDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	UPDATE database_administration_2019.mailtype
	SET Cost_per_pound = P_Cost_per_pound,
	Name = P_Name
	WHERE TypeID = P_TypeID;
	
End if;
end if;
End if;
end if;
End if;

End sp_UpdateMailType;
/

--Update to employee

 
 Create or replace procedure sp_UpdateEmployee(P_TRN in number ,P_FirstName in varchar2,P_LastName in varchar2,P_DOB in date, P_Gender in char)
as
begin

if (TO_CHAR(sysdate, 'fmDAY')= 'WEDNESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	UPDATE database_administration_2019.Employee
	SET FirstName = P_FirstName,
    LastName = P_LastName,
	Gender = P_Gender,
	DOB = P_DOB
	WHERE TRN = P_TRN;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'MONDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	UPDATE database_administration_2019.Employee
	SET FirstName = P_FirstName,
    LastName = P_LastName,
	Gender = P_Gender,
	DOB = P_DOB
	WHERE TRN = P_TRN;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'TUESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	UPDATE database_administration_2019.Employee
	SET FirstName = P_FirstName,
    LastName = P_LastName,
	Gender = P_Gender,
	DOB = P_DOB
	WHERE TRN = P_TRN;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'THURSDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	UPDATE database_administration_2019.Employee
	SET FirstName = P_FirstName,
    LastName = P_LastName,
	Gender = P_Gender,
	DOB = P_DOB
	WHERE TRN = P_TRN;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'FRIDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	UPDATE database_administration_2019.Employee
	SET FirstName = P_FirstName,
    LastName = P_LastName,
	Gender = P_Gender,
	DOB = P_DOB
	WHERE TRN = P_TRN;
	
End if;
end if;
End if;
end if;
End if;

End sp_UpdateEmployee;
/

--insert into Address

 
 Create or replace procedure sp_UpdateAddress(P_ID_number in number,P_AddressID in number ,P_Street_number in number,
 P_Street_name in varchar ,P_Other_details in varchar,P_Parish in varchar,P_Postal_code in number)
as
begin

if (TO_CHAR(sysdate, 'fmDAY')= 'WEDNESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	UPDATE database_administration_2019.Address
	SET ID_number = P_ID_number,
    Street_number = P_Street_number,
	Street_name = P_Street_name,
	Other_details = P_Other_details,
	Parish = P_Parish,
	Postal_code = P_Postal_code
	WHERE AddressID = P_AddressID;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'MONDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	UPDATE database_administration_2019.Address
	SET ID_number = P_ID_number,
    Street_number = P_Street_number,
	Street_name = P_Street_name,
	Other_details = P_Other_details,
	Parish = P_Parish,
	Postal_code = P_Postal_code
	WHERE AddressID = P_AddressID;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'TUESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	UPDATE database_administration_2019.Address
	SET ID_number = P_ID_number,
    Street_number = P_Street_number,
	Street_name = P_Street_name,
	Other_details = P_Other_details,
	Parish = P_Parish,
	Postal_code = P_Postal_code
	WHERE AddressID = P_AddressID;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'THURSDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	UPDATE database_administration_2019.Address
	SET ID_number = P_ID_number,
    Street_number = P_Street_number,
	Street_name = P_Street_name,
	Other_details = P_Other_details,
	Parish = P_Parish,
	Postal_code = P_Postal_code
	WHERE AddressID = P_AddressID;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'FRIDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	UPDATE database_administration_2019.Address
	SET ID_number = P_ID_number,
    Street_number = P_Street_number,
	Street_name = P_Street_name,
	Other_details = P_Other_details,
	Parish = P_Parish,
	Postal_code = P_Postal_code
	WHERE AddressID = P_AddressID;
	
End if;
end if;
End if;
end if;
End if;

End sp_UpdateAddress;
/

--Update to Mail

 
 Create or replace procedure sp_UpdateMail(P_ID_number in number ,P_TypeID in number ,P_SenderID in number ,P_RecipientID in number,P_DateReceived in date, 
 P_DateAssigned in date, P_DateDelivered in date, P_Weight in number,P_StatusID in number )
as

	totalCost number;
	rating number;
	
begin

--Geting the cost per pound from mailtype table 
SELECT Cost_per_pound INTO rating FROM database_administration_2019.MailType where TypeID = P_TypeID ;

--calculating the total cost of mail using weight and cost per pound
totalCost:=rating*P_weight;
	

if (TO_CHAR(sysdate, 'fmDAY')= 'WEDNESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	UPDATE database_administration_2019.Mail
	SET ID_number = P_ID_number,
    TypeID = P_TypeID,
	RecipientID = P_RecipientID,
	DateReceived = P_DateReceived,
	DateAssigned = P_DateAssigned,
	DateDelivered= P_DateDelivered,
	Weight = P_Weight,
	StatusID = P_StatusID,
	Cost = totalCost
	WHERE SenderID = P_SenderID;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'MONDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	UPDATE database_administration_2019.Mail
	SET ID_number = P_ID_number,
    TypeID = P_TypeID,
	RecipientID = P_RecipientID,
	DateReceived = P_DateReceived,
	DateAssigned = P_DateAssigned,
	DateDelivered= P_DateDelivered,
	Weight = P_Weight,
	StatusID = P_StatusID,
	Cost = totalCost
	WHERE SenderID = P_SenderID;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'TUESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	UPDATE database_administration_2019.Mail
	SET ID_number = P_ID_number,
    TypeID = P_TypeID,
	RecipientID = P_RecipientID,
	DateReceived = P_DateReceived,
	DateAssigned = P_DateAssigned,
	DateDelivered= P_DateDelivered,
	Weight = P_Weight,
	StatusID = P_StatusID,
	Cost = totalCost
	WHERE SenderID = P_SenderID;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'THURSDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	UPDATE database_administration_2019.Mail
	SET ID_number = P_ID_number,
    TypeID = P_TypeID,
	RecipientID = P_RecipientID,
	DateReceived = P_DateReceived,
	DateAssigned = P_DateAssigned,
	DateDelivered= P_DateDelivered,
	Weight = P_Weight,
	StatusID = P_StatusID,
	Cost = totalCost
	WHERE SenderID = P_SenderID;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'FRIDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	UPDATE database_administration_2019.Mail
	SET ID_number = P_ID_number,
    TypeID = P_TypeID,
	RecipientID = P_RecipientID,
	DateReceived = P_DateReceived,
	DateAssigned = P_DateAssigned,
	DateDelivered= P_DateDelivered,
	Weight = P_Weight,
	StatusID = P_StatusID,
	Cost = totalCost
	WHERE SenderID = P_SenderID;
	
End if;
end if;
End if;
end if;
End if;

End sp_UpdateMail;
/

--Update to Status


Create or replace procedure sp_UpdateStatus(P_StatusID in number ,P_StatusType in varchar)
as
begin

if (TO_CHAR(sysdate, 'fmDAY')= 'WEDNESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	UPDATE database_administration_2019.Status
	SET StatusType = P_StatusType
    WHERE StatusID = P_StatusID;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'MONDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	UPDATE database_administration_2019.Status
	SET StatusType = P_StatusType
    WHERE StatusID = P_StatusID;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'TUESDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	UPDATE database_administration_2019.Status
	SET StatusType = P_StatusType
    WHERE StatusID = P_StatusID;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'THURSDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	UPDATE database_administration_2019.Status
	SET StatusType = P_StatusType
    WHERE StatusID = P_StatusID;
	
Else if (TO_CHAR(sysdate, 'fmDAY')= 'FRIDAY') and (SYSDATE - TRUNC( SYSDATE ) BETWEEN 06/24 AND 19/24) then
	UPDATE database_administration_2019.Status
	SET StatusType = P_StatusType
    WHERE StatusID = P_StatusID;
	
End if;
end if;
End if;
end if;
End if;

End sp_UpdateStatus;
/

----------------------------------------------------------------------------------------------------------------------

---- Number A5-------

-- Audit table for mail

create table AuditMail(
  Audit_Number number primary key not null,
  Audit_User varchar2(50),
  Audit_date date,
  New_ID_number number ,
  Old_ID_number number ,
  New_TypeID number ,
  Old_TypeID number ,
  New_SenderID number ,
  Old_SenderID number ,
  New_RecipientID number,
  Old_RecipientID number,
  New_DateReceived date,
  Old_DateReceived date,
  New_DateAssigned date,
  Old_DateAssigned date,
  New_DateDelivered date,
  Old_DateDelivered date,
  New_Weight number,
  Old_Weight number,
  New_StatusID number ,
  Old_StatusID number,
  New_Cost number,
  Old_Cost number
  );

--- Allow auto increment for Auditmail ID
Create sequence Audit_Number start with 1
increment by 1
minvalue 1
maxvalue 10000;

--- TRIGGER---

CREATE OR REPLACE TRIGGER tr_AfterUpdateDeleteMail
AFTER UPDATE or Delete 
   ON database_administration_2019.mail
   FOR EACH ROW

DECLARE
   v_username varchar2(50);

BEGIN

	--Find username of person performing UPDATE or delete on mail table--
    SELECT user INTO v_username FROM dual;
   
   --Insert record into audit table
   
   INSERT INTO database_administration_2019.AuditMail
   (Audit_Number ,Audit_User ,Audit_date ,New_ID_number ,Old_ID_number ,
  New_TypeID ,Old_TypeID ,New_SenderID ,Old_SenderID ,New_RecipientID ,Old_RecipientID ,
  New_DateReceived ,Old_DateReceived ,New_DateAssigned ,Old_DateAssigned ,New_DateDelivered ,
  Old_DateDelivered ,New_Weight ,Old_Weight ,New_StatusID ,Old_StatusID ,New_Cost ,Old_Cost 
  )
   VALUES
   (Audit_Number.nextval,v_username,
   sysdate,
   :new.ID_number,
   :old.ID_number,
   :new.TypeID ,
  :old.TypeID ,
  :new.SenderID  ,
  :old.SenderID  ,
  :new.RecipientID ,
  :old.RecipientID ,
  :new.DateReceived ,
  :old.DateReceived ,
  :new.DateAssigned ,
  :old.DateAssigned ,
  :new.DateDelivered ,
  :old.DateDelivered ,
  :new.Weight ,
  :old.Weight ,
  :new.StatusID  ,
  :old.StatusID ,
  :new.Cost ,
  :old.Cost 
   );

END;

/

--EXECUTE database_administration_2019.sp_UpdateMail(6,3,2,1,TO_DATE('1996/03/05', 'yyyy/mm/dd '),TO_DATE('1996/03/05', 'yyyy/mm/dd '),TO_DATE('1996/03/05', 'yyyy/mm/dd '),2,2);
