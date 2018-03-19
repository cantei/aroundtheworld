SELECT -- t.pcucodeperson,t.pid
t.idcard
,CONCAT(c.titlename,t.fname,'   ',t.lname) as fullname
-- ,t.hcode
,t.birth
,TIMESTAMPDIFF(MONTH,t.birth,CURDATE()) as  'agemonth'
,t.mother as 'มารดา'
,GROUP_CONCAT(t.items ORDER BY (sequence*1) ASC) as items
,h.hno,substr(h.villcode,7,2) as moo 
-- ,h.pcucodepersonvola,h.pidvola
,concat(v.fname,'  ',v.lname) as 'volanteer'
FROM 
(
-- BCG
SELECT p.idcard,p.pcucodeperson,p.pid,p.hcode,p.prename,p.fname,p.lname,p.mother
,p.birth,'BCG' as items
,'1'  AS sequence
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
SELECT p.idcard,p.pcucodeperson,p.pid,p.hcode,p.prename,p.fname,p.lname,p.mother
,p.birth,'DHB1' as items
,'2'  AS sequence
FROM person p										
WHERE p.typelive in ('1','3') 
AND p.dischargetype='9'
AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 3 AND  61 
AND NOT EXISTS 
(
SELECT * FROM visitepi e
WHERE e.vaccinecode NOT IN ('DHB1','DTP1')  AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
)
-- OPV1
UNION 
SELECT p.idcard,p.pcucodeperson,p.pid,p.hcode,p.prename,p.fname,p.lname,p.mother
,p.birth,'OPV1' as items
,'3'  AS sequence
FROM person p										
WHERE p.typelive in ('1','3') 
AND p.dischargetype='9'
AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 3 AND  61 
AND NOT EXISTS 
(
SELECT * FROM visitepi e
WHERE e.vaccinecode='OPV1' AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
)
-- DHB2
UNION 
SELECT p.idcard,p.pcucodeperson,p.pid,p.hcode,p.prename,p.fname,p.lname,p.mother
,p.birth,'DHB2' as items
,'4'  AS sequence
FROM person p										
WHERE p.typelive in ('1','3') 
AND p.dischargetype='9'
AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 5 AND  61 
AND NOT EXISTS 
(
SELECT * FROM visitepi e
WHERE e.vaccinecode NOT IN ('DHB2','DTP2') AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
)

-- OPV2
UNION 
SELECT p.idcard,p.pcucodeperson,p.pid,p.hcode,p.prename,p.fname,p.lname,p.mother
,p.birth,'OPV2' as items
,'5'  AS sequence
FROM person p										
WHERE p.typelive in ('1','3') 
AND p.dischargetype='9'
AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 5 AND  61 
AND NOT EXISTS 
(
SELECT * FROM visitepi e
WHERE e.vaccinecode='OPV2' AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
)
-- IPV
-- IPV เริ่มใช้ธันวาคม 2558 ฉะนั้น เด็กที่เกิดตั้งแต่ 2015-08-01 
UNION 
SELECT p.idcard,p.pcucodeperson,p.pid,p.hcode,p.prename,p.fname,p.lname,p.mother
,p.birth,'IPV' as items
,'6'  AS sequence
FROM person p										
WHERE p.typelive in ('1','3') 
AND p.dischargetype='9'
AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 5 AND  61 
AND p.birth > '2015-07-31'
AND NOT EXISTS 
(
SELECT * FROM visitepi e
WHERE e.vaccinecode='IPV-P' AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
)

-- DHB3
UNION 
SELECT p.idcard,p.pcucodeperson,p.pid,p.hcode,p.prename,p.fname,p.lname,p.mother
,p.birth,'DHB3' as items
,'7'  AS sequence
FROM person p										
WHERE p.typelive in ('1','3') 
AND p.dischargetype='9'
AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 7 AND  61 
AND NOT EXISTS 
(
SELECT * FROM visitepi e
WHERE e.vaccinecode NOT IN ('DHB2','DTP3') AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
)

-- OPV3
UNION 
SELECT p.idcard,p.pcucodeperson,p.pid,p.hcode,p.prename,p.fname,p.lname,p.mother
,p.birth,'OPV3' as items
,'8'  AS sequence
FROM person p										
WHERE p.typelive in ('1','3') 
AND p.dischargetype='9'
AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 7 AND  61 
AND NOT EXISTS 
(
SELECT * FROM visitepi e
WHERE e.vaccinecode='OPV3' AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
)

-- MMR1
UNION 
SELECT p.idcard,p.pcucodeperson,p.pid,p.hcode,p.prename,p.fname,p.lname,p.mother
,p.birth,'MMR1' as items
,'9'  AS sequence
FROM person p										
WHERE p.typelive in ('1','3') 
AND p.dischargetype='9'
AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 10 AND  60 
AND NOT EXISTS 
(
SELECT * FROM visitepi e
WHERE e.vaccinecode='MMR' AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
)


-- LAJE1
-- LAJE เริ่มใช้ มีนาคม 2558  ฉะนั้น เด็กที่เกิดปีงบประมาณ 2557 บางส่วนควรจะได้รับ 
UNION 
SELECT p.idcard,p.pcucodeperson,p.pid,p.hcode,p.prename,p.fname,p.lname,p.mother
,p.birth,'LAJE1' as items
,'10'  AS sequence
FROM person p										
WHERE p.typelive in ('1','3') 
AND p.dischargetype='9'
AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 13 AND  60 
AND p.birth > '2013-09-30'
AND NOT EXISTS 
(
SELECT * FROM visitepi e
WHERE e.vaccinecode NOT IN ('J11','JE1') AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
)


-- DTP4
UNION 
SELECT p.idcard,p.pcucodeperson,p.pid,p.hcode,p.prename,p.fname,p.lname,p.mother
,p.birth,'DTP4' as items
,'11'  AS sequence
FROM person p										
WHERE p.typelive in ('1','3') 
AND p.dischargetype='9'
AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 19 AND  60 
AND NOT EXISTS 
(
SELECT * FROM visitepi e
WHERE e.vaccinecode='DTP4' AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
)
-- OPV4
UNION 
SELECT p.idcard,p.pcucodeperson,p.pid,p.hcode,p.prename,p.fname,p.lname,p.mother
,p.birth,'OPV4' as items
,'12'  AS sequence
FROM person p										
WHERE p.typelive in ('1','3') 
AND p.dischargetype='9'
AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 19 AND  60 
AND NOT EXISTS 
(
SELECT * FROM visitepi e
WHERE e.vaccinecode='OPV4' AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
)

-- MMR2
UNION 
SELECT p.idcard,p.pcucodeperson,p.pid,p.hcode,p.prename,p.fname,p.lname,p.mother
,p.birth,'MMR2' as items
,'13'  AS sequence
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
SELECT p.idcard,p.pcucodeperson,p.pid,p.hcode,p.prename,p.fname,p.lname,p.mother
,p.birth,'LAJE2' as items
,'14'  AS sequence
FROM person p										
WHERE p.typelive in ('1','3') 
AND p.dischargetype='9'
AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 31 AND  60 
AND p.birth > '2013-09-30'
AND NOT EXISTS 
(
SELECT * FROM visitepi e
WHERE e.vaccinecode NOT IN ('J12','JE2','JE3') AND p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
)
-- DTP5
UNION 
SELECT p.idcard,p.pcucodeperson,p.pid,p.hcode,p.prename,p.fname,p.lname,p.mother
,p.birth,'DTP5' as items
,'15'  AS sequence
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
SELECT p.idcard,p.pcucodeperson,p.pid,p.hcode,p.prename,p.fname,p.lname,p.mother
,p.birth,'OPV5' as items
,'16'  AS sequence
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
ORDER BY moo,(SPLIT_STR(hno,'/', 1)*1),(SPLIT_STR(hno,'/',2)*1);
