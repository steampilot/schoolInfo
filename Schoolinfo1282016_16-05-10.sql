DROP DATABASE IF EXISTS `schoolinfo_neu`;
CREATE DATABASE IF NOT EXISTS `schoolinfo_neu`
  DEFAULT CHARACTER SET latin1;
USE `schoolinfo_neu`;
SET SESSION SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";

--
-- Table structure for table `klasse`
--
START TRANSACTION;
DROP TABLE IF EXISTS `klasse`;
CREATE TABLE `klasse` (
  `id`           INT(10) NOT NULL        AUTO_INCREMENT,
  `lehrer_id`    INT(10)                 DEFAULT NULL,
  `name`         VARCHAR(50)
                                         DEFAULT NULL,
  `beschreibung` VARCHAR(255)
                                         DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;
SELECT "Table klasse has been created";
COMMIT;

--
-- Insert data for table `klasse`
--
START TRANSACTION;
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
SELECT "Data fo klasse has been imported";
COMMIT;

--
-- Table structure for table `lehrbetriebe`
--
START TRANSACTION;
DROP TABLE IF EXISTS `lehrbetriebe`;
CREATE TABLE `lehrbetriebe` (
  `id`          INT(10) NOT NULL        AUTO_INCREMENT,
  `name`        VARCHAR(45)             DEFAULT NULL,
  `strasse`     VARCHAR(45)             DEFAULT NULL,
  `haus_nr`     VARCHAR(6)              DEFAULT NULL,
  `plz`         VARCHAR(6)              DEFAULT NULL,
  `ort`         VARCHAR(45)             DEFAULT NULL,
  `kanton_code` VARCHAR(2)              DEFAULT NULL,
  `land_code`   VARCHAR(2)              DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;
SELECT "Table lehrbetriebe has been created";
COMMIT;
--
-- Insert data for table `lehrbetriebe`
--
START TRANSACTION;
LOCK TABLES `lehrbetriebe` WRITE;
ALTER TABLE `lehrbetriebe` DISABLE KEYS;
INSERT INTO `lehrbetriebe` (
  `id`, `name`, `strasse`, `haus_nr`, `plz`, `ort`, `kanton_code`, `land_code`
)
  SELECT
    `id_Lehrbetrieb` AS `id`,
    `FName`          AS `name`,
    `FStrasse`       AS `strasse`,
    `FHausNr`        AS `haus_nr`,
    `FPlz`           AS `plz`,
    `FOrt`           AS `ort`,
    `FKanton`        AS `kanton_code`,
    `FLand`          AS `land_code`

  FROM `schoolinfo12802016`.`lehrbetriebe`;

ALTER TABLE `lehrbetriebe` ENABLE KEYS;
UNLOCK TABLES;
SELECT "Data for lehrbetriebe has been imported";
COMMIT;

--
-- Table structure for table `lernende`
--
START TRANSACTION;
DROP TABLE IF EXISTS `lernende`;
CREATE TABLE `lernende` (
  `id`              INT(10)    NOT NULL        AUTO_INCREMENT,
  `anrede`          VARCHAR(25)                DEFAULT NULL,
  `name`            VARCHAR(50)                DEFAULT NULL,
  `vorname`         VARCHAR(50)                DEFAULT NULL,
  `geschlecht`      VARCHAR(50)                DEFAULT NULL,
  `klasse_id`       INT(10)                    DEFAULT NULL,
  `ist_bm`          TINYINT(1) NOT NULL,
  `fachrichtung_id` INT(10)                    DEFAULT NULL,
  `lehrbetrieb_id`  INT(10)                    DEFAULT NULL,
  `strasse`         VARCHAR(50)                DEFAULT NULL,
  `plz`             VARCHAR(50)                DEFAULT NULL,
  `ort`             VARCHAR(50)                DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;
SELECT "Table lernende has been created";
COMMIT;

--
-- Dumping data for table `lernende`
--
START TRANSACTION;
LOCK TABLES `lernende` WRITE;
ALTER TABLE `lernende` DISABLE KEYS;
INSERT INTO `lernende` (
  `id`, `anrede`, `name`, `vorname`,
  `geschlecht`, `klasse_id`, `ist_bm`,
  `fachrichtung_id`, `lehrbetrieb_id`,
  `strasse`, `plz`, `ort`
)
  SELECT
    `Lern_id`     AS `id`,
    `anrede`      AS `anrede`,
    `name`        AS `name`,
    `vorname`     AS `vorname`,
    `geschlecht`  AS `geschlecht`,
    `klasse`      AS `klasse_id`,
    `bm`          AS `ist_bm`,
    `richtung`    AS `fachrichtung_id`,
    `lehrbetrieb` AS `lehrbetrieb_id`,
    `strasse`     AS `strasse`,
    `plz`         AS `plz`,
    `ort`         AS `ort`
  FROM `schoolinfo12802016`.`lernende`;

ALTER TABLE `lernende` ENABLE KEYS;
UNLOCK TABLES;
SELECT "Data for lernende has been imported";
COMMIT;

--
-- Table structure for table `berechtigung_log`
--
START TRANSACTION;
DROP TABLE IF EXISTS `berechtigung_log`;
CREATE TABLE `berechtigung_log` (
  `id`           INT(10)                    NOT NULL AUTO_INCREMENT,
  `benutzer`     VARCHAR(50)                NOT NULL,
  `zeitpunkt`    DATETIME                   NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `grund`        VARCHAR(50)                NOT NULL,
  `typ`          ENUM ('db', 'tab', 'attr') NOT NULL,
  `berechtigung` VARCHAR(50)                NOT NULL,
  `tabelle` VARCHAR(255)                    NOT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = latin1;
SELECT "Table berechtigung_log has been created";
COMMIT;

--
-- Insert data for table `berechtigung_log`
--
START TRANSACTION;
LOCK TABLES `berechtigung_log` WRITE;
ALTER TABLE `berechtigung_log` DISABLE KEYS;
INSERT INTO `berechtigung_log` (
  `id`, `benutzer`, `zeitpunkt`, `grund`, `typ`, `berechtigung`, `tabelle`)
  SELECT
    `id`           AS `id`,
    `benutzer`     AS `benutzer`,
    `timestamp`    AS `zeitpunkt`,
    `wofuer`       AS `grund`,
    `typ`          AS `typ`,
    `berechtigung` AS `berechtigung`,
    `fuer`         AS `tabelle`
  FROM `schoolinfo12802016`.`log_berechtigung`;
ALTER TABLE `berechtigung_log` ENABLE KEYS;
UNLOCK TABLES;
SELECT "Data for berechtigung_log has been imported";
COMMIT;

--
-- Table structure for table `modul`
--
START TRANSACTION;
DROP TABLE IF EXISTS `ict-module`;
CREATE TABLE `ict-module` (
  `id`           INT(10) NOT NULL        AUTO_INCREMENT,
  `name`         VARCHAR(50)             DEFAULT NULL,
  `beschreibung` VARCHAR(255)            DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;
SELECT "Table ict-module has been created";
COMMIT;

--
-- Insert data for table `modul`
--
START TRANSACTION;
LOCK TABLES `ict-module` WRITE;
ALTER TABLE `ict-module` DISABLE KEYS;
INSERT INTO `ict-module` (
  `id`, `name`, `beschreibung`
)
  SELECT
    `id`        AS `id`,
    `m_name`    AS `name`,
    `modulname` AS `beschreibung`
  FROM `schoolinfo12802016`.`modul`;


ALTER TABLE `ict-module` ENABLE KEYS;
UNLOCK TABLES;
SELECT "Data for ict-module has been imported";
COMMIT;

--
-- Table structure for table `noten`
--
START TRANSACTION;
DROP TABLE IF EXISTS `noten`;
CREATE TABLE `noten` (
  `id`                   INT(10) NOT NULL AUTO_INCREMENT,
  `lernende_id`          INT(10)          DEFAULT NULL,
  `ict-modul_id`         INT(10)          DEFAULT NULL,
  `erfahrungsnote`       DOUBLE(15, 2)    DEFAULT NULL,
  `knw_note`             DOUBLE(15, 2)    DEFAULT NULL,
  `erfahrungsnote_datum` DATETIME         DEFAULT NULL,
  `knw_datum`            DATETIME         DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;
SELECT "Table klasse has been created";
COMMIT;

--
-- Insert data for table `noten`
--
START TRANSACTION;
LOCK TABLES `noten` WRITE;
ALTER TABLE `noten` DISABLE KEYS;

INSERT INTO `noten` (
  `lernende_id`,
  `ict-modul_id`,
  `erfahrungsnote`,
  `erfahrungsnote_datum`,
  `knw_note`,
  `knw_datum`
)
  SELECT
    `lernende_idlernende` AS `lernende_id`,
    `module_idmodule`     AS `ict-modul_id`,
    `erfahrungsnote`      AS `erfahrungsnote`,
    `dat_erfa`            AS `erfahrungsnote_datum`,
    `knw_note`            AS `knw_note`,
    `dat_knw`             AS `knw_datum`
  FROM `schoolinfo12802016`.`noten`;

ALTER TABLE `noten` ENABLE KEYS;
UNLOCK TABLES;
SELECT "Data noten has been imported";
COMMIT;

--
-- Table structure for table `richtung`
--
START TRANSACTION;
DROP TABLE IF EXISTS fachrichtung;
CREATE TABLE fachrichtung (
  `id`   INT(10) NOT NULL        AUTO_INCREMENT,
  `name` VARCHAR(50)             DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;
SELECT "Table fachrichtung has been created";
COMMIT;

--
-- Insert data for table `richtung`
--
START TRANSACTION;
LOCK TABLES fachrichtung WRITE;
ALTER TABLE fachrichtung DISABLE KEYS;

INSERT INTO `noten` (
  `id`, `name`
)
  SELECT
    `id`       AS `idrichtung`,
    `richtung` AS `name`
  FROM `schoolinfo12802016`.`richtung`;

ALTER TABLE fachrichtung ENABLE KEYS;
UNLOCK TABLES;
SELECT "Data fachrichtung has been imported";
COMMIT;
