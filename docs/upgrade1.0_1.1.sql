-- Adds new alternative location column
alter table Event add alternativeLocation varchar(255) default NULL;

-- Price should not be float
ALTER TABLE event MODIFY COLUMN price VARCHAR(255);

-- Subscriptions 
CREATE TABLE subscriber (
  id int NOT NULL,
  calendar_id int NULL,
  email varchar(255) NOT NULL,
  PRIMARY KEY  (id)
);


CREATE TABLE subscriber (
  id bigint(20) unsigned NOT NULL auto_increment,
  calendar_id bigint(20) unsigned NOT NULL default '0',
  email varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8
