DROP DATABASE IF EXISTS `schoolinfo_neu`;
CREATE DATABASE IF NOT EXISTS `schoolinfo_neu`
  DEFAULT CHARACTER SET latin1;
USE `schoolinfo_neu`;
SET SESSION SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";

--
-- Table structure for table `klasse`
--

DROP TABLE IF EXISTS `klasse`;

CREATE TABLE `klasse` (
  `id`           INT(10) NOT NULL,
  `lehrer_id`    INT(10)                 DEFAULT NULL,
  `name`         VARCHAR(45)
                 COLLATE utf8_unicode_ci DEFAULT NULL,
  `beschreibung` VARCHAR(255)
                 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;

--
-- Dumping data for table `klasse`
--

LOCK TABLES `klasse` WRITE;
ALTER TABLE `klasse` DISABLE KEYS;
INSERT INTO `klasse` (`id`, `lehrer_id`, `name`, `beschreibung`)
  SELECT
    `idklasse`      AS `id`,
    `klassenlehrer` AS `lehrer_id`,
    `name`          AS `name`,
    `realname`      AS `beschreibung`
  FROM `schoolinfo12802016`.`klasse`;


ALTER TABLE `klasse` ENABLE KEYS;
UNLOCK TABLES;

--
-- Table structure for table `lehrbetriebe`
--

DROP TABLE IF EXISTS `lehrbetrieb`;
CREATE TABLE `lehrbetrieb` (
  `id`           INTEGER(10) NOT NULL,
  `name`         VARCHAR(45)
                 COLLATE utf8_unicode_ci DEFAULT NULL,
  `strasse`      VARCHAR(45)
                 COLLATE utf8_unicode_ci DEFAULT NULL,
  `hausnummer`   VARCHAR(6)
                 COLLATE utf8_unicode_ci DEFAULT NULL,
  `postleitzahl` VARCHAR(6)
                 COLLATE utf8_unicode_ci DEFAULT NULL,
  `ort`          VARCHAR(45)
                 COLLATE utf8_unicode_ci DEFAULT NULL,
  `kanton_code`  VARCHAR(2)
                 COLLATE utf8_unicode_ci DEFAULT NULL,
  `land_code`    VARCHAR(2)
                 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;
--
-- Dumping data for table `lehrbetriebe`
--

LOCK TABLES `lehrbetrieb` WRITE;
ALTER TABLE `lehrbetrieb` DISABLE KEYS;
INSERT INTO `lehrbetrieb` (
  `id`, `name`, `strasse`, `hausnummer`, `postleitzahl`, `ort`, `kanton_code`, `land_code`
)
  SELECT
    `id_Lehrbetrieb` AS `id`,
    `FName`          AS `name`,
    `FStrasse`       AS `strasse`,
    `FHausNr`        AS `hausnummer`,
    `FPlz`           AS `postleitzahl`,
    `FOrt`           AS `ort`,
    `FKanton`        AS `kanton_code`,
    `FLand`          AS `land_code`

  FROM `schoolinfo12802016`.`lehrbetriebe`;

ALTER TABLE `lehrbetrieb` ENABLE KEYS;
UNLOCK TABLES;

--
-- Table structure for table `lernende`
--

DROP TABLE IF EXISTS `lernende`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lernende` (
  `Lern_id`     INT(10)    NOT NULL,
  `anrede`      VARCHAR(50)
                COLLATE utf8_unicode_ci DEFAULT NULL,
  `name`        VARCHAR(51)
                COLLATE utf8_unicode_ci DEFAULT NULL,
  `vorname`     VARCHAR(50)
                COLLATE utf8_unicode_ci DEFAULT NULL,
  `geschlecht`  VARCHAR(50)
                COLLATE utf8_unicode_ci DEFAULT NULL,
  `klasse`      INT(10)                 DEFAULT NULL,
  `bm`          TINYINT(1) NOT NULL,
  `richtung`    INT(10)                 DEFAULT NULL,
  `lehrbetrieb` INT(10)                 DEFAULT NULL,
  `strasse`     VARCHAR(50)
                COLLATE utf8_unicode_ci DEFAULT NULL,
  `plz`         VARCHAR(50)
                COLLATE utf8_unicode_ci DEFAULT NULL,
  `ort`         VARCHAR(50)
                COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`Lern_id`),
  KEY `Lern_id` (`Lern_id`),
  KEY `vorname` (`vorname`),
  KEY `name` (`name`) USING BTREE
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lernende`
--

LOCK TABLES `lernende` WRITE;
/*!40000 ALTER TABLE `lernende` DISABLE KEYS */;
INSERT INTO `lernende`;
/*!40000 ALTER TABLE `lernende` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_berechtigung`
--

DROP TABLE IF EXISTS `log_berechtigung`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_berechtigung` (
  `id`           INT(11)                   NOT NULL AUTO_INCREMENT,
  `benutzer`     VARCHAR(150)              NOT NULL,
  `timestamp`    DATETIME                  NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `wofuer`       VARCHAR(80)               NOT NULL,
  `typ`          ENUM('db', 'tab', 'attr') NOT NULL,
  `berechtigung` VARCHAR(100)              NOT NULL,
  `fuer`         VARCHAR(80)               NOT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = latin1;
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
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modul` (
  `idmodul`   INT(10) NOT NULL,
  `m_name`    VARCHAR(30)
              COLLATE utf8_unicode_ci DEFAULT NULL,
  `modulname` VARCHAR(100)
              COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`idmodul`),
  KEY `index2` (`m_name`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modul`
--

LOCK TABLES `modul` WRITE;
/*!40000 ALTER TABLE `modul` DISABLE KEYS */;
INSERT INTO `modul`;
/*!40000 ALTER TABLE `modul` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `noten`
--

DROP TABLE IF EXISTS `noten`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `noten` (
  `lernende_idlernende` INT(10)       DEFAULT NULL,
  `module_idmodule`     INT(10)       DEFAULT NULL,
  `erfahrungsnote`      DOUBLE(15, 5) DEFAULT NULL,
  `knw_note`            DOUBLE(15, 5) DEFAULT NULL,
  `dat_erfa`            DATETIME      DEFAULT NULL,
  `dat_knw`             DATETIME      DEFAULT NULL,
  KEY `lernende_idlernende` (`lernende_idlernende`, `knw_note`, `erfahrungsnote`, `module_idmodule`) USING BTREE
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `noten`
--

LOCK TABLES `noten` WRITE;
/*!40000 ALTER TABLE `noten` DISABLE KEYS */;
INSERT INTO `noten`;
INSERT INTO `noten`;
/*!40000 ALTER TABLE `noten` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `richtung`
--

DROP TABLE IF EXISTS `richtung`;
/*!40101 SET @saved_cs_client = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `richtung` (
  `idrichtung` INT(10)                 DEFAULT NULL,
  `richtung`   VARCHAR(30)
               COLLATE utf8_unicode_ci DEFAULT NULL,
  KEY `richtungrichtung` (`richtung`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `richtung`
--

LOCK TABLES `richtung` WRITE;
/*!40000 ALTER TABLE `richtung` DISABLE KEYS */;
INSERT INTO `richtung` VALUES (1, 'Applikationsentwicklung'), (2, 'Systemtechnik'), (3, 'Generalistische Ausrichtung'),
  (4, 'Betriebsinformatik');
/*!40000 ALTER TABLE `richtung` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE = @OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE = @OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT = @OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS = @OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION = @OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES = @OLD_SQL_NOTES */;

-- Dump completed on 2016-05-10 14:56:13
