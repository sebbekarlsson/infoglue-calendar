CREATE TABLE calendar (
  id int NOT NULL ,
  name varchar(255) default NULL,
  description varchar(255) default NULL,
  owner varchar(255) default NULL,
  PRIMARY KEY  (id)
);

CREATE TABLE category (
  id int NOT NULL ,
  name varchar(255) default NULL,
  description varchar(255) default NULL,
  PRIMARY KEY  (id)
);

CREATE TABLE entry (
  id int NOT NULL ,
  firstName varchar(255) default NULL,
  lastName varchar(255) default NULL,
  email varchar(255) default NULL,
  organisation varchar(255) default NULL,
  address varchar(255) default NULL,
  zipcode varchar(255) default NULL,
  city varchar(255) default NULL,
  phone varchar(255) default NULL,
  fax varchar(255) default NULL,
  message varchar(1024) default NULL,
  event_id int default NULL,
  PRIMARY KEY  (id)
);

CREATE TABLE event (
  id int NOT NULL ,
  name varchar(255) default NULL,
  description varchar(255) default NULL,
  endDateTime date default NULL,
  startDateTime date default NULL,
  lecturer varchar(255) default NULL,
  isOrganizedByGU int default NULL,
  lastRegistrationDateTime date default NULL,
  longDescription varchar(255) default NULL,
  maxumumParticipants int default NULL,
  contactEmail varchar(255) default NULL,
  shortDescription varchar(255) default NULL,
  organizerName varchar(255) default NULL,
  contactPhone varchar(255) default NULL,
  price float default NULL,
  customLocation varchar(255) default NULL,
  isInternal int default NULL,
  eventUrl varchar(255) default NULL,
  contactName varchar(255) default NULL,
  isPublished int default NULL,
  calendar_id int default NULL,
  PRIMARY KEY  (id)
);

CREATE TABLE event_category (
  event_id int default 0 NOT NULL,
  category_id int default 0 NOT NULL ,
  PRIMARY KEY  (event_id,category_id)
);

CREATE TABLE event_location (
  event_id int default 0 NOT NULL,
  location_id int default 0 NOT NULL,
  PRIMARY KEY  (event_id,location_id)
);

CREATE TABLE location (
  id int NOT NULL ,
  name varchar(255) default NULL,
  description varchar(255) default NULL,
  PRIMARY KEY  (id)
);

CREATE TABLE participant (
  id int NOT NULL ,
  userName varchar(255) default NULL,
  event_id int default NULL,
  PRIMARY KEY  (id)
);

CREATE TABLE asset (
  id int NOT NULL ,
  fileName varchar(255) default NULL,
  assetKey varchar(255) default NULL,
  assetBlob blob NOT NULL,
  event_id int default NULL,
  PRIMARY KEY  (id)
);

create sequence hibernate_sequence;
