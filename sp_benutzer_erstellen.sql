DELIMITER //
CREATE PROCEDURE sp_benutzer_erstellen(
  IN this_user       VARCHAR(50),
  IN this_host       VARCHAR(50),
  IN this_pass       VARCHAR(50),
  IN this_table      VARCHAR(50),
  IN this_permission VARCHAR(50)
)
  BEGIN
    START TRANSACTION;
    IF (LENGTH(
      this_user OR
      this_host OR
      this_pass OR
      this_table OR
      this_permission
       ) > 50)
      THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Eingabe zu lange';
    ELSEIF (
      this_user OR
      this_host OR
      this_pass OR
      this_table OR
      this_permission
    REGEXP  '|^((?![;$<>{}\[\]]).)*$|')
      THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Eingabe enthaelt unerlaubte Zeichen. Nur a-z A-Z 0-9 sind erlaubt';
    END IF;

    DECLARE query1 VARCHAR(255);
    SET query1 = CONCAT('
          CREATE USER IF NOT EXISTS "', this_user, '"@"', this_host,
                        '" IDENTIFIED BY "', this_pass, '" ');

    PREPARE statement1 FROM query1;
    EXECUTE statement1;
    DEALLOCATE PREPARE statement1;

    SELECT CONCAT(' User ', this_user, ' at ', this_host, ' has been created.');

    INSERT INTO `schoolinfo_neu`.`berechtigungen_log`
    (`benutzer`, `grund`, `berechtigung`,`tabelle`)
    VALUES (CONCAT(this_user, "@", this_host), "CREATE", "NONE", "NONE");
    COMMIT;

    START TRANSACTION;
    DECLARE query2 VARCHAR(255);
    SET query2 = CONCAT(
        'GRANT ', this_permission, ' ON `schoolinfo.neu`.', this_table,
        ' TO "', this_user, '"@"', this_host, '" IDENTIFIED BY "', this_pass, '" ');
    PREPARE statement2 FROM query2;
    EXECUTE statement2;
    DEALLOCATE PREPARE statement2;
    SELECT CONCAT(' User ', this_user, ' at ', this_host,
                  ' has been granted ',this_permission,
                  ' permisson on table ',this_table,'.');
    INSERT INTO `schoolinfo_neu`.`berechtigungen_log`
    (`benutzer`, `grund`, `berechtigung`, `tabelle`)
    VALUES (CONCAT(this_user, "@", this_host), "Granted permission", this_permission, this_table);
    COMMIT;

  END //
DELIMITER ;
