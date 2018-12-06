SELECT 
-- s.pcucodeperson,s.pcucode,s.pid
p.idcard,p.fname,p.lname,p.birth,p.sex,p.typelive 
,TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) as agemonth
,h.hno,substr(h.villcode,7,2) as moo
,s.villcode
,v.villname
,s.schoolno
,s.classeducate
-- ,s.classroom
,cs.classname
,concat('ร.ร.',vs.schoolname) as nameschool
FROM personstudent s
LEFT JOIN village v
ON s.pcucode=v.pcucode AND s.villcode=v.villcode 
LEFT JOIN villageschool vs
ON s.pcucode=vs.pcucode AND s.villcode=vs.villcode  AND s.schoolno=vs.schoolno 
LEFT JOIN cschoolclass cs 
ON s.classeducate=cs.classcode 
LEFT JOIN person p
ON s.pcucodeperson=p.pcucodeperson AND s.pid=p.pid 
LEFT JOIN house h
ON p.pcucodeperson=h.pcucode AND p.hcode=h.hcode
-- WHERE v.villno<>'0'
-- AND s.villcode='84120702'
-- AND s.classeducate=9
-- where	  p.idcard in ()
where fname = 'รุ่งฤทธิ์'
ORDER BY  h.villcode,(SPLIT_STR(h.hno,'/', 1)*1),(SPLIT_STR(h.hno,'/',2)*1)
