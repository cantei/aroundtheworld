-- Appointment Individual  ON  Any Month

SET  @thisyear=YEAR(CURDATE()) ;
SET  @thismonth=(MONTH(CURDATE())+0) ;

SELECT a.dateappoint,p.pid,p.idcard as cid,p.fname,p.lname,p.birth,p.typelive
			,TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) as age_month
			,CONCAT(p.mother,'-',p.father) as parents
			,GROUP_CONCAT(a.vaccinecode ORDER BY a.vaccinecode SEPARATOR ',') as vaccine_needs	
FROM visitepiappoint a
INNER JOIN person p
ON p.pcucodeperson=a.pcucodeperson AND p.pid=a.pid
WHERE year(a.dateappoint)=@thisyear AND month(a.dateappoint)=@thismonth
GROUP BY p.idcard
-- HAVING vaccine_needs LIKE '%DTP%'
ORDER BY p.pid
