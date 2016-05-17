DELIMITER //
CREATE PROCEDURE sp_migration_starten
  BEGIN
    DROP DATABASE IF EXISTS `schoolinfo_neu`;
    CREATE DATABASE IF NOT EXISTS `schoolinfo_neu`
      DEFAULT CHARACTER SET latin1;
    USE `schoolinfo_neu`;
    SET SESSION SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";

    START TRANSACTION;
    DROP TABLE IF EXISTS `klassen`;
    CREATE TABLE `klassen` (
      `id`           INT(10) NOT NULL        AUTO_INCREMENT,
      `lehrer_id`    INT(10)                 DEFAULT NULL,
      `name`         VARCHAR(50)
                                             DEFAULT NULL,
      `beschreibung` VARCHAR(255)
                                             DEFAULT NULL,
      PRIMARY KEY (`id`)
      #   FOREIGN KEY (klassen_lehrer_id) REFERENCES lehrer(id)
    )
      ENGINE = InnoDB
      DEFAULT CHARSET = utf8
      COLLATE = utf8_unicode_ci;
    SELECT "Table klassen has been created";
    COMMIT;

    START TRANSACTION;
    LOCK TABLES `klassen` WRITE;
    ALTER TABLE `klassen`
      DISABLE KEYS;
    INSERT INTO `klassen` (`id`, `lehrer_id`, `name`, `beschreibung`)
      SELECT
        `idklasse`      AS `id`,
        `klassenlehrer` AS `lehrer_id`,
        `name`          AS `name`,
        `realname`      AS `beschreibung`
      FROM `schoolinfo12802016`.`klasse`;
    ALTER TABLE `klassen`
      ENABLE KEYS;
    UNLOCK TABLES;
    SELECT "Data for klassen has been imported";
    COMMIT;

    START TRANSACTION;
    DROP TABLE IF EXISTS `lehrbetriebe`;
    CREATE TABLE `lehrbetriebe` (
      `id`          INT(10)     NOT NULL        AUTO_INCREMENT,
      `name`        VARCHAR(50) NOT NULL,
      `strasse`     VARCHAR(50) NOT NULL,
      `haus_nr`     VARCHAR(8)                  DEFAULT NULL,
      `plz`         VARCHAR(8)  NOT NULL,
      `ort`         VARCHAR(50) NOT NULL,
      `kanton_code` VARCHAR(2)                  DEFAULT NULL,
      `land_code`   VARCHAR(2)                  DEFAULT NULL,
      PRIMARY KEY (`id`)
    )
      ENGINE = InnoDB
      DEFAULT CHARSET = utf8
      COLLATE = utf8_unicode_ci;
    SELECT "Table lehrbetriebe has been created";
    COMMIT;

    START TRANSACTION;
    LOCK TABLES `lehrbetriebe` WRITE;
    ALTER TABLE `lehrbetriebe`
      DISABLE KEYS;
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

    ALTER TABLE `lehrbetriebe`
      ENABLE KEYS;
    UNLOCK TABLES;
    SELECT "Data for lehrbetriebe has been imported";
    COMMIT;

    START TRANSACTION;
    DROP TABLE IF EXISTS `lernende`;
    CREATE TABLE `lernende` (
      `id`              INT(10)       NOT NULL     AUTO_INCREMENT,
      `anrede`          VARCHAR(25)                DEFAULT NULL,
      `name`            VARCHAR(50)                DEFAULT NULL,
      `vorname`         VARCHAR(50)                DEFAULT NULL,
      `geschlecht`      VARCHAR(50)                DEFAULT NULL,
      `klasse_id`       INT(10)                    DEFAULT NULL,
      `ist_bm`          TINYINT(1)    NOT NULL,
      `fachrichtung_id` INT(10)                    DEFAULT NULL,
      `lehrbetrieb_id`  INT(10)                    DEFAULT NULL,
      `strasse`         VARCHAR(50)                DEFAULT NULL,
      `plz`             VARCHAR(50)                DEFAULT NULL,
      `ort`             VARCHAR(50)                DEFAULT NULL,
      PRIMARY KEY (`id`),
      FOREIGN KEY (lernende_klasse_id) REFERENCES klassen (id),
      FOREIGN KEY (lernende_fachrichtung_id) REFERENCES fachrichtungen (id),
      FOREIGN KEY (lernende_lehrbetrieb_id) REFERENCES lehrbetriebe (id)
    )
      ENGINE = InnoDB
      DEFAULT CHARSET = utf8
      COLLATE = utf8_unicode_ci;
    SELECT "Table lernende has been created";
    COMMIT;

    START TRANSACTION;
    LOCK TABLES `lernende` WRITE;
    ALTER TABLE `lernende`
      DISABLE KEYS;
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

    ALTER TABLE `lernende`
      ENABLE KEYS;
    UNLOCK TABLES;
    SELECT "Data for lernende has been imported";
    COMMIT;

    START TRANSACTION;
    DROP TABLE IF EXISTS `berechtigungen_log`;
    CREATE TABLE `berechtigungen_log` (
      `id`           INT(10)      NOT NULL AUTO_INCREMENT,
      `benutzer`     VARCHAR(50)  NOT NULL,
      `zeitpunkt`    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
      `grund`        VARCHAR(50)  NOT NULL,
      `berechtigung` VARCHAR(50)  NOT NULL,
      `tabelle`      VARCHAR(255) NOT NULL,
      PRIMARY KEY (`id`)
    )
      ENGINE = InnoDB
      DEFAULT CHARSET = latin1;
    SELECT "Table berechtigungen_log has been created";
    COMMIT;

    START TRANSACTION;
    LOCK TABLES `berechtigungen_log` WRITE;
    ALTER TABLE `berechtigungen_log`
      DISABLE KEYS;
    INSERT INTO `berechtigungen_log` (
      `id`, `benutzer`, `zeitpunkt`, `grund`, `berechtigung`, `tabelle`)
      SELECT
        `id`           AS `id`,
        `benutzer`     AS `benutzer`,
        `timestamp`    AS `zeitpunkt`,
        `wofuer`       AS `grund`,
        `berechtigung` AS `berechtigung`,
        `fuer`         AS `tabelle`
      FROM `schoolinfo12802016`.`log_berechtigung`;
    ALTER TABLE `berechtigungen_log`
      ENABLE KEYS;
    UNLOCK TABLES;
    SELECT "Data for berechtigungen_log has been imported";
    COMMIT;

    START TRANSACTION;
    DROP TABLE IF EXISTS `module`;
    CREATE TABLE `module` (
      `id`           INT(10) NOT NULL        AUTO_INCREMENT,
      `name`         VARCHAR(50)             DEFAULT NULL,
      `beschreibung` VARCHAR(255)            DEFAULT NULL,
      PRIMARY KEY (`id`)
    )
      ENGINE = InnoDB
      DEFAULT CHARSET = utf8
      COLLATE = utf8_unicode_ci;
    SELECT "Table module has been created";
    COMMIT;

    START TRANSACTION;
    LOCK TABLES `module` WRITE;
    ALTER TABLE `module`
      DISABLE KEYS;
    INSERT INTO `module` (
      `id`, `name`, `beschreibung`
    )
      SELECT
        `id`        AS `id`,
        `m_name`    AS `name`,
        `modulname` AS `beschreibung`
      FROM `schoolinfo12802016`.`modul`;


    ALTER TABLE `module`
      ENABLE KEYS;
    UNLOCK TABLES;
    SELECT "Data for module has been imported";
    COMMIT;

    START TRANSACTION;
    DROP TABLE IF EXISTS `noten`;
    CREATE TABLE `noten` (
      `id`          INT(10) NOT NULL AUTO_INCREMENT,
      `lernende_id` INT(10)          DEFAULT NULL,
      `modul_id`    INT(10)          DEFAULT NULL,
      `erf_note`    DOUBLE(15, 2)    DEFAULT NULL,
      `erf_datum`   DATETIME         DEFAULT NULL,
      `knw_note`    DOUBLE(15, 2)    DEFAULT NULL,
      `knw_datum`   DATETIME         DEFAULT NULL,
      PRIMARY KEY (`id`)
    )
      ENGINE = InnoDB
      DEFAULT CHARSET = utf8
      COLLATE = utf8_unicode_ci;
    SELECT "Table noten has been created";
    COMMIT;

    START TRANSACTION;
    LOCK TABLES `noten` WRITE;
    ALTER TABLE `noten`
      DISABLE KEYS;

    INSERT INTO `noten` (
      `lernende_id`,
      `modul_id`,
      `erf_note`,
      `erf_datum`,
      `knw_note`,
      `knw_datum`
    )
      SELECT
        `lernende_idlernende` AS `lernende_id`,
        `module_idmodule`     AS `modul_id`,
        `erf_note`            AS `erfahrungsnote`,
        `erf_datum`           AS `erfahrungsnote_datum`,
        `knw_note`            AS `knw_note`,
        `knw_datum`           AS `knw_datum`
      FROM `schoolinfo12802016`.`noten`;

    ALTER TABLE `noten`
      ENABLE KEYS;
    UNLOCK TABLES;
    SELECT "Data noten has been imported";
    COMMIT;

    START TRANSACTION;
    DROP TABLE IF EXISTS `fachrichtungen`;
    CREATE TABLE `fachrichtungen` (
      `id`   INT(10) NOT NULL        AUTO_INCREMENT,
      `name` VARCHAR(50)             DEFAULT NULL,
      PRIMARY KEY (`id`)
    )
      ENGINE = InnoDB
      DEFAULT CHARSET = utf8
      COLLATE = utf8_unicode_ci;
    SELECT "Table fachrichtungen has been created";
    COMMIT;

    START TRANSACTION;
    LOCK TABLES `fachrichtungen` WRITE;
    ALTER TABLE `fachrichtungen`
      DISABLE KEYS;

    INSERT INTO `fachrichtungen` (
      `id`, `name`
    )
      SELECT
        `id`       AS `idrichtung`,
        `richtung` AS `name`
      FROM `schoolinfo12802016`.`richtung`;

    ALTER TABLE fachrichtungen
      ENABLE KEYS;
    UNLOCK TABLES;
    SELECT "Data fachrichtungen has been imported";
    COMMIT;
  END //
DELIMITER ;