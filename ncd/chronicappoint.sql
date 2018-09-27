SELECT p.idcard,p.fname,p.lname
,h.hno,h.villcode 
,v.pcucode,v.visitno,v.visitdate,v.pid
,d.dxtype,d.diagcode
,a.appodate,a.appotype
,CASE WHEN a.appotype='1' THEN 'รับยา'
WHEN a.appotype='2' THEN 'ฟังผล'
WHEN a.appotype='3' THEN 'ทำแผล'
WHEN a.appotype='4' THEN 'เจาะเลือด'
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
ON h.pcucode=p.pcucodeperson AND h.hcode=p.hcode AND h.pid=p.pid 
WHERE a.appodate BETWEEN '2017-10-01' AND '2018-08-23'
AND SUBSTR(d.diagcode,1,3) BETWEEN 'E10' AND 'E14'
ORDER BY a.appotype DESC 

