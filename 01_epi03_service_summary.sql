# จำนวนผู้รับบริการ จำแนกรายวัคซีน (ใบเบิกวัคซัน)

SET  @thisyear=YEAR(CURDATE()) ;
SET  @thismonth=MONTH(CURDATE()) ;
SELECT a.dateepi
,sum(if(vaccinecode in ('DHB1','DHB2','DHB3'),1,0)) as DHB
,sum(if(vaccinecode in ('OPV1','OPV2','OPV3','OPV4','OPV5'),1,0)) as OPV
,sum(if(vaccinecode in ('IPV-P'),1,0)) as IPV
,sum(if(vaccinecode in ('MMR','MMR2'),1,0)) as MMR
,sum(if(vaccinecode in ('DTP4','DTP5'),1,0)) as DTP
,sum(if(vaccinecode in ('J11','J12'),1,0)) as LAJE
,sum(if(vaccinecode in ('HPVs1','HPVs2'),1,0)) as HPV
,sum(if(SUBSTR(vaccinecode,1,2) in ('dT','TT'),1,0)) as TT
FROM visitepi a
INNER JOIN person p
ON p.pcucodeperson=a.pcucodeperson AND p.pid=a.pid
AND p.pcucodeperson=a.hosservice
-- WHERE year(a.dateepi)=@thisyear AND month(a.dateepi)=(@thismonth-1)
GROUP BY a.dateepi
ORDER BY a.dateepi DESC ;
