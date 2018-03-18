BEGIN
			DROP TABLE IF EXISTS table11;
      CREATE TABLE table11 
      (
        pid int(15) default NULL,
        memo varchar(100) default NULL
      ) 
      ENGINE=InnoDB DEFAULT CHARSET=utf8;
 
		INSERT INTO table11 (pid)SELECT DISTINCT p.pid 	FROM  person p 	WHERE p.typelive in ('1','3') AND p.dischargetype='9' AND p.birth > '2015-10-01' ;


BLOCK1: begin

	DECLARE  c_pid varchar(15) ;
	DECLARE  c_finished  INTEGER DEFAULT 0;
	DECLARE n INT  ;
	DECLARE l INT  ;
	DEClARE 	personcursor CURSOR FOR 
		SELECT pid
					FROM  table11 ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_finished = 1;

	OPEN personcursor;
				-- start loop
				bcg: LOOP
						-- WHERE age needs
						FETCH personcursor INTO c_pid;
								SET n=(SELECT count(*)
										FROM visitepi e  
LEFT JOIN person p
ON p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
										WHERE e.vaccinecode='BCG' AND  e.pid=c_pid  AND TIMESTAMPDIFF(day,p.birth,e.dateepi) > 0);

								SET l=(SELECT LENGTH(memo)
										FROM table11  
										WHERE  pid=c_pid);
						IF c_finished = 1 THEN 
								LEAVE bcg;
						END IF;
								if n =0  THEN 
									UPDATE table11 SET memo='BCG' WHERE  pid=c_pid;
								END IF; 
				END LOOP bcg;
 
	CLOSE personcursor;

end BLOCK1;
	
BLOCK2: begin

	DECLARE  c_pid varchar(15) ;
	DECLARE  c_finished  INTEGER DEFAULT 0;
	DECLARE n INT  ;
	DECLARE l INT  ;
	DEClARE 	personcursor CURSOR FOR 
		SELECT pid
					FROM  table11 ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_finished = 1;

	OPEN personcursor;
				dhb1: LOOP
						FETCH personcursor INTO c_pid;
-- WHERE age needs
								SET n=(SELECT count(*)
										FROM visitepi e  
LEFT JOIN person p
ON p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
										WHERE e.vaccinecode in ('DHB1','DTP1') AND  e.pid=c_pid  AND TIMESTAMPDIFF(WEEK,p.birth,e.dateepi) > 8);

								SET l=(SELECT LENGTH(memo)
										FROM table11  
										WHERE  pid=c_pid);
						IF c_finished = 1 THEN 
								LEAVE dhb1;
						END IF;
								if    n = 0 AND l > 1  THEN 
									UPDATE table11 SET memo=concat(memo,',DHB1') WHERE  pid=c_pid;
								ELSEIF n =0 AND (l<1  OR ISNULL(l)) THEN 
									UPDATE table11 SET memo='DHB1' WHERE  pid=c_pid;
								END IF; 
				END LOOP dhb1;
 
	CLOSE personcursor;

end BLOCK2;

BLOCK3: begin

	DECLARE  c_pid varchar(15) ;
	DECLARE  c_finished  INTEGER DEFAULT 0;
	DECLARE n INT  ;
	DECLARE l INT  ;
	DEClARE 	personcursor CURSOR FOR 
		SELECT pid
					FROM  table11 ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_finished = 1;

	OPEN personcursor;
				-- start loop
				opv1: LOOP
						FETCH personcursor INTO c_pid;
								SET n=(SELECT count(*)
										FROM visitepi e  
										WHERE e.vaccinecode in ('OPV1') AND  pid=c_pid);

								SET l=(SELECT LENGTH(memo)
										FROM table11  
										WHERE  pid=c_pid);
						IF c_finished = 1 THEN 
								LEAVE opv1;
						END IF;
								if    n = 0 AND l > 1  THEN 
									UPDATE table11 SET memo=concat(memo,',OPV1') WHERE  pid=c_pid;
								ELSEIF n =0 AND (l<1  OR ISNULL(l)) THEN 
									UPDATE table11 SET memo='OPV1' WHERE  pid=c_pid;
								END IF; 
				END LOOP opv1;
 
	CLOSE personcursor;
end BLOCK3;


BLOCK4: begin

	DECLARE  c_pid varchar(15) ;
	DECLARE  c_finished  INTEGER DEFAULT 0;
	DECLARE n INT  ;
	DECLARE l INT  ;
	DEClARE 	personcursor CURSOR FOR 
		SELECT pid
					FROM  table11 ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_finished = 1;

	OPEN personcursor;
				-- start loop
				dhb2: LOOP
						FETCH personcursor INTO c_pid;
								SET n=(SELECT count(*)
										FROM visitepi e  
										WHERE e.vaccinecode in ('DHB2','DTP2') AND  pid=c_pid);

								SET l=(SELECT LENGTH(memo)
										FROM table11  
										WHERE  pid=c_pid);
						IF c_finished = 1 THEN 
								LEAVE dhb2;
						END IF;
								if    n = 0 AND l > 1  THEN 
									UPDATE table11 SET memo=concat(memo,',DHB2') WHERE  pid=c_pid;
								ELSEIF n =0 AND (l<1  OR ISNULL(l)) THEN 
									UPDATE table11 SET memo='DHB2' WHERE  pid=c_pid;
								END IF; 
				END LOOP dhb2;
 
	CLOSE personcursor;

end BLOCK4;

BLOCK5: begin

	DECLARE  c_pid varchar(15) ;
	DECLARE  c_finished  INTEGER DEFAULT 0;
	DECLARE n INT  ;
	DECLARE l INT  ;
	DEClARE 	personcursor CURSOR FOR 
		SELECT pid
					FROM  table11 ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_finished = 1;

	OPEN personcursor;
				-- start loop
				opv2: LOOP
						FETCH personcursor INTO c_pid;
								SET n=(SELECT count(*)
										FROM visitepi e  
										WHERE e.vaccinecode in ('OPV2') AND  pid=c_pid);

								SET l=(SELECT LENGTH(memo)
										FROM table11  
										WHERE  pid=c_pid);
						IF c_finished = 1 THEN 
								LEAVE opv2;
						END IF;
								if    n = 0 AND l > 1  THEN 
									UPDATE table11 SET memo=concat(memo,',OPV2') WHERE  pid=c_pid;
								ELSEIF n =0 AND (l<1  OR ISNULL(l)) THEN 
									UPDATE table11 SET memo='OPV2' WHERE  pid=c_pid;
								END IF; 
				END LOOP opv2;
 
	CLOSE personcursor;
end BLOCK5;

BLOCK6: begin

	DECLARE  c_pid varchar(15) ;
	DECLARE  c_finished  INTEGER DEFAULT 0;
	DECLARE n INT  ;
	DECLARE l INT  ;
	DEClARE 	personcursor CURSOR FOR 
		SELECT pid
					FROM  table11 ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_finished = 1;

	OPEN personcursor;
				dhb3: LOOP
						FETCH personcursor INTO c_pid;
								SET n=(SELECT count(*)
										FROM visitepi e  
										WHERE e.vaccinecode in ('DHB3','DTP3') AND  pid=c_pid);

								SET l=(SELECT LENGTH(memo)
										FROM table11  
										WHERE  pid=c_pid);
						IF c_finished = 1 THEN 
								LEAVE dhb3;
						END IF;
								if    n = 0 AND l > 1  THEN 
									UPDATE table11 SET memo=concat(memo,',DHB3') WHERE  pid=c_pid;
								ELSEIF n =0 AND (l<1  OR ISNULL(l)) THEN 
									UPDATE table11 SET memo='DHB3' WHERE  pid=c_pid;
								END IF; 
				END LOOP dhb3;
 
	CLOSE personcursor;

end BLOCK6;

BLOCK7: begin

	DECLARE  c_pid varchar(15) ;
	DECLARE  c_finished  INTEGER DEFAULT 0;
	DECLARE n INT  ;
	DECLARE l INT  ;
	DEClARE 	personcursor CURSOR FOR 
		SELECT pid
					FROM  table11 ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_finished = 1;

	OPEN personcursor;
				-- start loop
				opv3: LOOP
						FETCH personcursor INTO c_pid;
								SET n=(SELECT count(*)
										FROM visitepi e  
										WHERE e.vaccinecode in ('OPV3') AND  pid=c_pid);

								SET l=(SELECT LENGTH(memo)
										FROM table11  
										WHERE  pid=c_pid);
						IF c_finished = 1 THEN 
								LEAVE opv3;
						END IF;
								if    n = 0 AND l > 1  THEN 
									UPDATE table11 SET memo=concat(memo,',OPV3') WHERE  pid=c_pid;
								ELSEIF n =0 AND (l<1  OR ISNULL(l)) THEN 
									UPDATE table11 SET memo='OPV3' WHERE  pid=c_pid;
								END IF; 
				END LOOP opv3;
 
	CLOSE personcursor;
end BLOCK7;

BLOCK8: begin

	DECLARE  c_pid varchar(15) ;
	DECLARE  c_finished  INTEGER DEFAULT 0;
	DECLARE n INT  ;
	DECLARE l INT  ;
	DEClARE 	personcursor CURSOR FOR 
		SELECT pid
					FROM  table11 ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_finished = 1;

	OPEN personcursor;
				-- start loop
				ipv: LOOP
						FETCH personcursor INTO c_pid;
								SET n=(SELECT count(*)
										FROM visitepi e  
										WHERE e.vaccinecode in ('IPV-P') AND  pid=c_pid);

								SET l=(SELECT LENGTH(memo)
										FROM table11  
										WHERE  pid=c_pid);
						IF c_finished = 1 THEN 
								LEAVE ipv;
						END IF;
								if    n = 0 AND l > 1  THEN 
									UPDATE table11 SET memo=concat(memo,',IPV') WHERE  pid=c_pid;
								ELSEIF n =0 AND (l<1  OR ISNULL(l)) THEN 
									UPDATE table11 SET memo='IPV' WHERE  pid=c_pid;
								END IF; 
				END LOOP ipv;
 
	CLOSE personcursor;
end BLOCK8;

BLOCK9: begin

	DECLARE  c_pid varchar(15) ;
	DECLARE  c_finished  INTEGER DEFAULT 0;
	DECLARE n INT  ;
	DECLARE l INT  ;
	DEClARE 	personcursor CURSOR FOR 
		SELECT pid
					FROM  table11 ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_finished = 1;

	OPEN personcursor;
				-- start loop
				mmr: LOOP
						FETCH personcursor INTO c_pid;
								SET n=(SELECT count(*) 
													FROM person p 
													WHERE p.pid=c_pid AND  TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) > 8 
													AND  EXISTS 
													(
													SELECT * FROM visitepi e WHERE p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid  AND e.vaccinecode='MMR'
													));

								SET l=(SELECT LENGTH(memo)
										FROM table11  
										WHERE  pid=c_pid);
						IF c_finished = 1 THEN 
								LEAVE mmr;
						END IF;
								if    n = 0 AND l > 1  THEN 
									UPDATE table11 SET memo=concat(memo,',MMR1') WHERE  pid=c_pid;
								ELSEIF n =0 AND (l<1  OR ISNULL(l)) THEN 
									UPDATE table11 SET memo='MMR1' WHERE  pid=c_pid;
								END IF; 
				END LOOP mmr;
 
	CLOSE personcursor;
end BLOCK9;

BLOCK10: begin

	DECLARE  c_pid varchar(15) ;
	DECLARE  c_finished  INTEGER DEFAULT 0;
	DECLARE n INT  ;
	DECLARE l INT  ;
	DEClARE 	personcursor CURSOR FOR 
		SELECT pid
					FROM  table11 ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_finished = 1;

	OPEN personcursor;
				-- start loop
				j11: LOOP
						FETCH personcursor INTO c_pid;
								SET n=(SELECT count(*)
										FROM visitepi e  
										WHERE e.vaccinecode in ('J11','JE1') AND  pid=c_pid);

								SET l=(SELECT LENGTH(memo)
										FROM table11  
										WHERE  pid=c_pid);
						IF c_finished = 1 THEN 
								LEAVE j11;
						END IF;
								if    n = 0 AND l > 1  THEN 
									UPDATE table11 SET memo=concat(memo,',LAJE1') WHERE  pid=c_pid;
								ELSEIF n =0 AND (l<1  OR ISNULL(l)) THEN 
									UPDATE table11 SET memo='LAJE1' WHERE  pid=c_pid;
								END IF; 
				END LOOP j11;
 
	CLOSE personcursor;
end BLOCK10;

BLOCK11: begin

	DECLARE  c_pid varchar(15) ;
	DECLARE  c_finished  INTEGER DEFAULT 0;
	DECLARE n INT  ;
	DECLARE l INT  ;
	DEClARE 	personcursor CURSOR FOR 
		SELECT pid
					FROM  table11 ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_finished = 1;

	OPEN personcursor;
				dtp4: LOOP
						FETCH personcursor INTO c_pid;
								SET n=(SELECT count(*)
										FROM visitepi e  
										WHERE e.vaccinecode in ('DTP4') AND  pid=c_pid);

								SET l=(SELECT LENGTH(memo)
										FROM table11  
										WHERE  pid=c_pid);
						IF c_finished = 1 THEN 
								LEAVE dtp4;
						END IF;
								if    n = 0 AND l > 1  THEN 
									UPDATE table11 SET memo=concat(memo,',DTP4') WHERE  pid=c_pid;
								ELSEIF n =0 AND (l<1  OR ISNULL(l)) THEN 
									UPDATE table11 SET memo='DTP4' WHERE  pid=c_pid;
								END IF; 
				END LOOP dtp4;
 
	CLOSE personcursor;

end BLOCK11;

BLOCK12: begin

	DECLARE  c_pid varchar(15) ;
	DECLARE  c_finished  INTEGER DEFAULT 0;
	DECLARE n INT  ;
	DECLARE l INT  ;
	DEClARE 	personcursor CURSOR FOR 
		SELECT pid
					FROM  table11 ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_finished = 1;

	OPEN personcursor;
				-- start loop
				opv4: LOOP
						FETCH personcursor INTO c_pid;
								SET n=(SELECT count(*)
										FROM visitepi e  
										WHERE e.vaccinecode in ('OPV4') AND  pid=c_pid);

								SET l=(SELECT LENGTH(memo)
										FROM table11  
										WHERE  pid=c_pid);
						IF c_finished = 1 THEN 
								LEAVE opv4;
						END IF;
								if    n = 0 AND l > 1  THEN 
									UPDATE table11 SET memo=concat(memo,',OPV4') WHERE  pid=c_pid;
								ELSEIF n =0 AND (l<1  OR ISNULL(l)) THEN 
									UPDATE table11 SET memo='OPV4' WHERE  pid=c_pid;
								END IF; 
				END LOOP opv4;
 
	CLOSE personcursor;
end BLOCK12;


BLOCK13: begin

	DECLARE  c_pid varchar(15) ;
	DECLARE  c_finished  INTEGER DEFAULT 0;
	DECLARE n INT  ;
	DECLARE l INT  ;
	DEClARE 	personcursor CURSOR FOR 
		SELECT pid
					FROM  table11 ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_finished = 1;

	OPEN personcursor;
				-- start loop
				mmr2: LOOP
						FETCH personcursor INTO c_pid;
								SET n=(SELECT count(*)
										FROM visitepi e  
										WHERE e.vaccinecode in ('MMR2') AND  pid=c_pid);

								SET l=(SELECT LENGTH(memo)
										FROM table11  
										WHERE  pid=c_pid);
						IF c_finished = 1 THEN 
								LEAVE mmr2;
						END IF;
								if    n = 0 AND l > 1  THEN 
									UPDATE table11 SET memo=concat(memo,',MMR2') WHERE  pid=c_pid;
								ELSEIF n =0 AND (l<1  OR ISNULL(l)) THEN 
									UPDATE table11 SET memo='MMR2' WHERE  pid=c_pid;
								END IF; 
				END LOOP mmr2;
 
	CLOSE personcursor;
end BLOCK13;

BLOCK14: begin

	DECLARE  c_pid varchar(15) ;
	DECLARE  c_finished  INTEGER DEFAULT 0;
	DECLARE n INT  ;
	DECLARE l INT  ;
	DEClARE 	personcursor CURSOR FOR 
		SELECT pid
					FROM  table11 ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_finished = 1;

	OPEN personcursor;
				-- start loop
				j12: LOOP
						FETCH personcursor INTO c_pid;
								SET n=(SELECT count(*)
										FROM visitepi e  
										WHERE e.vaccinecode in ('J12','JE2','JE3') AND  pid=c_pid);

								SET l=(SELECT LENGTH(memo)
										FROM table11  
										WHERE  pid=c_pid);
						IF c_finished = 1 THEN 
								LEAVE j12;
						END IF;
								if    n = 0 AND l > 1  THEN 
									UPDATE table11 SET memo=concat(memo,',LAJE2') WHERE  pid=c_pid;
								ELSEIF n =0 AND (l<1  OR ISNULL(l)) THEN 
									UPDATE table11 SET memo='LAJE2' WHERE  pid=c_pid;
								END IF; 
				END LOOP j12;
 
	CLOSE personcursor;
end BLOCK14;

BLOCK15: begin

	DECLARE  c_pid varchar(15) ;
	DECLARE  c_finished  INTEGER DEFAULT 0;
	DECLARE n INT  ;
	DECLARE l INT  ;
	DEClARE 	personcursor CURSOR FOR 
		SELECT pid
					FROM  table11 ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_finished = 1;

	OPEN personcursor;
				dtp5: LOOP
						FETCH personcursor INTO c_pid;
								SET n=(SELECT count(*)
										FROM visitepi e  
										WHERE e.vaccinecode in ('DTP5') AND  pid=c_pid);

								SET l=(SELECT LENGTH(memo)
										FROM table11  
										WHERE  pid=c_pid);
						IF c_finished = 1 THEN 
								LEAVE dtp5;
						END IF;
								if    n = 0 AND l > 1  THEN 
									UPDATE table11 SET memo=concat(memo,',DTP5') WHERE  pid=c_pid;
								ELSEIF n =0 AND (l<1  OR ISNULL(l)) THEN 
									UPDATE table11 SET memo='DTP5' WHERE  pid=c_pid;
								END IF; 
				END LOOP dtp5;
 
	CLOSE personcursor;

end BLOCK15;

BLOCK16: begin

	DECLARE  c_pid varchar(15) ;
	DECLARE  c_finished  INTEGER DEFAULT 0;
	DECLARE n INT  ;
	DECLARE l INT  ;
	DEClARE 	personcursor CURSOR FOR 
		SELECT pid
					FROM  table11 ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_finished = 1;

	OPEN personcursor;
				-- start loop
				opv5: LOOP
						FETCH personcursor INTO c_pid;
								SET n=(SELECT count(*)
										FROM visitepi e  
										WHERE e.vaccinecode in ('OPV5') AND  pid=c_pid);

								SET l=(SELECT LENGTH(memo)
										FROM table11  
										WHERE  pid=c_pid);
						IF c_finished = 1 THEN 
								LEAVE opv5;
						END IF;
								if    n = 0 AND l > 1  THEN 
									UPDATE table11 SET memo=concat(memo,',OPV5') WHERE  pid=c_pid;
								ELSEIF n =0 AND (l<1  OR ISNULL(l)) THEN 
									UPDATE table11 SET memo='OPV5' WHERE  pid=c_pid;
								END IF; 
				END LOOP opv5;
 
	CLOSE personcursor;
end BLOCK16;




END
