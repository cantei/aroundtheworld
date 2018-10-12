SELECT concat(v.fname,' ',v.lname) as volanteer
,h.hno,h.villcode
,SPLIT_STR(if(substr(h.hno,1,1)='0',SPLIT_STR(h.hno,'-',2),h.hno),'/',1) as x1
,SPLIT_STR(if(substr(h.hno,1,1)='0',SPLIT_STR(h.hno,'-',2),h.hno),'/',2) as x2
,if(substr(h.hno,1,1)='0',1,0) as x3
-- ,concat(o.fname,' ',o.lname) as houseowner
,if(h.area='1','เทศบาล','อบต') as area
,p.idcard
,concat(pr.titlename,p.fname,'   ',p.lname) as member
,if(f.famposcode='0','ฮ',f.famposcode) as fposcode
-- ,f.famposcode
,f.famposname
,p.birth
,TIMESTAMPDIFF(YEAR,p.birth,'2018-10-01') as age
,CONCAT(DATE_FORMAT(p.birth,'%d-%m'),'-',year(p.birth)+543) as born 
,p.typelive,p.hnomoi,concat(p.provcodemoi,p.distcodemoi,p.subdistcodemoi,p.mumoi) as addressmoi
,t.hno as address,concat(t.provcode,t.distcode,t.subdistcode,t.mu) as realaddress
,if((TIMESTAMPDIFF(YEAR,p.birth,'2018-10-01') BETWEEN 20 AND 59),'/',NULL) AS 'Worker'
,if((TIMESTAMPDIFF(YEAR,p.birth,'2018-10-01') BETWEEN 6 AND 19),'/',NULL) AS 'Educate'
,if((TIMESTAMPDIFF(YEAR,p.birth,'2018-10-01') BETWEEN 0 AND 5),'/',NULL) AS 'Child'
-- ,TIMESTAMPDIFF(week,n.lmp ,CURDATE()) as timega
,if(SPLIT_STR(GROUP_CONCAT(CAST(a.pregage AS CHAR(10000) CHARACTER SET utf8)  ORDER BY a.datecheck DESC SEPARATOR ','),',',1)  BETWEEN 0 AND 41,'/',NULL) AS 'A'
-- ,GROUP_CONCAT(ht.chroniccode ORDER BY ht.datedxfirst  DESC) as ht
-- ,GROUP_CONCAT(dm.chroniccode ORDER BY dm.datedxfirst  DESC) as dm
,if(NOT ISNULL(ht.chroniccode) ,'/',NULL) AS 'HT'
,if(NOT ISNULL(dm.chroniccode) ,'/',NULL) AS 'DM'
-- ,ht.chroniccode
-- ,dm.chroniccode 

,IF(NOT ISNULL(ut.typecode),'/',NULL) AS 'D'
,if((TIMESTAMPDIFF(YEAR,p.birth,'2018-10-01') > 59),'/',NULL) AS 'O'
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
LEFT JOIN visitanc a 
ON p.pcucodeperson=a.pcucodeperson AND p.pid=a.pid 
LEFT JOIN visitancpregnancy n 
ON a.pcucodeperson=n.pcucodeperson AND a.pid=n.pid AND a.pregno=n.pregno 
LEFT JOIN  visitancdeliver l
ON a.pcucodeperson=l.pcucodeperson AND a.pid=l.pid AND a.pregno=l.pregno
LEFT JOIN  personunable u 
ON p.pcucodeperson=u.pcucodeperson AND p.pid=u.pid 
LEFT JOIN personunable1type ut
ON u.pcucodeperson=ut.pcucodeperson AND u.pid=ut.pid 
LEFT JOIN cpersonincomplete i
ON ut.typecode=i.incompletecode 

WHERE substr(h.villcode,8,1)='2'
AND p.typelive in ('1','3')
AND p.dischargetype='9'
-- AND p.idcard='3841200016821'

GROUP BY p.pid
-- LIMIT 100
-- HAVING NOT ISNULL(A)
