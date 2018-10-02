SELECT p.mumoi,p.idcard,p.fname,p.lname
,h.hno,h.villcode 
,v.pcucode,v.visitno,v.visitdate,v.pid
,GROUP_CONCAT(d.dxtype ORDER BY d.dxtype  SEPARATOR ',') as dxtype
,GROUP_CONCAT(d.diagcode ORDER BY d.dxtype  SEPARATOR ',') as diagcode
,a.appodate,a.appotype
,CASE WHEN a.appotype='1' THEN 'รับยา'
WHEN a.appotype='2' THEN 'ฟังผล'
WHEN a.appotype='3' THEN 'ทำแผล'
WHEN a.appotype='4' THEN 'เจาะเลือด'
WHEN a.appotype='5' THEN 'ตรวจน้ำตาล'
WHEN a.appotype='6' THEN 'วัคความดัน'
WHEN a.appotype='7' THEN 'แพทย์แผนไทย'
WHEN a.appotype='9' THEN 'ทันตกรรม'
ELSE 'ยังไม่ทราบ'
END as 'wherefu'
,a.`comment`
FROM visit v
LEFT JOIN visitdiag d
ON v.pcucode=d.pcucode AND v.visitno=d.visitno 
LEFT JOIN  visitdiagappoint a
ON  v.pcucode=a.pcucode AND v.visitno=a.visitno 
LEFT JOIN person p
ON v.pcucode=p.pcucodeperson AND v.pid=p.pid 
LEFT JOIN house h
ON h.pcucode=p.pcucodeperson AND h.hcode=p.hcode 
WHERE a.appodate BETWEEN '2018-11-16' AND '2018-11-16'
-- AND SUBSTR(d.diagcode,1,3) BETWEEN 'E10' AND 'E14'
GROUP BY v.visitno
ORDER BY (substr(h.villcode,8,1)),(SPLIT_STR(h.hno,'/', 1)*1),(SPLIT_STR(h.hno,'/',2)*1)



