# ตรวจสอบวันนัด 
SELECT p.idcard,CONCAT(c.titlename,p.fname,'  ',p.lname) as fullname,p.sex,p.birth,TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) as  'agemonth'
,e.dateepi,GROUP_CONCAT(DISTINCT e.vaccinecode) as vaccines
,GROUP_CONCAT(DISTINCT CONVERT( a.dateappoint, CHAR(255)) ORDER BY a.dateappoint ASC) as appoint
,GROUP_CONCAT(DISTINCT a.vaccinecode ORDER BY a.dateappoint ASC)  as need_vaccine
FROM visitepi e
INNER JOIN visitepiappoint a 
ON e.pcucodeperson=a.pcucodeperson AND e.pid=a.pid 
INNER JOIN person p
ON e.pcucodeperson=p.pcucodeperson AND e.pid=p.pid 
INNER JOIN ctitle c
ON p.prename=c.titlecode
WHERE e.dateepi BETWEEN '2018-01-01' AND '2021-06-31'
AND a.dateappoint > e.dateepi
GROUP BY e.pid ;
