#
# DUMP FILE
#
# Database is ported from MS Access
#------------------------------------------------------------------
# Created using "MS Access to MySQL" form http://www.bullzip.com
# Program Version 5.2.252
#
# OPTIONS:
#   sourcefilename=C:\Users\iluchten\Creative Cloud Files\Webcoaching\cursusmateriaal\SQL\eindoefening\Reisbureau.mdb
#   sourceusername=
#   sourcepassword=
#   sourcesystemdatabase=
#   destinationdatabase=movedb
#   storageengine=MyISAM
#   dropdatabase=0
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
#

CREATE DATABASE IF NOT EXISTS `Reisbureau`;
USE `Reisbureau`;

#
# Table structure for table 'tblBestemming'
#

DROP TABLE IF EXISTS `tblBestemming`;

CREATE TABLE `tblBestemming` (
  `BestemmingsID` VARCHAR(5) NOT NULL, 
  `Werelddeel` VARCHAR(20), 
  `Land` VARCHAR(25), 
  `Plaats` VARCHAR(25), 
  INDEX (`BestemmingsID`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'tblBestemming'
#

INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('VERAC', 'Noord Amerika', 'Mexico', 'Veracruz');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('ALANY', 'West Europa', 'Turkije', 'Alanya');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('ALEXA', 'Afrika', 'Egypte', 'Alexandrie');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('ANTAL', 'West Europa', 'Turkije', 'Antalya');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('BAGHD', 'Azie', 'Irak', 'Baghdad');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('BALI', 'Azie', 'Indonesie', 'Bali (Kuta)');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('BANGK', 'Azie', 'Thailand', 'Bangkok');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('BARCE', 'West Europa', 'Spanje', 'Barcelona');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('BASRA', 'Azie', 'Irak', 'Basra');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('BENID', 'West Europa', 'Spanje', 'Benidorm');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('BOGOT', 'Zuid Amerika', 'Colombia', 'Bogota');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('BUENO', 'Zuid Amerika', 'Argentinie', 'Buenos Aires');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('CAIRO', 'Afrika', 'Egypte', 'Cairo');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('CALGA', 'Noord Amerika', 'Canada', 'Calgary');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('CARAC', 'Zuid Amerika', 'Venezuela', 'Caracas');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('CARTA', 'Zuid Amerika', 'Colombia', 'Cartagena');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('CASSA', 'Afrika', 'Marokko', 'Cassablanca');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('CHIAN', 'Azie', 'Thailand', 'Chiangmai');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('CORDO', 'Zuid Amerika', 'Argentinie', 'Cordoba');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('CORSI', 'West Europa', 'Frankrijk', 'Corsica');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('HAVA', 'Centraal Amerika', 'Cuba', 'Havanna');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('DALLA', 'Noord Amerika', 'Verenigde Staten', 'Dallas');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('DROME', 'West Europa', 'Frankrijk', 'Drome');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('DUSSD', 'West Europa', 'Duitsland', 'Dusseldorf');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('ELALA', 'Afrika', 'Egypte', 'El\'Alamein');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('GERON', 'West Europa', 'Spanje', 'Gerona');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('GITES', 'West Europa', 'Frankrijk', 'Gites');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('GRANC', 'West Europa', 'Spanje', 'Gran Canaria');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('HELSI', 'West Europa', 'Finland', 'Helsinki');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('ISTAN', 'West Europa', 'Turkije', 'Istanbul');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('JAKAR', 'Azie', 'Indonesie', 'Jakarta');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('KIRKU', 'Azie', 'Irak', 'Kirkuk');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('LIMA', 'Zuid Amerika', 'Peru', 'Lima');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('MADRI', 'West Europa', 'Spanje', 'Madrid');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('MANIL', 'Azie', 'Filippijnen', 'Manila');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('MARDE', 'Zuid Amerika', 'Argentinie', 'Mar del Plata');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('MEDAN', 'Azie', 'Indonesie', 'Medan');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('MEXIC', 'Noord Amerika', 'Mexico', 'Mexico');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('MIAMI', 'Noord Amerika', 'Verenigde Staten', 'Miami');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('MOIRA', 'West Europa', 'Spanje', 'Moirara');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('MONTE', 'Zuid Amerika', 'Uruguay', 'Montevideo');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('MONTR', 'Noord Amerika', 'Canada', 'Montreal');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('MOSUL', 'Azie', 'Irak', 'Mosul');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('NEWOR', 'Noord Amerika', 'Verenigde Staten', 'New Orleans');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('OTTAW', 'Noord Amerika', 'Canada', 'Ottawa');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('PARIJ', 'West Europa', 'Frankrijk', 'Parijs');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('PATTA', 'Azie', 'Thailand', 'Pattaya');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('PEKIN', 'Azie', 'China', 'Peking');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('RABAT', 'Afrika', 'Marokko', 'Rabat');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('RECIF', 'Zuid Amerika', 'Brazilie', 'Recife');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('RIO', 'Zuid Amerika', 'Brazilie', 'Rio de Janeiro');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('SALOU', 'West Europa', 'Spanje', 'Salou');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('SANFR', 'Noord Amerika', 'Verenigde Staten', 'San Francisco');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('SANPA', 'Azie', 'Filippijnen', 'San Pablo');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('SAOPA', 'Zuid Amerika', 'Brazilie', 'Sao Paulo');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('SURUB', 'Azie', 'Indonesie', 'Surubaya');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('TANGE', 'Afrika', 'Marokko', 'Tanger');
INSERT INTO `tblBestemming` (`BestemmingsID`, `Werelddeel`, `Land`, `Plaats`) VALUES ('THEBE', 'Afrika', 'Egypte', 'Thebes');
# 58 records

#
# Table structure for table 'tblBoeking'
#

DROP TABLE IF EXISTS `tblBoeking`;

CREATE TABLE `tblBoeking` (
  `Boekingnummer` INTEGER NOT NULL, 
  `Klantnummer` INTEGER NOT NULL, 
  `Reisnummer` INTEGER NOT NULL, 
  `Boekdatum` DATETIME NOT NULL, 
  `AantalVolwassenen` TINYINT(3) UNSIGNED, 
  `AantalKinderen` TINYINT(3) UNSIGNED DEFAULT 0, 
  `BetaaldBedrag` FLOAT NULL, 
  `Annuleringsverzekering` TINYINT(1) DEFAULT 0, 
  `Betaalwijze` TINYINT(3) UNSIGNED DEFAULT 0, 
  INDEX (`Klantnummer`), 
  INDEX (`Reisnummer`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'tblBoeking'
#

INSERT INTO `tblBoeking` (`Boekingnummer`, `Klantnummer`, `Reisnummer`, `Boekdatum`, `AantalVolwassenen`, `AantalKinderen`, `BetaaldBedrag`, `Annuleringsverzekering`, `Betaalwijze`) VALUES (984329, 100156220, 98402, '2015-03-22 00:00:00', 2, 0, 1300, 1, 3);
INSERT INTO `tblBoeking` (`Boekingnummer`, `Klantnummer`, `Reisnummer`, `Boekdatum`, `AantalVolwassenen`, `AantalKinderen`, `BetaaldBedrag`, `Annuleringsverzekering`, `Betaalwijze`) VALUES (984330, 100300470, 98392, '2015-03-22 00:00:00', 1, 2, 300, 0, 3);
INSERT INTO `tblBoeking` (`Boekingnummer`, `Klantnummer`, `Reisnummer`, `Boekdatum`, `AantalVolwassenen`, `AantalKinderen`, `BetaaldBedrag`, `Annuleringsverzekering`, `Betaalwijze`) VALUES (984331, 100984470, 90390, '2015-03-22 00:00:00', 2, 1, 2300, 1, 2);
INSERT INTO `tblBoeking` (`Boekingnummer`, `Klantnummer`, `Reisnummer`, `Boekdatum`, `AantalVolwassenen`, `AantalKinderen`, `BetaaldBedrag`, `Annuleringsverzekering`, `Betaalwijze`) VALUES (984332, 100183500, 90378, '2015-03-22 00:00:00', 2, 0, 0, 0, 1);
INSERT INTO `tblBoeking` (`Boekingnummer`, `Klantnummer`, `Reisnummer`, `Boekdatum`, `AantalVolwassenen`, `AantalKinderen`, `BetaaldBedrag`, `Annuleringsverzekering`, `Betaalwijze`) VALUES (984333, 100300470, 94368, '2015-03-22 00:00:00', 1, 0, 2000, 0, 1);
INSERT INTO `tblBoeking` (`Boekingnummer`, `Klantnummer`, `Reisnummer`, `Boekdatum`, `AantalVolwassenen`, `AantalKinderen`, `BetaaldBedrag`, `Annuleringsverzekering`, `Betaalwijze`) VALUES (984334, 100300160, 94389, '2015-03-23 00:00:00', 2, 0, 4500, 0, 3);
INSERT INTO `tblBoeking` (`Boekingnummer`, `Klantnummer`, `Reisnummer`, `Boekdatum`, `AantalVolwassenen`, `AantalKinderen`, `BetaaldBedrag`, `Annuleringsverzekering`, `Betaalwijze`) VALUES (984335, 100283350, 98387, '2015-03-23 00:00:00', 2, 2, 0, 0, 3);
INSERT INTO `tblBoeking` (`Boekingnummer`, `Klantnummer`, `Reisnummer`, `Boekdatum`, `AantalVolwassenen`, `AantalKinderen`, `BetaaldBedrag`, `Annuleringsverzekering`, `Betaalwijze`) VALUES (984336, 100183500, 92396, '2015-03-23 00:00:00', 1, 0, 2500, 0, 3);
INSERT INTO `tblBoeking` (`Boekingnummer`, `Klantnummer`, `Reisnummer`, `Boekdatum`, `AantalVolwassenen`, `AantalKinderen`, `BetaaldBedrag`, `Annuleringsverzekering`, `Betaalwijze`) VALUES (984337, 100283560, 92398, '2015-03-24 00:00:00', 2, 0, 3000, 0, 3);
INSERT INTO `tblBoeking` (`Boekingnummer`, `Klantnummer`, `Reisnummer`, `Boekdatum`, `AantalVolwassenen`, `AantalKinderen`, `BetaaldBedrag`, `Annuleringsverzekering`, `Betaalwijze`) VALUES (984338, 100300160, 90390, '2015-03-26 00:00:00', 5, 3, 4500, 0, 2);
INSERT INTO `tblBoeking` (`Boekingnummer`, `Klantnummer`, `Reisnummer`, `Boekdatum`, `AantalVolwassenen`, `AantalKinderen`, `BetaaldBedrag`, `Annuleringsverzekering`, `Betaalwijze`) VALUES (984339, 100432890, 98388, '2015-03-27 00:00:00', 4, 5, 0, 0, 3);
INSERT INTO `tblBoeking` (`Boekingnummer`, `Klantnummer`, `Reisnummer`, `Boekdatum`, `AantalVolwassenen`, `AantalKinderen`, `BetaaldBedrag`, `Annuleringsverzekering`, `Betaalwijze`) VALUES (984400, 100103620, 94379, '2015-03-28 00:00:00', 2, 0, 3200, 1, 3);
INSERT INTO `tblBoeking` (`Boekingnummer`, `Klantnummer`, `Reisnummer`, `Boekdatum`, `AantalVolwassenen`, `AantalKinderen`, `BetaaldBedrag`, `Annuleringsverzekering`, `Betaalwijze`) VALUES (984401, 100142310, 94379, '2015-04-01 00:00:00', 4, 1, 4500, 0, 2);
INSERT INTO `tblBoeking` (`Boekingnummer`, `Klantnummer`, `Reisnummer`, `Boekdatum`, `AantalVolwassenen`, `AantalKinderen`, `BetaaldBedrag`, `Annuleringsverzekering`, `Betaalwijze`) VALUES (984402, 100349550, 96395, '2015-04-01 00:00:00', 2, 0, 0, 0, 1);
INSERT INTO `tblBoeking` (`Boekingnummer`, `Klantnummer`, `Reisnummer`, `Boekdatum`, `AantalVolwassenen`, `AantalKinderen`, `BetaaldBedrag`, `Annuleringsverzekering`, `Betaalwijze`) VALUES (984403, 100156220, 90377, '2015-04-02 00:00:00', 3, 1, 4200, 0, 1);
INSERT INTO `tblBoeking` (`Boekingnummer`, `Klantnummer`, `Reisnummer`, `Boekdatum`, `AantalVolwassenen`, `AantalKinderen`, `BetaaldBedrag`, `Annuleringsverzekering`, `Betaalwijze`) VALUES (984404, 100200340, 98392, '2015-04-02 00:00:00', 2, 0, 0, 0, 1);
INSERT INTO `tblBoeking` (`Boekingnummer`, `Klantnummer`, `Reisnummer`, `Boekdatum`, `AantalVolwassenen`, `AantalKinderen`, `BetaaldBedrag`, `Annuleringsverzekering`, `Betaalwijze`) VALUES (984405, 100953370, 98400, '2015-04-03 00:00:00', 2, 1, 1000, 0, 2);
INSERT INTO `tblBoeking` (`Boekingnummer`, `Klantnummer`, `Reisnummer`, `Boekdatum`, `AantalVolwassenen`, `AantalKinderen`, `BetaaldBedrag`, `Annuleringsverzekering`, `Betaalwijze`) VALUES (984406, 100733820, 92380, '2015-04-03 00:00:00', 4, 0, 0, 0, 2);
INSERT INTO `tblBoeking` (`Boekingnummer`, `Klantnummer`, `Reisnummer`, `Boekdatum`, `AantalVolwassenen`, `AantalKinderen`, `BetaaldBedrag`, `Annuleringsverzekering`, `Betaalwijze`) VALUES (984407, 100984499, 98402, '2015-04-04 00:00:00', 2, 3, 2300, 0, 2);
INSERT INTO `tblBoeking` (`Boekingnummer`, `Klantnummer`, `Reisnummer`, `Boekdatum`, `AantalVolwassenen`, `AantalKinderen`, `BetaaldBedrag`, `Annuleringsverzekering`, `Betaalwijze`) VALUES (984409, 100483880, 98404, '2015-04-04 00:00:00', 2, 1, 0, 0, 2);
INSERT INTO `tblBoeking` (`Boekingnummer`, `Klantnummer`, `Reisnummer`, `Boekdatum`, `AantalVolwassenen`, `AantalKinderen`, `BetaaldBedrag`, `Annuleringsverzekering`, `Betaalwijze`) VALUES (984410, 100899230, 98386, '2015-04-04 00:00:00', 3, 1, 0, 0, 2);
INSERT INTO `tblBoeking` (`Boekingnummer`, `Klantnummer`, `Reisnummer`, `Boekdatum`, `AantalVolwassenen`, `AantalKinderen`, `BetaaldBedrag`, `Annuleringsverzekering`, `Betaalwijze`) VALUES (984411, 100933730, 92396, '2015-04-05 00:00:00', 1, 0, 2500, 0, 3);
INSERT INTO `tblBoeking` (`Boekingnummer`, `Klantnummer`, `Reisnummer`, `Boekdatum`, `AantalVolwassenen`, `AantalKinderen`, `BetaaldBedrag`, `Annuleringsverzekering`, `Betaalwijze`) VALUES (984412, 100546738, 92396, '2015-04-05 00:00:00', 1, 0, 2500, 0, 3);
INSERT INTO `tblBoeking` (`Boekingnummer`, `Klantnummer`, `Reisnummer`, `Boekdatum`, `AantalVolwassenen`, `AantalKinderen`, `BetaaldBedrag`, `Annuleringsverzekering`, `Betaalwijze`) VALUES (984413, 100142310, 95405, '2015-03-31 00:00:00', 2, 2, 500, 1, 3);
INSERT INTO `tblBoeking` (`Boekingnummer`, `Klantnummer`, `Reisnummer`, `Boekdatum`, `AantalVolwassenen`, `AantalKinderen`, `BetaaldBedrag`, `Annuleringsverzekering`, `Betaalwijze`) VALUES (984414, 100984470, 95405, '2015-03-31 00:00:00', 1, 0, 1200, 1, 1);
INSERT INTO `tblBoeking` (`Boekingnummer`, `Klantnummer`, `Reisnummer`, `Boekdatum`, `AantalVolwassenen`, `AantalKinderen`, `BetaaldBedrag`, `Annuleringsverzekering`, `Betaalwijze`) VALUES (984415, 100984493, 95405, '2015-03-31 00:00:00', 2, 1, 2000, 1, 2);
INSERT INTO `tblBoeking` (`Boekingnummer`, `Klantnummer`, `Reisnummer`, `Boekdatum`, `AantalVolwassenen`, `AantalKinderen`, `BetaaldBedrag`, `Annuleringsverzekering`, `Betaalwijze`) VALUES (984416, 100984474, 95405, '2015-03-31 00:00:00', 2, 0, 500, 1, 3);
# 27 records

#


#
# Table structure for table 'tblKlanten'
#

DROP TABLE IF EXISTS `tblKlanten`;

CREATE TABLE `tblKlanten` (
  `KlantID` INTEGER, 
  `Naam` VARCHAR(255), 
  `Voornaam` VARCHAR(255), 
  `Straat` VARCHAR(255), 
  `Postnr` VARCHAR(50), 
  `Gemeente` VARCHAR(255), 
  `Provincie` VARCHAR(255), 
  `Firma` VARCHAR(255), 
  `Geslacht` VARCHAR(255), 
  `Geboortedatum` DATETIME, 
  `Klanttype` INTEGER, 
  `Telefoonnummer` VARCHAR(255), 
  `Faxnummer` VARCHAR(50), 
  `GSM` VARCHAR(255), 
  `Mailadres` VARCHAR(255), 
  `Kinderen` TINYINT(1) DEFAULT 0, 
  `Rekening` VARCHAR(255), 
  `BTWnr` VARCHAR(255), 
  INDEX (`KlantID`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'tblKlanten'
#

INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100103620, 'Rovers', 'Veerle', 'Kerkstraat 26', '8000', 'Brugge', 'W-VL', 'MODERN OFFICE BVBA', 'v', '1975-12-08 00:00:00', 1, '(050) 95.89.83', NULL, '0477 123457', 'Veerle.Rovers@hotmail.com', 1, '431809088181', 'BE 400.046.806');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100142310, 'Vandenabeele', 'Marc', 'Markt 16', '9300', 'Aalst', 'O-VL', 'A.R.G. BVBA', 'm', '1975-02-09 00:00:00', 2, '(053) 28.52.34', NULL, '0496 577498', 'Marc.Vandenabeele@hotmail.com', 0, '000014802604', 'BE 417.435.540');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100156220, 'Tijtgat', 'Ward', 'Noordstraat 23', '2300', 'Turnhout', 'Antwerpen', 'AHREND NV', 'm', '1969-08-03 00:00:00', 3, '(03) 397.08.23', NULL, '0478 278299', 'Ward.Tijtgat@hotmail.com', 1, '319221964787', 'BE 405.702.005');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100163380, 'Dhollander', 'Dirk', 'Sepulkrijnenlaan 14', '3500', 'Hasselt', 'Limburg', 'RANK XEROX SA', 'm', '1970-09-09 00:00:00', 1, '(011) 17.02.36', NULL, '0479 238864', 'Dirk.Dhollander@hotmail.com', 0, '001155346182', 'BE 400.438.764');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100183500, 'Vanacker', 'Hanne', 'Langestraat 98', '2300', 'Turnhout', 'Antwerpen', 'R & G SCHUMACHER', 'v', '1975-03-04 00:00:00', 2, '(03) 512.75.69', NULL, '0477 001122', 'Hanne.Vanacker@hotmail.com', 1, '000001058714', 'BE 861.316.448');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100200340, 'Catteeuw', 'Eric', 'Provinciestraat 14', '2000', 'Antwerpen', 'Antwerpen', 'ENGELEN BVBA', 'm', '1969-07-02 00:00:00', 3, '(03) 406.46.98', NULL, '0496 784512', 'Eric.Catteeuw@hotmail.com', 0, '410039378181', 'BE 417.767.617');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100277380, 'Bonnet', 'Roger', 'St-Hubertuslaan 41', '3800', 'St-Truiden', 'Limburg', 'MERCATOR SA', 'm', '1960-05-09 00:00:00', 1, '(013) 65.95.81', NULL, '0478 748596', 'Roger.Bonnet@hotmail.com', 1, '734301414674', 'BE 405.928.172');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100283350, 'Platteau', 'Magda', 'Vijfwegenstraat 164', '8800', 'Roeselare', 'W-VL', 'EURO SI', 'v', '1970-01-29 00:00:00', 2, '(051) 93.07.68', NULL, '0479 112233', 'Magda.Platteau@hotmail.com', 0, '001155355781', 'BE 636.158.662');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100283560, 'Van Elk', 'Peter', 'Molenstraat 56', '9800', 'Deinze', 'O-VL', 'DELMI DECOR', 'm', '1975-12-28 00:00:00', 3, '(050) 71.44.72', NULL, '', 'Peter.Van Elk@hotmail.com', 1, '335002867711', 'BE 414.771.010');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100300160, 'Van den Broecke', 'Lucie', 'Koning Albertlaan 23', '3800', 'St-Truiden', 'Limburg', 'ALFA-DISC', 'v', '1975-02-22 00:00:00', 1, '(016) 03.88.68', NULL, '0476 456789', 'Lucie.Van den Broecke@hotmail.com', 0, '001016354276', 'BE 425.585.520');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100300470, 'Lanssens', 'Piet', 'Hoogstraat 10', '8800', 'Roeselare', 'W-VL', 'ACCOMS BVBA', 'm', '1969-08-20 00:00:00', 2, '(051) 37.50.90', NULL, '', 'Piet.Lanssens@hotmail.com', 1, '408702649170', 'BE 421.382.648');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100318310, 'Ramon', 'Johan', 'Beukenlaan 16', '8810', 'Lichtervelde', 'W-VL', 'TOBIE DE PRINS BVBA', 'm', '1970-09-29 00:00:00', 3, '(050) 97.32.72', '(050) 12.45.78', '0477 445566', 'Johan.Ramon@hotmail.com', 0, '784508996715', 'BE 404.944.514');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100349550, 'De Clerk', 'Dorine', 'Lindenlaan 23', '3800', 'St-Truiden', 'Limburg', 'VANSEVENANT BVBA', 'v', '1975-03-24 00:00:00', 1, '(011) 47.97.30', NULL, '0496 556677', 'Dorine.De Clerk@hotmail.com', 1, '210030386920', 'BE 419.693.462');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100432890, 'Glorieux', 'Ann', 'Hoogstraat 2', '9300', 'Aalst', 'O-VL', 'INTERLIT NV', 'v', '1969-07-22 00:00:00', 2, '(053) 63.60.20', NULL, '0478 667788', 'Ann.Glorieux@hotmail.com', 0, '290001790174', 'BE 400.027.109');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100477310, 'Janssens', 'Johan', 'Kortrijkse steenweg 56', '9800', 'Deinze', 'O-VL', 'DE WOLF FERDINAND & CO BVBA', 'm', '1960-05-29 00:00:00', 3, '(09) 790.43.07', NULL, '0479 778899', 'Johan.Janssens@hotmail.com', 1, '220001976513', 'BE 400.025.129');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100483880, 'Kerkhove', 'Greet', 'Kattestraat 10', '2200', 'Herentals', 'Antwerpen', 'ALLGEIER COMPUTER GMBH', 'v', '1970-01-29 00:00:00', 1, '(03) 941.47.84', NULL, '0477 986532', 'Greet.Kerkhove@hotmail.com', 0, '210047916032', 'BE 426.820.883');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100546738, 'Desmet', 'Jozef', 'Brugse steenweg 203', '8800', 'Roeselare', 'W-VL', 'AVEMART BVBA', 'm', '1966-01-27 00:00:00', 2, '(051) 18.22.02', NULL, '0496 552288', 'Jozef.Desmet@hotmail.com', 1, '461319222874', 'BE 408.466.604');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100733820, 'Ruysschaert', 'Ann', 'Beheersstraat 12', '8500', 'Kortrijk', 'W-VL', 'ROUX MEUBELPRODUKTEN', 'v', '1975-12-18 00:00:00', 3, '(056) 61.23.89', NULL, '0478 783255', 'Ann.Ruysschaert@hotmail.com', 0, '450049115196', 'BE 401.843.438');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100899230, 'Van Den Broecke', 'Luc', 'Eikenberg 62', '3700', 'Tongeren', 'Limburg', 'WIJCKMANS', 'm', '1975-02-19 00:00:00', 1, '(012) 75.97.22', NULL, '0479 197328', 'Luc.Van Den Broecke@hotmail.com', 1, '799550004853', 'BE 412.661.754');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100933730, 'Vandenbroucke', 'Jan', 'Stationsstraat 89', '3500', 'Hasselt', 'Limburg', 'LUCAS BELGIUM NV', 'm', '1969-08-13 00:00:00', 2, '(011) 44.25.52', NULL, '0477 330022', 'Jan.Vandenbroucke@hotmail.com', 0, '235046002967', 'BE 415.503.953');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100953370, 'Declerck', 'Mia', 'Rodestraat 12', '3700', 'Tongeren', 'Limburg', 'SENTINEL COMPUTER PRODUCTS NV', 'v', '1970-09-19 00:00:00', 3, '(012) 51.78.67', NULL, '0496 794631', 'Mia.Declerck@hotmail.com', 1, '000077862405', 'BE 422.901.687');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100984470, 'Deschuymere', 'Kathy', 'Jozef Plateaustraat 10', '9000', 'Gent', 'O-VL', 'DUPLICATO', 'v', '1975-03-14 00:00:00', 1, '(09) 216.91.10', NULL, '0478 775533', 'Kathy.Deschuymere@hotmail.com', 0, '443353347161', 'BE 451.312.888');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100984471, 'Cloet', 'Hugo', 'Keizerlei 57', '2000', 'Antwerpen', 'Antwerpen', 'KEMPENSE KANTOORSYSTEMEN CV', 'm', '1969-07-12 00:00:00', 2, '(03) 304.00.45', NULL, '0479 010203', 'Hugo.Cloet@hotmail.com', 1, '434809501174', 'BE 428.927.565');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100984472, 'Coopman', 'Peter', 'Eikenlaan 54', '9800', 'Deinze', 'O-VL', 'B.G.O. NV', 'm', '1960-05-19 00:00:00', 3, '(050) 44.77.79', NULL, '0477 040506', 'Peter.Coopman@hotmail.com', 0, '425007448181', 'BE 428.122.663');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100984473, 'Deschuymer', 'Elsie', 'St-Pietersnieuwstraat 2', '9000', 'Gent', 'O-VL', 'DRUKKERIJ JOOS NV', 'v', '1970-01-19 00:00:00', 1, '(09) 289.70.15', '(059) 88.42.18', '0477 458211', 'Elsie.Deschuymer@hotmail.com', 1, '000024810475', 'BE 404.162.178');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100984474, 'Lambrecht', 'Geert', 'Groenstraat 412', '2200', 'Herentals', 'Antwerpen', 'ETALO NV', 'm', '1969-07-02 00:00:00', 2, '(03) 626.53.00', NULL, '', 'Geert.Lambrecht@hotmail.com', 0, '750919137103', 'BE 405.561.750');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100984475, 'Janssens', 'Dirk', 'Grote Markt 12', '8500', 'Kortrijk', 'W-VL', 'SSI SCHAEFER SA', 'm', '1960-05-09 00:00:00', 3, '(056) 90.19.25', NULL, '0477 070809', 'Dirk.Janssens@hotmail.com', 1, '310027374593', 'BE 414.944.620');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100984476, 'Goethals', 'Patrick', 'Romeinse laan 16', '8500', 'Kortrijk', 'W-VL', 'SONUWE NV', 'm', '1970-01-29 00:00:00', 1, '(056) 01.28.85', NULL, '0496 708090', 'Patrick.Goethals@hotmail.com', 0, '335002531039', 'BE 401.348.683');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100984477, 'Meuleman', 'Luc', 'Italiëlei 203', '2000', 'Antwerpen', 'Antwerpen', 'LOGICA SA', 'm', '1975-12-28 00:00:00', 2, '(03) 103.25.13', NULL, '0478 405060', 'Luc.Meuleman@hotmail.com', 1, '477866990721', 'BE 419.457.197');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100984478, 'Staelens', 'Els', 'Scheldestraat 89', '2000', 'Antwerpen', 'Antwerpen', 'VELDEMAN NV', 'v', '1975-02-22 00:00:00', 3, '(03) 851.78.12', NULL, '0479 102030', 'Els.Staelens@hotmail.com', 0, '220096335382', 'BE 426.720.519');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100984479, 'Blomme', 'Alain', 'Klaverheide 10', '2000', 'Antwerpen', 'Antwerpen', 'DIDECOR SPRL', 'm', '1969-08-20 00:00:00', 1, '(03) 664.40.86', NULL, '0477 779331', 'Alain.Blomme@hotmail.com', 1, '430025295163', 'BE 421.282.480');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100984480, 'D\'hollander', 'Luc', 'Zuidmolenstraat 12', '8800', 'Roeselare', 'W-VL', 'CLAUS-KELEMAN', 'm', '1970-09-29 00:00:00', 2, '(050) 05.93.29', NULL, '0496 558221', 'Luc.D\'hollander@hotmail.com', 0, '306722008801', 'BE 816.319.237');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100984481, 'Vanackere', 'Charlotte', 'Zuidstraat 87', '2300', 'Turnhout', 'Antwerpen', 'DIGITAL SA', 'v', '1975-03-24 00:00:00', 3, '(03) 563.10.14', NULL, '0478 933822', 'Charlotte.Vanackere@hotmail.com', 1, '712011301290', 'BE 407.823.434');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100984482, 'Desmedt', 'Mia', 'Stationsstraat 16', '8000', 'Brugge', 'W-VL', 'FRAMA', 'v', '1969-07-22 00:00:00', 1, '(050) 56.82.83', NULL, '0479 771882', 'Mia.Desmedt@hotmail.com', 0, '700004029786', 'BE 423.969.776');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100984483, 'Grymonprez', 'Hans', 'Heidebloemlaan 16', '2200', 'Herentals', 'Antwerpen', 'CATO', 'm', '1960-05-29 00:00:00', 2, '(03) 196.99.49', NULL, '0477 664997', 'Hans.Grymonprez@hotmail.com', 1, '413400542157', 'BE 405.123.694');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100984484, 'Cooman', 'Eric', 'Leopold 3-laan', '8400', 'Oostende', 'W-VL', 'C.N.CO. CLAESEN COLLECTION', 'm', '1970-01-29 00:00:00', 3, '(059) 65.71.04', NULL, '0496 113446', 'Eric.Cooman@hotmail.com', 0, '210090251074', 'BE 416.965.089');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100984485, 'Mussche', 'Rose-Anne', 'Overleiestraat 10', '8500', 'Kortrijk', 'W-VL', 'VETRORESINA', 'v', '1966-01-27 00:00:00', 1, '(056) 63.16.88', NULL, '0478 337119', 'Rose-Anne.Mussche@hotmail.com', 1, '271016555104', 'BE 216.819.645');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100984486, 'Bonte', 'Louise', 'Westlaan 16', '8800', 'Roeselare', 'W-VL', 'OBUMEX BVBA', 'v', '1975-12-18 00:00:00', 2, '(050) 01.52.75', NULL, '0479 885225', 'Louise.Bonte@hotmail.com', 0, '467712833182', 'BE 405.584.417');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100984487, 'Vandenbroecke', 'Stefaan', 'Sikkelstraat 56', '3700', 'Tongeren', 'Limburg', 'CATOOR', 'm', '1975-02-19 00:00:00', 3, '(012) 23.12.43', NULL, '0477 445665', 'Stefaan.Vandenbroecke@hotmail.com', 1, '310015105111', 'BE 461.316.954');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100984488, 'Vanden Abeele', 'Roger', 'Tongerse steenweg 124', '3500', 'Hasselt', 'Limburg', 'HERMANT SPRL', 'm', '1969-08-13 00:00:00', 1, '(011) 24.42.33', NULL, '0496 881992', 'Roger.Vanden Abeele@hotmail.com', 0, '646017327042', 'BE 405.911.346');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100984489, 'Declercq', 'Maria', 'Demerstraat 45', '3500', 'Hasselt', 'Limburg', 'PAMI NV', 'v', '1970-09-19 00:00:00', 2, '(011) 81.91.04', NULL, '0478 775773', 'Maria.Declercq@hotmail.com', 0, '319261360329', 'BE 423.087.373');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100984490, 'Kerckhof', 'Guido', 'Sterreweg 45', '2200', 'Herentals', 'Antwerpen', 'VERHAEGEN J. BVBA', 'm', '1975-03-14 00:00:00', 3, '(03) 834.75.37', NULL, '0479 337991', 'Guido.Kerckhof@hotmail.com', 1, '435028444120', 'BE 423.298.397');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100984491, 'Jansen', 'Wilfried', 'Blandijnberg 56', '9000', 'Gent', 'O-VL', 'KINDEKENS ETS SPRL', 'm', '1969-07-12 00:00:00', 1, '(09) 337.11.84', NULL, '0477 468210', 'Wilfried.Jansen@hotmail.com', 0, '230099306691', 'BE 401.899.011');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100984492, 'De Smet', 'Dirk', 'Kouter 23', '9000', 'Gent', 'O-VL', 'AIMS', 'm', '1960-05-19 00:00:00', 2, '(09) 261.00.27', NULL, '0496 888222', 'Dirk.De Smet@hotmail.com', 1, '235011041339', 'BE 416.446.734');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100984493, 'Jansens', 'Simon', 'Schoolstraat 78', '2300', 'Turnhout', 'Antwerpen', 'SAMKO BURO', 'm', '1970-01-19 00:00:00', 3, '(03) 728.18.85', NULL, '0478 771117', 'Simon.Jansens@hotmail.com', 0, '220096588491', 'BE 406.469.194');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100984494, 'Waterloos', 'Marie-Anne', 'Overpoortstraat 25', '9000', 'Gent', 'O-VL', 'INTERSTUHL RACO BVBA', 'v', '1975-03-14 00:00:00', 1, '(09) 560.46.46', NULL, '0479 993339', 'Marie-Anne.Waterloos@hotmail.com', 1, '220030091254', 'BE 425.984.606');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100984495, 'Janssen', 'Veerle', 'Kortrijkse steenweg 10', '9000', 'Gent', 'O-VL', 'HONEYWELL BULL SA', 'v', '1969-07-12 00:00:00', 2, '(09) 443.55.79', NULL, '0477 779997', 'Veerle.Janssen@hotmail.com', 0, '220076081378', 'BE 402.026.891');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100984496, 'Stockmans', 'Mieke', 'Oude Vest 14', '2300', 'Turnhout', 'Antwerpen', 'DEBACKERE BVBA KANTOORMEUBELEN', 'v', '1960-05-19 00:00:00', 3, '(03) 203.36.61', NULL, '0496 664446', 'Mieke.Stockmans@hotmail.com', 1, '000024810475', 'BE 425.509.702');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100984497, 'Dereygere', 'Clement', 'Berkenlaan 8', '3600', 'Genk', 'Limburg', 'EVER', 'm', '1970-01-19 00:00:00', 1, '(089) 37.90.70', NULL, '0478 113331', 'Clement.Dereygere@hotmail.com', 0, '712100147129', 'BE 451.312.888');
INSERT INTO `tblKlanten` (`KlantID`, `Naam`, `Voornaam`, `Straat`, `Postnr`, `Gemeente`, `Provincie`, `Firma`, `Geslacht`, `Geboortedatum`, `Klanttype`, `Telefoonnummer`, `Faxnummer`, `GSM`, `Mailadres`, `Kinderen`, `Rekening`, `BTWnr`) VALUES (100984499, 'Jacobs', 'Dirk', 'Vindictievelaan 14', '8400', 'Oostende', 'W-VL', 'GOEKINT', 'm', '1980-05-29 00:00:00', 2, '(059) 11.17.02', '(059) 66.73.37', '0498 667379', 'Dirk.Jacobs@yahoo.com', 1, '310003867053', 'BE 451.999.123');
# 50 records

#
# Table structure for table 'tblPersoneelsleden'
#

DROP TABLE IF EXISTS `tblPersoneelsleden`;

CREATE TABLE `tblPersoneelsleden` (
  `PersoneelsID` INTEGER, 
  `Familienaam` VARCHAR(255), 
  `Voornaam` VARCHAR(255), 
  `StraatNummer` VARCHAR(255), 
  `Postcode` VARCHAR(255), 
  `Gemeente` VARCHAR(255), 
  `Telefoon` VARCHAR(255), 
  `gsm` VARCHAR(255), 
  `e-mail` VARCHAR(255), 
  `Geboortedatum` DATETIME, 
  `DatumIndiensttreding` DATETIME, 
  `InDienst` INTEGER, 
  `Rekeningnummer` VARCHAR(255), 
  `Salaris` DOUBLE NULL, 
  INDEX (`PersoneelsID`), 
  INDEX (`Postcode`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'tblPersoneelsleden'
#

INSERT INTO `tblPersoneelsleden` (`PersoneelsID`, `Familienaam`, `Voornaam`, `StraatNummer`, `Postcode`, `Gemeente`, `Telefoon`, `gsm`, `e-mail`, `Geboortedatum`, `DatumIndiensttreding`, `InDienst`, `Rekeningnummer`, `Salaris`) VALUES (1054, 'Vandenabeele', 'Jos', 'Dapperstraat 16', '8490', 'Jabbeke', '95 89 83', '0497 66 35 13', 'JVandena', '1966-01-27 00:00:00', '2000-01-03 00:00:00', -1, '461-3192228-74', 1500);
INSERT INTO `tblPersoneelsleden` (`PersoneelsID`, `Familienaam`, `Voornaam`, `StraatNummer`, `Postcode`, `Gemeente`, `Telefoon`, `gsm`, `e-mail`, `Geboortedatum`, `DatumIndiensttreding`, `InDienst`, `Rekeningnummer`, `Salaris`) VALUES (1055, 'Vanacker', 'Veerle', 'Land van Belofte 26', '8000', 'Brugge', '28 52 34', '0497 36 36 86', 'VVanacke', '1969-07-02 00:00:00', '2000-01-03 00:00:00', -1, '750-9191371-03', 1500);
INSERT INTO `tblPersoneelsleden` (`PersoneelsID`, `Familienaam`, `Voornaam`, `StraatNummer`, `Postcode`, `Gemeente`, `Telefoon`, `gsm`, `e-mail`, `Geboortedatum`, `DatumIndiensttreding`, `InDienst`, `Rekeningnummer`, `Salaris`) VALUES (1056, 'Verlinde', 'Marc', 'H. Serruyslaan 66', '8400', 'Oostende', '97 08 23', '0497 49 71 96', 'MVerlind', '1975-12-08 00:00:00', '2002-02-20 00:00:00', -1, '000-0148026-04', 1500);
INSERT INTO `tblPersoneelsleden` (`PersoneelsID`, `Familienaam`, `Voornaam`, `StraatNummer`, `Postcode`, `Gemeente`, `Telefoon`, `gsm`, `e-mail`, `Geboortedatum`, `DatumIndiensttreding`, `InDienst`, `Rekeningnummer`, `Salaris`) VALUES (1057, 'Lievens', 'Ward', 'Noordstraat 23', '8320', 'Assebroek', '11 75 69', '0497 66 73 37', 'WLievens', '1980-05-29 00:00:00', '2001-03-21 00:00:00', 0, '000-0248104-75', 1500);
INSERT INTO `tblPersoneelsleden` (`PersoneelsID`, `Familienaam`, `Voornaam`, `StraatNummer`, `Postcode`, `Gemeente`, `Telefoon`, `gsm`, `e-mail`, `Geboortedatum`, `DatumIndiensttreding`, `InDienst`, `Rekeningnummer`, `Salaris`) VALUES (1058, 'Dedeurwaerder', 'Dirk', 'Zevende Hemel 7', '8730', 'Oedelem', '12 75 69', '0497 09 72 20', 'DDedeurw', '1983-02-20 00:00:00', '1999-02-14 00:00:00', -1, '290-0017901-74', 1500);
INSERT INTO `tblPersoneelsleden` (`PersoneelsID`, `Familienaam`, `Voornaam`, `StraatNummer`, `Postcode`, `Gemeente`, `Telefoon`, `gsm`, `e-mail`, `Geboortedatum`, `DatumIndiensttreding`, `InDienst`, `Rekeningnummer`, `Salaris`) VALUES (2012, 'Quaghebuur', 'Mieke', 'Langestraat 98', '9000', 'Gent', '06 46 98', '0496 78 45 12', 'MQuagheb', '1969-08-03 00:00:00', '2002-02-01 00:00:00', -1, '410-0393781-81', 1500);
INSERT INTO `tblPersoneelsleden` (`PersoneelsID`, `Familienaam`, `Voornaam`, `StraatNummer`, `Postcode`, `Gemeente`, `Telefoon`, `gsm`, `e-mail`, `Geboortedatum`, `DatumIndiensttreding`, `InDienst`, `Rekeningnummer`, `Salaris`) VALUES (2013, 'Dedecker', 'Eric', 'Zoeten Inval 144', '9000', 'Gent', '65 95 81', '0478 74 85 96', 'EDedecke', '1970-01-29 00:00:00', '2002-02-01 00:00:00', -1, '230-0993066-97', 1500);
INSERT INTO `tblPersoneelsleden` (`PersoneelsID`, `Familienaam`, `Voornaam`, `StraatNummer`, `Postcode`, `Gemeente`, `Telefoon`, `gsm`, `e-mail`, `Geboortedatum`, `DatumIndiensttreding`, `InDienst`, `Rekeningnummer`, `Salaris`) VALUES (2014, 'Lieckens', 'Roger', 'St-Hubertuslaan 41', '9000', 'Gent', '93 07 68', '0479 50 21 12', 'RLiecken', '1975-12-18 00:00:00', '2002-02-01 00:00:00', -1, '467-7128331-82', 1500);
INSERT INTO `tblPersoneelsleden` (`PersoneelsID`, `Familienaam`, `Voornaam`, `StraatNummer`, `Postcode`, `Gemeente`, `Telefoon`, `gsm`, `e-mail`, `Geboortedatum`, `DatumIndiensttreding`, `InDienst`, `Rekeningnummer`, `Salaris`) VALUES (2015, 'Delporte', 'Saartje', 'Vijfwegenstraat 164', '9000', 'Oostakker', '71 44 72', NULL, 'SDelport', '1960-05-09 00:00:00', '2002-02-01 00:00:00', 0, '210-0479160-32', 1500);
INSERT INTO `tblPersoneelsleden` (`PersoneelsID`, `Familienaam`, `Voornaam`, `StraatNummer`, `Postcode`, `Gemeente`, `Telefoon`, `gsm`, `e-mail`, `Geboortedatum`, `DatumIndiensttreding`, `InDienst`, `Rekeningnummer`, `Salaris`) VALUES (2016, 'Lievemans', 'Chris', 'Trapiestendreef 69', '9000', 'Langerbrugge', '03 88 68', '0476 45 67 89', 'CLievema', '1966-01-27 00:00:00', '2002-02-01 00:00:00', -1, '220-0760813-78', 1500);
INSERT INTO `tblPersoneelsleden` (`PersoneelsID`, `Familienaam`, `Voornaam`, `StraatNummer`, `Postcode`, `Gemeente`, `Telefoon`, `gsm`, `e-mail`, `Geboortedatum`, `DatumIndiensttreding`, `InDienst`, `Rekeningnummer`, `Salaris`) VALUES (2017, 'Lindemans', 'Klaas', 'Rue Les Miserables 2', '9000', 'Gent', '37 50 90', NULL, 'KLindema', '1975-02-19 00:00:00', '2002-02-01 00:00:00', -1, '306-7220088-00', 1500);
INSERT INTO `tblPersoneelsleden` (`PersoneelsID`, `Familienaam`, `Voornaam`, `StraatNummer`, `Postcode`, `Gemeente`, `Telefoon`, `gsm`, `e-mail`, `Geboortedatum`, `DatumIndiensttreding`, `InDienst`, `Rekeningnummer`, `Salaris`) VALUES (3088, 'Filliers', 'Dirk', 'De Keyserlei', '2000', 'Antwerpen', '19 51 24', NULL, 'DFillier', '1976-01-08 00:00:00', '1998-04-01 00:00:00', -1, '700-0040297-97', 1500);
INSERT INTO `tblPersoneelsleden` (`PersoneelsID`, `Familienaam`, `Voornaam`, `StraatNummer`, `Postcode`, `Gemeente`, `Telefoon`, `gsm`, `e-mail`, `Geboortedatum`, `DatumIndiensttreding`, `InDienst`, `Rekeningnummer`, `Salaris`) VALUES (3089, 'Moens', 'Johan', 'Statiestraat 7', '2950', 'Kapellen', '52 07 86', NULL, 'JMoens', '1979-09-06 00:00:00', '1998-04-01 00:00:00', -1, '001-0163542-77', 1500);
INSERT INTO `tblPersoneelsleden` (`PersoneelsID`, `Familienaam`, `Voornaam`, `StraatNummer`, `Postcode`, `Gemeente`, `Telefoon`, `gsm`, `e-mail`, `Geboortedatum`, `DatumIndiensttreding`, `InDienst`, `Rekeningnummer`, `Salaris`) VALUES (3090, 'Vanbergen', 'Jacqueline', 'Turnhoutsebaan 16', '2140', 'Borgerhout', '85 19 13', '0496 49 93 57', 'JVanberg', '1975-12-29 00:00:00', '1998-04-01 00:00:00', 0, '310-0273745-98', 1500);
INSERT INTO `tblPersoneelsleden` (`PersoneelsID`, `Familienaam`, `Voornaam`, `StraatNummer`, `Postcode`, `Gemeente`, `Telefoon`, `gsm`, `e-mail`, `Geboortedatum`, `DatumIndiensttreding`, `InDienst`, `Rekeningnummer`, `Salaris`) VALUES (3091, 'Vanmarcke', 'Inge', 'Turnhoutsebaan 194', '2110', 'Wijnegem', '85 34 27', '0478 44 38 89', 'IVanmarc', '1975-12-30 00:00:00', '1998-04-01 00:00:00', -1, '310-0273745-99', 1500);
INSERT INTO `tblPersoneelsleden` (`PersoneelsID`, `Familienaam`, `Voornaam`, `StraatNummer`, `Postcode`, `Gemeente`, `Telefoon`, `gsm`, `e-mail`, `Geboortedatum`, `DatumIndiensttreding`, `InDienst`, `Rekeningnummer`, `Salaris`) VALUES (3092, 'Versluys', 'Michel', 'Magdalenastraat 44', '2100', 'Deurne', '72 11 14', '0479 42 56 98', 'MVersluy', '1984-02-29 00:00:00', '1998-04-01 00:00:00', -1, '734-3014146-75', 1500);
INSERT INTO `tblPersoneelsleden` (`PersoneelsID`, `Familienaam`, `Voornaam`, `StraatNummer`, `Postcode`, `Gemeente`, `Telefoon`, `gsm`, `e-mail`, `Geboortedatum`, `DatumIndiensttreding`, `InDienst`, `Rekeningnummer`, `Salaris`) VALUES (4001, 'Debruyne', 'Luc', 'Thonissenlaan 47', '3500', 'Hasselt', '35 60 07', '0478 14 21 32', 'LDebruyn', '1976-01-01 00:00:00', '2000-04-05 00:00:00', -1, '700-0040297-90', 1500);
INSERT INTO `tblPersoneelsleden` (`PersoneelsID`, `Familienaam`, `Voornaam`, `StraatNummer`, `Postcode`, `Gemeente`, `Telefoon`, `gsm`, `e-mail`, `Geboortedatum`, `DatumIndiensttreding`, `InDienst`, `Rekeningnummer`, `Salaris`) VALUES (4002, 'Coudeville', 'Silvain', 'Lanceloot Blondeellaan 21', '3920', 'Lommel', '55 59 19', '0479 46 52 59', 'SCoudevi', '1976-01-02 00:00:00', '2003-12-11 00:00:00', -1, '700-0040297-91', 1500);
INSERT INTO `tblPersoneelsleden` (`PersoneelsID`, `Familienaam`, `Voornaam`, `StraatNummer`, `Postcode`, `Gemeente`, `Telefoon`, `gsm`, `e-mail`, `Geboortedatum`, `DatumIndiensttreding`, `InDienst`, `Rekeningnummer`, `Salaris`) VALUES (4003, 'Govaert', 'Jan', 'Gildestraat 4', '3680', 'Maaseik', '88 76 85', '0477 11 34 95', 'JGovaert', '1969-06-28 00:00:00', '1999-08-04 00:00:00', 0, '410-0393781-84', 1500);
INSERT INTO `tblPersoneelsleden` (`PersoneelsID`, `Familienaam`, `Voornaam`, `StraatNummer`, `Postcode`, `Gemeente`, `Telefoon`, `gsm`, `e-mail`, `Geboortedatum`, `DatumIndiensttreding`, `InDienst`, `Rekeningnummer`, `Salaris`) VALUES (4004, 'Adriaens', 'Marc', 'Europalaan 23', '3630', 'Maasmechelen', '16 95 17', '0496 12 36 54', 'MAdriaen', '1976-01-03 00:00:00', '2000-06-05 00:00:00', -1, '700-0040297-92', 1500);
INSERT INTO `tblPersoneelsleden` (`PersoneelsID`, `Familienaam`, `Voornaam`, `StraatNummer`, `Postcode`, `Gemeente`, `Telefoon`, `gsm`, `e-mail`, `Geboortedatum`, `DatumIndiensttreding`, `InDienst`, `Rekeningnummer`, `Salaris`) VALUES (4005, 'Dejonge', 'Koen', 'Ambiorixplein 55', '3700', 'Tongeren', '03 86 13', '0478 99 45 21', 'KDejonge', '1969-06-29 00:00:00', '2001-12-15 00:00:00', -1, '712-1001471-33', 1500);
INSERT INTO `tblPersoneelsleden` (`PersoneelsID`, `Familienaam`, `Voornaam`, `StraatNummer`, `Postcode`, `Gemeente`, `Telefoon`, `gsm`, `e-mail`, `Geboortedatum`, `DatumIndiensttreding`, `InDienst`, `Rekeningnummer`, `Salaris`) VALUES (4006, 'Walgraeve', 'Tinneke', 'De Merodedreef 123', '3700', 'Tongeren', '43 01 84', '0479 12 59 41', 'TWalgrae', '1969-06-30 00:00:00', '2003-07-23 00:00:00', -1, '410-0393781-85', 1500);
INSERT INTO `tblPersoneelsleden` (`PersoneelsID`, `Familienaam`, `Voornaam`, `StraatNummer`, `Postcode`, `Gemeente`, `Telefoon`, `gsm`, `e-mail`, `Geboortedatum`, `DatumIndiensttreding`, `InDienst`, `Rekeningnummer`, `Salaris`) VALUES (4007, 'Aerts', 'Pascale', 'Molenvest 66', '3700', 'Tongeren', '04 43 17', '0477 77 35 46', 'PAerts', '1976-01-04 00:00:00', '2000-06-23 00:00:00', -1, '700-0040297-93', 1500);
INSERT INTO `tblPersoneelsleden` (`PersoneelsID`, `Familienaam`, `Voornaam`, `StraatNummer`, `Postcode`, `Gemeente`, `Telefoon`, `gsm`, `e-mail`, `Geboortedatum`, `DatumIndiensttreding`, `InDienst`, `Rekeningnummer`, `Salaris`) VALUES (5045, 'Geuzemans', 'Lambiek', 'Stationsstraat 2', '3150', 'Haacht', '97 32 72', '0477 16 04 51', 'LGeuzema', '1969-08-13 00:00:00', '1998-08-08 00:00:00', 0, '210-0303869-20', 1500);
INSERT INTO `tblPersoneelsleden` (`PersoneelsID`, `Familienaam`, `Voornaam`, `StraatNummer`, `Postcode`, `Gemeente`, `Telefoon`, `gsm`, `e-mail`, `Geboortedatum`, `DatumIndiensttreding`, `InDienst`, `Rekeningnummer`, `Salaris`) VALUES (5046, 'Roels', 'Hilde', 'L. Melsenstraat 20', '3000', 'Leuven', '47 97 30', '0477 00 52 28', 'HRoels', '1975-12-18 00:00:00', '2002-10-14 00:00:00', -1, '235-0110413-39', 1500);
INSERT INTO `tblPersoneelsleden` (`PersoneelsID`, `Familienaam`, `Voornaam`, `StraatNummer`, `Postcode`, `Gemeente`, `Telefoon`, `gsm`, `e-mail`, `Geboortedatum`, `DatumIndiensttreding`, `InDienst`, `Rekeningnummer`, `Salaris`) VALUES (5047, 'Vandaele', 'Martine', 'Leuvensestraat 8', '3300', 'Tienen', '63 60 20', '0477 55 67 35', 'MVandael', '1970-01-29 00:00:00', '2001-09-06 00:00:00', -1, '335-0025310-39', 1500);
INSERT INTO `tblPersoneelsleden` (`PersoneelsID`, `Familienaam`, `Voornaam`, `StraatNummer`, `Postcode`, `Gemeente`, `Telefoon`, `gsm`, `e-mail`, `Geboortedatum`, `DatumIndiensttreding`, `InDienst`, `Rekeningnummer`, `Salaris`) VALUES (5048, 'Acke', 'Jan', 'Sint-Maartensstraat', '3000', 'Leuven', '90 43 07', '0477 56 47 58', 'JAcke', '1975-12-28 00:00:00', '2003-09-12 00:00:00', -1, '310-0273745-97', 1500);
# 27 records

#
# Table structure for table 'tblReis'
#

DROP TABLE IF EXISTS `tblReis`;

CREATE TABLE `tblReis` (
  `ReisID` INTEGER NOT NULL DEFAULT 0, 
  `Bestemmingcode` VARCHAR(5) NOT NULL, 
  `Vertrekdatum` DATETIME NOT NULL, 
  `AantalDagen` TINYINT(3) UNSIGNED NOT NULL, 
  `PrijsPerPersoon` DECIMAL(19,4) NOT NULL, 
  INDEX (`Bestemmingcode`), 
  INDEX (`ReisID`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'tblReis'
#

INSERT INTO `tblReis` (`ReisID`, `Bestemmingcode`, `Vertrekdatum`, `AantalDagen`, `PrijsPerPersoon`) VALUES (92367, 'SANPA', '2015-05-11 00:00:00', 14, 2300);
INSERT INTO `tblReis` (`ReisID`, `Bestemmingcode`, `Vertrekdatum`, `AantalDagen`, `PrijsPerPersoon`) VALUES (94368, 'SANFR', '2015-07-16 00:00:00', 14, 3200);
INSERT INTO `tblReis` (`ReisID`, `Bestemmingcode`, `Vertrekdatum`, `AantalDagen`, `PrijsPerPersoon`) VALUES (92369, 'BALI', '2015-05-16 00:00:00', 21, 4300);
INSERT INTO `tblReis` (`ReisID`, `Bestemmingcode`, `Vertrekdatum`, `AantalDagen`, `PrijsPerPersoon`) VALUES (98370, 'CORSI', '2015-05-18 00:00:00', 23, 1600);
INSERT INTO `tblReis` (`ReisID`, `Bestemmingcode`, `Vertrekdatum`, `AantalDagen`, `PrijsPerPersoon`) VALUES (96373, 'CORDO', '2015-05-19 00:00:00', 21, 5300);
INSERT INTO `tblReis` (`ReisID`, `Bestemmingcode`, `Vertrekdatum`, `AantalDagen`, `PrijsPerPersoon`) VALUES (98375, 'MADRI', '2015-05-19 00:00:00', 10, 1400);
INSERT INTO `tblReis` (`ReisID`, `Bestemmingcode`, `Vertrekdatum`, `AantalDagen`, `PrijsPerPersoon`) VALUES (92376, 'SANPA', '2015-05-21 00:00:00', 23, 4900);
INSERT INTO `tblReis` (`ReisID`, `Bestemmingcode`, `Vertrekdatum`, `AantalDagen`, `PrijsPerPersoon`) VALUES (90377, 'RABAT', '2015-05-23 00:00:00', 12, 2770);
INSERT INTO `tblReis` (`ReisID`, `Bestemmingcode`, `Vertrekdatum`, `AantalDagen`, `PrijsPerPersoon`) VALUES (90378, 'TANGE', '2015-06-23 00:00:00', 23, 3650);
INSERT INTO `tblReis` (`ReisID`, `Bestemmingcode`, `Vertrekdatum`, `AantalDagen`, `PrijsPerPersoon`) VALUES (94379, 'VERAC', '2015-05-23 00:00:00', 14, 4900);
INSERT INTO `tblReis` (`ReisID`, `Bestemmingcode`, `Vertrekdatum`, `AantalDagen`, `PrijsPerPersoon`) VALUES (92380, 'MEDAN', '2015-05-26 00:00:00', 19, 5320);
INSERT INTO `tblReis` (`ReisID`, `Bestemmingcode`, `Vertrekdatum`, `AantalDagen`, `PrijsPerPersoon`) VALUES (90385, 'TANGE', '2015-05-29 00:00:00', 14, 2795);
INSERT INTO `tblReis` (`ReisID`, `Bestemmingcode`, `Vertrekdatum`, `AantalDagen`, `PrijsPerPersoon`) VALUES (98386, 'GRANC', '2015-05-02 00:00:00', 10, 1300);
INSERT INTO `tblReis` (`ReisID`, `Bestemmingcode`, `Vertrekdatum`, `AantalDagen`, `PrijsPerPersoon`) VALUES (98387, 'ISTAN', '2015-05-03 00:00:00', 14, 2773);
INSERT INTO `tblReis` (`ReisID`, `Bestemmingcode`, `Vertrekdatum`, `AantalDagen`, `PrijsPerPersoon`) VALUES (98388, 'HELSI', '2015-05-03 00:00:00', 12, 2399);
INSERT INTO `tblReis` (`ReisID`, `Bestemmingcode`, `Vertrekdatum`, `AantalDagen`, `PrijsPerPersoon`) VALUES (94389, 'MIAMI', '2015-06-04 00:00:00', 23, 5890);
INSERT INTO `tblReis` (`ReisID`, `Bestemmingcode`, `Vertrekdatum`, `AantalDagen`, `PrijsPerPersoon`) VALUES (90390, 'RABAT', '2015-05-04 00:00:00', 14, 2950);
INSERT INTO `tblReis` (`ReisID`, `Bestemmingcode`, `Vertrekdatum`, `AantalDagen`, `PrijsPerPersoon`) VALUES (90391, 'RABAT', '2015-05-04 00:00:00', 21, 3590);
INSERT INTO `tblReis` (`ReisID`, `Bestemmingcode`, `Vertrekdatum`, `AantalDagen`, `PrijsPerPersoon`) VALUES (98392, 'GITES', '2015-05-09 00:00:00', 14, 3200);
INSERT INTO `tblReis` (`ReisID`, `Bestemmingcode`, `Vertrekdatum`, `AantalDagen`, `PrijsPerPersoon`) VALUES (96395, 'LIMA', '2015-05-09 00:00:00', 28, 6790);
INSERT INTO `tblReis` (`ReisID`, `Bestemmingcode`, `Vertrekdatum`, `AantalDagen`, `PrijsPerPersoon`) VALUES (92396, 'BANGK', '2015-05-09 00:00:00', 22, 5395);
INSERT INTO `tblReis` (`ReisID`, `Bestemmingcode`, `Vertrekdatum`, `AantalDagen`, `PrijsPerPersoon`) VALUES (92398, 'SURUB', '2015-05-11 00:00:00', 28, 6666);
INSERT INTO `tblReis` (`ReisID`, `Bestemmingcode`, `Vertrekdatum`, `AantalDagen`, `PrijsPerPersoon`) VALUES (90399, 'CAIRO', '2015-05-11 00:00:00', 8, 1468);
INSERT INTO `tblReis` (`ReisID`, `Bestemmingcode`, `Vertrekdatum`, `AantalDagen`, `PrijsPerPersoon`) VALUES (98400, 'BARCE', '2015-05-11 00:00:00', 9, 1240);
INSERT INTO `tblReis` (`ReisID`, `Bestemmingcode`, `Vertrekdatum`, `AantalDagen`, `PrijsPerPersoon`) VALUES (98401, 'DUSSD', '2015-05-12 00:00:00', 4, 840);
INSERT INTO `tblReis` (`ReisID`, `Bestemmingcode`, `Vertrekdatum`, `AantalDagen`, `PrijsPerPersoon`) VALUES (98402, 'MOIRA', '2015-05-12 00:00:00', 20, 1630);
INSERT INTO `tblReis` (`ReisID`, `Bestemmingcode`, `Vertrekdatum`, `AantalDagen`, `PrijsPerPersoon`) VALUES (94403, 'MIAMI', '2015-05-14 00:00:00', 21, 5300);
INSERT INTO `tblReis` (`ReisID`, `Bestemmingcode`, `Vertrekdatum`, `AantalDagen`, `PrijsPerPersoon`) VALUES (98404, 'CORSI', '2015-05-14 00:00:00', 10, 2400);
INSERT INTO `tblReis` (`ReisID`, `Bestemmingcode`, `Vertrekdatum`, `AantalDagen`, `PrijsPerPersoon`) VALUES (95405, 'HAVA', '2015-05-31 00:00:00', 14, 1800);
# 29 records

