START TRANSACTION;
DROP TABLE IF EXISTS `ort`;
CREATE TABLE `ort` (
  `id`   INT(10)            NOT NULL        AUTO_INCREMENT,
  `plz`  VARCHAR(6)         NOT NULL,
  `ort` VARCHAR(50)         NOT NULL,
  `region_code` VARCHAR(2)  DEFAULT NULL,
  'land_code'   VARCHAR(2)  DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COLLATE = utf8_unicode_ci;
SELECT "Table ort has been created";
COMMIT;

START TRANSACTION;
LOCK TABLES `ort` WRITE;
ALTER TABLE `ort` DISABLE KEYS;
INSERT INTO `ort` (`plz`, `ort`)

  SELECT DISTINCT
    plz, ort
  FROM (
         SELECT
           TRIM(TRAILING "\r" FROM `plz`
           ) as plz,
           TRIM(TRAILING " 1" FROM
                TRIM(TRAILING " AG" FROM
                     TRIM(TRAILING " SO" FROM
                          TRIM(TRAILING " BL" FROM
                               TRIM(TRAILING "\r" FROM `ort`)
                          )
                     )
                )
           ) as ort
         FROM lernende GROUP BY `plz`, `ort`
         UNION
         SELECT
           TRIM(TRAILING "\r" FROM `plz`
           ) as plz,
           TRIM(TRAILING " 1" FROM
                TRIM(TRAILING " AG" FROM
                     TRIM(TRAILING " SO" FROM
                          TRIM(TRAILING " BL" FROM
                               TRIM(TRAILING "\r" FROM `ort`)
                          )
                     )
                )
           ) as ort
         FROM lehrbetriebe GROUP BY `plz`, `ort`) as tmp;

ALTER TABLE `ort` ENABLE KEYS;
UNLOCK TABLES;
SELECT "Data for ort has been imported";
COMMIT;

START TRANSACTION;
  LOCK TABLES `lernende`, WRITE;
  ALTER TABLE `lernende`
    ADD COLUMN `ort_id` INT(10) NULL DEFAULT NULL AFTER `strasse`;
  SELECT "ort collumn has been created for lernende table";

  UPDATE `lernende`
    SET `lernende`.`ort_id` = `ort`.`id`
    WHERE
    `lernende`.`plz` LIKE CONCAT('%', `ort`.`plz` ,'%') AND
    `lernende`.`ort` LIKE CONCAT('%', `ort`.`ort` ,'%');
  SELECT "ort_id has been set in lernende table";

  ALTER TABLE `lernende`
    ADD FOREIGN KEY (`lernende_ort_id`)
    REFERENCES `ort`(`id`);

  SELECT "lernende_ort_id foreign key has been established";
UNLOCK TABLES;
COMMIT;

START TRANSACTION;
  LOCK TABLES `lehrbetriebe` WRITE;
  ALTER TABLE `lehrbetriebe`
    ADD COLUMN `ort_id` INT(10) NULL DEFAULT NULL AFTER `haus_nr`;
  SELECT "ort collumn has been created for lehrbetriebe table";

  UPDATE `lehrbetriebe`
    SET `lehrbetriebe`.`ort_id` = `ort`.`id`
    WHERE
    `lehrbetriebe`.`plz` LIKE CONCAT('%', `ort`.`plz` ,'%') AND
    `lehrbetriebe`.`ort` LIKE CONCAT('%', `ort`.`ort` ,'%');
  SELECT "ort_id has been set in lehrbetriebe table";

  ALTER TABLE `lehrbetriebe`
    ADD FOREIGN KEY (`lernende_ort_id`)
    REFERENCES `ort`(`id`);

  SELECT "lehrbetriebe_ort_id foreign key has been established";
  UNLOCK TABLES;
COMMIT;


