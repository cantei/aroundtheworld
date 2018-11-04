SELECT p.pcucodeperson,p.pid
-- , t1.pcucodeperson,t1.pcucode,t1.pid
,CONCAT(c.titlename,p.fname,'   ',p.lname) as fullname
	,concat(DATE_FORMAT(p.birth, "%d"),'-',DATE_FORMAT(p.birth, "%m"),'-',(DATE_FORMAT(p.birth, "%Y")+543)) as born
	,TIMESTAMPDIFF(year,p.birth,CURDATE()) as  age
	,p.typelive
	,p.hnomoi,p.mumoi
	,a.hno,a.mu as moo
	,CONCAT(a.hno,'  ','หมู่ที่ ',a.mu )as address
	,h.hno as homeno,(substr(h.villcode,7,2)*1) as homevillage
,CONCAT(o.fname,'  ',o.lname) as 'volanteer'

FROM person p
LEFT JOIN ctitle c
ON p.prename=c.titlecode
LEFT JOIN personaddresscontact a
ON p.pcucodeperson=a.pcucodeperson AND p.pid=a.pid 
LEFT JOIN house h
ON a.hno=h.hno AND concat(a.provcode,a.distcode,a.subdistcode,a.mu)=h.villcode  
LEFT JOIN person o
ON h.pcucodepersonvola=o.pcucodeperson and	h.pidvola=o.pid

WHERE p.typelive in ('1')
AND p.dischargetype='9'
HAVING ISNULL(homeno) 
-- AND mumoi in ('4','04')
ORDER BY p.mumoi ,volanteer,(SPLIT_STR(p.hnomoi,'/', 1)*1),(SPLIT_STR(p.hnomoi,'/',2)*1)
