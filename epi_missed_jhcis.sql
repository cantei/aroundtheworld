SELECT t2.hospcode,t2.person_id,t2.cid,t2.fname,t2.lname,t2.birth
,t2.age_day,t2.hno,substr(t2.villcode,7,2) as moo
,if(AGE_DAY >1 AND NOT ISNULL(t2.BCG),'1',IF(AGE_DAY >1 AND ISNULL(t2.BCG) ,'0','9')) as BCG
,if(AGE_DAY >1 AND NOT ISNULL(t2.HBV1),'1',IF(AGE_DAY >1 AND ISNULL(t2.HBV1) ,'0','9')) as HBV1
,if(AGE_DAY >56 AND NOT ISNULL(t2.DHB1),'1',IF(AGE_DAY >56 AND ISNULL(t2.DHB1) ,'0','9')) as DHB1
,if(AGE_DAY >56 AND NOT ISNULL(t2.OPV1),'1',IF(AGE_DAY >56 AND ISNULL(t2.OPV1) ,'0','9')) as OPV1
,if(AGE_DAY >56 AND NOT ISNULL(t2.R21),'1',IF(AGE_DAY >56 AND ISNULL(t2.R21) ,'0','9')) as R21
,if(AGE_DAY >112 AND NOT ISNULL(t2.DHB2),'1',IF(AGE_DAY >112 AND ISNULL(t2.DHB2) ,'0','9')) as DHB2
,if(AGE_DAY >112 AND NOT ISNULL(t2.OPV2),'1',IF(AGE_DAY >112 AND ISNULL(t2.OPV2) ,'0','9')) as OPV2
,if(AGE_DAY >112 AND NOT ISNULL(t2.R22),'1',IF(AGE_DAY >112 AND ISNULL(t2.R22),'0','9')) as R22
,if(AGE_DAY >112 AND NOT ISNULL(t2.IPV),'1',IF(AGE_DAY >112 AND ISNULL(t2.IPV) ,'0','9')) as IPV
,if(AGE_DAY >168 AND NOT ISNULL(t2.DHB3),'1',IF(AGE_DAY >168 AND ISNULL(t2.DHB3) ,'0','9')) as DHB3
,if(AGE_DAY >168 AND NOT ISNULL(t2.OPV3),'1',IF(AGE_DAY >168 AND ISNULL(t2.OPV3) ,'0','9')) as OPV3
,if(AGE_DAY >168 AND NOT ISNULL(t2.R23),'1',IF(AGE_DAY >168 AND ISNULL(t2.R23) ,'0','9')) as R23
,if(AGE_DAY >224 AND NOT ISNULL(t2.MMR1),'1',IF(AGE_DAY >252 AND ISNULL(t2.MMR1) ,'0','9')) as MMR1
,if(AGE_DAY >365 AND NOT ISNULL(t2.LAJE1),'1',IF(AGE_DAY >365 AND ISNULL(t2.LAJE1) ,'0','9')) as LAJE1
,if(AGE_DAY >504 AND NOT ISNULL(t2.DTP4),'1',IF(AGE_DAY >504 AND ISNULL(t2.DTP4) ,'0','9')) as DTP4
,if(AGE_DAY >504 AND NOT ISNULL(t2.OPV4),'1',IF(AGE_DAY >504 AND ISNULL(t2.OPV4) ,'0','9')) as OPV4
,if(AGE_DAY >840 AND NOT ISNULL(t2.MMR2),'1',IF(AGE_DAY >840 AND ISNULL(t2.MMR2) ,'0','9')) as MMR2
,if(AGE_DAY >840 AND NOT ISNULL(t2.LAJE2),'1',IF(AGE_DAY >840 AND ISNULL(t2.LAJE2) ,'0','9')) as LAJE2
,if(AGE_DAY >1680 AND NOT ISNULL(t2.DTP5),'1',IF(AGE_DAY >1680 AND ISNULL(t2.DTP5) ,'0','9')) as DTP5
,if(AGE_DAY >1680 AND NOT ISNULL(t2.OPV5),'1',IF(AGE_DAY >1680 AND ISNULL(t2.OPV5) ,'0','9')) as OPV5  
FROM (


SELECT p.pcucodeperson as hospcode,p.pid as person_id,p.idcard as cid,p.fname,p.lname,p.birth
,TIMESTAMPDIFF(DAY,p.birth,CURDATE()) as age_day
,p.typelive,p.dischargetype
,h.hno,h.villcode
,t1.*
FROM person p
LEFT JOIN house h
ON p.pcucodeperson=h.pcucode AND p.hcode=h.hcode
LEFT JOIN 
(
SELECT e.pcucodeperson,e.pid
,MIN(IF(e.vaccinecode='BCG',e.dateepi,NULL)) AS BCG
,MIN(IF(e.vaccinecode='HBV1',e.dateepi,NULL)) AS HBV1
,MIN(IF(e.vaccinecode='DHB1',e.dateepi,NULL)) AS DHB1
,MIN(IF(e.vaccinecode='OPV1',e.dateepi,NULL)) AS OPV1
,MIN(IF(e.vaccinecode='R21',e.dateepi,NULL)) AS R21
,MIN(IF(e.vaccinecode='DHB2',e.dateepi,NULL)) AS DHB2
,MIN(IF(e.vaccinecode='OPV2',e.dateepi,NULL)) AS OPV2
,MIN(IF(e.vaccinecode='R22',e.dateepi,NULL)) AS R22
,MIN(IF(e.vaccinecode='IPV-P',e.dateepi,NULL)) AS IPV
,MIN(IF(e.vaccinecode='DHB3',e.dateepi,NULL)) AS DHB3
,MIN(IF(e.vaccinecode='OPV3',e.dateepi,NULL)) AS OPV3
,MIN(IF(e.vaccinecode='R23',e.dateepi,NULL)) AS R23
,MIN(IF(e.vaccinecode='MMR1' OR e.vaccinecode='MMR',e.dateepi,NULL)) AS MMR1
,MIN(IF(e.vaccinecode='J11',e.dateepi,NULL)) AS LAJE1
,MIN(IF(e.vaccinecode='DTP4',e.dateepi,NULL)) AS DTP4
,MIN(IF(e.vaccinecode='OPV4',e.dateepi,NULL)) AS OPV4
,MIN(IF(e.vaccinecode='J12',e.dateepi,NULL)) AS LAJE2
,MIN(IF(e.vaccinecode='MMR2' OR e.vaccinecode='MMR',e.dateepi,NULL)) AS MMR2
,MIN(IF(e.vaccinecode='DTP5',e.dateepi,NULL)) AS DTP5
,MIN(IF(e.vaccinecode='OPV5',e.dateepi,NULL)) AS OPV5
,MIN(IF(e.vaccinecode='R11',e.dateepi,NULL)) AS R11
,MIN(IF(e.vaccinecode='R12',e.dateepi,NULL)) AS R12
FROM visitepi e
GROUP BY e.pcucodeperson,e.pid
) as t1
ON t1.pcucodeperson=p.pcucodeperson AND t1.pid=p.pid 
-- WHERE p.birth  BETWEEN '2015-10-01' AND '2016-09-30'  /*  age group1  */
WHERE p.birth  BETWEEN '2014-10-01' AND '2015-09-30'  /*  age group2  */
AND p.typelive in ('1','3')  and	 p.dischargetype='9'
) as t2
HAVING BCG='0'  OR HBV1='0' 
OR DHB1='0'  OR OPV1= '0'  OR R21='0' 
OR DHB2='0'  OR OPV2='0' OR IPV='0' OR R22='0' 
OR DHB3='0'  OR OPV3='0' OR R23='0' 
OR MMR1='0'  
/*  end grp1  */
OR LAJE1='0' OR DTP4='0'  OR OPV4='0'
/*  end grp2  */
 -- OR MMR2='0' OR LAJE2='0'
/*  end grp3  */
-- OR DTP5='0' OR OPV5='0' 
/*  end grp4  */

ORDER BY  moo,hno,birth  DESC 
