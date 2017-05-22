# 1 AGE BCG
SELECT p.pcucodeperson,p.pid,p.birth
,e.vaccinecode,e.dateepi,e.hosservice
,TIMESTAMPDIFF(DAY,p.birth,e.dateepi)  as INTERVALS
FROM person p
INNER JOIN visitepi  e
ON p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
WHERE e.vaccinecode='BCG' 
HAVING INTERVALS <  0  OR INTERVALS > 3 
ORDER BY e.dateepi DESC ;

# 2 AGE HBV1
SELECT p.pcucodeperson,p.pid,p.birth
,e.vaccinecode,e.dateepi,e.hosservice
,TIMESTAMPDIFF(DAY,p.birth,e.dateepi)  as INTERVALS
FROM person p
INNER JOIN visitepi  e
ON p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
WHERE e.vaccinecode='HBV1' 
HAVING INTERVALS <  0  OR INTERVALS > 1
ORDER BY e.dateepi DESC ;

# 3 AGE DHB1
SELECT p.pcucodeperson,p.pid,p.birth
,e.vaccinecode,e.dateepi,e.hosservice
,TIMESTAMPDIFF(DAY,p.birth,e.dateepi)  as INTERVALS
FROM person p
INNER JOIN visitepi  e
ON p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
WHERE e.vaccinecode='DHB1' 
HAVING INTERVALS < 42
ORDER BY e.dateepi DESC ;

# 4 AGE MMR1
SELECT p.pcucodeperson,p.pid,p.birth
,e.vaccinecode,e.dateepi,e.hosservice
,TIMESTAMPDIFF(DAY,p.birth,e.dateepi)  as INTERVALS
FROM person p
INNER JOIN visitepi  e
ON p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
WHERE e.vaccinecode='MMR' 
HAVING INTERVALS < 252
ORDER BY e.dateepi DESC ;

# 5 AGE MMR2
SELECT p.pcucodeperson,p.pid,p.birth
,e.vaccinecode,e.dateepi,e.hosservice
,TIMESTAMPDIFF(DAY,p.birth,e.dateepi)  as INTERVALS
FROM person p
INNER JOIN visitepi  e
ON p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
WHERE e.vaccinecode='MMR2' 
HAVING INTERVALS < 504
ORDER BY e.dateepi DESC ;

# 6 AGE LAJE1
SELECT p.pcucodeperson,p.pid,p.birth
,e.vaccinecode,e.dateepi,e.hosservice
,TIMESTAMPDIFF(DAY,p.birth,e.dateepi)  as INTERVALS
FROM person p
INNER JOIN visitepi  e
ON p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
WHERE e.vaccinecode='J11' 
HAVING INTERVALS < 252
ORDER BY e.dateepi DESC ;

# 7 AGE DTP4
SELECT p.pcucodeperson,p.pid,p.birth
,e.vaccinecode,e.dateepi,e.hosservice
,TIMESTAMPDIFF(DAY,p.birth,e.dateepi)  as INTERVALS
FROM person p
INNER JOIN visitepi  e
ON p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
WHERE e.vaccinecode='DTP4' 
HAVING INTERVALS < 365
ORDER BY e.dateepi DESC ;


# 8 AGE ROTA 
SELECT t.pcucodeperson,t.pid,t.birth
,ROTA1,ROTA2,ROTA3
,TIMESTAMPDIFF(WEEK,t.birth,t.ROTA1) AS AGE_WEEK_DOSE1
,TIMESTAMPDIFF(WEEK,t.birth,t.ROTA2) AS  AGE_WEEK_DOSE2
,TIMESTAMPDIFF(WEEK,t.birth,t.ROTA3) AS  AGE_WEEK_DOSE3 
FROM 
(
SELECT p.pcucodeperson,p.pid,p.birth
,MIN(IF(e.vaccinecode='R21',e.dateepi,NULL)) AS ROTA1
,MIN(IF(e.vaccinecode='R22',e.dateepi,NULL)) AS ROTA2
,MIN(IF(e.vaccinecode='R23',e.dateepi,NULL)) AS ROTA3
FROM person p
INNER JOIN visitepi  e
ON p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
GROUP BY p.pcucodeperson,p.pid
) as t
HAVING AGE_WEEK_DOSE1 < 6  OR AGE_WEEK_DOSE1 > 15  OR AGE_WEEK_DOSE2  > 32 OR AGE_WEEK_DOSE3  > 32
ORDER BY ROTA1  ;
