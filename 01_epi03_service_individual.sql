
-- NOT need house because  house is not completed

SET  @thisyear=YEAR(CURDATE()) ;
SET  @thismonth=(MONTH(CURDATE())-3) ;

SELECT p.pcucodeperson,p.pid
,p.idcard
,CONCAT(c.titlename,p.fname,'   ',p.lname) as fullname
,p.birth
,TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) as  'agemonth'
,p.mother as 'มารดา'
,GROUP_CONCAT(e.vaccinecode) as vaccinecode
FROM visitepi e
LEFT JOIN person p 
ON e.pcucode=p.pcucodeperson AND e.pid=p.pid 
LEFT JOIN ctitle c
ON p.prename=c.titlecode
WHERE e.pcucode=e.hosservice
AND year(e.dateepi)=@thisyear AND month(e.dateepi)=@thismonth
GROUP BY p.pcucodeperson,p.pid
