CREATE DATABASE IF NOT EXISTS maplestory;
USE maplestory;

-- DROP TABLE IF EXISTS comment;
-- DROP TABLE IF EXISTS newsBoard;
-- DROP TABLE IF EXISTS updateBoard;
-- DROP TABLE IF EXISTS eventBoard;
-- DROP TABLE IF EXISTS freeBoard;
-- DROP TABLE IF EXISTS questionBoard;
-- DROP TABLE IF EXISTS youtubeBoard;
-- DROP TABLE IF EXISTS gamezoneBoard;
-- DROP TABLE IF EXISTS blogBoard;
-- DROP TABLE IF EXISTS liveChat;

ALTER TABLE accounts
ADD charid int(10);

ALTER TABLE accounts
ADD code varchar(10);

CREATE TABLE `guide` (
	`id`               int(11)              NOT NULL  auto_increment  ,
	`content`           text                    ,
	PRIMARY KEY ( `id` )
);

CREATE TABLE `comment` (
	`id`               int(11)              NOT NULL  auto_increment  ,
	`boardname`         varchar(20)         		   ,
  	`ref`             int(11)                        ,
	`name`              varchar(20)                    ,
	`content`           varchar(50)                    ,
	`regdate`          date                            ,
	PRIMARY KEY ( `id` )
);

CREATE TABLE `liveChat` (
	`id`               int(11)              NOT NULL  auto_increment  ,
	`name`              varchar(20)                    ,
	`content`           varchar(50)                    ,
	`regtime`           timestamp           DEFAULT now()             ,
	PRIMARY KEY ( `id` )
);

CREATE TABLE `newsBoard` (
	`id`               int(11)              NOT NULL  auto_increment  ,
	`boardname`         varchar(20)         DEFAULT 'newsboard',
	`name`              varchar(20)                    ,
	`subject`           varchar(50)                    ,
	`content`           text                           ,
	`pos`                smallint(7) unsigned           ,
	`ref`               smallint(7)                    ,
	`depth`             smallint(7) unsigned           ,
	`regdate`          date                           ,
	`pass`              varchar(15)                    ,
	`ip`                  varchar(15)                    ,
	`count`             smallint(7) unsigned           ,
	`filename`         varchar(30)                    ,
	`filesize`           int(11)                        ,
	`fix`				smallint(7) 		DEFAULT 0,
	PRIMARY KEY ( `id` )
);

CREATE TABLE `updateBoard` (
	`id`               int(11)              NOT NULL  auto_increment  ,
	`boardname`         varchar(20)         DEFAULT 'updateboard',
	`name`              varchar(20)                    ,
	`subject`           varchar(50)                    ,
	`content`           text                           ,
	`pos`                smallint(7) unsigned           ,
	`ref`               smallint(7)                    ,
	`depth`             smallint(7) unsigned           ,
	`regdate`          date                           ,
	`pass`              varchar(15)                    ,
	`ip`                  varchar(15)                    ,
	`count`             smallint(7) unsigned           ,
	`filename`         varchar(30)                    ,
	`filesize`           int(11)                        ,
	`fix`				smallint(7) 		DEFAULT 0,
	PRIMARY KEY ( `id` )
);

CREATE TABLE `eventBoard` (
	`id`               int(11)              NOT NULL  auto_increment  ,
	`boardname`         varchar(20)         DEFAULT 'eventboard',
	`name`              varchar(20)                    ,
	`subject`           varchar(50)                    ,
	`content`           text                           ,
	`pos`                smallint(7) unsigned           ,
	`ref`               smallint(7)                    ,
	`depth`             smallint(7) unsigned           ,
	`regdate`          date                           ,
	`pass`              varchar(15)                    ,
	`ip`                  varchar(15)                    ,
	`count`             smallint(7) unsigned           ,
	`filename`         varchar(30)                    ,
	`filesize`           int(11)                        ,
	`fix`				smallint(7) 		DEFAULT 0,
	PRIMARY KEY ( `id` )
);

CREATE TABLE `freeBoard` (
	`id`               int(11)              NOT NULL  auto_increment  ,
	`boardname`         varchar(20)         DEFAULT 'freeboard',
	`name`              varchar(20)                    ,
	`subject`           varchar(50)                    ,
	`content`           text                           ,
	`pos`                smallint(7) unsigned           ,
	`ref`               smallint(7)                    ,
	`depth`             smallint(7) unsigned           ,
	`regdate`          date                           ,
	`pass`              varchar(15)                    ,
	`ip`                  varchar(15)                    ,
	`count`             smallint(7) unsigned           ,
	`filename`         varchar(30)                    ,
	`filesize`           int(11)                        ,
	`fix`				smallint(7) 		DEFAULT 0,
	PRIMARY KEY ( `id` )
);

CREATE TABLE `questionBoard` (
	`id`               int(11)              NOT NULL  auto_increment  ,
	`boardname`         varchar(20)         DEFAULT 'questionboard',
	`name`              varchar(20)                    ,
	`subject`           varchar(50)                    ,
	`content`           text                           ,
	`pos`                smallint(7) unsigned           ,
	`ref`               smallint(7)                    ,
	`depth`             smallint(7) unsigned           ,
	`regdate`          date                           ,
	`pass`              varchar(15)                    ,
	`ip`                  varchar(15)                    ,
	`count`             smallint(7) unsigned           ,
	`filename`         varchar(30)                    ,
	`filesize`           int(11)                        ,
	`fix`				smallint(7) 		DEFAULT 0,
	PRIMARY KEY ( `id` )
);

CREATE TABLE `youtubeBoard` (
	`id`               int(11)              NOT NULL  auto_increment  ,
	`boardname`         varchar(20)         DEFAULT 'youtubeboard',
	`name`              varchar(20)                    ,
	`subject`           varchar(50)                    ,
	`content`           text                           ,
	`pos`                smallint(7) unsigned           ,
	`ref`               smallint(7)                    ,
	`depth`             smallint(7) unsigned           ,
	`regdate`          date                           ,
	`pass`              varchar(15)                    ,
	`ip`                  varchar(15)                    ,
	`count`             smallint(7) unsigned           ,
	`filename`         varchar(30)                    ,
	`filesize`           int(11)                        ,
	`fix`				smallint(7) 		DEFAULT 0,
	PRIMARY KEY ( `id` )
);

CREATE TABLE `gamezoneBoard` (
	`id`               int(11)              NOT NULL  auto_increment  ,
	`boardname`         varchar(20)         DEFAULT 'gamezoneboard',
	`name`              varchar(20)                    ,
	`subject`           varchar(50)                    ,
	`content`           text                           ,
	`pos`                smallint(7) unsigned           ,
	`ref`               smallint(7)                    ,
	`depth`             smallint(7) unsigned           ,
	`regdate`          date                           ,
	`pass`              varchar(15)                    ,
	`ip`                  varchar(15)                    ,
	`count`             smallint(7) unsigned           ,
	`filename`         varchar(30)                    ,
	`filesize`           int(11)                        ,
	`fix`				smallint(7) 		DEFAULT 0,
	PRIMARY KEY ( `id` )
);

CREATE TABLE `blogBoard` (
	`id`               int(11)              NOT NULL  auto_increment  ,
	`boardname`         varchar(20)         DEFAULT 'blogboard',
	`name`              varchar(20)                    ,
	`subject`           varchar(50)                    ,
	`content`           text                           ,
	`pos`                smallint(7) unsigned           ,
	`ref`               smallint(7)                    ,
	`depth`             smallint(7) unsigned           ,
	`regdate`          date                           ,
	`pass`              varchar(15)                    ,
	`ip`                  varchar(15)                    ,
	`count`             smallint(7) unsigned           ,
	`filename`         varchar(30)                    ,
	`filesize`           int(11)                        ,
	`fix`				smallint(7) 		DEFAULT 0,
	PRIMARY KEY ( `id` )
);
CREATE TABLE `inquireBoard` (
	`id`               int(11)              NOT NULL  auto_increment  ,
	`boardname`         varchar(20)         DEFAULT 'newsboard',
	`name`              varchar(20)                    ,
	`subject`           varchar(50)                    ,
	`content`           text                           ,
	`pos`                smallint(7) unsigned           ,
	`ref`               smallint(7)                    ,
	`depth`             smallint(7) unsigned           ,
	`regdate`          date                           ,
	`pass`              varchar(15)                    ,
	`ip`                  varchar(15)                    ,
	`count`             smallint(7) unsigned           ,
	`filename`         varchar(30)                    ,
	`filesize`           int(11)                        ,
	`fix`				smallint(7) 		DEFAULT 0,
	PRIMARY KEY ( `id` )
);

-- alter table newsboard add fix smallint(7) default 0;
-- insert newsBoard(name,content,subject,ref,pos,depth,regdate,pass,count,ip,filename,filesize)
-- values('aaa', 'bbb', 'ccc', 0, 0, 0, now(), '1111',0, '127.0.0.1', null, 0);