SELECT village
,sum(if(inscl in ('WEL','UCS'),1,0)) as UC
,sum(if(inscl in ('SSS'),1,0)) as SSS
,sum(if(inscl in ('OFC'),1,0)) as OFC
,sum(if(inscl NOT in ('WEL','UCS','SSS','OFC'),1,0)) as OTHER

FROM 
(


SELECT concat(v.fname,'   ',v.lname) as volanteer 
,concat(' ',h.hno) as hno ,substr(h.villcode,8,1) as village 
,p.fname,p.lname,p.typelive 
-- ,r.rightcode,r.rightname
,g.rightgroupname
,CASE WHEN g.rightgroupcode='1'  THEN 'OFC'
			WHEN g.rightgroupcode='2'  THEN 'SSS'
			WHEN g.rightgroupcode='3'  THEN 'UCS'
			WHEN g.rightgroupcode='4'  THEN 'WEL'
ELSE 'OTHER'
END AS inscl
,p.hossub,p.hosmain
FROM person p
LEFT JOIN house h 
ON p.pcucodeperson=h.pcucode AND p.hcode=h.hcode 
LEFT JOIN person v
ON h.pcucodepersonvola=v.pcucodeperson AND h.pidvola=v.pid 
LEFT JOIN cright r	 
on	p.rightcode=r.rightcode 
LEFT JOIN crightgroup g
ON r.rightgroup=g.rightgroupcode 

WHERE p.dischargetype='9'
AND substr(h.villcode,8,1)<>'0'
-- AND p.typelive='3' 

GROUP BY h.hno ,h.villcode,p.pid  
-- HAVING inscl in ('UCS','WEL')
-- AND p.hosmain <>'11366'
ORDER BY (substr(h.villcode,8,1)),volanteer,(SPLIT_STR(h.hno,'/', 1)*1),(SPLIT_STR(h.hno,'/',2)*1)
) as t
GROUP BY village 
