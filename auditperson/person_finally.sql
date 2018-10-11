SELECT concat(v.fname,' ',v.lname) as volanteer
,h.hno,h.villcode
,if(SPLIT_STR(h.hno,'/',1) LIKE '%-%' OR substr(h.hno,1,1)='0',0,1) as x0

,if(substr(h.hno,1,1)='0',(SPLIT_STR(h.hno,'-',2)*1),0) as x3
,if(substr(h.hno,1,1)='0',(SPLIT_STR(h.hno,'/',2)*1),0) as x4
,if(substr(h.hno,1,1)='0',(SPLIT_STR(h.hno,'-',1)*1),0) as x5
,if(substr(h.hno,1,1)<>'0',(SPLIT_STR(h.hno,'/',1)*1),0) as x1
,if(substr(h.hno,1,1)<>'0',(SPLIT_STR(h.hno,'/',2)*1),0) as x2
,concat(o.fname,' ',o.lname) as houseowner
,if(h.area='1','เทศบาล','อบต') as area
,concat(pr.titlename,p.fname,'   ',p.lname) as member
,if(f.famposcode='0','ฮ',f.famposcode) as fposcode
-- ,f.famposcode
,f.famposname
,p.birth
,CONCAT(DATE_FORMAT(p.birth,'%d-%m'),'-',year(p.birth)+543) as born 
,p.typelive,p.hnomoi,concat(p.provcodemoi,p.distcodemoi,p.subdistcodemoi,p.mumoi) as addressmoi
,t.hno as address,concat(t.provcode,t.distcode,t.subdistcode,t.mu) as realaddress
,GROUP_CONCAT(ht.chroniccode ORDER BY ht.datedxfirst  DESC) as ht
,GROUP_CONCAT(dm.chroniccode ORDER BY dm.datedxfirst  DESC) as dm



FROM house h
LEFT JOIN person o
ON h.pcucode=o.pcucodeperson AND h.hcode=o.hcode AND h.pid=o.pid 
LEFT JOIN person p
ON h.pcucode=p.pcucodeperson AND h.hcode=p.hcode
LEFT JOIN ctitle pr
ON p.prename=pr.titlecode 
LEFT JOIN person v
ON h.pcucodepersonvola=v.pcucodeperson AND h.pidvola=v.pid 
LEFT JOIN cfamilyposition f
ON p.familyposition=f.famposcode
LEFT JOIN personaddresscontact t
ON p.pcucodeperson=t.pcucodeperson AND p.pid=t.pid 
LEFT JOIN personchronic ht
ON p.pid=ht.pid AND substr(ht.chroniccode,1,3) BETWEEN 'I10' AND 'I15'
LEFT JOIN personchronic dm
ON p.pid=dm.pid AND substr(dm.chroniccode,1,3) BETWEEN 'E10' AND 'E14'

WHERE substr(h.villcode,8,1)='2'
AND p.typelive in ('1','3')
AND p.dischargetype='9'
-- AND p.typelive='2'
-- AND concat(p.provcodemoi,p.distcodemoi,p.subdistcodemoi,p.mumoi)NOT in ('84120701','8412071')
-- AND h.area='2'
GROUP BY h.hno,p.pid 
ORDER BY volanteer,x0,x1,x2,x3,x4,x5,fposcode
-- HAVING LENGTH(h.hno) > 5
-- HAVING alive<>0
-- HAVING volanteer  LIKE '%จิต%'
-- ORDER BY volanteer,(SPLIT_STR(h.hno,'/', 1)*1),(SPLIT_STR(h.hno,'/',2)*1),fposcode
-- ORDER BY SPLIT_STR(b,'-', 2)*1,a,c,fposcode
