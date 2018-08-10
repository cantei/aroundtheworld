SELECT 
p.idcard,concat(c.titlename,p.fname,"  ",p.lname) as fullname,p.birth,p.sex,p.typelive,p.nation
,h.hno,substr(h.villcode,7,2) as moo
,s.villcode
,v.villname
,vs.villcode as schoolmoo
,s.schoolno
,s.classeducate
-- ,s.classroom
,cs.classname
,concat('ร.ร.',vs.schoolname) as nameschool
-- ,n.dateservice,n.weight,n.hight
FROM personstudent s
LEFT JOIN village v
ON s.pcucode=v.pcucode AND s.villcode=v.villcode 
LEFT JOIN villageschool vs
ON s.pcucode=vs.pcucode AND s.villcode=vs.villcode  AND s.schoolno=vs.schoolno 
LEFT JOIN cschoolclass cs 
ON s.classeducate=cs.classcode 
LEFT JOIN person p
ON s.pcucodeperson=p.pcucodeperson AND s.pid=p.pid 
LEFT JOIN ctitle c
ON	p.prename=c.titlecode
LEFT JOIN house h
ON p.pcucodeperson=h.pcucode AND p.hcode=h.hcode
-- LEFT JOIN studenthealthnutrition n 
-- ON p.pcucodeperson=n.pcucodeperson AND p.pid=n.pid 
WHERE v.villno<>'0'
AND s.villcode in ('84120702','84120704')
AND s.classeducate=4
-- AND p.sex='2'
ORDER BY schoolmoo,fname
