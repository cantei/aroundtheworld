# จำนวนนักเรียนหญิง ป.๔ ปีการศึกษา ๒๕๕๙ # 

SELECT t.schoolname,count(*) n 
FROM 
(
SELECT 
p.pcucodeperson,p.idcard 
,p.pid ,CONCAT(ctitle.titlename,p.fname,' ',p.lname)as pname 
,TIMESTAMPDIFF(year,date_format(p.birth,'%Y-%m-%d'),date_format(now(),'%Y-%m-%d')) age 
,villageschool.schoolname ,cschoolclass.classname 
FROM person p 
INNER JOIN personstudent ON personstudent.pcucodeperson = p.pcucodeperson AND personstudent.pid = p.pid 
LEFT JOIN villageschool ON villageschool.pcucode = personstudent.pcucode AND villageschool.villcode = personstudent.villcode AND villageschool.schoolno = personstudent.schoolno 
INNER JOIN cschoolclass ON cschoolclass.classcode = personstudent.classeducate 
LEFT JOIN ctitle ON ctitle.titlecode=p.prename
WHERE personstudent.classeducate ='7' AND personstudent.yeareducate='2559' AND p.sex='2'
AND RIGHT(villageschool.villcode,2) <>'00' 
AND CONCAT(p.pid,p.pcucodeperson) NOT IN (SELECT CONCAT(persondeath.pid,persondeath.pcucodeperson) FROM persondeath ) 
ORDER BY villageschool.schoolname ,cschoolclass.classname ASC
) as t
GROUP BY t.schoolname
