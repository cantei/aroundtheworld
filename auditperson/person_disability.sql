# ผู้พิการ
SELECT h.villcode,h.hno,p.pcucodeperson,p.pid
,p.idcard
,CONCAT(c.titlename,p.fname,'   ',p.lname) as fullname
,p.birth
,p.typelive 
,concat(DATE_FORMAT(p.birth,'%d-%m'),'-',year(p.birth)+543) as born 
,u.registerno,u.dateregister
,CONCAT(h.hno,'  ','หมู่ที่','  ',substr(h.villcode,8,1))  as addess
,GROUP_CONCAT(t.typecode ORDER BY t.typecode SEPARATOR ',') as type
,GROUP_CONCAT(i.incompletename ORDER BY t.typecode SEPARATOR ',' ) as incompletename
-- ,i.incompletename,i.incompletetype
,GROUP_CONCAT(t.unablelevel ORDER BY t.typecode SEPARATOR ',') as levels
-- ,t.unablelevel,t.datestartunable
,CONCAT(v.fname,'  ',v.lname) as 'volanteer'
FROM personunable u 
LEFT JOIN personunable1type t
ON u.pcucodeperson=t.pcucodeperson AND u.pid=t.pid 
LEFT JOIN cpersonincomplete i
ON t.typecode=i.incompletecode 
LEFT JOIN person p
ON u.pcucodeperson=p.pcucodeperson AND u.pid=p.pid 
LEFT JOIN ctitle c
ON p.prename=c.titlecode
LEFT JOIN house h
ON h.pcucode=p.pcucodeperson AND h.hcode=p.hcode AND h.pid=p.pid
LEFT JOIN person v
ON h.pcucodepersonvola=v.pcucodeperson and	h.pidvola=v.pid 
 
WHERE p.typelive in ('1','3') 
AND p.dischargetype='9'
GROUP BY u.pid
