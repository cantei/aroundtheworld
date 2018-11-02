SELECT t.pid as hn,t.fullname,t.birth,t.real_age,t.address,t.areacode 
,GROUP_CONCAT(CAST(t.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY t.visitdate SEPARATOR ',') as visitdate
,GROUP_CONCAT(CAST(t.agemonth AS CHAR(10000) CHARACTER SET utf8)  ORDER BY t.visitdate SEPARATOR ',') as agemonth
,GROUP_CONCAT(CAST(t.food AS CHAR(10000) CHARACTER SET utf8)  ORDER BY t.visitdate SEPARATOR ',') as food
 
FROM 
(
SELECT p.pcucodeperson,p.hcode,p.pid
,CONCAT(c.titlename,p.fname,'   ',p.lname ) as fullname
,p.birth
,TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) as real_age
,CONCAT(p.provcodemoi,p.distcodemoi,p.subdistcodemoi,p.mumoi) as areacode
,CONCAT('  ',p.hnomoi,'  หมู่ที่   ' ,p.mumoi ) as address
,v.visitdate 
,TIMESTAMPDIFF(MONTH,p.birth,v.visitdate) as agemonth
,(
CASE 	WHEN n.food = '1' then 'A'
			WHEN n.food = '2' then 'B'
			WHEN n.food = '3' then 'C'
			WHEN n.food = '4' then 'D' 
ELSE NULL END
) AS 'food'
FROM person p
INNER JOIN ctitle c
ON  p.prename = c.titlecode
INNER JOIN visit v 
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
INNER JOIN visitnutrition n 
ON v.pcucode = n.pcucode AND v.visitno = n.visitno
WHERE p.birth > '2010-09-30'
AND p.typelive in ('1','3')
AND p.dischargetype='9'
) as t
GROUP BY t.pid
ORDER BY t.birth
