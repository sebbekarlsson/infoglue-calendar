drop table if exists Resource
drop table if exists Participant
drop table if exists Calendar
drop table if exists Event
drop table if exists Category
drop table if exists Location
create table Resource (
   id BIGINT NOT NULL AUTO_INCREMENT,
   primary key (id)
)
create table Participant (
   id BIGINT NOT NULL AUTO_INCREMENT,
   name VARCHAR(255) unique,
   primary key (id)
)
create table Calendar (
   id BIGINT NOT NULL AUTO_INCREMENT,
   name VARCHAR(255) unique,
   description VARCHAR(255),
   primary key (id)
)
create table Event (
   id BIGINT NOT NULL AUTO_INCREMENT,
   name VARCHAR(255) unique,
   description VARCHAR(255),
   endDateTime DATETIME,
   startDateTime DATETIME,
   calendar_id BIGINT,
   primary key (id)
)
create table Category (
   id BIGINT NOT NULL AUTO_INCREMENT,
   name VARCHAR(255) unique,
   primary key (id)
)
create table Location (
   id BIGINT NOT NULL AUTO_INCREMENT,
   name VARCHAR(255) unique,
   primary key (id)
)
alter table Event add index FK403827A1818C5BC (calendar_id), add constraint FK403827A1818C5BC foreign key (calendar_id) references Calendar (id)
