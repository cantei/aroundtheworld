SELECT volanteer
,GROUP_CONCAT(hno ORDER BY (SPLIT_STR(hno,'/', 1)*1),(SPLIT_STR(hno,'/',2)*1)) as housetarget
 FROM 
(
SELECT 
h.hno
,concat(o.fname,' ',o.lname) as houseowner
,h.pid as pidowner
,p.pid  
-- ,p.familyposition 
,f.famposname
,concat(v.fname,' ',v.lname) as volanteer
FROM house h
LEFT JOIN person o
ON h.pcucode=o.pcucodeperson AND h.hcode=o.hcode AND h.pid=o.pid 
LEFT JOIN person p
ON h.pcucode=p.pcucodeperson AND h.hcode=p.hcode AND h.pid=p.pid 
LEFT JOIN cfamilyposition f
ON p.familyposition=f.famposcode
LEFT JOIN person v
ON h.pcucodepersonvola=v.pcucodeperson AND h.pidvola=v.pid 
WHERE h.villcode='84120702'
GROUP BY h.hno
HAVING NOT ISNULL(volanteer)
ORDER BY (SPLIT_STR(h.hno,'/', 1)*1),(SPLIT_STR(h.hno,'/',2)*1)
) as t
GROUP BY volanteer

ORDER BY volanteer
