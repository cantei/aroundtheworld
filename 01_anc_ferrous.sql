SELECT p.idcard,p.fname,p.lname,p.birth
,TIMESTAMPDIFF(month,p.birth,v.visitdate) as age_month 
,v.visitno,v.visitdate
,d.drugcode,c.drugname
FROM visitdrug d
LEFT JOIN visit v
ON d.pcucode=v.pcucode AND d.visitno=v.visitno 
LEFT JOIN person p
ON v.pcucodeperson=p.pcucodeperson AND v.pid=p.pid 
LEFT JOIN cdrug c
ON d.drugcode=c.drugcode 
WHERE c.drugcode24='100497414002040330581606'
AND v.visitdate BETWEEN '2016-10-01' AND '2017-09-30'
HAVING age_month BETWEEN 6 AND 60 
ORDER BY visitdate DESC
