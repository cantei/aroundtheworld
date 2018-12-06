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
-- WHERE c.drugcode24='100497414002040330581606'
WHERE c.drugcode24 in ('201120320037726221781506'
,'201110100019999920381341'
,'201110100019999921881341'
,'201110100019999920381199'
,'201110100019999920381341'
)
AND v.visitdate BETWEEN '2017-10-01' AND '2018-09-30'
HAVING age_month BETWEEN 6 AND 60 
ORDER BY visitdate DESC;
