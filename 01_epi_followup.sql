-- ผิดนัดในเดือนใดๆ
SET @y='2018';
SET @m='05';

SELECT GROUP_CONCAT(t2.grp) as grps
,CONCAT(v.fname,'  ',v.lname) as 'volanteer'
,t2.fullname,t2.born,t2.agemonth
,CONCAT(h.hno,'  ','หมู่ที่ ',substr(h.villcode,8,1)) as address
,t2.mother,t2.needvaccine,t2.dateappoint
FROM 
(
SELECT 'ผิดนัด'  as grp
-- ,concat(v.fname,'  ',v.lname) as 'volanteer'
-- ,a.pcucodeperson,a.pid  
,p.idcard
,p.hcode
,CONCAT(c.titlename,p.fname,'   ',p.lname) as fullname
,concat(DATE_FORMAT(p.birth, "%d"),'-',DATE_FORMAT(p.birth, "%m"),'-',(DATE_FORMAT(p.birth, "%Y")+543)) as born
,TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) as  'agemonth'
,p.mother as 'mother'
,GROUP_CONCAT(a.vaccinecode ORDER BY a.vaccinecode ) as needvaccine
,'' as dateappoint
FROM visitepiappoint a 
LEFT JOIN person p
ON a.pcucodeperson=p.pcucodeperson AND a.pid=p.pid 
LEFT JOIN ctitle c
ON p.prename=c.titlecode
WHERE p.typelive in ('1','3') 
AND p.dischargetype='9'
AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 3 AND  61 
AND YEAR(a.dateappoint)=@y
AND MONTH(a.dateappoint)=@m
AND NOT EXISTS 
(
SELECT * FROM visitepi e 
WHERE a.pcucodeperson=e.pcucodeperson AND a.pid=e.pid
AND YEAR(e.dateepi)=@y
AND MONTH(e.dateepi)=@m
) 
GROUP BY p.idcard

UNION 
# ส่งจดหมายตาม  หรือขอดูสมุดสีชมพู
SELECT 'ยังได้ไม่ครบ'  as grp
,p.idcard
,p.hcode
,CONCAT(c.titlename,p.fname,'   ',p.lname) as fullname
,CONCAT(DATE_FORMAT(p.birth, "%d"),'-',DATE_FORMAT(p.birth, "%m"),'-',(DATE_FORMAT(p.birth, "%Y")+543)) as born
,TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) as  'agemonth'
,p.mother as 'mother'
,GROUP_CONCAT(t.items ORDER BY (sequence*1) ASC) as items
,t1.date_appoint
FROM 
(
	-- BCG
		SELECT p.pcucodeperson,p.pid
		,'BCG' as items
		,'1'  AS sequence
		FROM person p	
		WHERE p.typelive in ('1','3') 
		AND p.dischargetype='9'
		AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 0 AND  61 
		AND NOT EXISTS 
		(
		SELECT * FROM visitepi e
		WHERE e.vaccinecode='BCG' AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
		)
	-- DHB1
		UNION 
		SELECT p.pcucodeperson,p.pid
		,'DHB1' as items
		,'2'  AS sequence
		FROM person p										
		WHERE p.typelive in ('1','3') 
		AND p.dischargetype='9'
		AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 3 AND  61 
		AND NOT EXISTS 
		(
		SELECT * FROM visitepi e
		WHERE e.vaccinecode NOT IN ('D11','D21','D31','D41','D51','DHB1','DTP1')  AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
		)
	-- OPV1
		UNION 
		SELECT p.pcucodeperson,p.pid
		,'OPV1' as items
		,'3'  AS sequence
		FROM person p										
		WHERE p.typelive in ('1','3') 
		AND p.dischargetype='9'
		AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 3 AND  61 
		AND NOT EXISTS 
		(
		SELECT * FROM visitepi e
		WHERE e.vaccinecode in ('OPV1','D31','D41','D51','I11') AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
		)
	-- DHB2
		UNION 
		SELECT p.pcucodeperson,p.pid
		,'DHB2' as items
		,'4'  AS sequence
		FROM person p										
		WHERE p.typelive in ('1','3') 
		AND p.dischargetype='9'
		AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 5 AND  61 
		AND NOT EXISTS 
		(
		SELECT * FROM visitepi e
		WHERE e.vaccinecode NOT IN ('D12','D22','D32','D42','D52','DHB2','DTP2') AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
		)
	-- OPV2
		UNION 
		SELECT p.pcucodeperson,p.pid
		,'OPV2' as items
		,'5'  AS sequence
		FROM person p										
		WHERE p.typelive in ('1','3') 
		AND p.dischargetype='9'
		AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 5 AND  61 
		AND NOT EXISTS 
		(
		SELECT * FROM visitepi e
		WHERE e.vaccinecode in ('D32','D42','D52','I12','OPV2') AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
		)
	-- IPV
	-- IPV เริ่มใช้ธันวาคม 2558 ฉะนั้น เด็กที่เกิดตั้งแต่ 2015-08-01 
		UNION 
		SELECT p.pcucodeperson,p.pid
		,'IPV' as items
		,'6'  AS sequence
		FROM person p										
		WHERE p.typelive in ('1','3') 
		AND p.dischargetype='9'
		AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 5 AND  61 
		AND p.birth > '2015-07-31'
		AND NOT EXISTS 
		(
		SELECT * FROM visitepi e
		WHERE e.vaccinecode in ('IPV-P','D32','D42','D52','I12') AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
		)
	-- DHB3
		UNION 
		SELECT p.pcucodeperson,p.pid
		,'DHB3' as items
		,'7'  AS sequence
		FROM person p										
		WHERE p.typelive in ('1','3') 
		AND p.dischargetype='9'
		AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 7 AND  61 
		AND NOT EXISTS 
		(
		SELECT * FROM visitepi e
		WHERE e.vaccinecode NOT IN ('D13','D23','D33','D43','D53','DHB2','DTP3') AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
		)

	-- OPV3
		UNION 
		SELECT p.pcucodeperson,p.pid
		,'OPV3' as items
		,'8'  AS sequence
		FROM person p										
		WHERE p.typelive in ('1','3') 
		AND p.dischargetype='9'
		AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 7 AND  61 
		AND NOT EXISTS 
		(
		SELECT * FROM visitepi e
		WHERE e.vaccinecode in ('D33','D43','D53','I13','OPV3') AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
		)

	-- MMR1
		UNION 
		SELECT p.pcucodeperson,p.pid
		,'MMR1' as items
		,'9'  AS sequence
		FROM person p										
		WHERE p.typelive in ('1','3') 
		AND p.dischargetype='9'
		AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 10 AND  60 
		AND NOT EXISTS 
		(
		SELECT * FROM visitepi e
		WHERE e.vaccinecode in ('M11','MMR') AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
		)


	-- LAJE1
	-- LAJE เริ่มใช้ มีนาคม 2558  ฉะนั้น เด็กที่เกิดปีงบประมาณ 2557 บางส่วนควรจะได้รับ 
		UNION 
		SELECT p.pcucodeperson,p.pid
		,'LAJE1' as items
		,'10'  AS sequence
		FROM person p										
		WHERE p.typelive in ('1','3') 
		AND p.dischargetype='9'
		AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 13 AND  60 
		AND p.birth > '2013-09-30'
		AND NOT EXISTS 
		(
		SELECT * FROM visitepi e
		WHERE e.vaccinecode NOT IN ('J11','JE1') AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
		)
	-- DTP4
		UNION 
		SELECT p.pcucodeperson,p.pid
		,'DTP4' as items
		,'11'  AS sequence
		FROM person p										
		WHERE p.typelive in ('1','3') 
		AND p.dischargetype='9'
		AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 19 AND  60 
		AND NOT EXISTS 
		(
		SELECT * FROM visitepi e
		WHERE e.vaccinecode in('D14','D24','D34','D44','D54','DTP4') AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
		)
		
	-- OPV4
		UNION 
		SELECT p.pcucodeperson,p.pid
		,'OPV4' as items
		,'12'  AS sequence
		FROM person p										
		WHERE p.typelive in ('1','3') 
		AND p.dischargetype='9'
		AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 19 AND  60 
		AND NOT EXISTS 
		(
		SELECT * FROM visitepi e
		WHERE e.vaccinecode in ('D34','D44','D54','I14','OPV4') AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
		)

	-- MMR2
		UNION 
		SELECT p.pcucodeperson,p.pid
		,'MMR2' as items
		,'13'  AS sequence
		FROM person p										
		WHERE p.typelive in ('1','3') 
		AND p.dischargetype='9'
		AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 31 AND  60 
		AND NOT EXISTS 
		(
		SELECT * FROM visitepi e
		WHERE e.vaccinecode in ('M12','MMR2') AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
		)
	-- LAJE2
		UNION 
		SELECT p.pcucodeperson,p.pid
		,'LAJE2' as items
		,'14'  AS sequence
		FROM person p										
		WHERE p.typelive in ('1','3') 
		AND p.dischargetype='9'
		AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 31 AND  60 
		-- AND p.birth > '2013-09-30'
		AND NOT EXISTS 
		(
		SELECT * FROM visitepi e
			WHERE e.vaccinecode in ('J12','JE2','JE3') AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
		)
	-- DTP5
		UNION 
		SELECT p.pcucodeperson,p.pid
		,'DTP5' as items
		,'15'  AS sequence
		FROM person p										
		WHERE p.typelive in ('1','3') 
		AND p.dischargetype='9'
		AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 49 AND  60 
		AND NOT EXISTS 
		(
		SELECT * FROM visitepi e
		WHERE e.vaccinecode in ('D35','D45','D55','DTP5') AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
		)
	-- OPV5
		UNION 
		SELECT p.pcucodeperson,p.pid
		,'OPV5' as items
		,'16'  AS sequence
		FROM person p										
		WHERE p.typelive in ('1','3') 
		AND p.dischargetype='9'
		AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 49 AND  60 
		AND NOT EXISTS 
		(
		SELECT * FROM visitepi e
		WHERE e.vaccinecode in ('D35','D45','D55','I15','OPV5') AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
		)
) 
as t
LEFT JOIN person p 
ON t.pcucodeperson=p.pcucodeperson AND t.pid=p.pid 
LEFT JOIN ctitle c
ON p.prename=c.titlecode
LEFT   JOIN 
(
SELECT va.pcucodeperson,va.pid
,SPLIT_STR(GROUP_CONCAT(CAST(va.dateappoint  AS CHAR(10000) CHARACTER SET utf8) ORDER BY va.dateappoint  ASC SEPARATOR ','),',',1) as date_appoint
FROM visitepiappoint   va 
WHERE va.dateappoint > CURDATE() 
GROUP BY va.pcucodeperson,va.pid
HAVING NOT ISNULL(date_appoint) 
) as t1 
ON t.pcucodeperson=t1.pcucodeperson AND t.pid=t1.pid
GROUP BY p.pid

) as t2 
LEFT JOIN house h 
ON  t2.hcode=h.hcode
LEFT JOIN person v
ON h.pcucodepersonvola=v.pcucodeperson and	h.pidvola=v.pid 
GROUP BY t2.idcard
ORDER BY h.villcode,(SPLIT_STR(hno,'/', 1)*1),(SPLIT_STR(hno,'/',2)*1)
