# จำนวนนักเรียนหญิง ป.๔ ปีการศึกษา ๒๕๕๙ # 

SELECT t.villcode,t.schoolname,count(*) as n
FROM 
(
SELECT v.villcode,v.schoolname
,p.yeareducate
,p.pcucodeperson,p.pid
,m.fname,m.lname,m.birth,m.sex
,c.classname 
FROM  personstudent p 
LEFT JOIN villageschool  v 
ON v.pcucode = p.pcucode AND v.villcode = p.villcode AND v.schoolno = p.schoolno 
INNER JOIN cschoolclass c
ON c.classcode = p.classeducate
LEFT JOIN person m 
ON p.pcucodeperson=m.pcucodeperson AND p.pid=m.pid  
WHERE
-- v.villcode='67010207' AND 
p.classeducate='7' AND 
m.sex='2'
ORDER BY c.classcode,m.pid
) as t
GROUP BY t.villcode
