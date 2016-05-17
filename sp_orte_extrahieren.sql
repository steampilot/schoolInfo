DELIMITER //
CREATE PROCEDURE sp_orte_extrahieren
  BEGIN
  START TRANSACTION;
    DROP TABLE IF EXISTS `orte`;
    CREATE TABLE `orte` (
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
    LOCK TABLES `orte` WRITE;
    ALTER TABLE `orte` DISABLE KEYS;
    INSERT INTO `orte` (`plz`, `ort`)

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
             FROM `lernende` GROUP BY `plz`, `ort`
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
             FROM `lehrbetriebe` GROUP BY `plz`, `ort`) as tmp;

    ALTER TABLE `orte` ENABLE KEYS;
    UNLOCK TABLES;
    SELECT "Data for orte has been imported";
    COMMIT;

    START TRANSACTION;
      LOCK TABLES `lernende` WRITE;
      ALTER TABLE `lernende`
        ADD COLUMN `ort_id` INT(10) NULL DEFAULT NULL AFTER `strasse`;
      SELECT "ort collumn has been created for lernende table";

      UPDATE `lernende`
        SET `lernende`.`ort_id` = `orte`.`id`
        WHERE
        `lernende`.`plz` LIKE CONCAT('%', `orte`.`plz` ,'%') AND
        `lernende`.`ort` LIKE CONCAT('%', `orte`.`ort` ,'%');
      SELECT "ort_id has been set in lernende table";

      ALTER TABLE `lernende`
          DROP COLUMN `plz`,
        DROP COLUMN `ort`,
        ADD FOREIGN KEY (`lernende_ort_id`)
        REFERENCES `orte`(`id`);

      SELECT "lernende_ort_id foreign key has been established";
    UNLOCK TABLES;
    COMMIT;

    START TRANSACTION;
      LOCK TABLES `lehrbetriebe` WRITE;
      ALTER TABLE `lehrbetriebe`
        ADD COLUMN `ort_id` INT(10) NULL DEFAULT NULL AFTER `haus_nr`;
      SELECT "ort collumn has been created for lehrbetriebe table";

      UPDATE `lehrbetriebe`
        SET `lehrbetriebe`.`ort_id` = `orte`.`id`
        WHERE
        `lehrbetriebe`.`plz` LIKE CONCAT('%', `orte`.`plz` ,'%') AND
        `lehrbetriebe`.`ort` LIKE CONCAT('%', `orte`.`ort` ,'%');
      SELECT "ort_id has been set in lehrbetriebe table";

      ALTER TABLE `lehrbetriebe`
        DROP COLUMN `plz`,
        DROP COLUMN `ort`,
        ADD FOREIGN KEY (`lernende_ort_id`)
        REFERENCES `orte`(`id`);

      SELECT "lehrbetriebe_ort_id foreign key has been established";
      UNLOCK TABLES;
    COMMIT;
  END //
DELIMITER ;


