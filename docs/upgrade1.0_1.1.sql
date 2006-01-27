-- Adds new alternative location column
alter table Event add alternativeLocation varchar(255) default NULL;

-- Price should not be float
ALTER TABLE event MODIFY COLUMN price VARCHAR(255);
