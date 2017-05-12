SELECT t1.pcucode,t1.visitno,t1.dx,t1.dxtype
,CASE 
WHEN SUBSTR(dx,1,4) IN ("H650","H651","H659","H660","H664","H669", "H670","H671","H678","H720","H721",
"H722","H728","H729","J00","J010","J011","J012","J013","J014","J018","J019", 
 "J020","J029","J030","J038","J039","J040","J041","J042","J050","J051","J060","J068","J069", 
 "J101","J111","J200","J201","J202","J203","J204","J205","J206","J207","J208","J209","J210","J218","J219") THEN '01'
WHEN SUBSTR(dx,1,4) IN ("A000","A001","A009","A020","A030", 
"A031","A032","A033","A038","A039","A040","A041","A042","A043","A044","A045","A046","A047","A048","A049","A050", 
"A053","A054","A059","A080","A081","A082","A083","A084","A085","A090","A099","K521","K528","K529") THEN '02'
ELSE NULL
END AS 'rdu'
,v.visitdate
-- ,DATE_FORMAT(v.visitdate,'%Y%m%d') as date_serv
,d.drugcode
,c.drugname
,a.drugname as antibiotic
-- ,GROUP_CONCAT(d.drugcode ORDER BY d.drugcode SEPARATOR ',' ) as drug_id
-- ,GROUP_CONCAT(c.drugname ORDER BY d.drugcode SEPARATOR ',' ) as dname   
FROM 
(
SELECT pcucode,visitno,diagcode
,CASE diagcode 
              WHEN LENGTH(ltrim(diagcode)) =5 THEN SUBSTRING_INDEX(diagcode,'.',1)
              WHEN LENGTH(ltrim(diagcode)) >5 THEN CONCAT(SUBSTRING_INDEX(diagcode,'.',1),SUBSTRING_INDEX(diagcode,'.',-1))
             END as dx
,dxtype
FROM visitdiag 
) as t1
LEFT JOIN visit v
ON t1.pcucode=v.pcucode AND t1.visitno=v.visitno 
LEFT JOIN visitdrug d 
ON v.pcucode=d.pcucode AND v.visitno=d.visitno
LEFT JOIN cdrug c
ON d.drugcode=c.drugcode
LEFT JOIN c_antibioticss a 
ON substr(c.drugcode,1,19)=a.stdcode
WHERE v.visitdate BETWEEN '2014-10-01' AND '2015-10-31'
-- GROUP BY v.visitno
-- ORDER BY v.visitdate DESC 
LIMIT 100
-- HAVING rdu='02'
