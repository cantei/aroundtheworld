SELECT SUBSTR(h.villcode,8,1) as village
,COUNT(DISTINCT h.hno,h.villcode) as nhouse
,COUNT(*) as total
,SUM(if(p.typelive IN ('1','2'),1,0)) as gov_regist
,SUM(if(p.typelive IN ('1','3'),1,0)) as alive
FROM house h
LEFT JOIN person o
ON h.pcucode=o.pcucodeperson AND h.hcode=o.hcode AND h.pid=o.pid 
LEFT JOIN person p
ON h.pcucode=p.pcucodeperson AND h.hcode=p.hcode
WHERE h.villcode<>'84120700'
GROUP BY h.villcode
-- HAVING alive<>0
-- ORDER BY h.villcode
UNION 
SELECT 'Total' as village
,COUNT(DISTINCT h.hno,h.villcode) as nhouse
,COUNT(*) as total
,SUM(if(p.typelive IN ('1','2'),1,0)) as gov_regist
,SUM(if(p.typelive IN ('1','3'),1,0)) as alive
FROM house h
LEFT JOIN person o
ON h.pcucode=o.pcucodeperson AND h.hcode=o.hcode AND h.pid=o.pid 
LEFT JOIN person p
ON h.pcucode=p.pcucodeperson AND h.hcode=p.hcode
WHERE h.villcode<>'84120700'
