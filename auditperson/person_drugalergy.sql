SELECT h.villcode,h.hno,p.pcucodeperson,p.pid
,p.idcard
,CONCAT(c.titlename,p.fname,'   ',p.lname) as fullname
,p.birth
,p.typelive 
,p.hnomoi,p.mumoi
,CONCAT(DATE_FORMAT(p.birth,'%d-%m'),'-',year(p.birth)+543) as born 
,CONCAT(h.hno,'  ','หมู่ที่','  ',substr(h.villcode,8,1))  as addess
,GROUP_CONCAT(d.drugcode) as drugcode
,GROUP_CONCAT(r.drugname) as drugname
,d.levelalergic
FROM personalergic  d
LEFT JOIN cdrug r
ON d.drugcode=r.drugcode
LEFT JOIN person p
ON d.pcucodeperson=p.pcucodeperson AND d.pid=p.pid 
LEFT JOIN ctitle c
ON p.prename=c.titlecode
LEFT JOIN house h
ON h.pcucode=p.pcucodeperson AND h.hcode=p.hcode AND h.pid=p.pid
GROUP BY d.pid
-- WHERE p.dischargetype='1'
