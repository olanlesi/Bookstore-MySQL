-- MySQL Workbench Forward Engineering
-- Schema OLAP_BOOKSHOP
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema OLAP_BOOKSHOP
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS OLAP_BOOKSHOP DEFAULT CHARACTER SET
utf8 ;
USE OLAP_BOOKSHOP ;
-- -----------------------------------------------------
-- Table OLAP_BOOKSHOP.REGION
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS OLAP_BOOKSHOP.REGION (
 REGION_ID INT NOT NULL,
 REGION_NAME VARCHAR(20) NOT NULL,
 PRIMARY KEY (REGION_ID))
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table OLAP_BOOKSHOP.SUBREGION
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS OLAP_BOOKSHOP.SUBREGION (
 SUBREGION_ID INT NOT NULL,
 SUBREGION_NAME VARCHAR(30) NOT NULL,
 REGION_ID INT NOT NULL,
 PRIMARY KEY (SUBREGION_ID, REGION_ID),
 INDEX fk_SUBREGION_REGION_idx (REGION_ID ASC) VISIBLE,
 CONSTRAINT fk_SUBREGION_REGION
 FOREIGN KEY (REGION_ID)
 REFERENCES OLAP_BOOKSHOP.REGION (REGION_ID)
 ON DELETE NO ACTION
 ON UPDATE NO ACTION)
ENGINE = InnoDB;
- -----------------------------------------------------
-- Table OLAP_BOOKSHOP.WAREHOUSE
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS OLAP_BOOKSHOP.WAREHOUSE (
 CODE INT NOT NULL,
 SUBREGION_ID INT NOT NULL,
 PRIMARY KEY (CODE, SUBREGION_ID),
 INDEX fk_WAREHOUSE_SUBREGION1_idx (SUBREGION_ID ASC) VISIBLE,
 CONSTRAINT fk_WAREHOUSE_SUBREGION1
 FOREIGN KEY (SUBREGION_ID)
 REFERENCES OLAP_BOOKSHOP.SUBREGION (SUBREGION_ID)
 ON DELETE NO ACTION
 ON UPDATE NO ACTION)
ENGINE = InnoDB;
- -----------------------------------------------------
-- Table OLAP_BOOKSHOP.BOOKS
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS OLAP_BOOKSHOP.BOOKS (
 ISBN BIGINT NOT NULL,
 TITLE VARCHAR(45) NULL,
 PRICE VARCHAR(45) NULL,
 PRIMARY KEY (ISBN))
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table OLAP_BOOKSHOP.YEAR
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS OLAP_BOOKSHOP.YEAR (
 YEAR_ID INT NOT NULL,
 YEAR YEAR(4) NULL,
 PRIMARY KEY (YEAR_ID))
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table OLAP_BOOKSHOP.MONTH
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS OLAP_BOOKSHOP.MONTH (
 MONTH_ID INT NOT NULL,
 MONTH VARCHAR(15) NULL,
 YEAR_ID INT NOT NULL,
 PRIMARY KEY (MONTH_ID, YEAR_ID),
 INDEX fk_MONTH_YEAR1_idx (YEAR_ID ASC) VISIBLE,
CONSTRAINT fk_MONTH_YEAR1
 FOREIGN KEY (YEAR_ID)
 REFERENCES OLAP_BOOKSHOP.YEAR (YEAR_ID)
 ON DELETE NO ACTION
 ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table OLAP_BOOKSHOP.DAY
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS OLAP_BOOKSHOP.DAY (
 NUM_DAY INT NOT NULL,
 DAY_ID VARCHAR(45) NOT NULL,
 MONTH_ID INT NOT NULL,
 DAY VARCHAR(10),
 PRIMARY KEY (DAY_ID, MONTH_ID),
 INDEX fk_DAY_MONTH1_idx (MONTH_ID ASC) VISIBLE,
 CONSTRAINT fk_DAY_MONTH1
 FOREIGN KEY (MONTH_ID)
 REFERENCES OLAP_BOOKSHOP.MONTH (MONTH_ID)
 ON DELETE NO ACTION
 ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `OLAP_BOOKSHOP`.`FACTS_TICKET`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS OLAP_BOOKSHOP.FACTS_TICKET (
 SELL_BY_PRODUCT DOUBLE NOT NULL,
 TICKET_NUMBER INT NOT NULL,
 BOOKS_ISBN BIGINT NOT NULL,
 WAREHOUSE_CODE INT NOT NULL,
 DAY_ID VARCHAR(45) NOT NULL,
 PRIMARY KEY (SELL_BY_PRODUCT, BOOKS_ISBN, WAREHOUSE_CODE,
DAY_ID),
 INDEX fk_FACTS_TICKET_BOOKS1_idx (BOOKS_ISBN ASC) VISIBLE,
 INDEX fk_FACTS_TICKET_WAREHOUSE1_idx (WAREHOUSE_CODE ASC)
VISIBLE,
 INDEX fk_FACTS_TICKET_DAY1_idx (DAY_ID ASC) VISIBLE,
 CONSTRAINT fk_FACTS_TICKET_BOOKS1
 FOREIGN KEY (BOOKS_ISBN)
 REFERENCES OLAP_BOOKSHOP.BOOKS (ISBN)
 ON DELETE NO ACTION
 ON UPDATE NO ACTION,
 CONSTRAINT fk_FACTS_TICKET_WAREHOUSE1
 FOREIGN KEY (WAREHOUSE_CODE)
 REFERENCES OLAP_BOOKSHOP.WAREHOUSE (CODE)
 ON DELETE NO ACTION
 ON UPDATE NO ACTION,
 CONSTRAINT fk_FACTS_TICKET_DAY1
FOREIGN KEY (DAY_ID)
 REFERENCES OLAP_BOOKSHOP.DAY (DAY_ID)
 ON DELETE NO ACTION
 ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- inserts region

INSERT INTO olap_bookshop.region(region_id, region_name) VALUES (1,'america');
INSERT INTO olap_bookshop.region(region_id, region_name) VALUES (2,'europa');
INSERT INTO olap_bookshop.region(region_id, region_name) VALUES (3,'asia');
INSERT INTO olap_bookshop.region(region_id, region_name) VALUES (4,'africa');
INSERT INTO olap_bookshop.region(region_id, region_name) VALUES (5,'oceania');

-- inserts subregion

INSERT INTO olap_bookshop.subregion(subregion_id, region_id, subregion_name) VALUES (1,1,'north america');
INSERT INTO olap_bookshop.subregion(subregion_id, region_id, subregion_name) VALUES (2,1,'central america');
INSERT INTO olap_bookshop.subregion(subregion_id, region_id, subregion_name) VALUES (3,1,'caribe');
INSERT INTO olap_bookshop.subregion(subregion_id, region_id, subregion_name) VALUES (4,1,'south america');

INSERT INTO olap_bookshop.subregion(subregion_id, region_id, subregion_name) VALUES (5,2,'north of europe');
INSERT INTO olap_bookshop.subregion(subregion_id, region_id, subregion_name) VALUES (6,2,'south of europe');
INSERT INTO olap_bookshop.subregion(subregion_id, region_id, subregion_name) VALUES (7,2,'western europe');
INSERT INTO olap_bookshop.subregion(subregion_id, region_id, subregion_name) VALUES (8,2,'eastern europe');

INSERT INTO olap_bookshop.subregion(subregion_id, region_id, subregion_name) VALUES (9,3,'northern of asia');
INSERT INTO olap_bookshop.subregion(subregion_id, region_id, subregion_name) VALUES (10,3,'southern asia');
INSERT INTO olap_bookshop.subregion(subregion_id, region_id, subregion_name) VALUES (11,3,'eastern asia');
INSERT INTO olap_bookshop.subregion(subregion_id, region_id, subregion_name) VALUES (12,3,'central asia');
INSERT INTO olap_bookshop.subregion(subregion_id, region_id, subregion_name) VALUES (13,3,'southeast asia');

INSERT INTO olap_bookshop.subregion(subregion_id, region_id, subregion_name) VALUES (14,4,'north africa');
INSERT INTO olap_bookshop.subregion(subregion_id, region_id, subregion_name) VALUES (15,4,'southern africa');
INSERT INTO olap_bookshop.subregion(subregion_id, region_id, subregion_name) VALUES (16,4,'west africa');
INSERT INTO olap_bookshop.subregion(subregion_id, region_id, subregion_name) VALUES (17,4,'east africa');
INSERT INTO olap_bookshop.subregion(subregion_id, region_id, subregion_name) VALUES (18,4,'central africa');

INSERT INTO olap_bookshop.subregion(subregion_id, region_id,subregion_name) VALUES (19,5,'australia');
INSERT INTO olap_bookshop.subregion(subregion_id, region_id,subregion_name) VALUES (20,5,'melanesia');
INSERT INTO olap_bookshop.subregion(subregion_id, region_id,subregion_name) VALUES (21,5,'micronesia');
INSERT INTO olap_bookshop.subregion(subregion_id, region_id,subregion_name) VALUES (22,5,'polynesia');

-- inserts year

INSERT INTO olap_bookshop.year (year_id, year) VALUES (1,'2017');

commit;

-- insert month

INSERT INTO olap_bookshop.month (month_id, year_id, month) VALUES (1,1,'january');
INSERT INTO olap_bookshop.month (month_id, year_id, month) VALUES (2,1,'february');
INSERT INTO olap_bookshop.month (month_id, year_id, month) VALUES (3,1,'march');
INSERT INTO olap_bookshop.month (month_id, year_id, month) VALUES (4,1,'april');
INSERT INTO olap_bookshop.month (month_id, year_id, month) VALUES (5,1,'may');
INSERT INTO olap_bookshop.month (month_id, year_id, month) VALUES (6,1,'june');
INSERT INTO olap_bookshop.month (month_id, year_id, month) VALUES (7,1,'july');
INSERT INTO olap_bookshop.month (month_id, year_id, month) VALUES (8,1,'august');
INSERT INTO olap_bookshop.month (month_id, year_id, month) VALUES (9,1,'september');
INSERT INTO olap_bookshop.month (month_id, year_id, month) VALUES (10,1,'october');
INSERT INTO olap_bookshop.month (month_id, year_id, month) VALUES (11,1,'november');
INSERT INTO olap_bookshop.month (month_id, year_id, month) VALUES (12,1,'december');

commit;

-- insert day 

INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (1,1,'sunday',1);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (2,1,'monday',2);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (3,1,'tuesday',3);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (4,1,'wednesday',4);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (5,1,'thursday',5);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (6,1,'friday',6);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (7,1,'saturday',7);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (8,1,'sunday',8);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (9,1,'monday',9);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (10,1,'tuesday',10);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (11,1,'wednesday',11);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (12,1,'thursday',12);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (13,1,'friday',13);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (14,1,'saturday',14);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (15,1,'sunday',15);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (16,1,'monday',16);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (17,1,'tuesday',17);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (18,1,'wednesday',18);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (19,1,'thursday',19);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (20,1,'friday',20);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (21,1,'saturday',21);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (22,1,'sunday',22);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (23,1,'monday',23);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (24,1,'tuesday',24);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (25,1,'wednesday',25);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (26,1,'thursday',26);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (27,1,'friday',27);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (28,1,'saturday',28);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (29,1,'sunday',29);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (30,1,'monday',30);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (31,1,'tuesday',31);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (32,2,'wednesday',1);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (33,2,'thursday',2);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (34,2,'friday',3);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (35,2,'saturday',4);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (36,2,'sunday',5);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (37,2,'monday',6);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (38,2,'tuesday',7);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (39,2,'wednesday',8);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (40,2,'thursday',9);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (41,2,'friday',10);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (42,2,'saturday',11);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (43,2,'sunday',12);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (44,2,'monday',13);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (45,2,'tuesday',14);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (46,2,'wednesday',15);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (47,2,'thursday',16);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (48,2,'friday',17);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (49,2,'saturday',18);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (50,2,'sunday',19);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (51,2,'monday',20);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (52,2,'tuesday',21);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (53,2,'wednesday',22);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (54,2,'thursday',23);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (55,2,'friday',24);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (56,2,'saturday',25);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (57,2,'sunday',26);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (58,2,'monday',27);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (59,2,'tuesday',28);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (60,3,'wednesday',1);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (61,3,'thursday',2);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (62,3,'friday',3);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (63,3,'saturday',4);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (64,3,'sunday',5);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (65,3,'monday',6);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (66,3,'tuesday',7);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (67,3,'wednesday',8);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (68,3,'thursday',9);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (69,3,'friday',10);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (70,3,'saturday',11);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (71,3,'sunday',12);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (72,3,'monday',13);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (73,3,'tuesday',14);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (74,3,'wednesday',15);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (75,3,'thursday',16);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (76,3,'friday',17);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (77,3,'saturday',18);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (78,3,'sunday',19);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (79,3,'monday',20);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (80,3,'tuesday',21);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (81,3,'wednesday',22);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (82,3,'thursday',23);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (83,3,'friday',24);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (84,3,'saturday',25);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (85,3,'sunday',26);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (86,3,'monday',27);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (87,3,'tuesday',28);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (88,3,'wednesday',29);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (89,3,'thursday',30);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (90,3,'friday',31);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (91,4,'saturday',1);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (92,4,'sunday',2);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (93,4,'monday',3);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (94,4,'tuesday',4);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (95,4,'wednesday',5);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (96,4,'thursday',6);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (97,4,'friday',7);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (98,4,'saturday',8);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (99,4,'sunday',9);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (100,4,'monday',10);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (101,4,'tuesday',11);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (102,4,'wednesday',12);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (103,4,'thursday',13);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (104,4,'friday',14);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (105,4,'saturday',15);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (106,4,'sunday',16);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (107,4,'monday',17);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (108,4,'tuesday',18);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (109,4,'wednesday',19);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (110,4,'thursday',20);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (111,4,'friday',21);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (112,4,'saturday',22);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (113,4,'sunday',23);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (114,4,'monday',24);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (115,4,'tuesday',25);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (116,4,'wednesday',26);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (117,4,'thursday',27);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (118,4,'friday',28);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (119,4,'saturday',29);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (120,4,'sunday',30);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (121,5,'monday',1);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (122,5,'tuesday',2);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (123,5,'wednesday',3);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (124,5,'thursday',4);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (125,5,'friday',5);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (126,5,'saturday',6);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (127,5,'sunday',7);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (128,5,'monday',8);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (129,5,'tuesday',9);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (130,5,'wednesday',10);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (131,5,'thursday',11);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (132,5,'friday',12);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (133,5,'saturday',13);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (134,5,'sunday',14);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (135,5,'monday',15);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (136,5,'tuesday',16);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (137,5,'wednesday',17);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (138,5,'thursday',18);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (139,5,'friday',19);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (140,5,'saturday',20);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (141,5,'sunday',21);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (142,5,'monday',22);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (143,5,'tuesday',23);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (144,5,'wednesday',24);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (145,5,'thursday',25);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (146,5,'friday',26);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (147,5,'saturday',27);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (148,5,'sunday',28);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (149,5,'monday',29);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (150,5,'tuesday',30);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (151,5,'wednesday',31);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (152,6,'thursday',1);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (153,6,'friday',2);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (154,6,'saturday',3);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (155,6,'sunday',4);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (156,6,'monday',5);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (157,6,'tuesday',6);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (158,6,'wednesday',7);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (159,6,'thursday',8);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (160,6,'friday',9);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (161,6,'saturday',10);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (162,6,'sunday',11);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (163,6,'monday',12);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (164,6,'tuesday',13);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (165,6,'wednesday',14);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (166,6,'thursday',15);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (167,6,'friday',16);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (168,6,'saturday',17);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (169,6,'sunday',18);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (170,6,'monday',19);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (171,6,'tuesday',20);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (172,6,'wednesday',21);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (173,6,'thursday',22);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (174,6,'friday',23);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (175,6,'saturday',24);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (176,6,'sunday',25);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (177,6,'monday',26);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (178,6,'tuesday',27);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (179,6,'wednesday',28);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (180,6,'thursday',29);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (181,6,'friday',30);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (182,7,'saturday',1);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (183,7,'sunday',2);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (184,7,'monday',3);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (185,7,'tuesday',4);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (186,7,'wednesday',5);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (187,7,'thursday',6);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (188,7,'friday',7);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (189,7,'saturday',8);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (190,7,'sunday',9);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (191,7,'monday',10);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (192,7,'tuesday',11);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (193,7,'wednesday',12);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (194,7,'thursday',13);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (195,7,'friday',14);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (196,7,'saturday',15);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (197,7,'sunday',16);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (198,7,'monday',17);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (199,7,'tuesday',18);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (200,7,'wednesday',19);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (201,7,'thursday',20);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (202,7,'friday',21);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (203,7,'saturday',22);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (204,7,'sunday',23);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (205,7,'monday',24);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (206,7,'tuesday',25);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (207,7,'wednesday',26);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (208,7,'thursday',27);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (209,7,'friday',28);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (210,7,'saturday',29);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (211,7,'sunday',30);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (212,7,'monday',31);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (213,8,'tuesday',1);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (214,8,'wednesday',2);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (215,8,'thursday',3);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (216,8,'friday',4);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (217,8,'saturday',5);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (218,8,'sunday',6);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (219,8,'monday',7);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (220,8,'tuesday',8);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (221,8,'wednesday',9);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (222,8,'thursday',10);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (223,8,'friday',11);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (224,8,'saturday',12);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (225,8,'sunday',13);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (226,8,'monday',14);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (227,8,'tuesday',15);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (228,8,'wednesday',16);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (229,8,'thursday',17);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (230,8,'friday',18);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (231,8,'saturday',19);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (232,8,'sunday',20);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (233,8,'monday',21);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (234,8,'tuesday',22);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (235,8,'wednesday',23);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (236,8,'thursday',24);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (237,8,'friday',25);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (238,8,'saturday',26);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (239,8,'sunday',27);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (240,8,'monday',28);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (241,8,'tuesday',29);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (242,8,'wednesday',30);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (243,8,'thursday',31);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (244,9,'friday',1);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (245,9,'saturday',2);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (246,9,'sunday',3);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (247,9,'monday',4);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (248,9,'tuesday',5);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (249,9,'wednesday',6);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (250,9,'thursday',7);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (251,9,'friday',8);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (252,9,'saturday',9);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (253,9,'sunday',10);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (254,9,'monday',11);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (255,9,'tuesday',12);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (256,9,'wednesday',13);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (257,9,'thursday',14);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (258,9,'friday',15);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (259,9,'saturday',16);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (260,9,'sunday',17);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (261,9,'monday',18);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (262,9,'tuesday',19);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (263,9,'wednesday',20);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (264,9,'thursday',21);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (265,9,'friday',22);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (266,9,'saturday',23);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (267,9,'sunday',24);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (268,9,'monday',25);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (269,9,'tuesday',26);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (270,9,'wednesday',27);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (271,9,'thursday',28);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (272,9,'friday',29);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (273,9,'saturday',30);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (274,10,'sunday',1);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (275,10,'monday',2);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (276,10,'tuesday',3);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (277,10,'wednesday',4);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (278,10,'thursday',5);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (279,10,'friday',6);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (280,10,'saturday',7);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (281,10,'sunday',8);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (282,10,'monday',9);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (283,10,'tuesday',10);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (284,10,'wednesday',11);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (285,10,'thursday',12);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (286,10,'friday',13);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (287,10,'saturday',14);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (288,10,'sunday',15);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (289,10,'monday',16);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (290,10,'tuesday',17);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (291,10,'wednesday',18);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (292,10,'thursday',19);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (293,10,'friday',20);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (294,10,'saturday',21);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (295,10,'sunday',22);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (296,10,'monday',23);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (297,10,'tuesday',24);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (298,10,'wednesday',25);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (299,10,'thursday',26);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (300,10,'friday',27);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (301,10,'saturday',28);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (302,10,'sunday',29);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (303,10,'monday',30);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (304,10,'tuesday',31);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (305,11,'wednesday',1);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (306,11,'thursday',2);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (307,11,'friday',3);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (308,11,'saturday',4);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (309,11,'sunday',5);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (310,11,'monday',6);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (311,11,'tuesday',7);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (312,11,'wednesday',8);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (313,11,'thursday',9);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (314,11,'friday',10);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (315,11,'saturday',11);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (316,11,'sunday',12);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (317,11,'monday',13);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (318,11,'tuesday',14);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (319,11,'wednesday',15);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (320,11,'thursday',16);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (321,11,'friday',17);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (322,11,'saturday',18);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (323,11,'sunday',19);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (324,11,'monday',20);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (325,11,'tuesday',21);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (326,11,'wednesday',22);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (327,11,'thursday',23);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (328,11,'friday',24);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (329,11,'saturday',25);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (330,11,'sunday',26);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (331,11,'monday',27);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (332,11,'tuesday',28);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (333,11,'wednesday',29);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (334,11,'thursday',30);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (335,12,'friday',1);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (336,12,'saturday',2);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (337,12,'sunday',3);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (338,12,'monday',4);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (339,12,'tuesday',5);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (340,12,'wednesday',6);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (341,12,'thursday',7);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (342,12,'friday',8);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (343,12,'saturday',9);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (344,12,'sunday',10);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (345,12,'monday',11);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (346,12,'tuesday',12);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (347,12,'wednesday',13);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (348,12,'thursday',14);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (349,12,'friday',15);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (350,12,'saturday',16);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (351,12,'sunday',17);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (352,12,'monday',18);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (353,12,'tuesday',19);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (354,12,'wednesday',20);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (355,12,'thursday',21);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (356,12,'friday',22);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (357,12,'saturday',23);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (358,12,'sunday',24);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (359,12,'monday',25);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (360,12,'tuesday',26);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (361,12,'wednesday',27);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (362,12,'thursday',28);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (363,12,'friday',29);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (364,12,'saturday',30);
INSERT INTO olap_bookshop.day (day_id, month_id, day, num_day) VALUES (365,12,'sunday',31);

commit;

-- insert warehouse

INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (1,1);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (2,1);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (3,2);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (4,2);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (5,3);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (6,3);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (7,4);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (8,4);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (9,5);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (10,5);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (11,6);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (12,6);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (13,7);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (14,7);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (15,8);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (16,8);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (17,9);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (18,9);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (19,10);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (20,10);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (22,11);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (21,11);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (23,12);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (24,12);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (25,13);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (26,13);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (27,14);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (28,14);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (29,15);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (30,15);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (31,16);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (32,16);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (33,17);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (34,17);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (35,18);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (36,18);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (37,19);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (38,19);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (39,20);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (40,20);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (41,21);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (42,21);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (43,22);
INSERT INTO olap_bookshop.warehouse (code, subregion_id) VALUES (44,22);

-- inserts olap_bookshop.books

INSERT INTO olap_bookshop.books (isbn, title, price) VALUES (9706279301,'A Gentleman Never Keeps Score',384.00);
INSERT INTO olap_bookshop.books (isbn, title, price) VALUES (9728304802,'Texas Glory',94.50);
INSERT INTO olap_bookshop.books (isbn, title, price) VALUES (9702833303,'Rainy day friends',45.00);
INSERT INTO olap_bookshop.books (isbn, title, price) VALUES (9703859304,'Crazy Rich Asians',1234.50);
INSERT INTO olap_bookshop.books (isbn, title, price) VALUES (9793937405,'Tell me you are mine',23.60);
INSERT INTO olap_bookshop.books (isbn, title, price) VALUES (9729473006,'The spy and the traitor',200.00);
INSERT INTO olap_bookshop.books (isbn, title, price) VALUES (9703746207,'Paradaise Sky by Jose Lansdale',145.00);
INSERT INTO olap_bookshop.books (isbn, title, price) VALUES (9739482708,'Meet Camaro from the Nigh Charter',165.99);
INSERT INTO olap_bookshop.books (isbn, title, price) VALUES (9706279309,'Book 9 for A Gentleman',344.00);
INSERT INTO olap_bookshop.books (isbn, title, price) VALUES (9728304810,'Book 10 for Texas',84.50);
INSERT INTO olap_bookshop.books (isbn, title, price) VALUES (9702833311,'Book 11 for Rainy day',75.00);
INSERT INTO olap_bookshop.books (isbn, title, price) VALUES (9703859312,'Book 12 for Crazy Rich Asians',124.50);
INSERT INTO olap_bookshop.books (isbn, title, price) VALUES (9793937413,'Book 13 for you',23.60);
INSERT INTO olap_bookshop.books (isbn, title, price) VALUES (9729473014,'Book 14 for the spy and the traitor',240.00);
INSERT INTO olap_bookshop.books (isbn, title, price) VALUES (9793937415,'Book 15 for the Sky ',135.00);
INSERT INTO olap_bookshop.books (isbn, title, price) VALUES (9739482716,'Book 16 for the Nigh Charter',125.99);
INSERT INTO olap_bookshop.books (isbn, title, price) VALUES (9706279317,'Book 17 Keeps Score',314.00);
INSERT INTO olap_bookshop.books (isbn, title, price) VALUES (9728304818,'Book 18 Glory',84.50);
INSERT INTO olap_bookshop.books (isbn, title, price) VALUES (9702833319,'Book 19 day friends',65.00);
INSERT INTO olap_bookshop.books (isbn, title, price) VALUES (9703859320,'Book 20 Asians',1434.50);
INSERT INTO olap_bookshop.books (isbn, title, price) VALUES (9703859321,'Book 21 for the Bible',1434.50);

-- insert facts_ticket

INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (52,14,9703859312,275,1);
INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (345,10,9703746207,48,1);
INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (314,7,9739482716,15,1);
INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (50,17,9703746215,56,1);
INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (6,37,9793937405,270,1);
INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (358,31,9703746207,96,2);
INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (223,8,9703746215,84,2);
INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (91,23,9703746207,16,2);
INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (142,24,9793937413,166,3);
INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (123,25,9706279301,180,3);
INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (339,23,9793937413,14,3);
INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (35,29,9702833319,287,3);
INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (167,22,9728304802,56,3);
INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (64,13,9706279301,90,4);
INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (219,18,9793937413,581,4);
INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (129,14,9729473014,637,6);
INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (60,16,9729473006,74,6);
INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (7,12,9706279301,210,7);
INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (329,24,9728304810,84,7);
INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (344,38,9793937405,225,7);
INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (328,10,9739482716,105,7);
INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (239,32,9703859304,840,8);
INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (66,6,9793937405,225,8);
INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (44,30,9729473006,222,8);
INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (355,10,9703859320,198,9);
INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (54,13,9702833319,246,9);
INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (296,37,9703859304,240,10);
INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (49,18,9703859321,27,10);
INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (233,6,9729473014,364,11);
INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (88,5,9728304818,35,11);
INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (95,36,9728304810,72,11);
INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (341,21,9703746207,112,11); 
INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (217,11,9706279301,30,11);
INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (80,27,9706279317,42,13);
INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (206,28,9702833319,246,13);
INSERT INTO olap_bookshop.facts_ticket (day_id, warehouse_code, books_isbn, sell_by_product, ticket_number) VALUES (305,34,9706279317,84,13);
