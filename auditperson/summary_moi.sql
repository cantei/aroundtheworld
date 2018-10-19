SELECT SPLIT_STR(if(substr(h.hno,1,1)='0',SPLIT_STR(h.hno,'-',2),h.hno),'/',1) as x1
,SPLIT_STR(if(substr(h.hno,1,1)='0',SPLIT_STR(h.hno,'-',2),h.hno),'/',2) as x2
,if(substr(h.hno,1,1)='0',1,0) as x3
,h.pid,h.pidvola 
,concat(v.fname,' ',v.lname) as volanteer
,concat(' ',h.hno) as hno,h.villcode
,concat(o.fname,' ',o.lname) as houseowner
,famposname
-- ,sum(if(typelive in('1','2'),1,0)) as nmoi
,nmoi
FROM house h
LEFT JOIN person o
ON h.pcucode=o.pcucodeperson AND h.hcode=o.hcode AND h.pid=o.pid 
LEFT JOIN cfamilyposition f
ON o.familyposition=f.famposcode
LEFT JOIN 
(
SELECT h.hno,h.pid,h.villcode
,sum(if(p.typelive in('1','2'),1,0)) as nmoi
FROM house h
LEFT JOIN person p
ON h.pcucode=p.pcucodeperson AND h.hcode=p.hcode 
WHERE p.dischargetype='9'
GROUP BY h.hno,h.villcode
) as t 
ON h.hno=t.hno AND h.pid=t.pid AND h.villcode=t.villcode
LEFT JOIN person v
ON  h.pidvola=v.pid 
WHERE substr(h.villcode,8,1)='2'
ORDER BY x1*1,x2*1,x3*1
