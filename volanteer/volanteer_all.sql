SELECT p.pcucodeperson,p.pid,p.idcard
,pr.titlename
,p.fname,p.lname,p.birth,p.typelive,p.rightcode
,p.mumoi,p.hnomoi
,a.hno,a.mu
,h.hno as homeno,substr(h.villcode,7,2) as homevillage
,tn.persontypename
FROM person p
LEFT JOIN ctitle pr
ON p.prename=pr.titlecode 
LEFT JOIN personaddresscontact a
ON p.pcucodeperson=a.pcucodeperson AND p.pid=a.pid  
LEFT JOIN house h
ON p.pcucodeperson=h.pcucode and	p.hcode=h.hcode 
LEFT JOIN  cfamilyposition f
ON p.familyposition=f.famposcode
LEFT JOIN persontype t 
ON p.pcucodeperson=t.pcucodeperson AND p.pid=t.pid 
LEFT JOIN cpersontype tn
ON t.typecode=tn.persontypecode
WHERE p.typelive in ('1','3')
AND p.dischargetype='9'
AND t.typecode='09'
ORDER BY homevillage,fname,lname
