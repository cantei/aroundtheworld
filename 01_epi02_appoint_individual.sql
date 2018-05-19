# Appointment Individual
# FOR STEP1 CHECK Temp,BW,heigth

SET  @thisyear=YEAR(CURDATE()) ;
SET  @thismonth=MONTH(CURDATE()) ;

SELECT h.villcode,p.pcucodeperson,p.pid
,p.idcard
,CONCAT(c.titlename,p.fname,'   ',p.lname) as fullname
,p.birth
,concat(DATE_FORMAT(p.birth,'%d-%m'),'-',year(p.birth)+543) as born
,TIMESTAMPDIFF(MONTH,p.birth,CURDATE()) as  'agemonth'
,p.mother as 'มารดา'
,concat(h.hno,'  ','หมู่ที่','  ',substr(h.villcode,8,1))  as addess
,concat(v.fname,'  ',v.lname) as 'volanteer'
,a.dateappoint
,GROUP_CONCAT(a.vaccinecode)  as need_vaccine
FROM visitepiappoint a 
LEFT JOIN person p 
ON a.pcucodeperson=p.pcucodeperson AND a.pid=p.pid 
LEFT JOIN ctitle c
ON p.prename=c.titlecode
LEFT JOIN house h 
ON  p.pcucodeperson=h.pcucode AND p.hcode=h.hcode
LEFT JOIN person v
ON h.pcucodepersonvola=v.pcucodeperson and	h.pidvola=v.pid 
WHERE YEAR(a.dateappoint)=@thisyear
AND MONTH (a.dateappoint)=(@thismonth+1)
GROUP BY p.pcucodeperson,p.pid
ORDER BY h.villcode,(SPLIT_STR(hno,'/', 1)*1),(SPLIT_STR(hno,'/',2)*1)
