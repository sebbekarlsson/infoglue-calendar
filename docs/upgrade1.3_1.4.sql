CREATE TABLE language (
  id BIGINT unsigned NOT NULL auto_increment,
  name varchar(255) default NULL,
  isoCode varchar(10) default NULL,
  PRIMARY KEY  (id)
);

CREATE TABLE event_version (
  id BIGINT unsigned NOT NULL auto_increment,
  name varchar(255) default NULL,
  description varchar(255) default NULL,
  lecturer varchar(1024) default NULL,
  longDescription text NULL,
  contactEmail varchar(255) default NULL,
  shortDescription text NULL,
  organizerName varchar(255) default NULL,
  contactPhone varchar(255) default NULL,
  price float default NULL,
  customLocation varchar(255) default NULL,
  eventUrl varchar(255) default NULL,
  contactName varchar(255) default NULL,
  event_id int default NULL,
  attributes text NULL,
  PRIMARY KEY  (id)
);
