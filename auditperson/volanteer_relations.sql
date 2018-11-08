SELECT p.idcard,concat(p.fname,'   ',p.lname) as volanteer
,p.hnomoi,p.mumoi,p.subdistcodemoi,p.distcodemoi,p.provcodemoi
,p.rightcode 
,p.hosmain,p.hossub
,p.dateexpire 

,CONCAT_WS(' ', t1.idchildfather, t2.idchildmother) as childid
,p.fatherid,p.motherid 
,p.mateid

FROM person p
LEFT JOIN cright r	 
on	p.rightcode=r.rightcode 
LEFT JOIN crightgroup g
ON r.rightgroup=g.rightgroupcode 
LEFT JOIN 
(
SELECT p.idcard as idchildfather,p.fatherid,concat(p.fname,'    ', p.lname) as childfather
FROM person p 
WHERE p.dischargetype='9'
) t1
ON p.idcard=t1.fatherid 
LEFT JOIN 
(
SELECT p.idcard as idchildmother,p.motherid,concat(p.fname,'    ', p.lname) as childmother
FROM person p
WHERE p.dischargetype='9'
) t2
ON p.idcard=t2.motherid 
WHERE p.dischargetype='9'
AND r.rightcode='82'
AND p.dateexpire > CURDATE()
