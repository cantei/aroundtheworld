SELECT t.pcucodeperson,t.pid
-- ,t.items
,p.idcard
,p.hcode
,CONCAT(c.titlename,p.fname,'   ',p.lname) as fullname
,CONCAT(DATE_FORMAT(p.birth, "%d"),'-',DATE_FORMAT(p.birth, "%m"),'-',(DATE_FORMAT(p.birth, "%Y")+543)) as born
,TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) as  'agemonth'
,CONCAT(h.hno,'  ','หมู่ที่ ',substr(h.villcode,8,1)) as address
,p.mother as 'mother'
,GROUP_CONCAT(t.items) as vaccinecode
,CONCAT(v.fname,'  ',v.lname) as 'volanteer'
,t1.date_appoint,t1.itemsappoint
FROM 
(
SELECT * FROM vw_missed_vaccine 
UNION 
SELECT * FROM vw_missed_vaccine_appoint
) as t
LEFT JOIN person p
ON t.pcucodeperson=p.pcucodeperson AND t.pid=p.pid
LEFT JOIN ctitle c
ON p.prename=c.titlecode 
LEFT JOIN house h 
ON  p.hcode=h.hcode
LEFT JOIN person v
ON h.pcucodepersonvola=v.pcucodeperson and	h.pidvola=v.pid 
LEFT JOIN 
(
SELECT va.pcucodeperson,va.pid
,SPLIT_STR(GROUP_CONCAT(CAST(va.dateappoint  AS CHAR(10000) CHARACTER SET utf8) ORDER BY va.dateappoint  ASC SEPARATOR ','),',',1) as date_appoint
,GROUP_CONCAT(va.vaccinecode) as itemsappoint
FROM visitepiappoint   va 
WHERE va.dateappoint > CURDATE() 
GROUP BY va.pcucodeperson,va.pid
HAVING NOT ISNULL(date_appoint) 
) as t1 
ON p.pcucodeperson=t1.pcucodeperson AND p.pid=t1.pid
WHERE p.typelive in ('1','3') 
AND p.dischargetype='9'
AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 3 AND  61 
GROUP BY t.pid
ORDER BY p.birth 
