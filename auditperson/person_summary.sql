
SELECT concat(v.fname,' ',v.lname) as volanteer
,t1.hno
,concat(o.fname,' ',o.lname) as houseowner
,f.famposname
,t1.moi,t1.nlive
,t1.x1,t1.x2,t1.x3

FROM 
(
SELECT h.pcucode,h.hcode,h.hno
,h.pid 
,h.pidvola 
,sum(IF(p.typelive in ('1','2'),1,0)) AS moi 
,sum(IF(p.typelive in ('1','3'),1,0)) AS nlive

,SPLIT_STR(if(substr(h.hno,1,1)='0',SPLIT_STR(h.hno,'-',2),h.hno),'/',1) as x1
,SPLIT_STR(if(substr(h.hno,1,1)='0',SPLIT_STR(h.hno,'-',2),h.hno),'/',2) as x2
,if(substr(h.hno,1,1)='0',1,0) as x3

FROM house h
LEFT JOIN person p
ON h.pcucode=p.pcucodeperson AND h.hcode=p.hcode
WHERE substr(h.villcode,8,1)='2'
AND p.dischargetype='9'
GROUP BY h.hno 
) as t1 
LEFT JOIN person o
ON t1.pcucode=o.pcucodeperson AND t1.hcode=o.hcode AND t1.pid=o.pid 
LEFT JOIN cfamilyposition f
ON o.familyposition=f.famposcode
LEFT JOIN person v
ON  t1.pidvola=v.pid 
ORDER BY volanteer,x1*1,x2*1,x3*1 
