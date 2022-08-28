#
# DUMP FILE
#
# Database is ported from MS Access
#------------------------------------------------------------------
# Created using "MS Access to MySQL" form http://www.bullzip.com
# Program Version 5.1.242
#
# OPTIONS:
#   sourcefilename=E:\_webcoach\cursusmateriaal\SQL\databases\Laatste versie\Video.mdb
#   sourceusername=
#   sourcepassword=
#   sourcesystemdatabase=
#   destinationdatabase=Video
#   storageengine=InnoDB
#   dropdatabase=1
#   createtables=1
#   unicode=1
#   autocommit=0
#   transferdefaultvalues=1
#   transferindexes=0
#   transferautonumbers=1
#   transferrecords=1
#   columnlist=1
#   tableprefix=
#   negativeboolean=0
#   ignorelargeblobs=0
#   memotype=LONGTEXT
#

CREATE DATABASE IF NOT EXISTS `video`;
USE `video`;

#
# Table structure for table 'FILMS'
#

DROP TABLE IF EXISTS `films`;

CREATE TABLE `films` (
  `filmId` INTEGER AUTO_INCREMENT, 
  `titel` VARCHAR(30), 
  `genreId` INTEGER, 
  `maatschappijId` INTEGER, 
  `voorraad` INTEGER, 
  `verhuurd` INTEGER, 
  `prijs` DECIMAL(19,4), 
  `totaalVerhuurd` DOUBLE NULL, 
  INDEX (`filmId`)
) ENGINE=innodb DEFAULT CHARSET=utf8;

# SET autocommit=0;

#
# Dumping data for table 'FILMS'
#

INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (1, 'RAIDERS OF THE LOST ARK', 2, 5, 3, 3, 7.4368, 213);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (2, 'E T', 7, 2, 3, 1, 8.6763, 211);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (3, 'LOVE STORY', 11, 5, 1, 1, 8.6763, 234);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (4, 'TWO MOON JUNCTION', 4, 2, 8, 3, 13.6341, 14);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (5, 'POLICE ACADEMY', 6, 4, 3, 2, 9.9157, 346);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (6, 'ONCE UPON A TIME IN THE WEST', 3, 3, 2, 2, 6.1973, 142);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (7, 'TRON', 10, 4, 3, 3, 8.6763, 523);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (8, 'DE SNORKELS', 7, 2, 2, 2, 12.3947, 243);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (9, 'ZORRO', 2, 3, 2, 1, 8.6763, 387);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (10, 'HECTOR', 6, 4, 2, 2, 12.3947, 23);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (11, 'HIGH NOON', 3, 1, 4, 1, 6.1973, 125);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (12, 'CAPTAIN BLOOD', 9, 1, 2, 1, 9.9157, 32);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (13, 'THE LAST EMPEROR', 2, 2, 3, 3, 8.6763, 387);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (14, 'THE DEER HUNTER', 12, 5, 9, 3, 9.9157, 24);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (15, 'THE GODS MUST BE CRAZY', 6, 4, 6, 6, 12.3947, 22);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (16, 'SILENT NIGHT, DEADLY NIGHT', 13, 3, 4, 1, 11.1552, 21);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (17, 'THE BIRDS', 13, 3, 4, 2, 6.6931, 285);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (18, 'KICKBOXER', 13, 2, 4, 1, 10.9073, 1);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (19, 'BATMAN', 2, 1, 12, 6, 12.3947, 21);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (20, 'GEVAARLIJKE VRACHT', 13, 2, 6, 5, 9.1721, 5);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (21, 'TERMS OF ENDEARMENT', 11, 4, 8, 6, 7.6847, 24);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (22, 'EMANUELLE', 4, 5, 4, 1, 8.6763, 355);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (23, 'CRAMER VS CRAMER', 11, 1, 1, 1, 9.9157, 156);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (24, 'SKINDEEP', 11, 1, 5, 4, 12.3947, 1);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (25, 'EL GRINGO', 3, 5, 5, 1, 12.3947, 44);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (26, 'THE GRADUATE', 11, 4, 3, 1, 7.4368, 346);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (27, 'HET DUEL', 1, 1, 6, 2, 9.9157, 12);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (28, 'THE OMEN', 13, 4, 5, 2, 12.3947, 411);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (29, 'SEX,LIES AND VIDEOTAPES', 4, 3, 6, 2, 13.6341, 12);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (30, 'THE ABYSS', 1, 2, 7, 3, 8.6763, 33);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (31, 'DE SMURFEN', 7, 5, 6, 4, 6.1973, 12);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (32, 'FIRST BLOOD', 13, 1, 3, 2, 11.1552, 200);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (33, 'HER ALIBI', 4, 5, 5, 1, 12.3947, 12);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (34, 'DE LANGSTE DAG', 8, 2, 3, 2, 4.9579, 55);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (35, 'THE GUNS OF NAVARONE', 8, 2, 2, 1, 9.9157, 234);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (36, 'CISKE DE RAT', 2, 3, 6, 2, 7.9326, 2);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (37, 'THE REVENGE OF JAWS', 2, 2, 6, 3, 11.1552, 11);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (38, 'LOCK UP', 13, 3, 3, 1, 11.4031, 3);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (39, 'HELLRAISER', 5, 5, 5, 2, 13.6341, 22);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (40, 'THE EXORCIST', 5, 4, 2, 2, 11.1552, 123);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (41, 'DOORNROOSJE', 7, 3, 5, 2, 9.9157, 2);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (42, 'ROAD HOUSE', 13, 3, 5, 2, 9.9157, 11);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (43, 'MATADOR', 11, 1, 5, 1, 12.3947, 13);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (44, 'MISSING IN ACTION', 8, 1, 4, 2, 11.1552, 4);
INSERT INTO `films` (`filmId`, `titel`, `genreId`, `maatschappijId`, `voorraad`, `verhuurd`, `prijs`, `totaalVerhuurd`) VALUES (45, 'LICENCE TO KILL', 2, 1, 6, 2, 12.3947, 2);
# 45 records

# COMMIT;

#
# Table structure for table 'genres'
#

DROP TABLE IF EXISTS `genres`;

CREATE TABLE `genres` (
  `genreId` INTEGER AUTO_INCREMENT, 
  `genreCode` VARCHAR(3), 
  `genre` VARCHAR(20), 
  INDEX (`genreId`)
) ENGINE=innodb DEFAULT CHARSET=utf8;

# SET autocommit=0;

#
# Dumping data for table 'GENCODE'
#

INSERT INTO `genres` (`genreId`, `genreCode`, `genre`) VALUES (1, 'AKT', 'AKTIEFILM');
INSERT INTO `genres` (`genreId`, `genreCode`, `genre`) VALUES (2, 'AVO', 'AVONTUUR');
INSERT INTO `genres` (`genreId`, `genreCode`, `genre`) VALUES (3, 'COW', 'COWBOYFILM');
INSERT INTO `genres` (`genreId`, `genreCode`, `genre`) VALUES (4, 'ERO', 'EROTIEK');
INSERT INTO `genres` (`genreId`, `genreCode`, `genre`) VALUES (5, 'GRI', 'GRIEZEL');
INSERT INTO `genres` (`genreId`, `genreCode`, `genre`) VALUES (6, 'HUM', 'HUMOR');
INSERT INTO `genres` (`genreId`, `genreCode`, `genre`) VALUES (7, 'KIN', 'KINDERFILM');
INSERT INTO `genres` (`genreId`, `genreCode`, `genre`) VALUES (8, 'OOR', 'OORLOG');
INSERT INTO `genres` (`genreId`, `genreCode`, `genre`) VALUES (9, 'PIR', 'PIRATENFILM');
INSERT INTO `genres` (`genreId`, `genreCode`, `genre`) VALUES (10, 'SCF', 'SCIENCE FICTION');
INSERT INTO `genres` (`genreId`, `genreCode`, `genre`) VALUES (11, 'SEN', 'SENTIMENTEEL');
INSERT INTO `genres` (`genreId`, `genreCode`, `genre`) VALUES (12, 'SPE', 'SPEELFILM');
INSERT INTO `genres` (`genreId`, `genreCode`, `genre`) VALUES (13, 'TRI', 'THRILLER');
# 13 records

# COMMIT;

#
# Table structure for table 'klanten'
#

DROP TABLE IF EXISTS `klanten`;

CREATE TABLE `klanten` (
  `klantId` INTEGER AUTO_INCREMENT, 
  `naam` VARCHAR(30), 
  `voornaam` VARCHAR(20), 
  `adres` VARCHAR(30), 
  `postcode` CHAR(4) NULL, 
  `woonplaats` VARCHAR(30), 
  `klantStatus` VARCHAR(1), 
  `totaalGehuurd` INT NULL, 
  `datumLid` DATETIME, 
  `lidgeld` INTEGER DEFAULT 0, 
  INDEX (`klantId`)
) ENGINE=innodb DEFAULT CHARSET=utf8;

# SET autocommit=0;

#
# Dumping data for table 'klanten'
#

INSERT INTO `klanten` (`klantId`, `naam`, `voornaam`, `adres`, `postcode`, `woonplaats`, `klantStatus`, `totaalGehuurd`, `datumLid`, `lidgeld`) VALUES (1, 'HEIREMANS', 'MARC', 'KOEKELBERGSTRAAT 32', '9330', 'DENDERMONDE', '1', 34, '2001-11-16 00:00:00', 1);
INSERT INTO `klanten` (`klantId`, `naam`, `voornaam`, `adres`, `postcode`, `woonplaats`, `klantStatus`, `totaalGehuurd`, `datumLid`, `lidgeld`) VALUES (2, 'GOESSENS', 'VERONIQUE', 'DIEPEWEG 1', '9000', 'GENT', '2', 234, '2011-12-03 00:00:00', 1);
INSERT INTO `klanten` (`klantId`, `naam`, `voornaam`, `adres`, `postcode`, `woonplaats`, `klantStatus`, `totaalGehuurd`, `datumLid`, `lidgeld`) VALUES (3, 'VAN DELSEN', 'GUY', 'KOUTERSTRAAT 10', '9263', 'BAVEGEM', '1', 142, '2012-01-10 00:00:00', 1);
INSERT INTO `klanten` (`klantId`, `naam`, `voornaam`, `adres`, `postcode`, `woonplaats`, `klantStatus`, `totaalGehuurd`, `datumLid`, `lidgeld`) VALUES (4, 'VAN DEN BERGHE', 'EDUARD', 'MELKERIJSTRAAT 34', '8900', 'IEPER', '1', 134, '2010-06-16 00:00:00', 1);
INSERT INTO `klanten` (`klantId`, `naam`, `voornaam`, `adres`, `postcode`, `woonplaats`, `klantStatus`, `totaalGehuurd`, `datumLid`, `lidgeld`) VALUES (5, 'VAN DEN BOSCHE', 'PATRICK', 'HEIRBAAN 34', '9311', 'IMPE', '1', 125, '2011-01-09 00:00:00', 1);
INSERT INTO `klanten` (`klantId`, `naam`, `voornaam`, `adres`, `postcode`, `woonplaats`, `klantStatus`, `totaalGehuurd`, `datumLid`, `lidgeld`) VALUES (6, 'VERBIEST', 'ANNIE', 'DORPSSTRAAT 35', '9000', 'GENT', '1', 187, '2007-05-10 00:00:00', 1);
INSERT INTO `klanten` (`klantId`, `naam`, `voornaam`, `adres`, `postcode`, `woonplaats`, `klantStatus`, `totaalGehuurd`, `datumLid`, `lidgeld`) VALUES (7, 'BOELENS', 'DANNY', 'GRAVENSTRAAT 23', '9402', 'MEERBEKE', '2', 231, '2002-01-08 00:00:00', 1);
INSERT INTO `klanten` (`klantId`, `naam`, `voornaam`, `adres`, `postcode`, `woonplaats`, `klantStatus`, `totaalGehuurd`, `datumLid`, `lidgeld`) VALUES (8, 'VERPOEST', 'EDDY', 'BEUKENSTRAAT 456', '9300', 'AALST', '1', 27, '2002-01-13 00:00:00', 1);
INSERT INTO `klanten` (`klantId`, `naam`, `voornaam`, `adres`, `postcode`, `woonplaats`, `klantStatus`, `totaalGehuurd`, `datumLid`, `lidgeld`) VALUES (9, 'VERPLANCKEN', 'JOHAN', 'KEMPELAND 3', '9200', 'WETTEREN', '1', 198, '2006-02-11 00:00:00', 0);
INSERT INTO `klanten` (`klantId`, `naam`, `voornaam`, `adres`, `postcode`, `woonplaats`, `klantStatus`, `totaalGehuurd`, `datumLid`, `lidgeld`) VALUES (10, 'MEERT', 'EDDY', 'OOSTHOEK 23', '9230', 'MELLE', '1', 148, '1999-09-14 00:00:00', 1);
INSERT INTO `klanten` (`klantId`, `naam`, `voornaam`, `adres`, `postcode`, `woonplaats`, `klantStatus`, `totaalGehuurd`, `datumLid`, `lidgeld`) VALUES (11, 'BOELENS', 'FREDDY', 'KOEKOEKSTRAAT 2', '9000', 'GENT', '2', 231, '2013-10-08 00:00:00', 1);
INSERT INTO `klanten` (`klantId`, `naam`, `voornaam`, `adres`, `postcode`, `woonplaats`, `klantStatus`, `totaalGehuurd`, `datumLid`, `lidgeld`) VALUES (12, 'DE CLERQ', 'RITA', 'MOLENSTRAAT 23', '9140', 'ZELE', '1', 158, '2001-08-12 00:00:00', 1);
INSERT INTO `klanten` (`klantId`, `naam`, `voornaam`, `adres`, `postcode`, `woonplaats`, `klantStatus`, `totaalGehuurd`, `datumLid`, `lidgeld`) VALUES (13, 'DE CONINCK', 'MARTINE', 'STATIONSTRAAT 23', '9402', 'MEERBEKE', '2', 285, '2012-12-11 00:00:00', 1);
INSERT INTO `klanten` (`klantId`, `naam`, `voornaam`, `adres`, `postcode`, `woonplaats`, `klantStatus`, `totaalGehuurd`, `datumLid`, `lidgeld`) VALUES (14, 'COUSAERT', 'FRANKY', 'STATIONSTRAAT 234', '9300', 'AALST', '2', 234, '1999-01-12 00:00:00', 1);
INSERT INTO `klanten` (`klantId`, `naam`, `voornaam`, `adres`, `postcode`, `woonplaats`, `klantStatus`, `totaalGehuurd`, `datumLid`, `lidgeld`) VALUES (15, 'DE CONINCK', 'MARTINE', 'VOGELZANG 34', '9000', 'GENT', '1', 177, '2010-03-13 00:00:00', 0);
INSERT INTO `klanten` (`klantId`, `naam`, `voornaam`, `adres`, `postcode`, `woonplaats`, `klantStatus`, `totaalGehuurd`, `datumLid`, `lidgeld`) VALUES (16, 'LOREZ', 'MARC', 'BEVERHOEKSTRAAT 23', '9200', 'WETTEREN', '1', 129, '2013-02-11 00:00:00', 1);
INSERT INTO `klanten` (`klantId`, `naam`, `voornaam`, `adres`, `postcode`, `woonplaats`, `klantStatus`, `totaalGehuurd`, `datumLid`, `lidgeld`) VALUES (17, 'HEYMAN', 'EDDY', 'DEINZESTEENWEG 2', '9010', 'GENTBRUGGE', '2', 241, '2001-07-18 00:00:00', 1);
INSERT INTO `klanten` (`klantId`, `naam`, `voornaam`, `adres`, `postcode`, `woonplaats`, `klantStatus`, `totaalGehuurd`, `datumLid`, `lidgeld`) VALUES (18, 'HUYSMAN', 'HENNY', 'HUISEPONTWEG 3', '9300', 'AALST', '2', 284, '2010-08-12 00:00:00', 0);
INSERT INTO `klanten` (`klantId`, `naam`, `voornaam`, `adres`, `postcode`, `woonplaats`, `klantStatus`, `totaalGehuurd`, `datumLid`, `lidgeld`) VALUES (19, 'GEVAERT', 'AN', 'WORTEGEMSTRAAT 3', '1890', 'OPWIJK', '2', 239, '2001-02-13 00:00:00', 1);
INSERT INTO `klanten` (`klantId`, `naam`, `voornaam`, `adres`, `postcode`, `woonplaats`, `klantStatus`, `totaalGehuurd`, `datumLid`, `lidgeld`) VALUES (20, 'NIJS', 'JENNY', 'LINDESTRAAT 23', '9200', 'WETTEREN', '2', 211, '2000-11-13 00:00:00', 1);
INSERT INTO `klanten` (`klantId`, `naam`, `voornaam`, `adres`, `postcode`, `woonplaats`, `klantStatus`, `totaalGehuurd`, `datumLid`, `lidgeld`) VALUES (21, 'COPPENS', 'ROBIN', 'DORP 6', '9411', 'ERONDEGEM', '2', 277, '2001-04-16 00:00:00', 1);
INSERT INTO `klanten` (`klantId`, `naam`, `voornaam`, `adres`, `postcode`, `woonplaats`, `klantStatus`, `totaalGehuurd`, `datumLid`, `lidgeld`) VALUES (22, 'GYSELS', 'ROGER', 'KASTEELDREEF 45', '9000', 'GENT', '2', 261, '2012-03-14 00:00:00', 1);
INSERT INTO `klanten` (`klantId`, `naam`, `voornaam`, `adres`, `postcode`, `woonplaats`, `klantStatus`, `totaalGehuurd`, `datumLid`, `lidgeld`) VALUES (23, 'JANSSENS', 'DANNY', 'BLIKSTRAAT 21', '9370', 'LEBBEKE', '2', 313, '2000-12-13 00:00:00', 0);
INSERT INTO `klanten` (`klantId`, `naam`, `voornaam`, `adres`, `postcode`, `woonplaats`, `klantStatus`, `totaalGehuurd`, `datumLid`, `lidgeld`) VALUES (24, 'GOEMAN', 'PHILIPPE', 'EIKELSTRAAT 345', '9160', 'HAMME', '2', 217, '2009-08-14 00:00:00', 1);
INSERT INTO `klanten` (`klantId`, `naam`, `voornaam`, `adres`, `postcode`, `woonplaats`, `klantStatus`, `totaalGehuurd`, `datumLid`, `lidgeld`) VALUES (25, 'VAN DE SOMPEL', 'GUIDO', 'VOERMANSTRAAT 45', '9170', 'WAASMUNSTER', '2', 155, '2002-12-01 00:00:00', 1);
INSERT INTO `klanten` (`klantId`, `naam`, `voornaam`, `adres`, `postcode`, `woonplaats`, `klantStatus`, `totaalGehuurd`, `datumLid`, `lidgeld`) VALUES (26, 'VAN DE POELE', 'WILLY', 'STATIONSTRAAT 11', '9000', 'GENT', '1', 133, '2002-04-01 00:00:00', 1);
INSERT INTO `klanten` (`klantId`, `naam`, `voornaam`, `adres`, `postcode`, `woonplaats`, `klantStatus`, `totaalGehuurd`, `datumLid`, `lidgeld`) VALUES (27, 'MATTHIJS', 'RUDY', 'STICHELDREEF 37', '9140', 'ZELE', '1', 184, '2014-01-09 00:00:00', 1);
INSERT INTO `klanten` (`klantId`, `naam`, `voornaam`, `adres`, `postcode`, `woonplaats`, `klantStatus`, `totaalGehuurd`, `datumLid`, `lidgeld`) VALUES (28, 'LEFEVER', 'ANNELIES', 'LIJSTERSTRAAT 2', '9290', 'BERLARE', '2', 311, '1998-10-29 00:00:00', 1);
INSERT INTO `klanten` (`klantId`, `naam`, `voornaam`, `adres`, `postcode`, `woonplaats`, `klantStatus`, `totaalGehuurd`, `datumLid`, `lidgeld`) VALUES (29, 'LENAERDS', 'JACKY', 'DRAGONDERWEGEL 23', '9281', 'OVERMERE', '2', 273, '2001-05-09 00:00:00', 1);
INSERT INTO `klanten` (`klantId`, `naam`, `voornaam`, `adres`, `postcode`, `woonplaats`, `klantStatus`, `totaalGehuurd`, `datumLid`, `lidgeld`) VALUES (30, 'LAMPENS', 'LYDIA', 'DRAPSTRAAT 45', '9282', 'UITBERGEN', '2', 276, '2002-08-31 00:00:00', 0);
# 30 records

# COMMIT;

#
# Table structure for table 'maatschappijen'
#

DROP TABLE IF EXISTS `maatschappijen`;

CREATE TABLE `maatschappijen` (
  `maatschappijId` INTEGER AUTO_INCREMENT, 
  `maatschappijCode` VARCHAR(2), 
  `maatschappij` VARCHAR(30), 
  `adres` VARCHAR(30), 
  `postcode` CHAR(4), 
  `woonplaats` VARCHAR(30), 
  `contactPersoon` VARCHAR(30), 
  INDEX (`maatschappijId`)
) ENGINE=innodb DEFAULT CHARSET=utf8;

# SET autocommit=0;

#
# Dumping data for table 'maatschappijen'
#

INSERT INTO `maatschappijen` (`maatschappijId`, `maatschappijCode`, `maatschappij`, `adres`, `postcode`, `woonplaats`, `contactpersoon`) VALUES (1, 'HV', 'HOLLYWOOD VIDEO', 'LOUIZALAAN 144', '1000', 'BRUSSEL', 'COLLINS JUDY');
INSERT INTO `maatschappijen` (`maatschappijId`, `maatschappijCode`, `maatschappij`, `adres`, `postcode`, `woonplaats`, `contactpersoon`) VALUES (2, 'VC', 'VIDEO-SCREEN', 'LANGE BEELDEKENSSTRAAT 52', '2000','ANTWERPEN', 'PETERMANS PETER');
INSERT INTO `maatschappijen` (`maatschappijId`, `maatschappijCode`, `maatschappij`, `adres`, `postcode`, `woonplaats`, `contactpersoon`) VALUES (3, 'VF', 'VIDEO-FOR-PLEASURE', 'POTTENBAKKERSSTRAAT 16', '9000', 'GENT', 'DE VRIENDT STEFANIE');
INSERT INTO `maatschappijen` (`maatschappijId`, `maatschappijCode`, `maatschappij`, `adres`, `postcode`, `woonplaats`, `contactpersoon`) VALUES (4, 'VH', 'VIDEO HOME ENTERTAINMENT', 'LANGE KOUTERSSTRAAT 14/B1', '9200', 'WETTEREN', 'VAN HOVE JACKY');
INSERT INTO `maatschappijen` (`maatschappijId`, `maatschappijCode`, `maatschappij`, `adres`, `postcode`, `woonplaats`, `contactpersoon`) VALUES (5, 'VS', 'VIDEO-STAR', 'OUDE VEST 17', '9330', 'DENDERMONDE', 'COPPENS ROBIN');
# 5 records

# COMMIT;

#
# Table structure for table 'verhuringen'
#

DROP TABLE IF EXISTS `verhuringen`;

CREATE TABLE `verhuringen` (
  `verhuringId` INTEGER AUTO_INCREMENT, 
  `klantId` INTEGER, 
  `filmId` INTEGER, 
  `verhuurDatum` DATETIME, 
  INDEX (`verhuringId`)
) ENGINE=innodb DEFAULT CHARSET=utf8;

# SET autocommit=0;

#
# Dumping data for table 'VERHUUR'
#

INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (1, 25, 2, '2014-02-04 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (2, 4, 13, '2014-02-04 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (3, 12, 36, '2014-02-04 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (4, 6, 30, '2014-02-04 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (5, 14, 15, '2014-02-04 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (6, 3, 39, '2014-02-04 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (7, 11, 1, '2014-02-04 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (8, 11, 11, '2014-02-04 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (9, 4, 17, '2014-02-04 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (10, 6, 10, '2014-02-04 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (11, 6, 27, '2014-02-04 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (12, 14, 33, '2014-02-04 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (13, 15, 25, '2014-02-04 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (14, 27, 44, '2014-02-04 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (15, 30, 24, '2014-02-04 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (16, 28, 7, '2014-02-04 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (17, 28, 3, '2014-02-04 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (18, 14, 6, '2014-02-04 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (19, 4, 35, '2014-02-04 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (20, 6, 22, '2014-02-04 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (21, 9, 13, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (22, 13, 21, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (23, 15, 31, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (24, 17, 14, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (25, 24, 19, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (26, 26, 20, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (27, 5, 45, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (28, 5, 19, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (29, 16, 18, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (30, 18, 29, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (31, 19, 38, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (32, 17, 42, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (33, 14, 24, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (34, 5, 15, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (35, 2, 41, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (36, 1, 16, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (37, 9, 19, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (38, 25, 20, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (39, 23, 21, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (40, 2, 10, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (41, 1, 40, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (42, 5, 32, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (43, 14, 41, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (44, 5, 24, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (45, 9, 19, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (46, 17, 31, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (47, 13, 14, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (48, 11, 36, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (49, 6, 30, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (50, 7, 5, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (51, 9, 7, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (52, 15, 12, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (53, 28, 6, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (54, 27, 26, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (55, 29, 23, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (56, 12, 28, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (57, 15, 8, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (58, 16, 21, '2014-02-05 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (59, 23, 31, '2014-02-06 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (60, 4, 14, '2014-02-06 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (61, 1, 20, '2014-02-06 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (62, 2, 4, '2014-02-06 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (63, 4, 34, '2014-02-06 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (64, 6, 15, '2014-02-06 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (65, 5, 37, '2014-02-06 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (66, 12, 19, '2014-02-06 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (67, 18, 20, '2014-02-06 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (68, 4, 27, '2014-02-06 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (69, 5, 30, '2014-02-06 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (70, 1, 21, '2014-02-06 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (71, 16, 40, '2014-02-07 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (72, 16, 28, '2014-02-07 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (73, 14, 13, '2014-02-07 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (74, 12, 32, '2014-02-07 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (75, 18, 9, '2014-02-07 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (76, 14, 5, '2014-02-07 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (77, 16, 1, '2014-02-07 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (78, 18, 7, '2014-02-07 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (79, 15, 21, '2014-02-07 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (80, 1, 20, '2014-02-07 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (81, 2, 19, '2014-02-07 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (82, 9, 45, '2014-02-07 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (83, 4, 42, '2014-02-07 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (84, 5, 29, '2014-02-07 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (85, 2, 34, '2014-02-07 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (86, 14, 15, '2014-02-07 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (87, 5, 44, '2014-02-07 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (88, 13, 37, '2014-02-07 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (89, 25, 1, '2014-02-07 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (90, 28, 17, '2014-02-07 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (91, 30, 21, '2014-02-07 00:00:00');
INSERT INTO `verhuringen` (`verhuringId`, `klantId`, `filmId`, `verhuurDatum`) VALUES (92, 28, 31, '2014-02-07 00:00:00');
# 92 records

# COMMIT;

