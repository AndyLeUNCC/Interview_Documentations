BEGIN TRANSACTION;
DROP TABLE IF EXISTS "user";
CREATE TABLE IF NOT EXISTS "user" (
	"id"	INTEGER NOT NULL,
	"first_name"	VARCHAR(100),
	"last_name"	VARCHAR(100),
	"email"	VARCHAR(100),
	"password"	VARCHAR(255) NOT NULL,
	"registered_on"	DATETIME NOT NULL,
	"dark_mode"	VARCHAR(10) NOT NULL,
	PRIMARY KEY("id")
);
DROP TABLE IF EXISTS "event";
CREATE TABLE IF NOT EXISTS "event" (
	"event_id"	INTEGER NOT NULL,
	"name"	VARCHAR(100),
	"eventDate"	VARCHAR(50),
	"startTime"	VARCHAR(20),
	"endTime"	VARCHAR(20),
	"desc"	VARCHAR(100),
	"rating"	INTEGER,
	"path_image"	VARCHAR(200),
	"creation"	VARCHAR(50),
	"user_id"	INTEGER NOT NULL,
	PRIMARY KEY("event_id"),
	FOREIGN KEY("user_id") REFERENCES "user"("id")
);
DROP TABLE IF EXISTS "comment";
CREATE TABLE IF NOT EXISTS "comment" (
	"id"	INTEGER NOT NULL,
	"date_posted"	DATETIME NOT NULL,
	"content"	VARCHAR NOT NULL,
	"event_id"	INTEGER NOT NULL,
	"user_id"	INTEGER NOT NULL,
	PRIMARY KEY("id"),
	FOREIGN KEY("user_id") REFERENCES "user"("id"),
	FOREIGN KEY("event_id") REFERENCES "event"("event_id")
);
INSERT INTO "user" VALUES (1,'Jon','Ledbetter','jledbe20@uncc.edu','$2b$12$tf.Dggr/yBqvqcAYsKA0RennBfaFZILbgbIysnfqgdQQgdxiBMp/6','2021-04-27 13:20:27.058937','dark_mode');
INSERT INTO "event" VALUES (1,'Celtic Seance','May 5th, 2021','10pm','11pm','We''ll be lighting candles and chanting.',2,'candle.jpg','04-27-2021',1);
INSERT INTO "event" VALUES (4,'dwef','efwf','','','Add a description for your event here...',0,'images/default_pizza.jpg','04-27-2021',1);
INSERT INTO "event" VALUES (5,'wefwe','wefwf','','','Add a description for your event here...',0,'thumbsupgold.png','04-27-2021',1);
INSERT INTO "event" VALUES (6,'Wiggle','Waggle','Bing','Bong','Bang',0,'default_pizza.jpg','04-27-2021',1);
INSERT INTO "event" VALUES (7,'wefwef','agg','garg','argar','arga',2,'default_pizza.jpg','04-27-2021',1);
INSERT INTO "event" VALUES (8,'Grand Ole Operation','2021-04-27','Unspecified','Unspecified','Who knows?!',1,'default_pizza.jpg','04-27-2021',1);
INSERT INTO "event" VALUES (9,'Something Different','2021-04-27','16:00','18:00','Wooooo!',0,'default_pizza.jpg','04-27-2021',1);
INSERT INTO "event" VALUES (10,'yet another event','2021-04-28','Unspecified','Unspecified','Add a description for your event here...',0,'default_pizza.jpg','04-27-2021',1);
INSERT INTO "event" VALUES (11,'efwf','2021-04-06','15:09','15:29','',0,'default_pizza.jpg','04-27-2021',1);
INSERT INTO "event" VALUES (12,'Fillin er out','2021-04-30','15:19','21:13','desc',0,'default_pizza.jpg','04-27-2021',1);
INSERT INTO "comment" VALUES (1,'2021-04-27 13:22:54.599493','This is a comment about seances.',1,1);
INSERT INTO "comment" VALUES (2,'2021-04-27 14:28:08.999891','adding a comment!',6,1);
INSERT INTO "comment" VALUES (3,'2021-04-27 14:44:45.906283','I comment on this!',8,1);
INSERT INTO "comment" VALUES (4,'2021-04-27 14:59:30.949401','HOW DIFFERENT IS IT',9,1);
INSERT INTO "comment" VALUES (5,'2021-04-27 15:06:18.892148','ewfwfw',11,1);
INSERT INTO "comment" VALUES (6,'2021-04-27 15:22:14.568590','qfwef',12,1);
COMMIT;
