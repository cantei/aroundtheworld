-- WHO Get Vaccine Individual
SET  @thisyear=YEAR(CURDATE()) ;
SET  @thismonth=(MONTH(CURDATE())-0) ;

SELECT a.dateepi,p.pid,p.idcard as cid,p.fname,p.lname,p.birth,p.typelive
-- 			,TIMESTAMPDIFF(YEAR,p.birth,CURDATE()) as age_year
			,TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) as age_month
			,CONCAT(p.mother,'-',p.father) as parents
			,GROUP_CONCAT(a.vaccinecode ORDER BY a.vaccinecode SEPARATOR ',') as vaccine_items
FROM visitepi a
INNER JOIN person p
ON p.pcucodeperson=a.pcucodeperson AND p.pid=a.pid
AND p.pcucodeperson=a.hosservice
WHERE year(a.dateepi)=@thisyear AND month(a.dateepi)=@thismonth
GROUP BY p.pcucodeperson,p.pid;
