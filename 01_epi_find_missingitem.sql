SELECT -- t.pcucodeperson,t.pid
CONCAT(c.titlename,t.fname,'   ',t.lname) as fullname
-- ,t.hcode
,t.birth
,TIMESTAMPDIFF(MONTH,t.birth,CURDATE()) as 'อายุ (เดือน)'
,GROUP_CONCAT(t.items ORDER BY ageneed ASC) as items
,h.hno,substr(h.villcode,7,2) as moo 
-- ,h.pcucodepersonvola,h.pidvola
,concat(v.fname,'  ',v.lname) as 'อสม'
FROM 
(
-- BCG
SELECT p.pcucodeperson,p.pid,p.hcode,p.prename,p.fname,p.lname
,p.birth,'BCG' as items
,'1'  AS ageneed
FROM person p										
WHERE p.typelive in ('1','3') 
AND p.dischargetype='9'
AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 0 AND  61 
AND NOT EXISTS 
(
SELECT * FROM visitepi e
WHERE e.vaccinecode='BCG' AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
)
-- DHB1
UNION 
SELECT p.pcucodeperson,p.pid,p.hcode,p.prename,p.fname,p.lname
,p.birth,'DHB1' as items
,'2'  AS ageneed
FROM person p										
WHERE p.typelive in ('1','3') 
AND p.dischargetype='9'
AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 3 AND  61 
AND NOT EXISTS 
(
SELECT * FROM visitepi e
WHERE e.vaccinecode='DHB1' AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
)
-- DHB2
UNION 
SELECT p.pcucodeperson,p.pid,p.hcode,p.prename,p.fname,p.lname
,p.birth,'DHB2' as items
,'3'  AS ageneed
FROM person p										
WHERE p.typelive in ('1','3') 
AND p.dischargetype='9'
AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 5 AND  61 
AND NOT EXISTS 
(
SELECT * FROM visitepi e
WHERE e.vaccinecode='DHB2' AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
)
-- DHB3
UNION 
SELECT p.pcucodeperson,p.pid,p.hcode,p.prename,p.fname,p.lname
,p.birth,'DHB3' as items
,'4'  AS ageneed
FROM person p										
WHERE p.typelive in ('1','3') 
AND p.dischargetype='9'
AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 7 AND  61 
AND NOT EXISTS 
(
SELECT * FROM visitepi e
WHERE e.vaccinecode='DHB3' AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
)
-- MMR1
UNION 
SELECT p.pcucodeperson,p.pid,p.hcode,p.prename,p.fname,p.lname
,p.birth,'MMR1' as items
,'5'  AS ageneed
FROM person p										
WHERE p.typelive in ('1','3') 
AND p.dischargetype='9'
AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 10 AND  60 
AND NOT EXISTS 
(
SELECT * FROM visitepi e
WHERE e.vaccinecode='MMR' AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
)
-- MMR2
UNION 
SELECT p.pcucodeperson,p.pid,p.hcode,p.prename,p.fname,p.lname
,p.birth,'MMR2' as items
,'6'  AS ageneed
FROM person p										
WHERE p.typelive in ('1','3') 
AND p.dischargetype='9'
AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 31 AND  60 
AND NOT EXISTS 
(
SELECT * FROM visitepi e
WHERE e.vaccinecode='MMR2' AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
)
-- LAJE2
UNION 
SELECT p.pcucodeperson,p.pid,p.hcode,p.prename,p.fname,p.lname
,p.birth,'LAJE2' as items
,'7'  AS ageneed
FROM person p										
WHERE p.typelive in ('1','3') 
AND p.dischargetype='9'
AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 31 AND  60 
AND NOT EXISTS 
(
SELECT * FROM visitepi e
WHERE e.vaccinecode='J12' AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
)
-- DTP5
UNION 
SELECT p.pcucodeperson,p.pid,p.hcode,p.prename,p.fname,p.lname
,p.birth,'DTP5' as items
,'8'  AS ageneed
FROM person p										
WHERE p.typelive in ('1','3') 
AND p.dischargetype='9'
AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 49 AND  60 
AND NOT EXISTS 
(
SELECT * FROM visitepi e
WHERE e.vaccinecode='DTP5' AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
)
-- OPV5
UNION 
SELECT p.pcucodeperson,p.pid,p.hcode,p.prename,p.fname,p.lname
,p.birth,'OPV5' as items
,'9'  AS ageneed
FROM person p										
WHERE p.typelive in ('1','3') 
AND p.dischargetype='9'
AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 49 AND  60 
AND NOT EXISTS 
(
SELECT * FROM visitepi e
WHERE e.vaccinecode='OPV5' AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
)
) as t
LEFT JOIN ctitle c
ON t.prename=c.titlecode
LEFT JOIN house h 
ON  t.pcucodeperson=h.pcucode AND t.hcode=h.hcode
LEFT JOIN person v
ON h.pcucodepersonvola=v.pcucodeperson and	h.pidvola=v.pid 
GROUP BY t.pcucodeperson,t.pid
-- HAVING pid='11654'
ORDER BY moo,(SPLIT_STR(hno,'/', 1)*1),(SPLIT_STR(hno,'/',2)*1)
