# to verify key-in
-- NOT need house because  house is not completed

SET  @thisyear=YEAR(CURDATE()) ;
SET  @thismonth=(MONTH(CURDATE())-3) ;

SELECT t.* 
,SPLIT_STR(GROUP_CONCAT(CAST(a.dateappoint AS CHAR(10000) CHARACTER SET utf8)  ORDER BY a.dateappoint SEPARATOR ','),',',1) as dateappoint
,GROUP_CONCAT(a.vaccinecode)  as need_vaccine
FROM 
(
SELECT p.pcucodeperson,p.pid
,p.idcard
,CONCAT(c.titlename,p.fname,'   ',p.lname) as fullname
,p.birth
,TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) as  'agemonth'
,p.mother as 'มารดา'
,e.dateepi
,GROUP_CONCAT(e.vaccinecode ORDER BY e.vaccinecode) as vaccinecode
,GROUP_CONCAT(e.lotno ORDER BY e.vaccinecode) as lot_vaccine
FROM visitepi e
LEFT JOIN person p 
ON e.pcucode=p.pcucodeperson AND e.pid=p.pid 
LEFT JOIN ctitle c
ON p.prename=c.titlecode
WHERE e.pcucode=e.hosservice
AND year(e.dateepi)=@thisyear AND month(e.dateepi)=@thismonth
GROUP BY p.pcucodeperson,p.pid
ORDER BY e.visitno
) as t 
LEFT JOIN visitepiappoint a 
ON a.pcucodeperson=t.pcucodeperson AND a.pid=t.pid 
WHERE a.dateappoint > t.dateepi
GROUP BY t.pid
