/*
Navicat PGSQL Data Transfer

Source Server         : PostgreSQL 9.5
Source Server Version : 90505
Source Host           : localhost:5432
Source Database       : tournament
Source Schema         : public

Target Server Type    : PGSQL
Target Server Version : 90505
File Encoding         : 65001

Date: 2016-12-26 15:55:35
*/


-- ----------------------------
-- Sequence structure for matches_idmatch_seq
-- ----------------------------
DROP SEQUENCE "public"."matches_idmatch_seq";
CREATE SEQUENCE "public"."matches_idmatch_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 16
 CACHE 1;
SELECT setval('"public"."matches_idmatch_seq"', 16, true);

-- ----------------------------
-- Sequence structure for players_idplayer_seq
-- ----------------------------
DROP SEQUENCE "public"."players_idplayer_seq";
CREATE SEQUENCE "public"."players_idplayer_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 16
 CACHE 1;
SELECT setval('"public"."players_idplayer_seq"', 16, true);

-- ----------------------------
-- Sequence structure for rounds_id_seq
-- ----------------------------
DROP SEQUENCE "public"."rounds_id_seq";
CREATE SEQUENCE "public"."rounds_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 5
 CACHE 1;
SELECT setval('"public"."rounds_id_seq"', 5, true);

-- ----------------------------
-- Sequence structure for tournaments_id_seq
-- ----------------------------
DROP SEQUENCE "public"."tournaments_id_seq";
CREATE SEQUENCE "public"."tournaments_id_seq"
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 1
 CACHE 1;
SELECT setval('"public"."tournaments_id_seq"', 1, true);

-- ----------------------------
-- Table structure for matches
-- ----------------------------
DROP TABLE IF EXISTS "public"."matches";
CREATE TABLE "public"."matches" (
"idmatch" int4 DEFAULT nextval('matches_idmatch_seq'::regclass) NOT NULL,
"idround" int4,
"idplayer1" int4,
"idplayer2" int4,
"date" timestamp(6),
"winner" int4,
"looser" int4
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of matches
-- ----------------------------

-- ----------------------------
-- Table structure for matches_results
-- ----------------------------
DROP TABLE IF EXISTS "public"."matches_results";
CREATE TABLE "public"."matches_results" (
"idmatch" int4,
"winner" int4,
"looser" int4
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of matches_results
-- ----------------------------

-- ----------------------------
-- Table structure for players
-- ----------------------------
DROP TABLE IF EXISTS "public"."players";
CREATE TABLE "public"."players" (
"idplayer" int4 DEFAULT nextval('players_idplayer_seq'::regclass) NOT NULL,
"name" text COLLATE "default",
"nationality" text COLLATE "default"
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of players
-- ----------------------------
INSERT INTO "public"."players" VALUES ('1', 'Magnus', 'nor');
INSERT INTO "public"."players" VALUES ('2', 'Fabiano', 'usa');
INSERT INTO "public"."players" VALUES ('3', 'Vladimir', 'rus');
INSERT INTO "public"."players" VALUES ('4', 'Maxime', 'fra');
INSERT INTO "public"."players" VALUES ('5', 'Wesley', 'usa');
INSERT INTO "public"."players" VALUES ('6', 'Sergey', 'rus');
INSERT INTO "public"."players" VALUES ('7', 'Levon', 'arm');
INSERT INTO "public"."players" VALUES ('8', 'Viswanathan', 'ind');
INSERT INTO "public"."players" VALUES ('9', 'Hikaru', 'usa');
INSERT INTO "public"."players" VALUES ('10', 'Anish', 'ned');
INSERT INTO "public"."players" VALUES ('11', 'Pendyala', 'ind');
INSERT INTO "public"."players" VALUES ('12', 'Shakhriyar', 'aze');
INSERT INTO "public"."players" VALUES ('13', 'Ian', 'rus');
INSERT INTO "public"."players" VALUES ('14', 'Pavel', 'ukr');
INSERT INTO "public"."players" VALUES ('15', 'Veselin', 'bul');
INSERT INTO "public"."players" VALUES ('16', 'Liren', 'chn');
INSERT INTO "public"."players" VALUES ('17', 'Jean', 'dom');

-- ----------------------------
-- Table structure for rounds
-- ----------------------------
DROP TABLE IF EXISTS "public"."rounds";
CREATE TABLE "public"."rounds" (
"idround" int4 DEFAULT nextval('rounds_id_seq'::regclass) NOT NULL,
"idtournament" int4,
"date" timestamp(6),
"round_number" int4
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of rounds
-- ----------------------------

-- ----------------------------
-- Table structure for tournaments
-- ----------------------------
DROP TABLE IF EXISTS "public"."tournaments";
CREATE TABLE "public"."tournaments" (
"idtournament" int4 DEFAULT nextval('tournaments_id_seq'::regclass) NOT NULL,
"name" text COLLATE "default",
"date_start" timestamp(6),
"date_finish" timestamp(6),
"place" text COLLATE "default"
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of tournaments
-- ----------------------------
INSERT INTO "public"."tournaments" VALUES ('1', 'London Chess Classic 2016', '2016-12-09 00:00:00', '2016-12-28 00:00:00', 'London');

-- ----------------------------
-- Table structure for tournaments_vs_players
-- ----------------------------
DROP TABLE IF EXISTS "public"."tournaments_vs_players";
CREATE TABLE "public"."tournaments_vs_players" (
"idtournament" int4,
"idplayer" int4,
"date" timestamp(6)
)
WITH (OIDS=FALSE)

;

-- ----------------------------
-- Records of tournaments_vs_players
-- ----------------------------
INSERT INTO "public"."tournaments_vs_players" VALUES ('1', '1', '2016-12-24 00:00:00');
INSERT INTO "public"."tournaments_vs_players" VALUES ('1', '1', null);
INSERT INTO "public"."tournaments_vs_players" VALUES ('1', '2', '2016-12-24 00:00:00');
INSERT INTO "public"."tournaments_vs_players" VALUES ('1', '3', '2016-12-24 00:00:00');
INSERT INTO "public"."tournaments_vs_players" VALUES ('1', '4', '2016-12-24 00:00:00');
INSERT INTO "public"."tournaments_vs_players" VALUES ('1', '5', '2016-12-24 00:00:00');
INSERT INTO "public"."tournaments_vs_players" VALUES ('1', '6', '2016-12-24 00:00:00');
INSERT INTO "public"."tournaments_vs_players" VALUES ('1', '7', '2016-12-24 00:00:00');
INSERT INTO "public"."tournaments_vs_players" VALUES ('1', '8', '2016-12-24 00:00:00');
INSERT INTO "public"."tournaments_vs_players" VALUES ('1', '9', '2016-12-24 00:00:00');
INSERT INTO "public"."tournaments_vs_players" VALUES ('1', '10', '2016-12-24 00:00:00');
INSERT INTO "public"."tournaments_vs_players" VALUES ('1', '11', '2016-12-24 00:00:00');
INSERT INTO "public"."tournaments_vs_players" VALUES ('1', '12', '2016-12-24 00:00:00');
INSERT INTO "public"."tournaments_vs_players" VALUES ('1', '13', '2016-12-24 00:00:00');
INSERT INTO "public"."tournaments_vs_players" VALUES ('1', '14', '2016-12-24 00:00:00');
INSERT INTO "public"."tournaments_vs_players" VALUES ('1', '15', '2016-12-24 00:00:00');
INSERT INTO "public"."tournaments_vs_players" VALUES ('1', '16', '2016-12-24 00:00:00');
INSERT INTO "public"."tournaments_vs_players" VALUES ('1', '17', null);

-- ----------------------------
-- Alter Sequences Owned By 
-- ----------------------------
ALTER SEQUENCE "public"."matches_idmatch_seq" OWNED BY "matches"."idmatch";
ALTER SEQUENCE "public"."players_idplayer_seq" OWNED BY "players"."idplayer";
ALTER SEQUENCE "public"."rounds_id_seq" OWNED BY "rounds"."idround";
ALTER SEQUENCE "public"."tournaments_id_seq" OWNED BY "tournaments"."idtournament";

-- ----------------------------
-- Primary Key structure for table matches
-- ----------------------------
ALTER TABLE "public"."matches" ADD PRIMARY KEY ("idmatch");

-- ----------------------------
-- Primary Key structure for table players
-- ----------------------------
ALTER TABLE "public"."players" ADD PRIMARY KEY ("idplayer");

-- ----------------------------
-- Primary Key structure for table rounds
-- ----------------------------
ALTER TABLE "public"."rounds" ADD PRIMARY KEY ("idround");

-- ----------------------------
-- Primary Key structure for table tournaments
-- ----------------------------
ALTER TABLE "public"."tournaments" ADD PRIMARY KEY ("idtournament");

-- ----------------------------
-- Foreign Key structure for table "public"."matches"
-- ----------------------------
ALTER TABLE "public"."matches" ADD FOREIGN KEY ("looser") REFERENCES "public"."players" ("idplayer") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."matches" ADD FOREIGN KEY ("idplayer2") REFERENCES "public"."players" ("idplayer") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."matches" ADD FOREIGN KEY ("idplayer1") REFERENCES "public"."players" ("idplayer") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."matches" ADD FOREIGN KEY ("winner") REFERENCES "public"."players" ("idplayer") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."matches" ADD FOREIGN KEY ("idround") REFERENCES "public"."rounds" ("idround") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Key structure for table "public"."matches_results"
-- ----------------------------
ALTER TABLE "public"."matches_results" ADD FOREIGN KEY ("idmatch") REFERENCES "public"."matches" ("idmatch") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."matches_results" ADD FOREIGN KEY ("winner") REFERENCES "public"."players" ("idplayer") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."matches_results" ADD FOREIGN KEY ("looser") REFERENCES "public"."players" ("idplayer") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Key structure for table "public"."rounds"
-- ----------------------------
ALTER TABLE "public"."rounds" ADD FOREIGN KEY ("idtournament") REFERENCES "public"."tournaments" ("idtournament") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Key structure for table "public"."tournaments_vs_players"
-- ----------------------------
ALTER TABLE "public"."tournaments_vs_players" ADD FOREIGN KEY ("idplayer") REFERENCES "public"."players" ("idplayer") ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE "public"."tournaments_vs_players" ADD FOREIGN KEY ("idtournament") REFERENCES "public"."tournaments" ("idtournament") ON DELETE NO ACTION ON UPDATE NO ACTION;
