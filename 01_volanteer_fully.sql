SELECT 
h.hno
,o.pid as pidowner
,concat(o.fname,' ',o.lname) as houseowner
,f.famposname
,p.pid
,concat(p.fname,' ',p.lname) as housemember
,p.birth
,p.bloodgroup
,p.allergic
,CONCAT(h.hno,'  ','หมู่ที่ ',substr(h.villcode,8,1)) as address
,p.fatherid,p.motherid
,p.dischargetype
,CASE WHEN p.dischargetype='9' THEN 'ยังอยู่'
			WHEN p.dischargetype='0' THEN 'ตาย'
ELSE 'จำหน่าย'
END as dischargeperson
,p.typelive
,CASE  	WHEN p.typelive='1' THEN '(1)มีทะเบียนและตัวอยู่'
								WHEN p.typelive='2' THEN '(2)มีทะเบียนแต่ตัวไม่อยู่'
								WHEN p.typelive='3' THEN '(3)ไม่มีทะเบียนแต่ตัวอยู่'
WHEN p.typelive='0' THEN 'ต้องแก้ไข'
ELSE '(4)นอกเขต'
END as typeperson
,p.marystatus,s.statusname
,p.mateid
,p.occupa,ocp.occupaname
,p.educate,e.educationname
,GROUP_CONCAT(c.chroniccode) as chronic 
,dm.dm,ht.ht,copd.copd,asthma.asthma
,concat(v.fname,' ',v.lname) as volanteer
,p.dateupdate
FROM house h
LEFT JOIN person o
ON h.pcucode=o.pcucodeperson AND h.hcode=o.hcode AND h.pid=o.pid 
LEFT JOIN person p
ON h.pcucode=p.pcucodeperson AND h.hcode=p.hcode 
LEFT JOIN cfamilyposition f
ON p.familyposition=f.famposcode
LEFT JOIN cstatus s
ON p.marystatus=s.statuscode
LEFT JOIN coccupa ocp
ON p.occupa=ocp.occupacode
LEFT JOIN ceducation e
ON p.educate=e.educationcode 
LEFT JOIN person v
ON h.pcucodepersonvola=v.pcucodeperson AND h.pidvola=v.pid 
LEFT JOIN personchronic c
ON p.pid=c.pid 
LEFT JOIN 
(
SELECT c.pcucodeperson,c.pid
,SPLIT_STR(GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ','),',',1) as dm 
FROM personchronic c
WHERE substr(c.chroniccode,1,3) BETWEEN 'E10' AND 'E14'
GROUP BY c.pid
) as dm
ON p.pid=dm.pid
LEFT JOIN 
(SELECT c.pcucodeperson,c.pid
,SPLIT_STR(GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ','),',',1) as ht 
FROM personchronic c
WHERE substr(c.chroniccode,1,3) BETWEEN 'I10' AND 'I15'
GROUP BY c.pid
) as ht 
ON p.pid=ht.pid
LEFT JOIN 
(SELECT c.pcucodeperson,c.pid
,SPLIT_STR(GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ','),',',1) as  asthma
FROM personchronic c
WHERE substr(c.chroniccode,1,3) BETWEEN 'J45' AND 'J45'
GROUP BY c.pid
) as asthma 
ON p.pid=asthma.pid
LEFT JOIN 
(SELECT c.pcucodeperson,c.pid
,SPLIT_STR(GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ','),',',1) as copd  
FROM personchronic c
WHERE substr(c.chroniccode,1,3) BETWEEN 'J44' AND 'J44'
GROUP BY c.pid
) as copd 
ON p.pid=copd .pid

WHERE substr(h.villcode,8,1)<>'0'
GROUP BY h.hno,p.pid
-- HAVING NOT ISNULL(dm.dm) OR NOT ISNULL(copd.copd)
HAVING volanteer LIKE '%เนาวรัตน์%'
ORDER BY h.villcode,(SPLIT_STR(h.hno,'/', 1)*1),(SPLIT_STR(h.hno,'/',2)*1)
LIMIT 50 
