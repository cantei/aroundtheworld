SELECT p.pcucodeperson,p.pid,p.idcard as cid
,c.titlename
,p.fname,p.lname,p.birth
,TIMESTAMPDIFF(YEAR,p.birth,CURDATE()) as age_year
,TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) as age_month
,TIMESTAMPDIFF(DAY,p.birth,CURDATE()) as age_day
,h.hno,substr(h.villcode,7,2) as moo
,MIN(IF(e.vaccinecode='HBV1',e.dateepi,NULL)) AS HBV1
,MIN(IF(e.vaccinecode='BCG',e.dateepi,NULL)) AS BCG
,MIN(IF(e.vaccinecode in ('DHB1','DTP1'),e.dateepi,NULL)) AS DHB1
,MIN(IF(e.vaccinecode='OPV1',e.dateepi,NULL)) AS OPV1
,MIN(IF(e.vaccinecode in ('DHB2','DTP2'),e.dateepi,NULL)) AS DHB2
,MIN(IF(e.vaccinecode='OPV2',e.dateepi,NULL)) AS OPV2
,MIN(IF(e.vaccinecode='IPV-P',e.dateepi,NULL)) AS IPV
,MIN(IF(e.vaccinecode in ('DHB2','DTP3'),e.dateepi,NULL)) AS DHB3
,MIN(IF(e.vaccinecode='OPV3',e.dateepi,NULL)) AS OPV3
,MIN(IF(e.vaccinecode='MMR',e.dateepi,NULL)) AS MMR1
,MIN(IF(e.vaccinecode in ('J11','JE1'),e.dateepi,NULL)) AS JE1
,MIN(IF(e.vaccinecode ='DTP4',e.dateepi,NULL)) AS DTP4
,MIN(IF(e.vaccinecode='OPV4',e.dateepi,NULL)) AS OPV4
,MIN(IF(e.vaccinecode='MMR2',e.dateepi,NULL)) AS MMR2
,MIN(IF(e.vaccinecode in ('J12','JE2','JE3'),e.dateepi,NULL)) AS JE1
,MIN(IF(e.vaccinecode ='DTP5',e.dateepi,NULL)) AS DTP5
,MIN(IF(e.vaccinecode='OPV5',e.dateepi,NULL)) AS OPV5
/*
,MIN(IF(e.vaccinecode='R21',e.dateepi,NULL)) AS R21
,MIN(IF(e.vaccinecode='R22',e.dateepi,NULL)) AS R22
,MIN(IF(e.vaccinecode='R23',e.dateepi,NULL)) AS R23
*/
,concat(v.fname,'    ',v.lname) as 'volanteer'
FROM person p
LEFT JOIN ctitle c
ON p.prename=c.titlecode
LEFT JOIN house h
ON p.pcucodeperson=h.pcucode AND p.hcode=h.hcode
LEFT JOIN person v
ON h.pcucodepersonvola=v.pcucodeperson and	h.pidvola=v.pid 
LEFT JOIN visitepi e
ON p.pcucodeperson=e.pcucodeperson AND p.pid =e.pid 
WHERE  p.typelive in ('1','3')  
AND	 p.dischargetype='9'
AND TIMESTAMPDIFF(YEAR,p.birth,CURDATE()) BETWEEN 0 AND 5 
GROUP BY p.idcard
ORDER BY p.birth DESC 
