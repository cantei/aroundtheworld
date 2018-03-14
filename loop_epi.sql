DELIMITER $$
 
CREATE PROCEDURE x9 ()

BEGIN
 
	
	DECLARE  a_HOSPCODE varchar(5) ;
	DECLARE  a_PID varchar(15) ;
	DECLARE  c_finished  INTEGER DEFAULT 0;
 -- declare cursor for person
	DEClARE person_cursor CURSOR FOR 
			SELECT HOSPCODE,PID FROM  epi LIMIT 100;
 
 -- declare NOT FOUND handler
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_finished = 1;
 
 OPEN person_cursor;
 
		get_pid: LOOP
		 
				FETCH person_cursor INTO a_HOSPCODE,a_PID;
		 
				IF c_finished = 1 THEN 
				
						LEAVE get_pid;
				
				END IF;		 
					-- build email list
					-- SET email_list = CONCAT(v_email,";",email_list);
				INSERT INTO tb2(v1,v2) VALUES  (a_HOSPCODE,a_PID);
		END LOOP get_pid;
 
 CLOSE person_cursor;
 
END$$
 
DELIMITER ;
