SELECT t0.villcode
,concat(' ',t0.hno) as hno
,concat(t0.fname,'   ',t0.lname) as houseowner
,sum(IF(t1.typelive in ('1','2'),1,0)) AS moi 
,sum(IF(t1.typelive in ('1','3'),1,0)) AS nlivea

,GROUP_CONCAT(concat(' ',t1.hnomoi)) as hnomoi
,concat(t1.provcodemoi,t1.distcodemoi,t1.subdistcodemoi,t1.mumoi) as areamoi

,concat(v.fname,' ',v.lname) as volanteer
FROM
-- houseowner 
(
SELECT 
SPLIT_STR(if(substr(h.hno,1,1)='0',SPLIT_STR(h.hno,'-',2),h.hno),'/',1) as x1
,SPLIT_STR(if(substr(h.hno,1,1)='0',SPLIT_STR(h.hno,'-',2),h.hno),'/',2) as x2
,if(substr(h.hno,1,1)='0',1,0) as x3
,h.pcucode,h.hcode,h.hno,h.villcode,h.pcucodeperson,h.pid,h.pcucodepersonvola,h.pidvola
,p.fname,p.lname,p.hnomoi,p.mumoi,p.subdistcodemoi,p.distcodemoi,p.provcodemoi  	
FROM house h
LEFT   JOIN person p
ON h.pcucode=p.pcucodeperson AND h.pid=p.pid
) as t0
LEFT JOIN person t1
ON t0.pcucode=t1.pcucodeperson AND t0.hcode=t1.hcode
LEFT JOIN person v
ON t0.pcucodepersonvola=v.pcucodeperson AND t0.pidvola=v.pid 
WHERE substr(t0.villcode,1,8)='84120701'
AND t1.dischargetype='9'
-- GROUP BY t1.mumoi,t0.hnomoi
GROUP BY t0.villcode,t0.hno
-- HAVING  nlive =0 AND not ISNULL(volanteer)
HAVING ISNULL(volanteer)
ORDER BY t0.villcode,volanteer,t0.x1*1,t0.x2*1,t0.x3*1
