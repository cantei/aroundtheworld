SELECT CONCAT(v.fname,'  ',v.lname) as volanteer
,CONCAT(h.hno,'  ','หมู่ที่ ',substr(h.villcode,8,1)) as address
,p.pid
,CONCAT(c.titlename,p.fname,'   ',p.lname) as fullname
,p.birth
,TIMESTAMPDIFF(month,p.birth,CURDATE()) as agemonth
,h.hno,h.villcode
,GROUP_CONCAT(e.vaccinecode ORDER BY e.dateepi)  as vaccinecode
,GROUP_CONCAT(CAST(e.dateepi AS CHAR(10000) CHARACTER SET utf8)  ORDER BY e.dateepi SEPARATOR ',') as visitdate
,SPLIT_STR(GROUP_CONCAT(CAST(e.dateepi AS CHAR(10000) CHARACTER SET utf8)  ORDER BY e.dateepi SEPARATOR ',') ,',',1) as visitdate1
,SPLIT_STR(GROUP_CONCAT(CAST(e.dateepi AS CHAR(10000) CHARACTER SET utf8)  ORDER BY e.dateepi SEPARATOR ',') ,',',2) as visitdate2
,SPLIT_STR(GROUP_CONCAT(CAST(e.dateepi AS CHAR(10000) CHARACTER SET utf8)  ORDER BY e.dateepi SEPARATOR ',') ,',',3) as visitdate3
FROM person p
LEFT JOIN ctitle c
ON p.prename=c.titlecode
LEFT JOIN house h 
ON p.pcucodeperson=h.pcucode AND p.hcode=h.hcode 
LEFT JOIN person v
ON h.pcucodepersonvola=v.pcucodeperson AND h.pidvola=v.pid 
LEFT JOIN visitepi e
ON p.pcucodeperson=e.pcucodeperson AND p.pid=e.pid 
WHERE e.vaccinecode in ('MEAS','MMR','MMR2','MMRS','MRC')
AND p.typelive in ('1','3')
GROUP BY p.pid	 
HAVING (
agemonth BETWEEN 13 AND 180
AND ( visitdate1='' OR visitdate2='')
)
ORDER BY h.villcode
