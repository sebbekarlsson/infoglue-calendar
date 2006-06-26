DROP TABLE IF EXISTS interceptionPoint;

CREATE TABLE interceptionPoint (
  interceptionPointId int(11) NOT NULL auto_increment,
  category text NOT NULL,
  name varchar(255) NOT NULL,
  description text NOT NULL,
  usesExtraDataForAccessControl int(11) default '0' NULL,
  PRIMARY KEY  (interceptionPointId)
) TYPE=InnoDB;

DROP TABLE IF EXISTS accessRight;

CREATE TABLE accessRight (
  accessRightId int(11) NOT NULL auto_increment,
  parameters text NULL,
  interceptionPointId int(11) NOT NULL,
  PRIMARY KEY  (accessRightId)
) TYPE=InnoDB;

DROP TABLE IF EXISTS accessRightRole;

CREATE TABLE accessRightRole (
  accessRightRoleId int(11) NOT NULL auto_increment,
  accessRightId int(11) NOT NULL default '0',
  roleName varchar(150) NOT NULL default '',
  PRIMARY KEY  (accessRightRoleId)
) TYPE=InnoDB;

DROP TABLE IF EXISTS accessRightGroup;

CREATE TABLE accessRightGroup (
  accessRightGroupId int(11) NOT NULL auto_increment,
  accessRightId int(11) NOT NULL default '0',
  groupName varchar(150) NOT NULL default '',
  PRIMARY KEY  (accessRightGroupId)
) TYPE=InnoDB;

DROP TABLE IF EXISTS accessRightUser;

CREATE TABLE accessRightUser (
  accessRightUserId int(11) NOT NULL auto_increment,
  accessRightId int(11) NOT NULL default '0',
  userName varchar(150) NOT NULL default '',
  PRIMARY KEY  (accessRightUserId)
) TYPE=InnoDB;


-- NYTT

ALTER TABLE eventtype ADD COLUMN schemaValue TEXT;
ALTER TABLE eventtype ADD COLUMN type INTEGER UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE event ADD COLUMN entryFormId INTEGER UNSIGNED;

ALTER TABLE eventtype ADD COLUMN type INTEGER UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE eventtype ADD COLUMN schemaValue TEXT DEFAULT '';
 
update event set entryFormId = (select id from eventtype et where et.type = 1);

ALTER TABLE entry ADD COLUMN attributes TEXT DEFAULT '';
