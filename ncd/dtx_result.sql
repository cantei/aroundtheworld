SELECT p.fname,p.lname,v.visitdate
,l.sugarnumdigit as dtx
,if(l.foodsuspend='0','งด','ไม่งด') as foodsuspend
FROM visitlabsugarblood l
LEFT JOIN visit v
ON l.visitno=v.visitno AND l.pcucode=v.pcucode 
LEFT JOIN person p
ON v.pcucodeperson=p.pcucodeperson AND v.pid=p.pid 
WHERE v.visitdate ='2018-08-23'
ORDER BY v.visitno DESC 
