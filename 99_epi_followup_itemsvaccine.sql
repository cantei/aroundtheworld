BEGIN
			DROP TABLE IF EXISTS me_vaccine_where_needs;
      CREATE TABLE me_vaccine_where_needs 
      (
				pcucodeperson varchar(5) default  NULL,
        pid int(15) default NULL,
				birth date,
				age_day int(15) default  NULL,
				age_week int(15) default  NULL,
				age_month int(15) default  NULL,
        memo varchar(100) default  NULL
      ) 
      ENGINE=InnoDB DEFAULT CHARSET=utf8;
 
		INSERT INTO me_vaccine_where_needs (pcucodeperson,pid,birth,age_day,age_week,age_month) 
			SELECT  p.pcucodeperson,p.pid,p.birth
			,TIMESTAMPDIFF(day,p.birth,CURDATE()) as age_day
			,TIMESTAMPDIFF(WEEK,p.birth,CURDATE()) as age_week
			,TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) as age_month
			FROM  person p 	
			WHERE p.typelive in ('1','3') 
			AND p.dischargetype='9' 
			AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) < 61;


BLOCK1: begin

	DECLARE  c_pid varchar(15) ;
	DECLARE  c_finished  INTEGER DEFAULT 0;
	DECLARE c_age_day INT  ;
	DECLARE c_age_week INT  ;
	DECLARE c_age_month INT  ;
	DECLARE n INT  ;
	DECLARE l INT  ;
	DEClARE 	personcursor CURSOR FOR SELECT pid,age_day,age_week,age_month FROM  me_vaccine_where_needs ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_finished = 1;

	OPEN personcursor;
				bcg: LOOP
						-- WHERE age needs
						FETCH personcursor INTO c_pid,c_age_day,c_age_week,c_age_month;

								SET n=(SELECT count(*)
										FROM visitepi e  
										LEFT JOIN person p
										ON p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
										WHERE e.vaccinecode='BCG' AND  e.pid=c_pid  AND TIMESTAMPDIFF(day,p.birth,e.dateepi) > 0);

								SET l=(SELECT LENGTH(memo)
										FROM me_vaccine_where_needs  
										WHERE  pid=c_pid);
						IF c_finished = 1 THEN /*  checkage */
								LEAVE bcg;
						END IF;
								if n =0 AND c_age_day >= 0 THEN 
									UPDATE me_vaccine_where_needs SET memo='BCG' WHERE  pid=c_pid;
								END IF; 
				END LOOP bcg;
 
	CLOSE personcursor;

end BLOCK1;
	
BLOCK2: begin

	DECLARE  c_pid varchar(15) ;
	DECLARE  c_finished  INTEGER DEFAULT 0;
	DECLARE c_age_day INT  ;
	DECLARE c_age_week INT  ;
	DECLARE c_age_month INT  ;
	DECLARE n INT  ;
	DECLARE l INT  ;
	DEClARE 	personcursor CURSOR FOR SELECT pid,age_day,age_week,age_month FROM  me_vaccine_where_needs ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_finished = 1;

	OPEN personcursor;
				dhb1: LOOP
						FETCH personcursor INTO c_pid,c_age_day,c_age_week,c_age_month;
								SET n=(SELECT count(*)
										FROM visitepi e  
										LEFT JOIN person p
										ON p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
										WHERE e.vaccinecode in ('DHB1','DTP1') AND  e.pid=c_pid  AND TIMESTAMPDIFF(WEEK,p.birth,e.dateepi) > 8);

								SET l=(SELECT LENGTH(memo)
										FROM me_vaccine_where_needs  
										WHERE  pid=c_pid);
						IF c_finished = 1  THEN 
								LEAVE dhb1;
						END IF;
								if    n = 0 AND l > 1  AND c_age_month > 2 THEN 
									UPDATE me_vaccine_where_needs SET memo=concat(memo,',DHB1') WHERE  pid=c_pid;
								ELSEIF n =0 AND (l<1  OR ISNULL(l)) AND c_age_month > 2 THEN 
									UPDATE me_vaccine_where_needs SET memo='DHB1' WHERE  pid=c_pid;
								END IF; 
				END LOOP dhb1;
 
	CLOSE personcursor;

end BLOCK2;

BLOCK3: begin

	DECLARE  c_pid varchar(15) ;
	DECLARE  c_finished  INTEGER DEFAULT 0;
	DECLARE c_age_day INT  ;
	DECLARE c_age_week INT  ;
	DECLARE c_age_month INT  ;
	DECLARE n INT  ;
	DECLARE l INT  ;
	DEClARE 	personcursor CURSOR FOR SELECT pid,age_day,age_week,age_month FROM  me_vaccine_where_needs ;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_finished = 1;

	OPEN personcursor;

				opv1: LOOP
						FETCH personcursor INTO c_pid,c_age_day,c_age_week,c_age_month;
								SET n=(SELECT count(*)
										FROM visitepi e  
										WHERE e.vaccinecode in ('OPV1') AND  pid=c_pid);

								SET l=(SELECT LENGTH(memo)
										FROM me_vaccine_where_needs  
										WHERE  pid=c_pid);
						IF c_finished = 1  THEN 
								LEAVE opv1;
						END IF;
								if    n = 0 AND l > 1 AND c_age_month > 2  THEN 
									UPDATE me_vaccine_where_needs SET memo=concat(memo,',OPV1') WHERE  pid=c_pid;
								ELSEIF n =0 AND (l<1  OR ISNULL(l)) AND c_age_month > 2  THEN 
									UPDATE me_vaccine_where_needs SET memo='OPV1' WHERE  pid=c_pid;
								END IF; 
				END LOOP opv1;
 
	CLOSE personcursor;
end BLOCK3;

BLOCK4: begin

	DECLARE  c_pid varchar(15) ;
	DECLARE  c_finished  INTEGER DEFAULT 0;
	DECLARE c_age_day INT  ;
	DECLARE c_age_week INT  ;
	DECLARE c_age_month INT  ;
	DECLARE n INT  ;
	DECLARE l INT  ;
	DEClARE 	personcursor CURSOR FOR SELECT pid,age_day,age_week,age_month FROM  me_vaccine_where_needs ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_finished = 1;

	OPEN personcursor;

				dhb2: LOOP
						FETCH personcursor INTO c_pid,c_age_day,c_age_week,c_age_month;
								SET n=(SELECT count(*)
										FROM visitepi e  
										WHERE e.vaccinecode in ('DHB2','DTP2') AND  pid=c_pid);

								SET l=(SELECT LENGTH(memo)
										FROM me_vaccine_where_needs  
										WHERE  pid=c_pid);
						IF c_finished = 1  THEN 
								LEAVE dhb2;
						END IF;
								if    n = 0 AND l > 1 AND c_age_month > 4  THEN 
									UPDATE me_vaccine_where_needs SET memo=concat(memo,',DHB2') WHERE  pid=c_pid;
								ELSEIF n =0 AND (l<1  OR ISNULL(l)) AND c_age_month > 4 THEN 
									UPDATE me_vaccine_where_needs SET memo='DHB2' WHERE  pid=c_pid;
								END IF; 
				END LOOP dhb2;
 
	CLOSE personcursor;

end BLOCK4;

BLOCK5: begin

	DECLARE  c_pid varchar(15) ;
	DECLARE  c_finished  INTEGER DEFAULT 0;
	DECLARE c_age_day INT  ;
	DECLARE c_age_week INT  ;
	DECLARE c_age_month INT  ;
	DECLARE n INT  ;
	DECLARE l INT  ;
	DEClARE 	personcursor CURSOR FOR SELECT pid,age_day,age_week,age_month FROM  me_vaccine_where_needs ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_finished = 1;

	OPEN personcursor;

				opv2: LOOP
						FETCH personcursor INTO c_pid,c_age_day,c_age_week,c_age_month;
								SET n=(SELECT count(*)
										FROM visitepi e  
										WHERE e.vaccinecode in ('OPV2') AND  pid=c_pid);

								SET l=(SELECT LENGTH(memo)
										FROM me_vaccine_where_needs  
										WHERE  pid=c_pid);
						IF c_finished = 1 THEN 
								LEAVE opv2;
						END IF;
								if    n = 0 AND l > 1 AND c_age_month > 4 THEN 
									UPDATE me_vaccine_where_needs SET memo=concat(memo,',OPV2') WHERE  pid=c_pid;
								ELSEIF n =0 AND (l<1  OR ISNULL(l)) AND c_age_month > 4 THEN 
									UPDATE me_vaccine_where_needs SET memo='OPV2' WHERE  pid=c_pid;
								END IF; 
				END LOOP opv2;
 
	CLOSE personcursor;
end BLOCK5;

BLOCK6: begin
	DECLARE  c_pid varchar(15) ;
	DECLARE  c_finished  INTEGER DEFAULT 0;
	DECLARE c_age_day INT  ;
	DECLARE c_age_week INT  ;
	DECLARE c_age_month INT  ;
	DECLARE n INT  ;
	DECLARE l INT  ;
	DEClARE 	personcursor CURSOR FOR SELECT pid,age_day,age_week,age_month FROM  me_vaccine_where_needs ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_finished = 1;

	OPEN personcursor;
				dhb3: LOOP
						FETCH personcursor INTO c_pid,c_age_day,c_age_week,c_age_month;
								SET n=(SELECT count(*)
										FROM visitepi e  
										WHERE e.vaccinecode in ('DHB3','DTP3') AND  pid=c_pid);

								SET l=(SELECT LENGTH(memo)
										FROM me_vaccine_where_needs  
										WHERE  pid=c_pid);
						IF c_finished = 1 THEN 
								LEAVE dhb3;
						END IF;
								if    n = 0 AND l > 1  AND c_age_month > 6 THEN 
									UPDATE me_vaccine_where_needs SET memo=concat(memo,',DHB3') WHERE  pid=c_pid;
								ELSEIF n =0 AND (l<1  OR ISNULL(l)) AND c_age_month > 6 THEN 
									UPDATE me_vaccine_where_needs SET memo='DHB3' WHERE  pid=c_pid;
								END IF; 
				END LOOP dhb3;
 
	CLOSE personcursor;

end BLOCK6;

BLOCK7: begin

	DECLARE  c_pid varchar(15) ;
	DECLARE  c_finished  INTEGER DEFAULT 0;
	DECLARE c_age_day INT  ;
	DECLARE c_age_week INT  ;
	DECLARE c_age_month INT  ;
	DECLARE n INT  ;
	DECLARE l INT  ;
	DEClARE 	personcursor CURSOR FOR SELECT pid,age_day,age_week,age_month FROM  me_vaccine_where_needs ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_finished = 1;

	OPEN personcursor;

				opv3: LOOP
						FETCH personcursor INTO c_pid,c_age_day,c_age_week,c_age_month;
								SET n=(SELECT count(*)
										FROM visitepi e  
										WHERE e.vaccinecode in ('OPV3') AND  pid=c_pid);

								SET l=(SELECT LENGTH(memo)
										FROM me_vaccine_where_needs  
										WHERE  pid=c_pid);
						IF c_finished = 1 THEN 
								LEAVE opv3;
						END IF;
								if    n = 0 AND l > 1 AND c_age_month > 6 THEN 
									UPDATE me_vaccine_where_needs SET memo=concat(memo,',OPV3') WHERE  pid=c_pid;
								ELSEIF n =0 AND (l<1  OR ISNULL(l)) AND c_age_month > 6 THEN 
									UPDATE me_vaccine_where_needs SET memo='OPV3' WHERE  pid=c_pid;
								END IF; 
				END LOOP opv3;
 
	CLOSE personcursor;
end BLOCK7;

BLOCK8: begin

	DECLARE  c_pid varchar(15) ;
	DECLARE  c_finished  INTEGER DEFAULT 0;
	DECLARE c_age_day INT  ;
	DECLARE c_age_week INT  ;
	DECLARE c_age_month INT  ;
	DECLARE n INT  ;
	DECLARE l INT  ;
	DEClARE 	personcursor CURSOR FOR SELECT pid,age_day,age_week,age_month FROM  me_vaccine_where_needs ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_finished = 1;

	OPEN personcursor;

				ipv: LOOP
						FETCH personcursor INTO c_pid,c_age_day,c_age_week,c_age_month;
								SET n=(SELECT count(*)
										FROM visitepi e  
										WHERE e.vaccinecode in ('IPV-P') AND  pid=c_pid);

								SET l=(SELECT LENGTH(memo)
										FROM me_vaccine_where_needs  
										WHERE  pid=c_pid);
						IF c_finished = 1 THEN 
								LEAVE ipv;
						END IF;
								if    n = 0 AND l > 1  AND c_age_month > 4 THEN 
									UPDATE me_vaccine_where_needs SET memo=concat(memo,',IPV') WHERE  pid=c_pid;
								ELSEIF n =0 AND (l<1  OR ISNULL(l)) AND c_age_month > 4 THEN 
									UPDATE me_vaccine_where_needs SET memo='IPV' WHERE  pid=c_pid;
								END IF; 
				END LOOP ipv;
 
	CLOSE personcursor;
end BLOCK8;

BLOCK9: begin

	DECLARE  c_pid varchar(15) ;
	DECLARE  c_finished  INTEGER DEFAULT 0;
	DECLARE c_age_day INT  ;
	DECLARE c_age_week INT  ;
	DECLARE c_age_month INT  ;
	DECLARE n INT  ;
	DECLARE l INT  ;
	DEClARE 	personcursor CURSOR FOR SELECT pid,age_day,age_week,age_month FROM  me_vaccine_where_needs ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_finished = 1;

	OPEN personcursor;

				mmr: LOOP
						FETCH personcursor INTO c_pid,c_age_day,c_age_week,c_age_month;
								SET n=(SELECT count(*) 
													FROM person p 
													WHERE p.pid=c_pid AND  TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) > 8 
													AND  EXISTS 
													(
													SELECT * FROM visitepi e WHERE p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid  AND e.vaccinecode='MMR'
													));

								SET l=(SELECT LENGTH(memo)
										FROM me_vaccine_where_needs  
										WHERE  pid=c_pid);
						IF c_finished = 1 THEN 
								LEAVE mmr;
						END IF;
								if    n = 0 AND l > 1 AND c_age_month > 9 THEN 
									UPDATE me_vaccine_where_needs SET memo=concat(memo,',MMR1') WHERE  pid=c_pid;
								ELSEIF n =0 AND (l<1  OR ISNULL(l)) AND c_age_month > 9 THEN 
									UPDATE me_vaccine_where_needs SET memo='MMR1' WHERE  pid=c_pid;
								END IF; 
				END LOOP mmr;
 
	CLOSE personcursor;
end BLOCK9;

BLOCK10: begin

	DECLARE  c_pid varchar(15) ;
	DECLARE  c_finished  INTEGER DEFAULT 0;
	DECLARE c_age_day INT  ;
	DECLARE c_age_week INT  ;
	DECLARE c_age_month INT  ;
	DECLARE n INT  ;
	DECLARE l INT  ;
	DEClARE 	personcursor CURSOR FOR SELECT pid,age_day,age_week,age_month FROM  me_vaccine_where_needs ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_finished = 1;

	OPEN personcursor;

				j11: LOOP
						FETCH personcursor INTO c_pid,c_age_day,c_age_week,c_age_month;
								SET n=(SELECT count(*)
										FROM visitepi e  
										WHERE e.vaccinecode in ('J11','JE1') AND  pid=c_pid);

								SET l=(SELECT LENGTH(memo)
										FROM me_vaccine_where_needs  
										WHERE  pid=c_pid);
						IF c_finished = 1 THEN 
								LEAVE j11;
						END IF;
								if    n = 0 AND l > 1  AND c_age_month > 12 THEN 
									UPDATE me_vaccine_where_needs SET memo=concat(memo,',LAJE1') WHERE  pid=c_pid;
								ELSEIF n =0 AND (l<1  OR ISNULL(l)) AND c_age_month > 12 THEN 
									UPDATE me_vaccine_where_needs SET memo='LAJE1' WHERE  pid=c_pid;
								END IF; 
				END LOOP j11;
 
	CLOSE personcursor;
end BLOCK10;

BLOCK11: begin

	DECLARE  c_pid varchar(15) ;
	DECLARE  c_finished  INTEGER DEFAULT 0;
	DECLARE c_age_day INT  ;
	DECLARE c_age_week INT  ;
	DECLARE c_age_month INT  ;
	DECLARE n INT  ;
	DECLARE l INT  ;
	DEClARE 	personcursor CURSOR FOR SELECT pid,age_day,age_week,age_month FROM  me_vaccine_where_needs ;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_finished = 1;

	OPEN personcursor;
				dtp4: LOOP
						FETCH personcursor INTO c_pid,c_age_day,c_age_week,c_age_month;
								SET n=(SELECT count(*)
										FROM visitepi e  
										WHERE e.vaccinecode in ('DTP4') AND  pid=c_pid);

								SET l=(SELECT LENGTH(memo)
										FROM me_vaccine_where_needs  
										WHERE  pid=c_pid);
						IF c_finished = 1 THEN 
								LEAVE dtp4;
						END IF;
								if    n = 0 AND l > 1  AND c_age_month > 18 THEN 
									UPDATE me_vaccine_where_needs SET memo=concat(memo,',DTP4') WHERE  pid=c_pid;
								ELSEIF n =0 AND (l<1  OR ISNULL(l)) AND c_age_month > 18 THEN 
									UPDATE me_vaccine_where_needs SET memo='DTP4' WHERE  pid=c_pid;
								END IF; 
				END LOOP dtp4;
 
	CLOSE personcursor;

end BLOCK11;

BLOCK12: begin

	DECLARE  c_pid varchar(15) ;
	DECLARE  c_finished  INTEGER DEFAULT 0;
	DECLARE c_age_day INT  ;
	DECLARE c_age_week INT  ;
	DECLARE c_age_month INT  ;
	DECLARE n INT  ;
	DECLARE l INT  ;
	DEClARE 	personcursor CURSOR FOR SELECT pid,age_day,age_week,age_month FROM  me_vaccine_where_needs ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_finished = 1;

	OPEN personcursor;

				opv4: LOOP
						FETCH personcursor INTO c_pid,c_age_day,c_age_week,c_age_month;
								SET n=(SELECT count(*)
										FROM visitepi e  
										WHERE e.vaccinecode in ('OPV4') AND  pid=c_pid);

								SET l=(SELECT LENGTH(memo)
										FROM me_vaccine_where_needs  
										WHERE  pid=c_pid);
						IF c_finished = 1 THEN 
								LEAVE opv4;
						END IF;
								if    n = 0 AND l > 1 AND c_age_month > 18 THEN 
									UPDATE me_vaccine_where_needs SET memo=concat(memo,',OPV4') WHERE  pid=c_pid;
								ELSEIF n =0 AND (l<1  OR ISNULL(l)) AND c_age_month > 18 THEN 
									UPDATE me_vaccine_where_needs SET memo='OPV4' WHERE  pid=c_pid;
								END IF; 
				END LOOP opv4;
 
	CLOSE personcursor;
end BLOCK12;

BLOCK13: begin
	DECLARE  c_pid varchar(15) ;
	DECLARE  c_finished  INTEGER DEFAULT 0;
	DECLARE c_age_day INT  ;
	DECLARE c_age_week INT  ;
	DECLARE c_age_month INT  ;
	DECLARE n INT  ;
	DECLARE l INT  ;
	DEClARE 	personcursor CURSOR FOR SELECT pid,age_day,age_week,age_month FROM  me_vaccine_where_needs ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_finished = 1;

	OPEN personcursor;

				mmr2: LOOP
						FETCH personcursor INTO c_pid,c_age_day,c_age_week,c_age_month;
								SET n=(SELECT count(*)
										FROM visitepi e  
										WHERE e.vaccinecode in ('MMR2') AND  pid=c_pid);

								SET l=(SELECT LENGTH(memo)
										FROM me_vaccine_where_needs  
										WHERE  pid=c_pid);
						IF c_finished = 1 THEN 
								LEAVE mmr2;
						END IF;
								if    n = 0 AND l > 1 AND c_age_month > 30 THEN 
									UPDATE me_vaccine_where_needs SET memo=concat(memo,',MMR2') WHERE  pid=c_pid;
								ELSEIF n =0 AND (l<1  OR ISNULL(l)) AND c_age_month > 30 THEN 
									UPDATE me_vaccine_where_needs SET memo='MMR2' WHERE  pid=c_pid;
								END IF; 
				END LOOP mmr2;
 
	CLOSE personcursor;
end BLOCK13;

BLOCK14: begin
	DECLARE  c_pid varchar(15) ;
	DECLARE  c_finished  INTEGER DEFAULT 0;
	DECLARE c_age_day INT  ;
	DECLARE c_age_week INT  ;
	DECLARE c_age_month INT  ;
	DECLARE n INT  ;
	DECLARE l INT  ;
	DEClARE 	personcursor CURSOR FOR SELECT pid,age_day,age_week,age_month FROM  me_vaccine_where_needs ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_finished = 1;

	OPEN personcursor;

				j12: LOOP
						FETCH personcursor INTO c_pid,c_age_day,c_age_week,c_age_month;
								SET n=(SELECT count(*)
										FROM visitepi e  
										WHERE e.vaccinecode in ('J12','JE2','JE3') AND  pid=c_pid);

								SET l=(SELECT LENGTH(memo)
										FROM me_vaccine_where_needs  
										WHERE  pid=c_pid);
						IF c_finished = 1 THEN 
								LEAVE j12;
						END IF;
								if    n = 0 AND l > 1 AND c_age_month > 30  THEN 
									UPDATE me_vaccine_where_needs SET memo=concat(memo,',LAJE2') WHERE  pid=c_pid;
								ELSEIF n =0 AND (l<1  OR ISNULL(l)) AND c_age_month > 30 THEN 
									UPDATE me_vaccine_where_needs SET memo='LAJE2' WHERE  pid=c_pid;
								END IF; 
				END LOOP j12;
 
	CLOSE personcursor;
end BLOCK14;

BLOCK15: begin
	DECLARE  c_pid varchar(15) ;
	DECLARE  c_finished  INTEGER DEFAULT 0;
	DECLARE c_age_day INT  ;
	DECLARE c_age_week INT  ;
	DECLARE c_age_month INT  ;
	DECLARE n INT  ;
	DECLARE l INT  ;
	DEClARE 	personcursor CURSOR FOR SELECT pid,age_day,age_week,age_month FROM  me_vaccine_where_needs ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_finished = 1;

	OPEN personcursor;
				dtp5: LOOP
						FETCH personcursor INTO c_pid,c_age_day,c_age_week,c_age_month;
								SET n=(SELECT count(*)
										FROM visitepi e  
										WHERE e.vaccinecode in ('DTP5') AND  pid=c_pid);

								SET l=(SELECT LENGTH(memo)
										FROM me_vaccine_where_needs  
										WHERE  pid=c_pid);
						IF c_finished = 1  THEN 
								LEAVE dtp5;
						END IF;
								if    n = 0 AND l > 1 AND c_age_month > 48 THEN 
									UPDATE me_vaccine_where_needs SET memo=concat(memo,',DTP5') WHERE  pid=c_pid;
								ELSEIF n =0 AND (l<1  OR ISNULL(l)) AND c_age_month > 48 THEN 
									UPDATE me_vaccine_where_needs SET memo='DTP5' WHERE  pid=c_pid;
								END IF; 
				END LOOP dtp5;
 
	CLOSE personcursor;

end BLOCK15;

BLOCK16: begin
	DECLARE  c_pid varchar(15) ;
	DECLARE  c_finished  INTEGER DEFAULT 0;
	DECLARE c_age_day INT  ;
	DECLARE c_age_week INT  ;
	DECLARE c_age_month INT  ;
	DECLARE n INT  ;
	DECLARE l INT  ;
	DEClARE 	personcursor CURSOR FOR SELECT pid,age_day,age_week,age_month FROM  me_vaccine_where_needs ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_finished = 1;

	OPEN personcursor;

				opv5: LOOP
						FETCH personcursor INTO c_pid,c_age_day,c_age_week,c_age_month;
								SET n=(SELECT count(*)
										FROM visitepi e  
										WHERE e.vaccinecode in ('OPV5') AND  pid=c_pid);

								SET l=(SELECT LENGTH(memo)
										FROM me_vaccine_where_needs  
										WHERE  pid=c_pid);
						IF c_finished = 1  THEN 
								LEAVE opv5;
						END IF;
								if    n = 0 AND l > 1 AND c_age_month > 48 THEN 
									UPDATE me_vaccine_where_needs SET memo=concat(memo,',OPV5') WHERE  pid=c_pid;
								ELSEIF n =0 AND (l<1  OR ISNULL(l)) AND c_age_month > 48 THEN 
									UPDATE me_vaccine_where_needs SET memo='OPV5' WHERE  pid=c_pid;
								END IF; 
				END LOOP opv5;
 
	CLOSE personcursor;
end BLOCK16;


END
# report 
/* 
SELECT p.pcucodeperson,p.pid,p.idcard
,concat(c.titlename,p.fname,'   ',p.lname) as fullname
,p.birth
,i.age_month
,h.hno,substr(h.villcode,7,2) as moo 
,i.memo
,concat(v.fname,'    ',v.lname) as 'volanteer'
FROM me_vaccine_where_needs i
INNER JOIN person p
ON i.pcucodeperson=p.pcucodeperson AND i.pid=p.pid  
INNER JOIN ctitle c
ON p.prename=c.titlecode 
INNER JOIN house h
ON p.pcucodeperson=h.pcucode AND p.hcode=h.hcode
LEFT JOIN person v
ON h.pcucodepersonvola=v.pcucodeperson AND h.pidvola=v.pid  
WHERE NOT ISNULL(memo)
ORDER BY moo,(SPLIT_STR(hno,'/', 1)*1),(SPLIT_STR(hno,'/',2)*1)

*/
