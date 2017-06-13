SELECT
t1.pcucode
-- ,t1.hcode
,t1.villcode
-- ,t1.hid
,t1.hno
,t1.fname,t1.lname,t1.idcard
,t1.pidvola
,concat(t2.fname,'  ',t2.lname) as  อสม
,t1.xgis,t1.ygis
FROM 
(
SELECT 
h.pcucode,h.hcode
,h.villcode
-- ,h.hid
,h.hno,h.pidvola,h.xgis,h.ygis
,p.fname,p.lname,p.idcard
FROM  person p
		Inner Join house h ON p.pcucodeperson = h.pcucode AND p.hcode = h.hcode  AND p.pid=h.pid  
		Inner Join village v ON h.pcucode = v.pcucode AND h.villcode = v.villcode
		left Join ctitle c ON p.prename = c.titlecode
WHERE hno<>'0'
ORDER BY villcode,hno 
) as t1
LEFT JOIN person t2 
ON t1.pidvola=t2.pid AND t1.pcucode=t2.pcucodeperson 
HAVING ISNULL(xgis)
