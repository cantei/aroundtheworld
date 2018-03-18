
# 1 doses_interval DHB
SELECT t.pcucodeperson,t.pid,t.birth
,DHB1,DHB2,DHB3
,DATEDIFF(t.DHB2,t.DHB1) AS INTERVAL1 
,DATEDIFF(t.DHB3,t.DHB2) AS INTERVAL2 
FROM 
(
SELECT p.pcucodeperson,p.pid,p.birth
,MIN(IF(e.vaccinecode='DHB1',e.dateepi,NULL)) AS DHB1
,MIN(IF(e.vaccinecode='DHB2',e.dateepi,NULL)) AS DHB2
,MIN(IF(e.vaccinecode='DHB3',e.dateepi,NULL)) AS DHB3
FROM person p
INNER JOIN visitepi  e
ON p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
GROUP BY p.pcucodeperson,p.pid
) as t
HAVING INTERVAL1 < 28 OR INTERVAL2 < 28;
ORDER BY DHB3 DESC ;


# 2 doses_interval OPV
SELECT t.pcucodeperson,t.pid,t.birth
,OPV1,OPV2,OPV3
,DATEDIFF(t.OPV2,t.OPV1) AS INTERVAL1 
,DATEDIFF(t.OPV3,t.OPV2) AS INTERVAL2 
FROM 
(
SELECT p.pcucodeperson,p.pid,p.birth
,MIN(IF(e.vaccinecode='OPV1',e.dateepi,NULL)) AS OPV1
,MIN(IF(e.vaccinecode='OPV2',e.dateepi,NULL)) AS OPV2
,MIN(IF(e.vaccinecode='OPV3',e.dateepi,NULL)) AS OPV3
FROM person p
INNER JOIN visitepi  e
ON p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
GROUP BY p.pcucodeperson,p.pid
) as t
HAVING INTERVAL1 < 28 OR INTERVAL2 < 28
ORDER BY OPV3 DESC ;

# 3 doses_interval MMR
SELECT t.pcucodeperson,t.pid,t.birth
,MMR1,MMR2
,DATEDIFF(t.MMR2,t.MMR1) AS INTERVAL1 
FROM 
(
SELECT p.pcucodeperson,p.pid,p.birth
,MIN(IF(e.vaccinecode='MMR',e.dateepi,NULL)) AS MMR1
,MIN(IF(e.vaccinecode='MMR2',e.dateepi,NULL)) AS MMR2

FROM person p
INNER JOIN visitepi  e
ON p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
GROUP BY p.pcucodeperson,p.pid
) as t
HAVING INTERVAL1 < 28 
ORDER BY MMR2 DESC ;

# 4 doses_interval DTP

SELECT t.pcucodeperson,t.pid,t.birth
,DTP4,DTP5
,DATEDIFF(t.DTP5,t.DTP4) AS INTERVAL1 
FROM 
(
SELECT p.pcucodeperson,p.pid,p.birth
,MIN(IF(e.vaccinecode='DTP4',e.dateepi,NULL)) AS DTP4
,MIN(IF(e.vaccinecode='DTP5',e.dateepi,NULL)) AS DTP5

FROM person p
INNER JOIN visitepi  e
ON p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
GROUP BY p.pcucodeperson,p.pid
) as t
HAVING INTERVAL1 < 168 
ORDER BY DTP5 DESC ;


# 5 doses_interval  ROTA 

SELECT t.pcucodeperson,t.pid,t.birth
,R21,R22,R23
,DATEDIFF(t.R22,t.R21) AS INTERVAL1 
,DATEDIFF(t.R23,t.R22) AS INTERVAL2 
FROM 
(
SELECT p.pcucodeperson,p.pid,p.birth
,MIN(IF(e.vaccinecode='R21',e.dateepi,NULL)) AS R21
,MIN(IF(e.vaccinecode='R22',e.dateepi,NULL)) AS R22
,MIN(IF(e.vaccinecode='R23',e.dateepi,NULL)) AS R23
FROM person p
INNER JOIN visitepi  e
ON p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
GROUP BY p.pcucodeperson,p.pid
) as t
HAVING INTERVAL1 < 28 OR  INTERVAL2 < 28 
ORDER BY R23 DESC ;
