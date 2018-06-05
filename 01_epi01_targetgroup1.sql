# เด็กอายุครบ 1 ปี 
SET @d1='2017-10-01';
SET @d2='2018-09-30';

SELECT p.idcard
-- p.pcucodeperson,p.pid
,concat(c.titlename,p.fname,'    ',p.lname) as fullname
,substr(h.villcode,7,2) as moo,h.hno
,p.birth
,TIMESTAMPDIFF(month,p.birth,CURDATE()) as agemonth
,p.mother
,MIN(if(e.vaccinecode='BCG',e.dateepi,NULL)) as 'BCG'
,MIN(if(e.vaccinecode='HBV1',e.dateepi,NULL)) as 'HBV1'
,MIN(if(e.vaccinecode in ('DTP1','DHB1','D11','D21','D31','D41','D51'),e.dateepi,NULL)) as 'DHB1'
,MIN(if(e.vaccinecode in ('OPV1','D41','D51'),e.dateepi,NULL)) as 'OPV1'
,MIN(if(e.vaccinecode in ('DTP2','DHB2','D12','D22','D32','D42','D52'),e.dateepi,NULL)) as 'DHB2'
,MIN(if(e.vaccinecode in ('OPV2','D42','D52'),e.dateepi,NULL)) as 'OPV2'
,MIN(if(e.vaccinecode in ('IPV-P','D42','D52'),e.dateepi,NULL)) as 'IPV'
,MIN(if(e.vaccinecode in ('DTP3','DHB3','D13','D23','D33','D43','D53'),e.dateepi,NULL)) as 'DHB3'
,MIN(if(e.vaccinecode in ('OPV3','D43','D53'),e.dateepi,NULL)) as 'OPV3'
,MIN(if(e.vaccinecode='MMR',e.dateepi,NULL)) as 'MMR1'
,concat(v.fname,'    ',v.lname) as 'volanteer'
FROM person p
LEFT JOIN ctitle c
ON p.prename=c.titlecode
LEFT JOIN house h
on p.hcode=h.hcode AND p.pcucodeperson=h.pcucode 
LEFT JOIN visitepi e
on p.pid=e.pid AND p.pcucodeperson=e.pcucodeperson 
LEFT JOIN person v
ON h.pcucodepersonvola=v.pcucodeperson AND h.pidvola=v.pid 
WHERE p.typelive in ('1','3') 
AND p.dischargetype='9'
AND p.nation='99'
AND p.birth BETWEEN DATE_SUB(@d1, INTERVAL 1 YEAR) AND DATE_SUB(@d2, INTERVAL 1 YEAR)
GROUP BY CONCAT(p.pcucodeperson,p.pid)
ORDER BY  h.villcode,(SPLIT_STR(h.hno,'/', 1)*1),(SPLIT_STR(h.hno,'/',2)*1);
