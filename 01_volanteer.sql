SELECT DISTINCT t.hno,t.village,t.houseowner,t.volanteer 
FROM 
(
SELECT h.pcucode
-- ,h.pcucodeperson,h.pid
,h.hno
,substr(h.villcode,8,1) as village
,concat(o.fname,' ',o.lname) as houseowner
,h.pcucodepersonvola,h.pidvola
,concat(v.fname,' ',v.lname) as volanteer
FROM house h
LEFT JOIN person o
ON h.pcucode=o.pcucodeperson AND h.hcode=o.hcode AND h.pid=o.pid 
LEFT JOIN person v
ON h.pcucodepersonvola=v.pcucodeperson AND h.pidvola=v.pid 
LEFT JOIN person p
ON h.pcucode=p.pcucodeperson AND h.hcode=p.hcode
WHERE p.typelive in ('1','3')
GROUP BY h.villcode,h.hno,p.idcard
) as t 
where village='4'
ORDER BY t.village,(SPLIT_STR(t.hno,'/', 1)*1),(SPLIT_STR(t.hno,'/',2)*1)
