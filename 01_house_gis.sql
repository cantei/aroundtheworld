SELECT p.pcucodeperson,p.pid,p.fname,p.lname
,h.pid as housepid,h.hno,h.villcode,h.xgis,h.ygis    
FROM house h
LEFT JOIN person p
ON p.pcucodeperson=h.pcucode AND p.hcode=h.hcode AND p.pid=h.pid 
WHERE villcode='67010412'
AND ISNULL(xgis)
AND NOT ISNULL(p.pid)
ORDER BY (SUBSTRING_INDEX(h.hno,'/',1)*1),(SUBSTRING_INDEX(h.hno,'/',2)*1);
