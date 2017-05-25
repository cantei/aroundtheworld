# grp1 full

SET @startdate='2016-10-01';
SET @stoptdate='2017-09-30';

SELECT p.pcucodeperson,p.pid,p.idcard as cid,p.fname,p.lname,p.birth

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
,MIN(IF(e.vaccinecode='IPV-P',e.dateepi,NULL)) AS IPV
,MIN(IF(e.vaccinecode='R21',e.dateepi,NULL)) AS R21
,MIN(IF(e.vaccinecode='R22',e.dateepi,NULL)) AS R22
,MIN(IF(e.vaccinecode='R23',e.dateepi,NULL)) AS R23

FROM person p
LEFT JOIN house h
ON p.pcucodeperson=h.pcucode AND p.hcode=h.hcode
LEFT JOIN visitepi e
ON p.pcucodeperson=e.pcucodeperson AND p.pid =e.pid 
WHERE p.birth  BETWEEN DATE_SUB(@startdate,INTERVAL 1 YEAR) AND DATE_SUB(@stoptdate,INTERVAL 1 YEAR)
AND p.typelive in ('1','3')  and	 p.dischargetype='9'
GROUP BY p.idcard
HAVING (age_day > 1 AND ISNULL(BCG)) OR 
(age_day > 1 AND ISNULL(HBV1)) OR 
(age_day > 56 AND ISNULL(DHB1)) OR 
(age_day > 56 AND ISNULL(OPV1)) OR 
(age_day > 112 AND ISNULL(DHB2)) OR 
(age_day > 112 AND ISNULL(OPV2)) OR 
(age_day > 168 AND ISNULL(DHB2)) OR 
(age_day > 168 AND ISNULL(OPV2)) OR 
(age_day > 252 AND ISNULL(OPV2)) OR 
(p.birth > '2015-07-31'  AND ISNULL(IPV))  OR 
(p.birth > '2016-05-31' AND TIMESTAMPDIFF(WEEK,p.birth,CURDATE())  > 15 AND TIMESTAMPDIFF(WEEK,p.birth,CURDATE())  < 32 AND ISNULL(R21)) OR 
(p.birth > '2016-05-31' AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE())  > 5 AND TIMESTAMPDIFF(WEEK,p.birth,CURDATE())  < 32 AND ISNULL(R22)) OR 
(p.birth > '2016-05-31' AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE())  > 7 AND TIMESTAMPDIFF(WEEK,p.birth,CURDATE())  < 32 AND ISNULL(R23)) OR 
(age_day > 168 AND ISNULL(R23))
ORDER BY  moo,hno;


# grp2 
SET @startdate='2016-10-01';
SET @stoptdate='2017-09-30';

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
HAVING (age_day > 1 AND ISNULL(BCG)) OR 
(age_day > 1 AND ISNULL(HBV1)) OR 
(age_day > 56 AND ISNULL(DHB1)) OR 
(age_day > 56 AND ISNULL(OPV1)) OR 
(age_day > 112 AND ISNULL(DHB2)) OR 
(age_day > 112 AND ISNULL(OPV2)) OR 
(age_day > 168 AND ISNULL(DHB2)) OR 
(age_day > 168 AND ISNULL(OPV2)) OR 
(age_day > 252 AND ISNULL(OPV2)) OR 
(age_day > 393 AND ISNULL(LAJE1)) OR 
(age_day > 533 AND ISNULL(DTP4)) OR 
(age_day > 533 AND ISNULL(OPV4)) 
ORDER BY  moo,hno; 

# grp3.
SET @startdate='2016-10-01';
SET @stoptdate='2017-09-30';

SELECT t.*
,CASE WHEN NOT ISNULL(t.JE1) and	NOT ISNULL(t.JE2) and	NOT ISNULL(t.JE3)   THEN '1'
		WHEN NOT ISNULL(t.JE1) and	NOT ISNULL(t.JE2) and	NOT ISNULL(t.LAJE1)   THEN '2'
		WHEN NOT ISNULL(t.JE1) and	NOT ISNULL(t.LAJE1) and	NOT ISNULL(t.LAJE2)   THEN '3'
		WHEN  NOT ISNULL(t.LAJE1) and	NOT ISNULL(t.LAJE2)  THEN '4'
		WHEN  NOT ISNULL(t.JE1) and	NOT ISNULL(t.LAJE1)  THEN '5'
ELSE '0' 
END AS CHK_JE	
,CASE WHEN age_day > 989  and	 NOT ISNULL(t.MMR2)  THEN '1'
	WHEN age_day > 989  and	 NOT ISNULL(t.MRC)  THEN '2'
ELSE '0' 
END AS CHK_M
FROM (
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

(age_day > 1488 AND ISNULL(DTP5)) OR 
(age_day > 1488 AND ISNULL(OPV5)) OR 
 CHK_JE='0' OR 
CHK_M='0'
 #grp 4
 
 #นับถอยหลัง 2 ปี
SET @startdate='2015-10-01';
SET @stoptdate='2016-09-30';

SELECT t.*
,CASE WHEN NOT ISNULL(t.JE1) and	NOT ISNULL(t.JE2) and	NOT ISNULL(t.JE3)   THEN '1'
		WHEN NOT ISNULL(t.JE1) and	NOT ISNULL(t.JE2) and	NOT ISNULL(t.LAJE1)   THEN '2'
		WHEN NOT ISNULL(t.JE1) and	NOT ISNULL(t.LAJE1) and	NOT ISNULL(t.LAJE2)   THEN '3'
		WHEN  NOT ISNULL(t.LAJE1) and	NOT ISNULL(t.LAJE2)  THEN '4'
		WHEN  NOT ISNULL(t.JE1) and	NOT ISNULL(t.LAJE1)  THEN '5'
ELSE '0' 
END AS CHK_JE	
,CASE WHEN age_day > 989  and	 NOT ISNULL(t.MMR2)  THEN '1'
	WHEN age_day > 989  and	 NOT ISNULL(t.MRC)  THEN '2'
ELSE '0' 
END AS CHK_M
FROM (
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
(age_day > 1488 AND ISNULL(DTP5)) OR 
(age_day > 1488 AND ISNULL(OPV5)) OR 
CHK_JE='0' OR 
CHK_M='0';

 




