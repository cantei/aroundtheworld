########################################################  group1   ####################################################################
SET @startdate='2016-10-01';
SET @stoptdate='2017-09-30';
SELECT t1.*,t2.nextappoint
FROM 
(
		SELECT t.*
		FROM 
		(
				SELECT p.idcard as cid,p.fname,p.lname,p.birth
				,TIMESTAMPDIFF(YEAR,p.birth,CURDATE()) as age_year
				,TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) as age_month
				,TIMESTAMPDIFF(DAY,p.birth,CURDATE()) as age_day
				,h.hno,substr(h.villcode,7,2) as moo
				,MIN(IF(e.vaccinecode='HBV1',e.dateepi,NULL)) AS HBV1
				,MIN(IF(e.vaccinecode='BCG',e.dateepi,NULL)) AS BCG
				,MIN(IF(e.vaccinecode='DHB1',e.dateepi,NULL)) AS DHB1
				,MIN(IF(e.vaccinecode='OPV1',e.dateepi,NULL)) AS OPV1
				,MIN(IF(e.vaccinecode='DHB2',e.dateepi,NULL)) AS DHB2
				,MIN(IF(e.vaccinecode='OPV2',e.dateepi,NULL)) AS OPV2
				,MIN(IF(e.vaccinecode='DHB3',e.dateepi,NULL)) AS DHB3
				,MIN(IF(e.vaccinecode='OPV3',e.dateepi,NULL)) AS OPV3
				,MIN(IF(e.vaccinecode='MMR',e.dateepi,NULL)) AS MMR1

				FROM person p
				LEFT JOIN house h
				ON p.pcucodeperson=h.pcucode AND p.hcode=h.hcode
				LEFT JOIN visitepi e
				ON p.pcucodeperson=e.pcucodeperson AND p.pid =e.pid 
				WHERE p.birth  BETWEEN DATE_SUB(@startdate,INTERVAL 1 YEAR) AND DATE_SUB(@stoptdate,INTERVAL 1 YEAR)
				AND p.typelive in ('1','3')  and	 p.dischargetype='9'
				GROUP BY p.idcard 
		) as t
		HAVING  
		(age_day > 1 AND ISNULL(BCG)) OR 
		(age_day > 1 AND ISNULL(HBV1)) OR 
		(age_day > 56 AND ISNULL(DHB1)) OR 
		(age_day > 56 AND ISNULL(OPV1)) OR 
		(age_day > 112 AND ISNULL(DHB2)) OR 
		(age_day > 112 AND ISNULL(OPV2)) OR 
		(age_day > 168 AND ISNULL(DHB2)) OR 
		(age_day > 168 AND ISNULL(OPV2)) OR 
		(age_day > 252 AND ISNULL(MMR1)) 
) as t1 
LEFT JOIN 
-- next appoint
(
	SELECT t.pcucodeperson,t.pid,t.idcard
	,CONVERT(SUBSTRING_INDEX(appoint,',',1) USING utf8) as nextappoint
	,t.vaccines
	FROM 
	(
	SELECT p.pcucodeperson,p.pid,p.idcard
	,if(a.dateappoint > CURDATE(),GROUP_CONCAT(a.dateappoint ORDER BY a.dateappoint ASC ),null) as appoint 
	,if(a.dateappoint > CURDATE(),GROUP_CONCAT(a.vaccinecode ORDER BY a.dateappoint ASC ),null) as vaccines 
	FROM person p
	INNER  JOIN visitepiappoint a 
	ON p.pcucodeperson=a.pcucode AND p.pid=a.pid
	GROUP BY  p.pcucodeperson,p.pid
	HAVING NOT ISNULL(vaccines)
	) as t 
) as t2 ON t1.cid=t2.idcard
ORDER BY moo,hno;

########################################################  group2   ####################################################################
SET @startdate='2016-10-01';
SET @stoptdate='2017-09-30';
SELECT t1.*,t2.nextappoint
FROM 
(
		SELECT t.*
		,CASE WHEN NOT ISNULL(t.JE1)   THEN '1'
				WHEN  NOT ISNULL(t.LAJE1)  THEN '2'
		ELSE '0' 
		END AS CHK_JE	
		FROM 
		(
				SELECT p.idcard as cid,p.fname,p.lname,p.birth
				,TIMESTAMPDIFF(YEAR,p.birth,CURDATE()) as age_year
				,TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) as age_month
				,TIMESTAMPDIFF(DAY,p.birth,CURDATE()) as age_day
				,h.hno,substr(h.villcode,7,2) as moo
				,MIN(IF(e.vaccinecode='HBV1',e.dateepi,NULL)) AS HBV1
				,MIN(IF(e.vaccinecode='BCG',e.dateepi,NULL)) AS BCG
				,MIN(IF(e.vaccinecode='DHB1',e.dateepi,NULL)) AS DHB1
				,MIN(IF(e.vaccinecode='OPV1',e.dateepi,NULL)) AS OPV1
				,MIN(IF(e.vaccinecode='DHB2',e.dateepi,NULL)) AS DHB2
				,MIN(IF(e.vaccinecode='OPV2',e.dateepi,NULL)) AS OPV2
				,MIN(IF(e.vaccinecode='DHB3',e.dateepi,NULL)) AS DHB3
				,MIN(IF(e.vaccinecode='OPV3',e.dateepi,NULL)) AS OPV3
				,MIN(IF(e.vaccinecode='MMR',e.dateepi,NULL)) AS MMR1
				-- grp 2
				,MIN(IF(e.vaccinecode='JE1',e.dateepi,NULL)) AS JE1
				,MIN(IF(e.vaccinecode='J11',e.dateepi,NULL)) AS LAJE1
				,MIN(IF(e.vaccinecode='DTP4',e.dateepi,NULL)) AS DTP4
				,MIN(IF(e.vaccinecode='OPV4',e.dateepi,NULL)) AS OPV4
				FROM person p
				LEFT JOIN house h
				ON p.pcucodeperson=h.pcucode AND p.hcode=h.hcode
				LEFT JOIN visitepi e
				ON p.pcucodeperson=e.pcucodeperson AND p.pid =e.pid 
				WHERE p.birth  BETWEEN DATE_SUB(@startdate,INTERVAL 2 YEAR) AND DATE_SUB(@stoptdate,INTERVAL 2 YEAR)
				AND p.typelive in ('1','3')  and	 p.dischargetype='9'
				GROUP BY p.idcard 
		) as t
		HAVING  
		(age_day > 1 AND ISNULL(BCG)) OR 
		(age_day > 1 AND ISNULL(HBV1)) OR 
		(age_day > 56 AND ISNULL(DHB1)) OR 
		(age_day > 56 AND ISNULL(OPV1)) OR 
		(age_day > 112 AND ISNULL(DHB2)) OR 
		(age_day > 112 AND ISNULL(OPV2)) OR 
		(age_day > 168 AND ISNULL(DHB2)) OR 
		(age_day > 168 AND ISNULL(OPV2)) OR 
		(age_day > 252 AND ISNULL(MMR1)) OR 
		(age_day > 533 AND ISNULL(DTP4)) OR
		(age_day > 533 AND ISNULL(OPV4)) OR 
		(age_day > 365 AND CHK_JE='0')
) as t1 
LEFT JOIN 
-- next appoint
(
	SELECT t.pcucodeperson,t.pid,t.idcard
	,CONVERT(SUBSTRING_INDEX(appoint,',',1) USING utf8) as nextappoint
	,t.vaccines
	FROM 
	(
	SELECT p.pcucodeperson,p.pid,p.idcard
	,if(a.dateappoint > CURDATE(),GROUP_CONCAT(a.dateappoint ORDER BY a.dateappoint ASC ),null) as appoint 
	,if(a.dateappoint > CURDATE(),GROUP_CONCAT(a.vaccinecode ORDER BY a.dateappoint ASC ),null) as vaccines 
	FROM person p
	INNER  JOIN visitepiappoint a 
	ON p.pcucodeperson=a.pcucode AND p.pid=a.pid
	GROUP BY  p.pcucodeperson,p.pid
	HAVING NOT ISNULL(vaccines)
	) as t 
) as t2 ON t1.cid=t2.idcard
ORDER BY moo,hno;

########################################################  group3   ####################################################################
SET @startdate='2016-10-01';
SET @stoptdate='2017-09-30';
SELECT t1.*,t2.nextappoint
FROM 
(
		SELECT t.*
		,CASE WHEN NOT ISNULL(t.JE1) and	NOT ISNULL(t.JE2) and	NOT ISNULL(t.JE3)   THEN '1'
				WHEN NOT ISNULL(t.JE1) and	NOT ISNULL(t.JE2) and	( NOT ISNULL(t.LAJE1) OR NOT ISNULL(t.LAJE2))  THEN '2'
				WHEN NOT ISNULL(t.JE1) and	NOT ISNULL(t.LAJE1) and	NOT ISNULL(t.LAJE2)   THEN '3'
				WHEN  NOT ISNULL(t.LAJE1) and	NOT ISNULL(t.LAJE2)  THEN '4'
				WHEN  NOT ISNULL(t.JE1) and	NOT ISNULL(t.LAJE1)  THEN '5'
		ELSE '0' 
		END AS CHK_JE
		,CASE WHEN  NOT ISNULL(t.MMR2)  THEN '1'
					WHEN  NOT ISNULL(t.MRC)  	THEN '2'
		ELSE '0' 
		END AS CHK_M
		FROM 
		(
			SELECT p.idcard as cid,p.fname,p.lname,p.birth
			,TIMESTAMPDIFF(YEAR,p.birth,CURDATE()) as age_year
			,TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) as age_month
			,TIMESTAMPDIFF(DAY,p.birth,CURDATE()) as age_day
			,h.hno,substr(h.villcode,7,2) as moo
			,MIN(IF(e.vaccinecode='HBV1',e.dateepi,NULL)) AS HBV1
			,MIN(IF(e.vaccinecode='BCG',e.dateepi,NULL)) AS BCG
			,MIN(IF(e.vaccinecode='DHB1',e.dateepi,NULL)) AS DHB1
			,MIN(IF(e.vaccinecode='OPV1',e.dateepi,NULL)) AS OPV1
			,MIN(IF(e.vaccinecode='DHB2',e.dateepi,NULL)) AS DHB2
			,MIN(IF(e.vaccinecode='OPV2',e.dateepi,NULL)) AS OPV2
			,MIN(IF(e.vaccinecode='DHB3',e.dateepi,NULL)) AS DHB3
			,MIN(IF(e.vaccinecode='OPV3',e.dateepi,NULL)) AS OPV3
			,MIN(IF(e.vaccinecode='MMR',e.dateepi,NULL)) AS MMR1
			-- grp 2
			,MIN(IF(e.vaccinecode='JE1',e.dateepi,NULL)) AS JE1
			,MIN(IF(e.vaccinecode='J11',e.dateepi,NULL)) AS LAJE1
			,MIN(IF(e.vaccinecode='DTP4',e.dateepi,NULL)) AS DTP4
			,MIN(IF(e.vaccinecode='OPV4',e.dateepi,NULL)) AS OPV4
			-- grp 3
			,MIN(IF(e.vaccinecode='JE2',e.dateepi,NULL)) AS JE2
			,MIN(IF(e.vaccinecode='JE3',e.dateepi,NULL)) AS JE3
			,MIN(IF(e.vaccinecode='J12',e.dateepi,NULL)) AS LAJE2
			,MIN(IF(e.vaccinecode='MMR2',e.dateepi,NULL)) AS MMR2
			,MIN(IF(e.vaccinecode='MRC',e.dateepi,NULL)) AS MRC
			FROM person p
			LEFT JOIN house h
			ON p.pcucodeperson=h.pcucode AND p.hcode=h.hcode
			LEFT JOIN visitepi e
			ON p.pcucodeperson=e.pcucodeperson AND p.pid =e.pid 
			WHERE p.birth  BETWEEN DATE_SUB(@startdate,INTERVAL 3 YEAR) AND DATE_SUB(@stoptdate,INTERVAL 3 YEAR)
			AND p.typelive in ('1','3')  and	 p.dischargetype='9'
			GROUP BY p.idcard 
		) as t
		HAVING  
		(age_day > 1 AND ISNULL(BCG)) OR 
		(age_day > 1 AND ISNULL(HBV1)) OR 
		(age_day > 56 AND ISNULL(DHB1)) OR 
		(age_day > 56 AND ISNULL(OPV1)) OR 
		(age_day > 112 AND ISNULL(DHB2)) OR 
		(age_day > 112 AND ISNULL(OPV2)) OR 
		(age_day > 168 AND ISNULL(DHB2)) OR 
		(age_day > 168 AND ISNULL(OPV2)) OR 
		(age_day > 252 AND ISNULL(MMR1)) OR 
		(age_day > 533 AND ISNULL(DTP4)) OR 
		(age_day > 533 AND ISNULL(OPV4)) OR 
		(age_day > 365 AND CHK_JE='0')  OR 
		(age_day > 840 AND CHK_M='0')   
) as t1 
LEFT JOIN 
-- next appoint
(
	SELECT t.pcucodeperson,t.pid,t.idcard
	,CONVERT(SUBSTRING_INDEX(appoint,',',1) USING utf8) as nextappoint
	,t.vaccines
	FROM 
	(
	SELECT p.pcucodeperson,p.pid,p.idcard
	,if(a.dateappoint > CURDATE(),GROUP_CONCAT(a.dateappoint ORDER BY a.dateappoint ASC ),null) as appoint 
	,if(a.dateappoint > CURDATE(),GROUP_CONCAT(a.vaccinecode ORDER BY a.dateappoint ASC ),null) as vaccines 
	FROM person p
	INNER  JOIN visitepiappoint a 
	ON p.pcucodeperson=a.pcucode AND p.pid=a.pid
	GROUP BY  p.pcucodeperson,p.pid
	HAVING NOT ISNULL(vaccines)
	) as t 
) as t2 ON t1.cid=t2.idcard
ORDER BY moo,hno ;

########################################################  group4   ####################################################################
SET @startdate='2016-10-01';
SET @stoptdate='2017-09-30';
SELECT t1.*,t2.nextappoint
FROM 
(
	SELECT t.*
	,CASE WHEN NOT ISNULL(t.JE1) and	NOT ISNULL(t.JE2) and	NOT ISNULL(t.JE3)   THEN '1'
			WHEN NOT ISNULL(t.JE1) and	NOT ISNULL(t.JE2) and	( NOT ISNULL(t.LAJE1) OR NOT ISNULL(t.LAJE2))  THEN '2'
			WHEN NOT ISNULL(t.JE1) and	NOT ISNULL(t.LAJE1) and	NOT ISNULL(t.LAJE2)   THEN '3'
			WHEN  NOT ISNULL(t.LAJE1) and	NOT ISNULL(t.LAJE2)  THEN '4'
			WHEN  NOT ISNULL(t.JE1) and	NOT ISNULL(t.LAJE1)  THEN '5'
	ELSE '0' 
	END AS CHK_JE
	,CASE WHEN  NOT ISNULL(t.MMR2)  THEN '1'
				WHEN  NOT ISNULL(t.MRC)  	THEN '2'
	ELSE '0' 
	END AS CHK_M
	FROM 
	(
			SELECT p.idcard as cid,p.fname,p.lname,p.birth
			,TIMESTAMPDIFF(YEAR,p.birth,CURDATE()) as age_year
			,TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) as age_month
			,TIMESTAMPDIFF(DAY,p.birth,CURDATE()) as age_day
			,h.hno,substr(h.villcode,7,2) as moo
			,MIN(IF(e.vaccinecode='HBV1',e.dateepi,NULL)) AS HBV1
			,MIN(IF(e.vaccinecode='BCG',e.dateepi,NULL)) AS BCG
			,MIN(IF(e.vaccinecode='DHB1',e.dateepi,NULL)) AS DHB1
			,MIN(IF(e.vaccinecode='OPV1',e.dateepi,NULL)) AS OPV1
			,MIN(IF(e.vaccinecode='DHB2',e.dateepi,NULL)) AS DHB2
			,MIN(IF(e.vaccinecode='OPV2',e.dateepi,NULL)) AS OPV2
			,MIN(IF(e.vaccinecode='DHB3',e.dateepi,NULL)) AS DHB3
			,MIN(IF(e.vaccinecode='OPV3',e.dateepi,NULL)) AS OPV3
			,MIN(IF(e.vaccinecode='MMR',e.dateepi,NULL)) AS MMR1
			-- grp 2
			,MIN(IF(e.vaccinecode='JE1',e.dateepi,NULL)) AS JE1
			,MIN(IF(e.vaccinecode='J11',e.dateepi,NULL)) AS LAJE1
			,MIN(IF(e.vaccinecode='DTP4',e.dateepi,NULL)) AS DTP4
			,MIN(IF(e.vaccinecode='OPV4',e.dateepi,NULL)) AS OPV4
			-- grp 3
			,MIN(IF(e.vaccinecode='JE2',e.dateepi,NULL)) AS JE2
			,MIN(IF(e.vaccinecode='JE3',e.dateepi,NULL)) AS JE3
			,MIN(IF(e.vaccinecode='J12',e.dateepi,NULL)) AS LAJE2
			,MIN(IF(e.vaccinecode='MMR2',e.dateepi,NULL)) AS MMR2
			,MIN(IF(e.vaccinecode='MRC',e.dateepi,NULL)) AS MRC
			-- grp 4
			,MIN(IF(e.vaccinecode='DTP5',e.dateepi,NULL)) AS DTP5
			,MIN(IF(e.vaccinecode='OPV5',e.dateepi,NULL)) AS OPV5
			FROM person p
			LEFT JOIN house h
			ON p.pcucodeperson=h.pcucode AND p.hcode=h.hcode
			LEFT JOIN visitepi e
			ON p.pcucodeperson=e.pcucodeperson AND p.pid =e.pid 
			WHERE p.birth  BETWEEN DATE_SUB(@startdate,INTERVAL 5 YEAR) AND DATE_SUB(@stoptdate,INTERVAL 5 YEAR)
			AND p.typelive in ('1','3')  and	 p.dischargetype='9'
			GROUP BY p.idcard 
	) as t
	HAVING  
	(age_day > 1 AND ISNULL(BCG)) OR 
	(age_day > 1 AND ISNULL(HBV1)) OR 
	(age_day > 56 AND ISNULL(DHB1)) OR 
	(age_day > 56 AND ISNULL(OPV1)) OR 
	(age_day > 112 AND ISNULL(DHB2)) OR 
	(age_day > 112 AND ISNULL(OPV2)) OR 
	(age_day > 168 AND ISNULL(DHB2)) OR 
	(age_day > 168 AND ISNULL(OPV2)) OR 
	(age_day > 252 AND ISNULL(MMR1)) OR 

	(age_day > 533 AND ISNULL(DTP4)) OR 
	(age_day > 533 AND ISNULL(OPV4)) OR 
	(age_day > 365 AND CHK_JE='0')  OR 
	(age_day > 840 AND CHK_M='0')   OR 
	(age_day > 1344 AND ISNULL(DTP5)) OR 
	(age_day > 1344 AND ISNULL(OPV5))  
) as t1 
LEFT JOIN 	
-- next appoint
(
	SELECT t.pcucodeperson,t.pid,t.idcard
	,CONVERT(SUBSTRING_INDEX(appoint,',',1) USING utf8) as nextappoint
	,t.vaccines
	FROM 
	(
	SELECT p.pcucodeperson,p.pid,p.idcard
	,if(a.dateappoint > CURDATE(),GROUP_CONCAT(a.dateappoint ORDER BY a.dateappoint ASC ),null) as appoint 
	,if(a.dateappoint > CURDATE(),GROUP_CONCAT(a.vaccinecode ORDER BY a.dateappoint ASC ),null) as vaccines 
	FROM person p
	INNER  JOIN visitepiappoint a 
	ON p.pcucodeperson=a.pcucode AND p.pid=a.pid
	GROUP BY  p.pcucodeperson,p.pid
	HAVING NOT ISNULL(vaccines)
	) as t 
) as t2 ON t1.cid=t2.idcard
ORDER BY moo,hno;
