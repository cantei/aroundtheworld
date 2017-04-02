######################################################################################################################################
# 43 files
######################################################################################################################################
SELECT p.HOSPCODE,p.CID,p.`NAME`,p.LNAME,p.BIRTH,p.DISCHARGE,p.TYPEAREA 
-- ,p.hnomoi,p.mumoi 
,TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) as AGE_MO
,MIN(IF(e.VACCINETYPE='010',e.DATE_SERV,NULL)) AS BCG
,MIN(IF(e.VACCINETYPE='041',e.DATE_SERV,NULL)) AS HBV1
,MIN(IF(e.VACCINETYPE='091',e.DATE_SERV,NULL)) AS DHB1
,MIN(IF(e.VACCINETYPE='081',e.DATE_SERV,NULL)) AS OPV1
,MIN(IF(e.VACCINETYPE='R21',e.DATE_SERV,NULL)) AS R21
,MIN(IF(e.VACCINETYPE='092',e.DATE_SERV,NULL)) AS DHB2
,MIN(IF(e.VACCINETYPE='082',e.DATE_SERV,NULL)) AS OPV2
,MIN(IF(e.VACCINETYPE='R22',e.DATE_SERV,NULL)) AS R22
,MIN(IF(e.VACCINETYPE='IPV-P',e.DATE_SERV,NULL)) AS IPV
,MIN(IF(e.VACCINETYPE='093',e.DATE_SERV,NULL)) AS DHB3
,MIN(IF(e.VACCINETYPE='083',e.DATE_SERV,NULL)) AS OPV3
,MIN(IF(e.VACCINETYPE='R23',e.DATE_SERV,NULL)) AS R23
,MIN(IF(e.VACCINETYPE='061',e.DATE_SERV,NULL)) AS MMR1
,MIN(IF(e.VACCINETYPE='073',e.DATE_SERV,NULL)) AS MMR2
,MIN(IF(e.VACCINETYPE='034',e.DATE_SERV,NULL)) AS DTP4
,MIN(IF(e.VACCINETYPE='084',e.DATE_SERV,NULL)) AS OPV4
,MIN(IF(e.VACCINETYPE='035',e.DATE_SERV,NULL)) AS DTP5
,MIN(IF(e.VACCINETYPE='085',e.DATE_SERV,NULL)) AS OPV5
,MIN(IF(e.VACCINETYPE='J11',e.DATE_SERV,NULL)) AS LAJE1
,MIN(IF(e.VACCINETYPE='J12',e.DATE_SERV,NULL)) AS LAJE2
,MIN(IF(e.VACCINETYPE='051',e.DATE_SERV,NULL)) AS JE1
,MIN(IF(e.VACCINETYPE='052',e.DATE_SERV,NULL)) AS JE2
,MIN(IF(e.VACCINETYPE='053',e.DATE_SERV,NULL)) AS JE3
,MIN(IF(e.VACCINETYPE='R11',e.DATE_SERV,NULL)) AS R11
,MIN(IF(e.VACCINETYPE='R12',e.DATE_SERV,NULL)) AS R12
-- ,if(p.birth>'2015-08-01','need IPV',NULL) AS IPVCHECK
-- ,if(p.birth>'2016-05-01','need ROTA',NULL) AS ROTACHECK
FROM person p
LEFT JOIN epi e
ON p.HOSPCODE=e.HOSPCODE AND p.pid =e.pid 
WHERE p.TYPEAREA in('1','3')
AND p.DISCHARGE='9'
/*  AGE GROUP  */
AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) < 13
AND p.HOSPCODE='07720'
GROUP BY p.CID

HAVING 
-- grp1
(ISNULL(BCG) AND AGE_MO > 1) OR
(ISNULL(HBV1) AND AGE_MO > 1 ) OR
(ISNULL(DHB1) AND  AGE_MO > 3) OR 
(ISNULL(OPV1) AND  AGE_MO > 3) OR 
(ISNULL(IPV) AND  AGE_MO > 5) OR 
(ISNULL(DHB2) AND AGE_MO > 5) OR 
(ISNULL(OPV2) AND AGE_MO > 5) OR 
(ISNULL(DHB3) AND AGE_MO > 7) OR 
(ISNULL(OPV3) AND AGE_MO > 7)  OR 
(ISNULL(MMR1) AND AGE_MO > 10)  OR 
-- grp2 
(ISNULL(LAJE1) AND AGE_MO > 13)  OR 
(ISNULL(DTP4) AND AGE_MO > 19)  OR 
(ISNULL(OPV4) AND AGE_MO > 19) OR

-- grp3 
(ISNULL(LAJE2) AND AGE_MO > 31)  OR 
 
-- grp5 
(ISNULL(DTP4) AND AGE_MO > 49)  OR 
(ISNULL(OPV4) AND AGE_MO > 49) 
ORDER BY p.birth

######################################################################################################################################

# JHCIS

######################################################################################################################################

SELECT p.pcucodeperson,p.idcard,p.fname,p.lname,p.birth,p.dischargetype,p.typelive 
,p.hnomoi,p.mumoi 
,TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) as AGE_MO
,MIN(IF(e.vaccinecode='BCG',e.dateepi,NULL)) AS BCG
,MIN(IF(e.vaccinecode='HBV1',e.dateepi,NULL)) AS HBV1
,MIN(IF(e.vaccinecode='DHB1',e.dateepi,NULL)) AS DHB1
,MIN(IF(e.vaccinecode='OPV1',e.dateepi,NULL)) AS OPV1
,MIN(IF(e.vaccinecode='DHB2',e.dateepi,NULL)) AS DHB2
,MIN(IF(e.vaccinecode='OPV2',e.dateepi,NULL)) AS OPV2
,MIN(IF(e.vaccinecode='DHB3',e.dateepi,NULL)) AS DHB3
,MIN(IF(e.vaccinecode='OPV3',e.dateepi,NULL)) AS OPV3
,MIN(IF(e.vaccinecode='MMR',e.dateepi,NULL)) AS MMR1
,MIN(IF(e.vaccinecode='MMR2',e.dateepi,NULL)) AS MMR2
,MIN(IF(e.vaccinecode='DTP4',e.dateepi,NULL)) AS DTP4
,MIN(IF(e.vaccinecode='OPV4',e.dateepi,NULL)) AS OPV4
,MIN(IF(e.vaccinecode='DTP5',e.dateepi,NULL)) AS DTP5
,MIN(IF(e.vaccinecode='OPV5',e.dateepi,NULL)) AS OPV5
,MIN(IF(e.vaccinecode='J11',e.dateepi,NULL)) AS LAJE1
,MIN(IF(e.vaccinecode='J12',e.dateepi,NULL)) AS LAJE2
,MIN(IF(e.vaccinecode='JE1',e.dateepi,NULL)) AS JE1
,MIN(IF(e.vaccinecode='JE2',e.dateepi,NULL)) AS JE2
,MIN(IF(e.vaccinecode='JE3',e.dateepi,NULL)) AS JE3
,MIN(IF(e.vaccinecode='IPV-P',e.dateepi,NULL)) AS IPV
,MIN(IF(e.vaccinecode='R21',e.dateepi,NULL)) AS R21
,MIN(IF(e.vaccinecode='R22',e.dateepi,NULL)) AS R22
,MIN(IF(e.vaccinecode='R23',e.dateepi,NULL)) AS R23
,MIN(IF(e.vaccinecode='R11',e.dateepi,NULL)) AS R11
,MIN(IF(e.vaccinecode='R12',e.dateepi,NULL)) AS R12
FROM person p
LEFT JOIN visitepi e
ON p.pcucodeperson=e.pcucodeperson AND p.pid =e.pid 
WHERE p.typelive in('1','3')
AND p.dischargetype='9'
AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) > 12
GROUP BY p.idcard
HAVING (AGE_MO > 4  AND (ISNULL(IPV)))
ORDER BY p.birth




