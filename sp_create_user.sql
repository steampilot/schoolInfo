DELIMITER //
CREATE PROCEDURE createUser(IN this_user VARCHAR(50), IN this_host VARCHAR(50), IN this_pass VARCHAR(50))
	BEGIN
		-- Make sure this user isn't allready created
		IF (
			SELECT IFNULL((SELECT 1
			               FROM mysql.user
			               WHERE User = this_user AND Host = this_host), 0) = 0)
		THEN
			DECLARE query1 VARCHAR(255);
			SET query1 = CONCAT('
        CREATE USER "', this_user, '"@"', this_host, '" IDENTIFIED BY "', this_pass, '" '
			);
			PREPARE statement1 FROM query1;
			EXECUTE statement1;
			DEALLOCATE PREPARE statement1;
			DECLARE query2 VARCHAR(255);
			SET query2 = CONCAT('GRANT SELECT ON `schoolinfo_neu`
      TO "', this_user, '"@"', this_host, '" IDENTIFIED BY "', this_pass, '"
        WITH MAX_QUERIES_PER_HOUR 120
        MAX_CONNECTIONS_PER_HOUR 60
        MAX_UPDATES_PER_HOUR 60
        MAX_USER_CONNECTIONS 2'
			);
			PREPARE statement2 FROM query2;
			EXECUTE statement2;
			DEALLOCATE PREPARE statement2;
			SELECT CONCAT('User', this_user, ' at ', this_host, ' has been granted SELECT permissons');
		END IF;
	END //

DELIMITER ;
