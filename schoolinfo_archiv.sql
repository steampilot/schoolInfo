DELIMITER //
CREATE PROCEDURE archiviere_klasse(
  IN this_klasse_id INT(10)
)
  BEGIN
    CREATE DATABASE IF NOT EXISTS schoolinfo_archiv;

    USE schoolinfo_archiv;

    CREATE TABLE IF NOT EXISTS lernende_archiv (
      id          INT PRIMARY KEY       AUTO_INCREMENT,

      nachname    VARCHAR(51)  NOT NULL,
      vorname     VARCHAR(50)  NOT NULL,
      bm          BOOLEAN,
      strasse     VARCHAR(50),
      plz         VARCHAR(8),
      ort         VARCHAR(50),

      richtung    VARCHAR(30)  NOT NULL,

      klasse      VARCHAR(10)  NOT NULL,

      lehrbetrieb VARCHAR(100) NOT NULL,
      lbstrasse   VARCHAR(50),
      lbhausnr    VARCHAR(10),
      lbplz       VARCHAR(8),
      lbort       VARCHAR(50),
      lbland      VARCHAR(15),

      modulname   VARCHAR(30)  NOT NULL,

      note_erf    FLOAT,
      note_knw    FLOAT,

      timestamp   DATETIME     NOT NULL DEFAULT current_timestamp

    )
      ENGINE = ARCHIVE;

    INSERT INTO schoolinfo_archiv.lernende_archiv
      SELECT
        LD.`name`         AS nachname,
        LD.`vorname`      AS vorname,
        LD.`ist_bm`       AS bm,
        LD.`strasse`      AS strasse,
        LT.`plz`          AS plz,
        LT.`ort`          AS ort,
        LD.`fachrichtung` AS richtung,
        KL.`name`         AS klasse,
        BB.`name`         AS lehrbetrieb,
        BB.`strasse`      AS lbstrasse,
        BB.`haus_nr`      AS lbhausnr,
        BT.`plz`          AS lbplz,
        BT.`ort`          AS lbort,
        BB.`land_code`    AS lbland,
        MD.`name`         AS modulname,
        NT.`erf_note`     AS note_erf,
        NT.`knw_note`     AS note_knw
      FROM schoolinfo_neu.lernende AS LD
        LEFT JOIN schoolinfo_neu.orte AS LT
          ON LD.ort_id = LT.id
        LEFT JOIN schoolinfo_neu.klasse AS KL
          ON LD.klasse_id = KL.id
        LEFT JOIN schoolinfo_neu.lehrbetriebe AS BB
          ON LD.lehrbetrieb_id = BB.id
        LEFT JOIN schoolinfo_neu.orte AS BT
          ON BB.ort_id = BT.id
        RIGHT OUTER JOIN schoolinfo_neu.note AS NT
          ON NT.lernende_id = LD.id
        LEFT JOIN schoolinfo_neu.module AS MD
          ON NT.ict - modul_id = MD.id
    WHERE LD.klasse_id = this_klasse_id;

END //
DELIMITER ;