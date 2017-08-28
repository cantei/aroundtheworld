# jhcis
SELECT *
FROM 
(
SELECT p.pcucodeperson,p.idcard,p.birth,p.hnomoi,p.mumoi
,GROUP_CONCAT(if(e.vaccinecode='BCG',concat(CONVERT(e.dateepi USING utf8),'(',e.hosservice,')'),NULL) ORDER BY e.dateepi ) as BCG
,GROUP_CONCAT(if(e.vaccinecode='HBV1',concat(CONVERT(e.dateepi USING utf8),'(',e.hosservice,')'),NULL) ORDER BY e.dateepi ) as HBV1
,GROUP_CONCAT(if(e.vaccinecode='DHB1',concat(CONVERT(e.dateepi USING utf8),'(',e.hosservice,')'),NULL) ORDER BY e.dateepi ) as DHB1
,GROUP_CONCAT(if(e.vaccinecode='DHB2',concat(CONVERT(e.dateepi USING utf8),'(',e.hosservice,')'),NULL) ORDER BY e.dateepi ) as DHB2
,GROUP_CONCAT(if(e.vaccinecode='DHB3',concat(CONVERT(e.dateepi USING utf8),'(',e.hosservice,')'),NULL) ORDER BY e.dateepi ) as DHB3
,GROUP_CONCAT(if(e.vaccinecode='OPV1',concat(CONVERT(e.dateepi USING utf8),'(',e.hosservice,')'),NULL) ORDER BY e.dateepi ) as OPV1
,GROUP_CONCAT(if(e.vaccinecode='OPV2',concat(CONVERT(e.dateepi USING utf8),'(',e.hosservice,')'),NULL) ORDER BY e.dateepi ) as OPV2
,GROUP_CONCAT(if(e.vaccinecode='OPV3',concat(CONVERT(e.dateepi USING utf8),'(',e.hosservice,')'),NULL) ORDER BY e.dateepi ) as OPV3
,GROUP_CONCAT(if(e.vaccinecode='IPV-P',concat(CONVERT(e.dateepi USING utf8),'(',e.hosservice,')'),NULL) ORDER BY e.dateepi ) as IPV
,GROUP_CONCAT(if(e.vaccinecode in ('R11','R21'),concat(CONVERT(e.dateepi USING utf8),'(',e.hosservice,')'),NULL) ORDER BY e.dateepi ) as ROTA1
,GROUP_CONCAT(if(e.vaccinecode in ('R12','R22'),concat(CONVERT(e.dateepi USING utf8),'(',e.hosservice,')'),NULL) ORDER BY e.dateepi ) as ROTA2
,GROUP_CONCAT(if(e.vaccinecode in ('R13','R23'),concat(CONVERT(e.dateepi USING utf8),'(',e.hosservice,')'),NULL) ORDER BY e.dateepi ) as ROTA3
,GROUP_CONCAT(if(e.vaccinecode='MMR',concat(CONVERT(e.dateepi USING utf8),'(',e.hosservice,')'),NULL) ORDER BY e.dateepi ) as MMR1
,GROUP_CONCAT(if(e.vaccinecode='JE1',concat(CONVERT(e.dateepi USING utf8),'(',e.hosservice,')'),NULL) ORDER BY e.dateepi ) as JE1
,GROUP_CONCAT(if(e.vaccinecode='JE2',concat(CONVERT(e.dateepi USING utf8),'(',e.hosservice,')'),NULL) ORDER BY e.dateepi ) as JE2
,GROUP_CONCAT(if(e.vaccinecode='JE3',concat(CONVERT(e.dateepi USING utf8),'(',e.hosservice,')'),NULL) ORDER BY e.dateepi ) as JE3
,GROUP_CONCAT(if(e.vaccinecode='J11',concat(CONVERT(e.dateepi USING utf8),'(',e.hosservice,')'),NULL) ORDER BY e.dateepi ) as LAJE1
,GROUP_CONCAT(if(e.vaccinecode='J12',concat(CONVERT(e.dateepi USING utf8),'(',e.hosservice,')'),NULL) ORDER BY e.dateepi ) as LAJE2
,GROUP_CONCAT(if(e.vaccinecode='MMR2',concat(CONVERT(e.dateepi USING utf8),'(',e.hosservice,')'),NULL) ORDER BY e.dateepi ) as MMR2
,GROUP_CONCAT(if(e.vaccinecode='DTP4',concat(CONVERT(e.dateepi USING utf8),'(',e.hosservice,')'),NULL) ORDER BY e.dateepi ) as DTP4
,GROUP_CONCAT(if(e.vaccinecode='OPV4',concat(CONVERT(e.dateepi USING utf8),'(',e.hosservice,')'),NULL) ORDER BY e.dateepi ) as OPV4
,GROUP_CONCAT(if(e.vaccinecode='DTP5',concat(CONVERT(e.dateepi USING utf8),'(',e.hosservice,')'),NULL) ORDER BY e.dateepi ) as DTP5
,GROUP_CONCAT(if(e.vaccinecode='OPV5',concat(CONVERT(e.dateepi USING utf8),'(',e.hosservice,')'),NULL) ORDER BY e.dateepi ) as OPV5
from	 visitepi e
LEFT JOIN person p
ON e.pcucodeperson=p.pcucodeperson AND e.pid=p.pid 
where	p.birth > '2010-01-01'
GROUP BY p.idcard
) as t
HAVING LENGTH(BCG) > 17 
OR LENGTH(HBV1) > 17 
OR LENGTH(DHB1) > 17 
OR LENGTH(DHB2) > 17 
OR LENGTH(DHB3) > 17 
OR LENGTH(OPV1) > 17 
OR LENGTH(OPV2) > 17
OR LENGTH(OPV3) > 17 
OR LENGTH(IPV) > 17 
OR LENGTH(ROTA1) > 17
OR LENGTH(ROTA2) > 17
OR LENGTH(ROTA3) > 17
OR LENGTH(MMR1) > 17 
OR LENGTH(MMR2) > 17 
OR LENGTH(JE1) > 17 
OR LENGTH(JE2) > 17 
OR LENGTH(JE3) > 17 
OR LENGTH(LAJE1) > 17 
OR LENGTH(LAJE2) > 17 
OR LENGTH(DTP4) > 17 
OR LENGTH(OPV4) > 17 
OR LENGTH(DTP5) > 17 
OR LENGTH(OPV5) > 17 
ORDER BY t.birth
-- ORDER BY LENGTH(JE1) DESC ;

# 43 

SELECT HOSPCODE,CID,MMR1
FROM (
SELECT p.HOSPCODE,p.CID,p.`NAME`,p.LNAME,p.BIRTH,p.DISCHARGE,p.TYPEAREA 
,GROUP_CONCAT(IF(e.VACCINETYPE='010',concat(e.DATE_SERV,'(',e.VACCINEPLACE,')'),NULL) ORDER BY e.DATE_SERV ) AS BCG
,GROUP_CONCAT(IF(e.VACCINETYPE='041',concat(e.DATE_SERV,'(',e.VACCINEPLACE,')'),NULL)) AS HBV
,GROUP_CONCAT(IF(e.VACCINETYPE='091',concat(e.DATE_SERV,'(',e.VACCINEPLACE,')'),NULL)) AS DHB1
,GROUP_CONCAT(IF(e.VACCINETYPE='092',concat(e.DATE_SERV,'(',e.VACCINEPLACE,')'),NULL)) AS DHB2
,GROUP_CONCAT(IF(e.VACCINETYPE='093',concat(e.DATE_SERV,'(',e.VACCINEPLACE,')'),NULL)) AS DHB3
,GROUP_CONCAT(IF(e.VACCINETYPE='081',concat(e.DATE_SERV,'(',e.VACCINEPLACE,')'),NULL)) AS OPV1
,GROUP_CONCAT(IF(e.VACCINETYPE='082',concat(e.DATE_SERV,'(',e.VACCINEPLACE,')'),NULL)) AS OPV2
,GROUP_CONCAT(IF(e.VACCINETYPE='083',concat(e.DATE_SERV,'(',e.VACCINEPLACE,')'),NULL)) AS OPV3
,GROUP_CONCAT(IF(e.VACCINETYPE='401',concat(e.DATE_SERV,'(',e.VACCINEPLACE,')'),NULL)) AS IPV
,GROUP_CONCAT(IF((e.VACCINETYPE='R11' OR e.VACCINETYPE='R21'),concat(e.DATE_SERV,'(',e.VACCINEPLACE,')'),NULL)) AS ROTA1
,GROUP_CONCAT(IF((e.VACCINETYPE='R12' OR e.VACCINETYPE='R22'),concat(e.DATE_SERV,'(',e.VACCINEPLACE,')'),NULL)) AS ROTA2
,GROUP_CONCAT(IF((e.VACCINETYPE='R13' OR e.VACCINETYPE='R23'),concat(e.DATE_SERV,'(',e.VACCINEPLACE,')'),NULL)) AS ROTA3
,GROUP_CONCAT(IF(e.VACCINETYPE='061',concat(e.DATE_SERV,'(',e.VACCINEPLACE,')'),NULL)) AS MMR1
,GROUP_CONCAT(IF(e.VACCINETYPE='051',concat(e.DATE_SERV,'(',e.VACCINEPLACE,')'),NULL)) AS JE1
,GROUP_CONCAT(IF(e.VACCINETYPE='052',concat(e.DATE_SERV,'(',e.VACCINEPLACE,')'),NULL)) AS JE2
,GROUP_CONCAT(IF(e.VACCINETYPE='053',concat(e.DATE_SERV,'(',e.VACCINEPLACE,')'),NULL)) AS JE3
,GROUP_CONCAT(IF(e.VACCINETYPE='J11',concat(e.DATE_SERV,'(',e.VACCINEPLACE,')'),NULL)) AS LAJE1
,GROUP_CONCAT(IF(e.VACCINETYPE='J12',concat(e.DATE_SERV,'(',e.VACCINEPLACE,')'),NULL)) AS LAJE2
,GROUP_CONCAT(IF(e.VACCINETYPE='073',concat(e.DATE_SERV,'(',e.VACCINEPLACE,')'),NULL)) AS MMR2
,GROUP_CONCAT(IF(e.VACCINETYPE='034',concat(e.DATE_SERV,'(',e.VACCINEPLACE,')'),NULL)) AS DTP4
,GROUP_CONCAT(IF(e.VACCINETYPE='084',concat(e.DATE_SERV,'(',e.VACCINEPLACE,')'),NULL)) AS OPV4
,GROUP_CONCAT(IF(e.VACCINETYPE='035',concat(e.DATE_SERV,'(',e.VACCINEPLACE,')'),NULL)) AS DTP5
,GROUP_CONCAT(IF(e.VACCINETYPE='085',concat(e.DATE_SERV,'(',e.VACCINEPLACE,')'),NULL)) AS OPV5
FROM person p
LEFT JOIN epi e
ON p.HOSPCODE=e.HOSPCODE AND p.pid =e.pid 
WHERE	 p.TYPEAREA in('1','3')
AND p.DISCHARGE='9'
AND TIMESTAMPDIFF(year,p.BIRTH,CURDATE()) < 5
GROUP BY p.CID
) as t
HAVING LENGTH(MMR1) > 17
-- AND HOSPCODE='07716'
ORDER BY birth
