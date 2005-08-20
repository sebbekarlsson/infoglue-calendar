# EMS MySQL Manager 1.9.6.5
# ---------------------------------------
# Host     : localhost
# Port     : 3306
# Database : calendar


CREATE DATABASE calendar;

USE calendar;

#
# Structure for table calendar : 
#

CREATE TABLE `calendar` (
  `id` bigint(20) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`)
) TYPE=MyISAM;

#
# Structure for table category : 
#

CREATE TABLE `category` (
  `id` bigint(20) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`)
) TYPE=MyISAM;

#
# Structure for table entry : 
#

CREATE TABLE `entry` (
  `id` bigint(20) NOT NULL auto_increment,
  `firstName` varchar(255) default NULL,
  `lastName` varchar(255) default NULL,
  `email` varchar(255) default NULL,
  `event_id` bigint(20) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK40018521093C0E0` (`event_id`)
) TYPE=MyISAM;

#
# Structure for table event : 
#

CREATE TABLE `event` (
  `id` bigint(20) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` varchar(255) default NULL,
  `endDateTime` datetime default NULL,
  `startDateTime` datetime default NULL,
  `calendar_id` bigint(20) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `FK403827A1818C5BC` (`calendar_id`)
) TYPE=MyISAM;

#
# Structure for table event_category : 
#

CREATE TABLE `event_category` (
  `event_id` bigint(20) NOT NULL default '0',
  `category_id` bigint(20) NOT NULL default '0',
  PRIMARY KEY  (`event_id`,`category_id`),
  KEY `FK9210F9431093C0E0` (`event_id`),
  KEY `FK9210F9435BA8ABFC` (`category_id`)
) TYPE=MyISAM;

#
# Structure for table event_location : 
#

CREATE TABLE `event_location` (
  `event_id` bigint(20) NOT NULL default '0',
  `location_id` bigint(20) NOT NULL default '0',
  PRIMARY KEY  (`event_id`,`location_id`),
  KEY `FK5DDBFA20EBB9E5` (`location_id`),
  KEY `FK5DDBFA1093C0E0` (`event_id`)
) TYPE=MyISAM;

#
# Structure for table location : 
#

CREATE TABLE `location` (
  `id` bigint(20) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `description` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`)
) TYPE=MyISAM;

#
# Structure for table participant : 
#

CREATE TABLE `participant` (
  `id` bigint(20) NOT NULL auto_increment,
  `userName` varchar(255) default NULL,
  `event_id` bigint(20) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK912797131093C0E0` (`event_id`)
) TYPE=MyISAM;

#
# Structure for table resource : 
#

CREATE TABLE `asset` (
  `id` bigint(20) NOT NULL auto_increment,
  `fileName` varchar(255) default NULL,
  `assetKey` varchar(255) default NULL,
  `assetBlob` blob NOT NULL,
  `event_id` bigint(20) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FKEF86282E1093C0E0` (`event_id`)
) TYPE=MyISAM;

