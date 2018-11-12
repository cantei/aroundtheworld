SELECT p.fname,p.lname,p.birth
,if(TIMESTAMPDIFF(year,p.birth,d.datedeliver)<20,'1','2')   as typemom 
,d.datedeliver 
FROM visitanc a
LEFT JOIN visitancdeliver d
ON a.pcucodeperson=d.pcucodeperson AND a.pid=d.pid 
LEFT JOIN person p
ON d.pcucodeperson=p.pcucodeperson AND d.pid=p.pid 
WHERE d.pregno='1'
AND d.datedeliver BETWEEN '2010-10-01' AND '2018-09-30'
GROUP BY a.pid
HAVING typemom='1'
ORDER BY d.datedeliver 
