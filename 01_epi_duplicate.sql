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
where	p.birth > '2013-01-01'
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
