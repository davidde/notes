#
# DUMP FILE
#
# Database is ported from MS Access
#------------------------------------------------------------------
# Created using "MS Access to MySQL" form http://www.bullzip.com
# Program Version 5.4.274
#
# OPTIONS:
#   sourcefilename=C:\Users\lhoreman\Dropbox\Informatica\SQL\nieuwe versie 2015\databases\planten.mdb
#   sourceusername=
#   sourcepassword=
#   sourcesystemdatabase=
#   destinationdatabase=planten
#   storageengine=InnoDB
#   dropdatabase=1
#   createtables=1
#   unicode=1
#   autocommit=1
#   transferdefaultvalues=1
#   transferindexes=1
#   transferautonumbers=1
#   transferrecords=1
#   columnlist=1
#   tableprefix=
#   negativeboolean=0
#   ignorelargeblobs=0
#   memotype=LONGTEXT
#   datetimetype=DATETIME
#

DROP DATABASE IF EXISTS `planten`;
CREATE DATABASE IF NOT EXISTS `planten`;
USE `planten`;

#
# Table structure for table 'artikelsleveranciers'
#

DROP TABLE IF EXISTS `artikelsleveranciers`;

CREATE TABLE `artikelsleveranciers` (
  `artikelLeverancierId` INTEGER NOT NULL AUTO_INCREMENT, 
  `leverancierId` INTEGER, 
  `artikelLeverancierCode` VARCHAR(5), 
  `plantId` INTEGER, 
  `levertijd` DOUBLE NULL, 
  `offertePrijs` DOUBLE NULL,
  PRIMARY KEY (`artikelLeverancierId`)
) ENGINE=innodb DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'artikelsleveranciers'
#

INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (1, 1, 'A004', 115, 7, 1.1);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (2, 1, 'A075', 88, 7, .35);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (3, 1, 'A103', 102, 7, .3);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (4, 1, 'A184', 108, 7, .6);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (5, 1, 'A385', 24, 7, .6);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (6, 1, 'A421', 97, 7, 1.2);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (7, 1, 'B148', 94, 7, .6);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (8, 1, 'B331', 83, 7, .6);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (9, 1, 'B337', 34, 7, 1.1);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (10, 1, 'C274', 81, 7, .6);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (11, 1, 'D225', 87, 7, .5);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (12, 2, '002', 6, 21, 2.95);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (13, 2, '011', 10, 21, 9.9);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (14, 2, '013', 54, 21, 6.55);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (15, 2, '014', 71, 21, 7.9);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (16, 2, '021', 64, 21, 2.25);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (17, 2, '023', 70, 21, 10.15);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (18, 2, '024', 107, 21, 7.9);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (19, 2, '029', 31, 21, 2.5);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (20, 2, '044', 78, 21, 3.4);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (21, 2, '045', 32, 21, 6.75);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (22, 2, '050', 39, 21, 8.8);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (23, 2, '064', 50, 21, 4.3);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (24, 2, '078', 44, 21, 10.15);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (25, 2, '081', 66, 21, 3.4);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (26, 2, '085', 9, 21, 4.5);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (27, 2, '091', 118, 21, 7.9);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (28, 2, '097', 56, 21, .2);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (29, 2, '099', 93, 21, 5.65);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (30, 2, '103', 11, 21, 6.1);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (31, 2, '114', 45, 21, 8.8);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (32, 2, '115', 109, 21, 5.65);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (33, 2, '116', 112, 21, 14.4);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (34, 2, '145', 84, 21, 4.3);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (35, 3, 'E01R', 43, 21, 2.9);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (36, 3, 'E05R', 42, 10, .8);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (37, 3, 'E11X', 82, 10, 1.05);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (38, 3, 'E23W', 61, 10, 1.05);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (39, 3, 'H09', 70, 14, 11.95);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (40, 3, 'H10R', 39, 14, 10.35);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (41, 3, 'H14R', 32, 14, 7.95);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (42, 3, 'H14W', 54, 14, 7.7);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (43, 3, 'H17', 31, 14, 2.9);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (44, 3, 'H19O', 107, 14, 9.3);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (45, 3, 'H75P', 38, 14, 10.35);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (46, 3, 'H99G', 112, 14, 16.95);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (47, 4, 'A002', 18, 10, 1.45);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (48, 4, 'A101', 115, 7, 1.15);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (49, 4, 'A103', 36, 7, .1);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (50, 4, 'A154', 57, 7, .5);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (51, 4, 'A230', 23, 10, 1.65);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (52, 4, 'A395', 21, 10, 2.3);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (53, 4, 'A472', 98, 7, .65);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (54, 4, 'A520', 92, 10, 1.3);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (55, 4, 'A677', 19, 10, 1.3);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (56, 4, 'B006', 42, 14, 1);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (57, 4, 'B024', 50, 14, 6.2);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (58, 4, 'B101', 1, 7, .4);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (59, 4, 'B111', 119, 10, 2.3);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (60, 4, 'B396', 85, 10, 1.65);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (61, 4, 'B578', 39, 14, 12.7);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (62, 4, 'C051', 109, 14, 8.15);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (63, 4, 'C119', 72, 14, 6.2);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (64, 4, 'C243', 48, 14, 11.4);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (65, 4, 'D029', 9, 14, 6.5);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (66, 4, 'D296', 93, 14, 8.15);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (67, 4, 'D321', 96, 10, 1.65);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (68, 4, 'D555', 25, 14, 12.7);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (69, 4, 'D742', 64, 14, 3.25);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (70, 4, 'E098', 103, 10, 1.95);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (71, 4, 'E409', 91, 10, 1.3);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (72, 4, 'F342', 27, 10, 6.2);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (73, 4, 'F823', 41, 10, 1.65);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (74, 4, 'G001', 105, 10, 1.3);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (75, 4, 'G202', 101, 14, 6.5);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (76, 4, 'G430', 7, 10, 2.95);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (77, 4, 'H510', 30, 10, 1.95);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (78, 5, '001-2', 97, 10, 1.15);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (79, 5, '012-V', 16, 10, 1.7);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (80, 5, '027-V', 23, 10, 1.45);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (81, 5, '067-V', 114, 10, 2);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (82, 5, '082-V', 75, 10, 1.15);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (83, 5, '103-2', 63, 10, 1.05);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (84, 5, '117-V', 14, 10, 1.7);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (85, 5, '118-V', 113, 10, 1.15);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (86, 5, '162-V', 91, 10, 1.15);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (87, 5, '195-1', 108, 10, .55);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (88, 5, '201-V', 53, 10, 2);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (89, 5, '209-V', 79, 10, 1.7);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (90, 5, '255-1', 52, 10, .35);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (91, 5, '257-V', 3, 10, 1.45);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (92, 5, '263-V', 60, 10, 1.7);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (93, 5, '264-V', 68, 10, 1.45);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (94, 5, '273-2', 89, 10, .55);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (95, 5, '281-2', 83, 10, .55);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (96, 5, '286-V', 103, 10, 1.7);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (97, 5, '300-V', 105, 10, 1.15);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (98, 5, '327-1', 110, 10, .45);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (99, 5, '335-V', 117, 10, 1.7);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (100, 5, '362-V', 85, 10, 1.45);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (101, 5, '365-V', 102, 10, .3);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (102, 5, '393-V', 96, 10, 1.45);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (103, 5, '397-V', 73, 10, 2.55);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (104, 5, '400-2', 94, 10, .55);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (105, 5, '408-V', 30, 10, 1.7);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (106, 5, '471-2', 104, 10, .55);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (107, 5, '498-1', 1, 10, .35);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (108, 6, 'ACMO', 21, 14, 2.1);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (109, 6, 'ACON', 28, 14, 1.8);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (110, 6, 'ALSC', 46, 14, 1.2);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (111, 6, 'ALTH', 47, 14, 1.2);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (112, 6, 'CAMP', 103, 14, 1.8);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (113, 6, 'CENT', 67, 14, 1.2);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (114, 6, 'CHRY', 3, 14, 1.5);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (115, 6, 'CYNO', 96, 14, 1.5);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (116, 6, 'DELP', 16, 14, 1.8);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (117, 6, 'DIAN', 117, 14, 1.8);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (118, 6, 'ERYN', 14, 14, 1.8);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (119, 6, 'EUPH', 23, 14, 1.5);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (120, 6, 'GEUM', 30, 14, 1.8);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (121, 6, 'GYPS', 73, 14, 2.7);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (122, 6, 'HELI', 113, 14, 1.2);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (123, 6, 'KNIP', 13, 14, 2.1);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (124, 6, 'LAMI', 105, 14, 1.2);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (125, 6, 'LUPI', 5, 14, 1.5);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (126, 6, 'MATR', 51, 14, 1.8);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (127, 6, 'PAEO', 100, 14, 2.7);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (128, 6, 'POTE', 18, 14, 1.35);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (129, 6, 'ROSM', 33, 14, 1.2);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (130, 7, '001', 81, 7, .65);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (131, 7, '047', 8, 7, .65);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (132, 7, '066', 99, 7, .1);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (133, 7, '103', 115, 7, 1.15);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (134, 7, '162', 49, 7, .5);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (135, 7, '195', 36, 7, .1);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (136, 7, '209', 1, 7, .4);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (137, 7, '210', 87, 7, .5);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (138, 7, '257', 20, 7, .65);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (139, 7, '263', 76, 7, .05);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (140, 7, '281', 65, 7, 2.45);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (141, 7, '362', 98, 7, .65);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (142, 7, '393', 110, 7, .5);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (143, 7, '471', 90, 7, 1);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (144, 7, '498', 57, 7, .5);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (145, 8, 'AZA', 107, 10, 8.75);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (146, 8, 'BRE', 64, 10, 2.5);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (147, 8, 'FOR', 86, 10, 2.75);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (148, 8, 'HUL', 70, 10, 11.25);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (149, 8, 'KOR', 31, 10, 2.75);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (150, 8, 'LIG', 56, 10, .2);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (151, 8, 'MAG', 54, 10, 7.25);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (152, 8, 'OLI', 9, 10, 5);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (153, 8, 'PEP', 32, 10, 7.5);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (154, 8, 'ROD', 39, 10, 9.75);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (155, 8, 'SER', 38, 10, 9.75);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (156, 8, 'TOV', 112, 10, 16);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (157, 8, 'VUU', 37, 10, 2.5);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (158, 8, 'ZUU', 15, 10, 1.75);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (159, 9, 'B-003', 50, 14, 5.15);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (160, 9, 'B-011', 44, 14, 12.15);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (161, 9, 'B-034', 109, 14, 6.75);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (162, 9, 'B-076', 95, 14, 2.45);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (163, 9, 'B-104', 17, 14, 22.95);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (164, 9, 'E-002', 43, 10, 2.95);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (165, 9, 'E-003', 42, 10, .8);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (166, 9, 'S-015', 56, 14, .2);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (167, 9, 'S-077', 9, 14, 5.4);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (168, 9, 'S-118', 107, 14, 9.45);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (169, 9, 'S-154', 64, 14, 2.7);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (170, 10, 'ACMO', 21, 14, 2.15);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (171, 10, 'ALTH', 47, 14, 1.25);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (172, 10, 'ANCE', 35, 14, 1.25);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (173, 10, 'ANEM', 53, 14, 2.15);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (174, 10, 'ANGR', 111, 14, 1.25);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (175, 10, 'ANTI', 49, 14, .5);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (176, 10, 'AQUI', 55, 14, 1.55);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (177, 10, 'ARDR', 106, 14, 1.25);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (178, 10, 'BEGO', 1, 14, .4);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (179, 10, 'CAMP', 103, 14, 1.85);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (180, 10, 'CHEI', 34, 14, 1.1);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (181, 10, 'CHMA', 3, 14, 1.55);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (182, 10, 'CORT', 27, 14, 5.9);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (183, 10, 'CYNO', 89, 14, .6);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (184, 10, 'DELP', 16, 14, 1.85);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (185, 10, 'ECHI', 62, 14, 1.85);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (186, 10, 'ERYN', 14, 14, 1.85);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (187, 10, 'HEDE', 2, 14, 4.65);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (188, 10, 'LUPI', 5, 14, 1.55);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (189, 10, 'OCBA', 59, 14, 1.25);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (190, 10, 'PAPA', 58, 14, 3.1);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (191, 10, 'PARH', 94, 14, .6);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (192, 10, 'PHLO', 90, 14, .95);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (193, 10, 'PRIM', 97, 14, 1.25);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (194, 10, 'RUSC', 116, 14, 1.25);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (195, 10, 'SALV', 92, 14, 1.25);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (196, 10, 'TAGE', 52, 14, .35);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (197, 10, 'TULI', 26, 14, .25);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (198, 10, 'VIOL', 102, 14, .3);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (199, 10, 'VITI', 101, 14, 6.2);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (200, 10, 'WIST', 99, 14, .05);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (201, 11, 'ST1P1', 5, 10, 1.65);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (202, 11, 'ST1P3', 85, 10, 1.65);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (203, 11, 'ST1P4', 74, 10, 1.3);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (204, 11, 'ST1P6', 47, 10, 1.3);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (205, 11, 'ST1P8', 29, 10, 2.95);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (206, 11, 'ST1P9', 58, 10, 3.3);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (207, 11, 'ST2P1', 113, 10, 1.3);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (208, 11, 'ST2P2', 60, 10, 2);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (209, 11, 'ST2P3', 21, 10, 2.3);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (210, 11, 'ST2P5', 77, 10, 2.95);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (211, 11, 'ST2P6', 79, 10, 2);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (212, 11, 'ST3P1', 69, 10, 4.3);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (213, 11, 'ST3P2', 2, 10, 4.95);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (214, 11, 'ST3P5', 22, 10, 1.3);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (215, 11, 'ST4P1', 4, 10, 7.9);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (216, 11, 'ST4P2', 12, 10, 3.3);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (217, 11, 'ST4P5', 80, 10, .85);
INSERT INTO `artikelsleveranciers` (`artikelLeverancierId`, `leverancierId`, `artikelLeverancierCode`, `plantId`, `levertijd`, `offertePrijs`) VALUES (218, 11, 'ST4P6', 40, 10, 3.3);
# 218 records

#
# Table structure for table 'bestellijnen'
#

DROP TABLE IF EXISTS `bestellijnen`;

CREATE TABLE `bestellijnen` (
  `bestelLijnId` INTEGER NOT NULL AUTO_INCREMENT, 
  `bestelId` INTEGER, 
  `artikelLeverancierId` INTEGER, 
  `aantal` DOUBLE NULL, 
  `bestelPrijs` DOUBLE NULL, 
  PRIMARY KEY (`bestelLijnId`)
) ENGINE=innodb DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'bestellijnen'
#

INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (1, 1, 50, 150, .45);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (2, 1, 56, 150, .95);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (3, 1, 59, 25, 2.25);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (4, 1, 60, 50, 1.65);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (5, 1, 70, 50, 1.9);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (6, 1, 75, 25, 6.35);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (7, 2, 6, 50, 1.35);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (8, 2, 7, 25, .65);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (9, 2, 8, 25, .7);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (10, 2, 10, 25, .65);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (11, 3, 1, 50, .75);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (12, 3, 2, 250, .25);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (13, 3, 3, 400, .2);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (14, 3, 4, 50, .45);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (15, 3, 5, 100, .4);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (16, 3, 6, 50, .8);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (17, 3, 7, 50, .45);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (18, 3, 8, 10, .45);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (19, 3, 9, 100, .7);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (20, 3, 10, 25, .45);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (21, 3, 11, 25, .35);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (22, 4, 20, 10, 3.6);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (23, 4, 21, 5, 7.2);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (24, 4, 29, 20, 6.05);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (25, 4, 31, 3, 9.45);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (26, 4, 33, 25, 15.45);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (27, 5, 165, 200, 1.2);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (28, 6, 134, 100, .65);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (29, 6, 140, 100, 3.25);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (30, 6, 143, 25, 1.3);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (31, 7, 78, 100, 1.15);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (32, 7, 83, 100, 1);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (33, 7, 85, 200, 1.15);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (34, 7, 89, 25, 1.6);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (35, 7, 90, 200, .35);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (36, 7, 92, 50, 1.65);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (37, 7, 95, 25, .55);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (38, 7, 102, 20, 1.45);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (39, 8, 48, 100, 1.1);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (40, 8, 49, 1000, .1);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (41, 8, 50, 100, .5);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (42, 8, 53, 250, .6);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (43, 8, 58, 50, .4);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (44, 8, 59, 50, 2.15);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (45, 8, 60, 50, 1.5);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (46, 8, 61, 10, 11.7);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (47, 8, 62, 10, 7.55);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (48, 8, 65, 15, 6);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (49, 8, 66, 10, 7.55);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (50, 8, 69, 25, 2.95);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (51, 8, 70, 50, 1.8);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (52, 8, 74, 25, 1.2);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (53, 8, 76, 30, 2.75);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (54, 8, 77, 40, 1.75);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (55, 9, 201, 100, 1.65);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (56, 9, 207, 25, 1.35);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (57, 9, 213, 24, 5.05);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (58, 9, 217, 12, .9);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (59, 10, 206, 50, 3.75);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (60, 10, 207, 25, 1.45);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (61, 10, 211, 50, 2.3);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (62, 10, 212, 36, 4.85);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (63, 10, 215, 48, 8.95);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (64, 10, 217, 24, 1);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (65, 11, 1, 25, 1.25);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (66, 11, 4, 25, .65);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (67, 11, 7, 25, .7);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (68, 11, 8, 10, .7);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (69, 12, 1, 25, 1.25);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (70, 12, 4, 25, .7);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (71, 12, 5, 25, .7);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (72, 12, 6, 50, 1.45);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (73, 12, 7, 25, .7);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (74, 12, 8, 25, .75);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (75, 12, 10, 25, .75);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (76, 12, 11, 50, .55);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (77, 13, 86, 75, 1.35);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (78, 13, 88, 25, 2.4);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (79, 13, 90, 150, .4);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (80, 13, 98, 150, .5);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (81, 13, 105, 100, 2.05);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (82, 13, 107, 100, .4);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (83, 14, 111, 25, 1.15);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (84, 14, 113, 50, 1.15);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (85, 14, 115, 50, 1.4);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (86, 14, 121, 25, 2.65);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (87, 14, 123, 50, 2.05);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (88, 14, 125, 200, 1.4);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (89, 15, 171, 50, 1);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (90, 15, 178, 50, .35);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (91, 15, 179, 150, 1.55);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (92, 15, 180, 50, .95);
INSERT INTO `bestellijnen` (`bestelLijnId`, `bestelId`, `artikelLeverancierId`, `aantal`, `bestelPrijs`) VALUES (93, 15, 184, 100, 1.5);
# 93 records

#
# Table structure for table 'bestellingen'
#

DROP TABLE IF EXISTS `bestellingen`;

CREATE TABLE `bestellingen` (
  `bestelId` INTEGER NOT NULL AUTO_INCREMENT, 
  `leverancierId` INTEGER, 
  `bestelDatum` DATETIME, 
  `leveringsDatum` DATETIME, 
  `korting` decimal(4,2) NULL, 
  PRIMARY KEY (`bestelId`)
) ENGINE=innodb DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'bestellingen'
#

INSERT INTO `bestellingen` (`bestelId`, `leverancierId`, `bestelDatum`, `leveringsDatum`, `korting`) VALUES (1, 4, '2016-01-17 00:00:00', '2016-01-31 00:00:00', .02);
INSERT INTO `bestellingen` (`bestelId`, `leverancierId`, `bestelDatum`, `leveringsDatum`, `korting`) VALUES (2, 1, '2016-02-25 00:00:00', '2016-03-04 00:00:00', 0);
INSERT INTO `bestellingen` (`bestelId`, `leverancierId`, `bestelDatum`, `leveringsDatum`, `korting`) VALUES (3, 1, '2016-02-27 00:00:00', '2016-03-06 00:00:00', .01);
INSERT INTO `bestellingen` (`bestelId`, `leverancierId`, `bestelDatum`, `leveringsDatum`, `korting`) VALUES (4, 2, '2016-03-06 00:00:00', '2016-03-27 00:00:00', .05);
INSERT INTO `bestellingen` (`bestelId`, `leverancierId`, `bestelDatum`, `leveringsDatum`, `korting`) VALUES (5, 9, '2016-03-06 00:00:00', '2016-03-16 00:00:00', 0);
INSERT INTO `bestellingen` (`bestelId`, `leverancierId`, `bestelDatum`, `leveringsDatum`, `korting`) VALUES (6, 7, '2016-03-11 00:00:00', '2016-03-18 00:00:00', .02);
INSERT INTO `bestellingen` (`bestelId`, `leverancierId`, `bestelDatum`, `leveringsDatum`, `korting`) VALUES (7, 5, '2016-03-13 00:00:00', '2016-03-23 00:00:00', .03);
INSERT INTO `bestellingen` (`bestelId`, `leverancierId`, `bestelDatum`, `leveringsDatum`, `korting`) VALUES (8, 4, '2016-03-13 00:00:00', '2016-03-27 00:00:00', .09);
INSERT INTO `bestellingen` (`bestelId`, `leverancierId`, `bestelDatum`, `leveringsDatum`, `korting`) VALUES (9, 11, '2016-03-13 00:00:00', '2016-03-23 00:00:00', .04);
INSERT INTO `bestellingen` (`bestelId`, `leverancierId`, `bestelDatum`, `leveringsDatum`, `korting`) VALUES (10, 11, '2016-03-14 00:00:00', '2016-03-23 00:00:00', .04);
INSERT INTO `bestellingen` (`bestelId`, `leverancierId`, `bestelDatum`, `leveringsDatum`, `korting`) VALUES (11, 1, '2016-03-14 00:00:00', '2016-03-21 00:00:00', 0);
INSERT INTO `bestellingen` (`bestelId`, `leverancierId`, `bestelDatum`, `leveringsDatum`, `korting`) VALUES (12, 1, '2016-03-26 00:00:00', '2016-04-02 00:00:00', 0);
INSERT INTO `bestellingen` (`bestelId`, `leverancierId`, `bestelDatum`, `leveringsDatum`, `korting`) VALUES (13, 5, '2016-03-26 00:00:00', '2016-04-05 00:00:00', .02);
INSERT INTO `bestellingen` (`bestelId`, `leverancierId`, `bestelDatum`, `leveringsDatum`, `korting`) VALUES (14, 6, '2016-04-01 00:00:00', '2016-04-15 00:00:00', .09);
INSERT INTO `bestellingen` (`bestelId`, `leverancierId`, `bestelDatum`, `leveringsDatum`, `korting`) VALUES (15, 10, '2016-04-01 00:00:00', '2016-04-15 00:00:00', .01);
# 15 records

#
# Table structure for table 'categorieen'
#

DROP TABLE IF EXISTS `categorieen`;

CREATE TABLE `categorieen` (
  `categorieId` INTEGER NOT NULL AUTO_INCREMENT, 
  `categorie` VARCHAR(10), 
  `minHoogte` DOUBLE NULL, 
  `maxHoogte` DOUBLE NULL, 
  `afstand` DOUBLE NULL,
  PRIMARY KEY (`categorieId`)
) ENGINE=innodb DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'categorieen'
#

INSERT INTO `categorieen` (`categorieId`, `categorie`, `minHoogte`, `maxHoogte`, `afstand`) VALUES (1, 'LAAG', 5, 15, 20);
INSERT INTO `categorieen` (`categorieId`, `categorie`, `minHoogte`, `maxHoogte`, `afstand`) VALUES (2, 'MIDDEN', 16, 60, 30);
INSERT INTO `categorieen` (`categorieId`, `categorie`, `minHoogte`, `maxHoogte`, `afstand`) VALUES (3, 'ACHTER-L', 61, 100, 45);
INSERT INTO `categorieen` (`categorieId`, `categorie`, `minHoogte`, `maxHoogte`, `afstand`) VALUES (4, 'ACHTER-H', 101, 150, 60);
INSERT INTO `categorieen` (`categorieId`, `categorie`, `minHoogte`, `maxHoogte`, `afstand`) VALUES (5, 'SCHEIDING', 151, 300, 85);
INSERT INTO `categorieen` (`categorieId`, `categorie`, `minHoogte`, `maxHoogte`, `afstand`) VALUES (6, 'BOMEN', 301, 4000, 400);
# 6 records

#
# Table structure for table 'leveranciers'
#

DROP TABLE IF EXISTS `leveranciers`;

CREATE TABLE `leveranciers` (
  `leverancierId` INTEGER NOT NULL AUTO_INCREMENT, 
  `leverancierNaam` VARCHAR(20), 
  `adres` VARCHAR(25), 
  `woonplaats` VARCHAR(15),
  PRIMARY KEY (`leverancierId`)
) ENGINE=innodb DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'leveranciers'
#

INSERT INTO `leveranciers` (`leverancierId`, `leverancierNaam`, `adres`, `woonplaats`) VALUES (1, 'HOVENIER G.H.', 'ZANDWEG 50', 'LISSE');
INSERT INTO `leveranciers` (`leverancierId`, `leverancierNaam`, `adres`, `woonplaats`) VALUES (2, 'BAUMGARTEN R.', 'TAKSTRAAT 13', 'HILLEGOM');
INSERT INTO `leveranciers` (`leverancierId`, `leverancierNaam`, `adres`, `woonplaats`) VALUES (3, 'STRUIK BV.', 'BESSENLAAN 1', 'LISSE');
INSERT INTO `leveranciers` (`leverancierId`, `leverancierNaam`, `adres`, `woonplaats`) VALUES (4, 'SPITMAN EN ZN.', 'ACHTERTUIN 9', 'AALSMEER');
INSERT INTO `leveranciers` (`leverancierId`, `leverancierNaam`, `adres`, `woonplaats`) VALUES (5, 'DEZAAIER L.J.A.', 'DE GRONDEN 101', 'LISSE');
INSERT INTO `leveranciers` (`leverancierId`, `leverancierNaam`, `adres`, `woonplaats`) VALUES (6, 'MOOIWEER FA.', 'VERLENGDE ZOMERSTR. 24', 'AALSMEER');
INSERT INTO `leveranciers` (`leverancierId`, `leverancierNaam`, `adres`, `woonplaats`) VALUES (7, 'BLOEM L.Z.H.W.', 'LINNAEUSHOF 17', 'HILLEGOM');
INSERT INTO `leveranciers` (`leverancierId`, `leverancierNaam`, `adres`, `woonplaats`) VALUES (8, 'TRA A.', 'KOELEPLEKSTRAAT 10', 'LISSE');
INSERT INTO `leveranciers` (`leverancierId`, `leverancierNaam`, `adres`, `woonplaats`) VALUES (9, 'ERICA BV.', 'BERKENWEG 87', 'HEEMSTEDE');
INSERT INTO `leveranciers` (`leverancierId`, `leverancierNaam`, `adres`, `woonplaats`) VALUES (10, 'DE GROENE KAS BV.', 'GLASWEG 1', 'AALSMEER');
INSERT INTO `leveranciers` (`leverancierId`, `leverancierNaam`, `adres`, `woonplaats`) VALUES (11, 'FLORA BV.', 'OEVERSTRAAT 76', 'AALSMEER');
# 11 records

#
# Table structure for table 'planten'
#

DROP TABLE IF EXISTS `planten`;

CREATE TABLE `planten` (
  `plantId` INTEGER NOT NULL AUTO_INCREMENT, 
  `plantNaam` VARCHAR(16), 
  `soort` VARCHAR(7), 
  `kleur` VARCHAR(7), 
  `hoogte` INTEGER, 
  `beginBloeiMaand` INTEGER, 
  `eindBloeiMaand` INTEGER, 
  `prijs` DOUBLE NULL, 
  `categorieId` INTEGER,
  PRIMARY KEY (`plantId`)
) ENGINE=innodb DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'planten'
#

INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (1, 'BEGONIA', '1-JARIG', 'ROOD', 15, 6, 9, .65, 1);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (2, 'KLIMOP', 'KLIM', NULL, 0, 0, 0, 7.5, 5);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (3, 'MARGRIET', 'VAST', 'WIT', 70, 6, 8, 2.5, 3);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (4, 'WATERLELIE', 'WATER', 'WIT', 0, 0, 0, 12, 1);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (5, 'LUPINE', 'VAST', 'GEMENGD', 100, 6, 7, 2.5, 3);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (6, 'JENEVERBES', 'BOOM', NULL, 250, 0, 0, 6.5, 6);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (7, 'LISDODDE', 'WATER', 'GEEL', 200, 8, 9, 4.5, 5);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (8, 'RIDDERSPOOR', '1-JARIG', 'GEMENGD', 50, 7, 8, 1, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (9, 'OLIJFWILG', 'HEESTER', 'GEEL', 400, 9, 10, 10, 6);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (10, 'GOUDEN REGEN', 'BOOM', 'GEEL', 600, 5, 5, 22, 6);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (11, 'DWERGCYPRES', 'BOOM', NULL, 500, 0, 0, 13.5, 6);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (12, 'WATERHYACINT', 'WATER', 'BLAUW', 0, 6, 9, 5, 1);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (13, 'VUURPIJL', 'VAST', 'ROOD', 120, 6, 9, 3.5, 4);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (14, 'KRUISDISTEL', 'VAST', 'BLAUW', 75, 6, 7, 3, 3);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (15, 'ZUURBES', 'HEESTER', 'ORANJE', 300, 5, 6, 3.5, 5);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (16, 'RIDDERSPOOR', 'VAST', 'LILA', 150, 6, 7, 3, 4);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (17, 'LINDE', 'BOOM', 'GEEL', 4000, 7, 8, 42.5, 6);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (18, 'GANZERIK', 'VAST', 'ROOD', 25, 6, 9, 2.25, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (19, 'MUNT', 'KRUID', 'PAARS', 40, 8, 8, 2, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (20, 'KORENBLOEM', '1-JARIG', 'GEMENGD', 80, 7, 8, 1, 3);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (21, 'BEREKLAUW', 'VAST', 'WIT', 100, 7, 9, 3.5, 3);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (22, 'PETERSELIE', 'KRUID', NULL, 25, 0, 0, 2, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (23, 'WOLFSMELK', 'VAST', 'GEEL', 60, 4, 4, 2.5, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (24, 'VIOLIER', '1-JARIG', 'GEMENGD', 60, 6, 8, 1, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (25, 'ZILVERSPAR', 'BOOM', NULL, 3000, 0, 0, 19.5, 6);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (26, 'TULP', 'BOL', 'GEEL', 30, 4, 6, .4, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (27, 'PAMPUSGRAS', 'VAST', 'WIT', 300, 9, 10, 9.5, 5);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (28, 'MONNIKSKAP', 'VAST', 'VIOLET', 120, 8, 9, 3, 4);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (29, 'KALMOES', 'WATER', NULL, 90, 0, 0, 4.5, 3);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (30, 'NAGELKRUID', 'VAST', 'ORANJE', 50, 7, 8, 3, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (31, 'KORNOELJE', 'HEESTER', 'GEEL', 300, 5, 0, 5.5, 5);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (32, 'PEPERBOOMPJE', 'HEESTER', 'ROZE', 125, 2, 3, 15, 4);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (33, 'ROZEMARIJN', 'KRUID', 'BLAUW', 150, 5, 5, 2, 4);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (34, 'MUURBLOEM', '2-JARIG', 'BRUIN', 50, 4, 5, 1.8, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (35, 'KERVEL', 'KRUID', 'WIT', 30, 0, 0, 2, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (36, 'IRIS', 'BOL', 'BLAUW', 100, 5, 7, .14, 3);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (37, 'VUURDOORN', 'HEESTER', 'WIT', 0, 6, 6, 5, 5);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (38, 'SERING', 'HEESTER', 'PAARS', 500, 5, 6, 19.5, 6);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (39, 'RODODENDRON', 'HEESTER', 'ROOD', 125, 5, 7, 19.5, 4);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (40, 'CYPERGRAS', 'WATER', NULL, 100, 0, 0, 5, 3);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (41, 'BLAASJESKRUID', 'WATER', 'GEEL', 0, 7, 8, 2.5, 1);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (42, 'DOPHEIDE', 'HEIDE', 'ROOD', 35, 6, 9, 1.5, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (43, 'BOOMHEIDE', 'HEIDE', 'ROZE', 150, 7, 9, 5.5, 4);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (44, 'TULPEBOOM', 'BOOM', 'GEEL', 2000, 6, 7, 22.5, 6);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (45, 'MEIDOORN', 'BOOM', 'ROZE', 700, 5, 5, 19.5, 6);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (46, 'BIESLOOK', 'KRUID', 'PAARS', 20, 7, 8, 2, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (47, 'STOKROOS', 'VAST', 'ROOD', 250, 6, 9, 2, 5);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (48, 'ACACIA', 'BOOM', 'WIT', 2500, 6, 6, 17.5, 6);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (49, 'LEEUWEBEKJE', '1-JARIG', 'GEMENGD', 50, 7, 8, .8, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (50, 'JUDASBOOM', 'BOOM', 'ROZE', 800, 5, 5, 9.5, 6);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (51, 'KAMILLE', 'VAST', 'WIT', 70, 6, 7, 3, 3);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (52, 'AFRIKAANTJE', '1-JARIG', 'GEEL', 25, 7, 10, .6, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (53, 'ANEMOON', 'VAST', 'ROZE', 50, 8, 10, 3.5, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (54, 'MAGNOLIA', 'HEESTER', 'WIT', 1000, 4, 5, 14.5, 6);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (55, 'AKELEI', 'VAST', 'BLAUW', 60, 5, 7, 2.5, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (56, 'LIGUSTER', 'HEESTER', 'WIT', 200, 7, 7, .4, 5);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (57, 'CHRYSANT', '1-JARIG', 'GEEL', 80, 6, 8, .8, 3);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (58, 'KLAPROOS', 'VAST', 'ROOD', 70, 5, 6, 3, 3);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (59, 'BASILICUM', 'KRUID', 'WIT', 50, 8, 9, 2, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (60, 'BOTERBLOEM', 'VAST', 'WIT', 50, 5, 6, 3, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (61, 'WINTERHEIDE', 'HEIDE', 'WIT', 20, 2, 4, 2, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (62, 'KOGELDISTEL', 'VAST', 'BLAUW', 175, 6, 7, 3, 5);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (63, 'KLOKJESBLOEM', '2-JARIG', 'BLAUW', 70, 6, 8, 1.8, 3);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (64, 'BREM', 'HEESTER', 'GEEL', 150, 4, 7, 5, 4);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (65, 'SIERUI', 'BOL', 'BLAUW', 75, 6, 8, 3.75, 3);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (66, 'LIJSTERBES', 'BOOM', 'WIT', 500, 5, 5, 7.5, 6);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (67, 'KORENBLOEM', 'VAST', 'BLAUW', 80, 7, 8, 2, 3);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (68, 'TIJM', 'KRUID', 'PAARS', 10, 6, 6, 2.5, 1);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (69, 'BOSRANK', 'KLIM', 'PAARS', 300, 7, 9, 6.5, 5);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (70, 'HULST', 'HEESTER', NULL, 700, 0, 0, 22.5, 6);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (71, 'ESDOORN', 'BOOM', 'GROEN', 2500, 6, 6, 17.5, 6);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (72, 'PASSIEBLOEM', 'KLIM', 'BLAUW', 0, 6, 9, 9.5, 1);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (73, 'GIPSKRUID', 'VAST', 'WIT', 90, 7, 8, 4.5, 3);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (74, 'VINGERHOEDSKRUID', 'VAST', 'GEMENGD', 0, 6, 8, 2, 1);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (75, 'MAJORAAN', 'KRUID', 'PAARS', 30, 7, 8, 2, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (76, 'KROKUS', 'BOL', 'WIT', 15, 2, 3, .1, 1);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (77, 'DOTTERBLOEM', 'WATER', 'GEEL', 30, 4, 6, 4.5, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (78, 'BERK', 'BOOM', NULL, 2000, 0, 0, 7.5, 6);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (79, 'DAGLELIE', 'VAST', 'ROOD', 80, 6, 8, 3, 3);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (80, 'KIKKERBEET', 'WATER', 'WIT', 0, 7, 8, 1.25, 1);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (81, 'GIPSKRUID', '1-JARIG', 'WIT', 50, 6, 7, 1, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (82, 'STRUIKHEIDE', 'HEIDE', 'GEMENGD', 30, 6, 8, 2, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (83, 'JUDASPENNING', '2-JARIG', 'LILA', 70, 5, 7, 1, 3);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (84, 'AZIJNBOOM', 'BOOM', 'ROOD', 0, 6, 7, 9.5, 6);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (85, 'LEVERKRUID', 'VAST', 'PAARS', 175, 8, 9, 2.5, 5);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (86, 'FORSYTHIA', 'HEESTER', 'GEEL', 250, 3, 4, 5.5, 5);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (87, 'PETUNIA', '1-JARIG', 'ROZE', 25, 7, 10, .8, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (88, 'ALYSSUM', '1-JARIG', 'PAARS', 10, 6, 9, .6, 1);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (89, 'HONDSTONG', '2-JARIG', 'BLAUW', 30, 5, 6, 1, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (90, 'VLAMBLOEM', '1-JARIG', 'GEMENGD', 30, 7, 8, 1.5, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (91, 'ENGELS GRAS', 'VAST', 'ROOD', 20, 0, 0, 2, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (92, 'SALIE', 'KRUID', 'VIOLET', 100, 6, 7, 2, 3);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (93, 'SPAR', 'BOOM', NULL, 3000, 0, 0, 12.5, 6);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (94, 'KLAPROOS', '2-JARIG', 'GEMENGD', 40, 6, 6, 1, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (95, 'POPULIER', 'BOOM', 'WIT', 1000, 3, 4, 4.5, 6);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (96, 'HONDSTONG', 'VAST', 'BLAUW', 30, 6, 8, 2.5, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (97, 'SLEUTELBLOEM', '2-JARIG', 'GEMENGD', 25, 4, 5, 2, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (98, 'DAHLIA', '1-JARIG', 'GEMENGD', 40, 8, 10, 1, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (99, 'BLAUW DRUIFJE', 'BOL', 'BLAUW', 20, 2, 6, .12, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (100, 'PIOEN', 'VAST', 'ROOD', 50, 6, 7, 4.5, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (101, 'WIJNSTOK', 'KLIM', NULL, 600, 0, 0, 10, 6);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (102, 'VIOOLTJE', '2-JARIG', 'GEMENGD', 15, 3, 8, .5, 1);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (103, 'KLOKJESBLOEM', 'VAST', 'BLAUW', 90, 6, 8, 3, 3);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (104, 'VIOLIER', '2-JARIG', 'GEMENGD', 60, 6, 7, 1, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (105, 'DOVENETEL', 'VAST', 'GEEL', 25, 4, 5, 2, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (106, 'DRAGON', 'KRUID', 'WIT', 100, 8, 9, 2, 3);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (107, 'AZALEA', 'HEESTER', 'ORANJE', 200, 4, 5, 17.5, 5);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (108, 'KLAPROOS', '1-JARIG', 'GEMENGD', 35, 6, 9, 1, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (109, 'BEUK', 'BOOM', 'GROEN', 3000, 4, 5, 12.5, 6);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (110, 'ASTER', '1-JARIG', 'GEMENGD', 50, 7, 10, .75, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (111, 'DILLE', 'KRUID', 'GEEL', 90, 7, 8, 2, 3);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (112, 'TOVERHAZELAAR', 'HEESTER', 'GEEL', 500, 1, 2, 32, 6);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (113, 'ZONNEBLOEM', 'VAST', 'GEEL', 150, 8, 9, 2, 4);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (114, 'VUURWERKPLANT', 'VAST', 'ROZE', 150, 6, 7, 3.5, 4);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (115, 'ZONNEBLOEM', '1-JARIG', 'GEEL', 150, 8, 10, 1.8, 4);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (116, 'ZURING', 'KRUID', 'ROOD', 70, 6, 6, 2, 3);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (117, 'ANJER', 'VAST', 'WIT', 40, 6, 8, 3, 2);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (118, 'PAARDEKASTANJE', 'BOOM', 'WIT', 2500, 5, 5, 17.5, 6);
INSERT INTO `planten` (`plantId`, `plantNaam`, `soort`, `kleur`, `hoogte`, `beginBloeiMaand`, `eindBloeiMaand`, `prijs`, `categorieId`) VALUES (119, 'WOLGRAS', 'WATER', 'WIT', 30, 5, 6, 3.5, 2);
# 119 records

DROP TABLE IF EXISTS `planten_oud`;

CREATE TABLE `planten_oud` (
  `plantId` INTEGER NOT NULL AUTO_INCREMENT, 
  `plantNaam` VARCHAR(16), 
  `soort` VARCHAR(7), 
  `kleur` VARCHAR(7), 
  `hoogte` INTEGER, 
  `beginBloeiMaand` INTEGER, 
  `eindBloeiMaand` INTEGER, 
  `prijs` DOUBLE NULL, 
  `categorieId` INTEGER,
  PRIMARY KEY (`plantId`)
) ENGINE=innodb DEFAULT CHARSET=utf8;

SET autocommit=1;

