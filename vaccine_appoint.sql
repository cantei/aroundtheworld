SELECT p.prename,p.fname,p.lname,p.birth,TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) as  'agemonth'
,e.dateepi,GROUP_CONCAT(DISTINCT e.vaccinecode) as vaccines
,GROUP_CONCAT(DISTINCT CONVERT( a.dateappoint, CHAR(255))) as appoint
,GROUP_CONCAT(a.vaccinecode)  as need_vaccine
FROM visitepi e
INNER JOIN visitepiappoint a 
ON e.pcucodeperson=a.pcucodeperson AND e.pid=a.pid 
INNER JOIN person p
ON e.pcucodeperson=p.pcucodeperson AND e.pid=p.pid 
WHERE e.dateepi BETWEEN '2021-01-01' AND '2021-06-31'
AND a.dateappoint > e.dateepi
GROUP BY e.pid ;
