SELECT concat(v.fname,' ',v.lname) as volanteer
,h.hno,h.villcode
,concat(o.fname,' ',o.lname) as houseowner
,if(h.area='1','เทศบาล','อบต') as area
,count(*) as total
,sum(if(p.typelive IN ('1','2'),1,0)) as gov_regist
,sum(if(p.typelive IN ('1','3'),1,0)) as alive
FROM house h
LEFT JOIN person o
ON h.pcucode=o.pcucodeperson AND h.hcode=o.hcode AND h.pid=o.pid 
LEFT JOIN person p
ON h.pcucode=p.pcucodeperson AND h.hcode=p.hcode
LEFT JOIN person v
ON h.pcucodepersonvola=v.pcucodeperson AND h.pidvola=v.pid 
WHERE substr(h.villcode,8,1)='3'
-- AND h.area='2'
GROUP BY h.hno 
-- HAVING alive<>0
ORDER BY volanteer,(SPLIT_STR(h.hno,'/', 1)*1),(SPLIT_STR(h.hno,'/',2)*1)
