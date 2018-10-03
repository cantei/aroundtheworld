SELECT concat(v.fname,' ',v.lname) as volanteer
,h.hno,h.villcode
,concat(o.fname,' ',o.lname) as houseowner
,if(h.area='1','เทศบาล','อบต') as area
,count(*) as total
,sum(if(p.typelive IN ('1','2'),1,0)) as gov_regist
,concat(p.fname,'   ',p.lname) as member
,f.famposcode,f.famposname
,p.typelive
FROM house h
LEFT JOIN person o
ON h.pcucode=o.pcucodeperson AND h.hcode=o.hcode AND h.pid=o.pid 
LEFT JOIN person p
ON h.pcucode=p.pcucodeperson AND h.hcode=p.hcode
LEFT JOIN person v
ON h.pcucodepersonvola=v.pcucodeperson AND h.pidvola=v.pid 
LEFT JOIN cfamilyposition f
ON p.familyposition=f.famposcode
WHERE substr(h.villcode,8,1)='2'
-- AND h.area='2'
GROUP BY h.hno,p.pid 
-- HAVING alive<>0
HAVING volanteer  LIKE '%จิต%'
ORDER BY volanteer,(SPLIT_STR(h.hno,'/', 1)*1),(SPLIT_STR(h.hno,'/',2)*1)
