SELECT t0.* 
,v.fname as vname,v.lname as vsurename
,REPLACE(c.chroniccode,'.','') as diag 
,substr(REPLACE(chroniccode,'.',''),1,3) as chroniccode
FROM 
(
SELECT h.pcucode,h.hcode
,p.pid,p.fname,p.lname,p.birth,p.sex,p.typelive,p.dischargetype 
,h.hid,h.hno,h.road,substr(h.villcode,7,2) as moo,h.telephonehouse,h.pcucodeperson,h.pcucodepersonvola,h.pidvola,h.xgis,h.ygis 

from  person p 
INNER JOIN house h
ON p.pcucodeperson=h.pcucode AND h.hcode=p.hcode
WHERE p.typelive in('1','3')
GROUP BY h.villcode,h.hno
ORDER BY h.villcode,h.hno
) as t0 
INNER JOIN person v
ON t0.pcucodepersonvola=v.pcucodeperson AND t0.pidvola=v.pid 
INNER JOIN personchronic c
ON t0.pcucode=c.pcucodeperson AND t0.pid=c.pid 
WHERE substr(REPLACE(chroniccode,'.',''),1,3) BETWEEN 'E10' AND 'E14' 
ORDER BY moo,hno
