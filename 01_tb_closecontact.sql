SELECT concat(c.titlename,t0.fname,'   ',t0.lname) as fullname
,t0.birth,t0.age,t0.hno,t0.moo
,'ผู้้สมผัสร่วมบ้าน' as ref 
,'1'  as grp
,concat(person.fname,'  ',person.lname) as 'อสม'
FROM 
(
SELECT p.prename,p.fname,p.lname,p.birth
,TIMESTAMPDIFF(year,p.birth,CURDATE()) as age
,p.typelive,p.dischargetype
,h.hno,substr(h.villcode,7,2) as moo 
,h.pcucodepersonvola,h.pidvola 
FROM person p
INNER JOIN house h
ON p.pcucodeperson=h.pcucode AND p.hcode=h.hcode
WHERE  p.typelive in('1','3')
AND p.dischargetype='9'
AND h.hno in ('72','94','999') AND h.villcode='84120707'
ORDER BY moo,(SPLIT_STR(hno,'/', 1)*1),(SPLIT_STR(hno,'/',2)*1)
) as t0
LEFT JOIN person 
ON t0.pcucodepersonvola=person.pcucodeperson AND t0.pidvola=person.pid
LEFT JOIN ctitle c
ON t0.prename=c.titlecode ;
