CREATE DATABASE  IF NOT EXISTS `schoolinfo1282016` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `schoolinfo1282016`;
-- MySQL dump 10.13  Distrib 5.6.28, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: schoolinfo1282016
-- ------------------------------------------------------
-- Server version	5.6.28-0ubuntu0.15.10.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `klasse`
--

DROP TABLE IF EXISTS `klasse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `klasse` (
  `idklasse` int(10) NOT NULL,
  `name` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `klassenlehrer` int(10) DEFAULT NULL,
  `realname` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`idklasse`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `klasse`
--

LOCK TABLES `klasse` WRITE;
/*!40000 ALTER TABLE `klasse` DISABLE KEYS */;
INSERT INTO `klasse` ;
/*!40000 ALTER TABLE `klasse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lehrbetriebe`
--

DROP TABLE IF EXISTS `lehrbetriebe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lehrbetriebe` (
  `id_Lehrbetrieb` double(15,5) NOT NULL,
  `FName` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FStrasse` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FHausNr` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FPlz` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FOrt` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FKanton` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `FLand` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_Lehrbetrieb`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lehrbetriebe`
--

LOCK TABLES `lehrbetriebe` WRITE;
/*!40000 ALTER TABLE `lehrbetriebe` DISABLE KEYS */;
INSERT INTO `lehrbetriebe` ;
/*!40000 ALTER TABLE `lehrbetriebe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lernende`
--

DROP TABLE IF EXISTS `lernende`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lernende` (
  `Lern_id` int(10) NOT NULL,
  `anrede` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(51) COLLATE utf8_unicode_ci DEFAULT NULL,
  `vorname` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `geschlecht` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `klasse` int(10) DEFAULT NULL,
  `bm` tinyint(1) NOT NULL,
  `richtung` int(10) DEFAULT NULL,
  `lehrbetrieb` int(10) DEFAULT NULL,
  `strasse` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `plz` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ort` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Lern_id`),
  KEY `Lern_id` (`Lern_id`),
  KEY `vorname` (`vorname`),
  KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lernende`
--

LOCK TABLES `lernende` WRITE;
/*!40000 ALTER TABLE `lernende` DISABLE KEYS */;
INSERT INTO `lernende` ;
/*!40000 ALTER TABLE `lernende` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_berechtigung`
--

DROP TABLE IF EXISTS `log_berechtigung`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_berechtigung` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `benutzer` varchar(150) NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `wofuer` varchar(80) NOT NULL,
  `typ` enum('db','tab','attr') NOT NULL,
  `berechtigung` varchar(100) NOT NULL,
  `fuer` varchar(80) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_berechtigung`
--

LOCK TABLES `log_berechtigung` WRITE;
/*!40000 ALTER TABLE `log_berechtigung` DISABLE KEYS */;
/*!40000 ALTER TABLE `log_berechtigung` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modul`
--

DROP TABLE IF EXISTS `modul`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modul` (
  `idmodul` int(10) NOT NULL,
  `m_name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `modulname` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`idmodul`),
  KEY `index2` (`m_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modul`
--

LOCK TABLES `modul` WRITE;
/*!40000 ALTER TABLE `modul` DISABLE KEYS */;
INSERT INTO `modul` VALUES (1,'103','Strukturiert programmieren nach Vorgabe'),(2,'101','Webauftritt erstellen und veröffentlichen'),(3,'301','Office Werkzeuge anwenden'),(4,'316','Spannung und Strom messen und interpretieren'),(5,'Mathe I','Mathematik'),(6,'Physik I','Physik'),(7,'214','Benutzer/innen im Umgang mit Informatikmitteln instruieren'),(8,'120','Benutzerschnittstellen implementieren'),(9,'318','Analysieren und objektbasiert programmieren'),(10,'104','Datenmodell implementieren'),(11,'122','Abläufe mit Scrips / Makros automatisieren'),(12,'129','LAN-Komponenten in Betrieb nehmen'),(13,'306','IT Kleinprojekt abwickeln'),(14,'133','Web-Applikation realisieren'),(15,'223','Multiuser-Applikation objektorientiert realisieren'),(16,'151','Datenbanken in Webauftritt einbinden'),(17,'145','Netzwerk betreiben und erweitern'),(18,'307','Interaktive Webseite erstellen'),(19,'141','Datenbanksysteme in Betrieb nehmen'),(20,'Chemie','Chemie'),(21,'BWL I','Betriebswirtschafliche Grundlagen'),(22,'BWL III','Betriebswirtschafliche Grundlagen'),(23,'153','Datenmodelle entwickeln'),(24,'Mathe II','Mathematik'),(25,'Physik II','Physik'),(26,'Physik III','Physik'),(27,'242','Mikroprozessoranwendung realisieren'),(28,'Englisch V','Englisch'),(29,'Turnen',NULL),(30,'Mathe III','Mathematik'),(31,'Englisch I','Englisch'),(32,'Englisch III','Englisch'),(33,'ABU',NULL),(34,'Turnen',NULL),(35,'BM',NULL),(36,'239','Internetserver in Betrieb nehmen'),(37,'BWL II','Betriebswirtschafliche Grundlagen'),(38,'Physik IV','Physik'),(39,'Physik V','Physik'),(40,'Physik VI','Physik'),(41,'Englisch II','Englisch'),(42,'Englisch IV','Englisch'),(43,'Englisch VI','Englisch'),(44,'100','Daten charakterisieren, aufbereiten und auswerten'),(45,'105','Datenbanken mit SQL bearbeiten'),(46,'114','Codierungs-, Kompressions- und Verschlüsselungsverfahren einsetzen'),(47,'121','Steuerungsaufgaben bearbeiten'),(48,'127','Server betreiben'),(49,'128','Datenbanken admin'),(50,'139','Anwenderschulung planen und durchführen'),(51,'143','Backup- und Restore-Systeme implementieren'),(52,'146','Internetanbindung für ein Unternehmen realisieren'),(53,'150','E-Business-Applikationen anpassen'),(54,'152','Multimedia-Inhalte in Webauftritt integrieren'),(55,'156','Neue Services entwickeln und implementieren'),(56,'159','Directoryservices konfigurieren und in Betrieb nehmen'),(57,'212','Lern- und Arbeitstechniken einsetzen'),(58,'226','Objektorientiert implementieren'),(59,'254','Geschäftsprozesse beschreiben'),(60,'302','Fort. Funktionen von Office Werkzeugen nutzen'),(61,'304','Personalcomputer in Betrieb nehmen'),(62,'108','Elektronisches Gerät aufbauen'),(63,'305','Multiusersysteme inst., konfigurieren und administrieren'),(64,'117','Inf.- und Netzinfrastruktur für kleines Unternehmen real.'),(65,'131','Arbeitspaket aus einem IT-Projekt realisieren'),(66,'326','Objektorientiert entwerfen und implementieren'),(67,'154','Applikation für Produktion vorbereiten'),(68,'123','Serverdienste in Betrieb nehmen'),(69,'126','Peripheriegeräte im Netzwerkbetrieb einsetzen'),(70,'130','LAN ausmessen und prüfen'),(71,'Mathe IV','Mathematik'),(72,'Mathe V','Mathematik'),(73,'431','Aufträge im IT-Umfeld selbstständig durchführen'),(74,'403','Strukturiert programmieren nach Vorgabe'),(75,'Chemie I','Chemie I'),(76,'404','Objektbasiert programmieren nach Vorgabe'),(77,'Mathe VI','Mathe VI'),(78,'340','IT Infrastruktur virtualisieren'),(79,'Mathe VII','Mathe VII'),(80,'300','Plattformübergreifende Dienste in ein Netzwerk integrieren');
/*!40000 ALTER TABLE `modul` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `noten`
--

DROP TABLE IF EXISTS `noten`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `noten` (
  `lernende_idlernende` int(10) DEFAULT NULL,
  `module_idmodule` int(10) DEFAULT NULL,
  `erfahrungsnote` double(15,5) DEFAULT NULL,
  `knw_note` double(15,5) DEFAULT NULL,
  `dat_erfa` datetime DEFAULT NULL,
  `dat_knw` datetime DEFAULT NULL,
  KEY `lernende_idlernende` (`lernende_idlernende`,`knw_note`,`erfahrungsnote`,`module_idmodule`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `noten`
--

LOCK TABLES `noten` WRITE;
/*!40000 ALTER TABLE `noten` DISABLE KEYS */;
INSERT INTO `noten` ;
INSERT INTO `noten` ;
/*!40000 ALTER TABLE `noten` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `richtung`
--

DROP TABLE IF EXISTS `richtung`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `richtung` (
  `idrichtung` int(10) DEFAULT NULL,
  `richtung` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  KEY `richtungrichtung` (`richtung`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `richtung`
--

LOCK TABLES `richtung` WRITE;
/*!40000 ALTER TABLE `richtung` DISABLE KEYS */;
INSERT INTO `richtung` VALUES (1,'Applikationsentwicklung'),(2,'Systemtechnik'),(3,'Generalistische Ausrichtung'),(4,'Betriebsinformatik');
/*!40000 ALTER TABLE `richtung` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-04-19 16:08:13
