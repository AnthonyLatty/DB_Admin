/*
  Database Administration Project
  Tutor: Ray Williams
*/

-- Setup config for IDE (Mac Users only)
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

