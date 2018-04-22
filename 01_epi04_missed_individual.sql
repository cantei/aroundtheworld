-- ผิดนัดในเดือนใดๆ
SET @y='2017';
SET @m='03';
SELECT DISTINCT a.pcucodeperson,a.pid  
,p.idcard
,CONCAT(c.titlename,p.fname,'   ',p.lname) as fullname
-- ,t.hcode
,p.birth
,TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) as  'agemonth'
,p.mother as 'monther'
,h.hno,substr(h.villcode,7,2) as moo 
,concat(v.fname,'  ',v.lname) as 'volanteer'
FROM visitepiappoint a 
LEFT JOIN person p
ON a.pcucodeperson=p.pcucodeperson AND a.pid=p.pid 
LEFT JOIN ctitle c
ON p.prename=c.titlecode
LEFT JOIN house h 
ON  p.pcucodeperson=h.pcucode AND p.hcode=h.hcode
LEFT JOIN person v
ON h.pcucodepersonvola=v.pcucodeperson and	h.pidvola=v.pid 
WHERE p.typelive in ('1','3') 
AND p.dischargetype='9'
AND TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) BETWEEN 3 AND  61 
AND YEAR(a.dateappoint)=@y
AND MONTH(a.dateappoint)=@m
AND NOT EXISTS 
(
SELECT * FROM visitepi e WHERE a.pcucodeperson=e.pcucodeperson AND a.pid=e.pid
AND YEAR(e.dateepi)=@y
AND MONTH(e.dateepi)=@m
) 
