SELECT t9.titlename,t9.fname,t9.lname,t9.birth,t9.typelive,t9.rightcode 
,t9.hnomoi,t9.mumoi
,t9.ref_cid ,t9.relate,t9.rightcoderelate  
,concat(t10.fname,'   ',t10.lname)  as closefamily 
,a.hno as address,a.mu as moo
,h.hno as homeno,h.villcode as homevillage 
FROM 
(
SELECT p.pcucodeperson,p.pid,p.hcode,p.idcard
,pr.titlename
,p.fname,p.lname,p.birth,p.typelive,p.rightcode
,p.mumoi,p.hnomoi
,tn.persontypename
,p.fatherid,p.motherid,p.mateid 
,CONCAT_WS(' ', t1.hischild, t2.herchild) as ref_cid
,CONCAT_WS(' ', t1.relate, t2.relate) as relate
,CONCAT_WS(' ', t1.rightcode, t2.rightcode) as rightcoderelate
FROM person p
LEFT JOIN ctitle pr
ON p.prename=pr.titlecode 
LEFT JOIN  cfamilyposition f
ON p.familyposition=f.famposcode
LEFT JOIN persontype t 
ON p.pcucodeperson=t.pcucodeperson AND p.pid=t.pid 
LEFT JOIN cpersontype tn
ON t.typecode=tn.persontypecode
LEFT JOIN 
(
SELECT p.idcard as hischild,p.fatherid,'1' AS relate,p.rightcode FROM person p
WHERE p.dischargetype='9'
) as t1 
ON p.idcard=t1.fatherid 
LEFT JOIN 
(
SELECT p.idcard as herchild,p.motherid,'2' AS relate,p.rightcode FROM person p
WHERE p.dischargetype='9'
) as t2 
ON p.idcard=t2.motherid 
WHERE p.typelive in ('1','3')
AND p.dischargetype='9'
AND t.typecode='09'

-- father 
UNION 
SELECT p.pcucodeperson,p.pid,p.hcode,p.idcard
,pr.titlename
,p.fname,p.lname,p.birth,p.typelive,p.rightcode
,p.mumoi,p.hnomoi
,tn.persontypename
,p.fatherid,p.motherid,p.mateid 
,t3.idcard as ref_cid
,t3.relate as relate
,t3.rightcode as rightcoderelate
FROM person p
LEFT JOIN ctitle pr
ON p.prename=pr.titlecode 
LEFT JOIN  cfamilyposition f
ON p.familyposition=f.famposcode
LEFT JOIN persontype t 
ON p.pcucodeperson=t.pcucodeperson AND p.pid=t.pid 
LEFT JOIN cpersontype tn
ON t.typecode=tn.persontypecode
LEFT JOIN 
(
SELECT p.idcard ,'3' AS relate,p.rightcode FROM person p
WHERE p.dischargetype='9'
) as t3 
ON p.fatherid=t3.idcard
WHERE p.typelive in ('1','3')
AND p.dischargetype='9'
AND t.typecode='09'

-- mother 

UNION 
SELECT p.pcucodeperson,p.pid,p.hcode,p.idcard
,pr.titlename
,p.fname,p.lname,p.birth,p.typelive,p.rightcode
,p.mumoi,p.hnomoi
,tn.persontypename
,p.fatherid,p.motherid,p.mateid 
,t4.idcard as ref_cid
,t4.relate as relate
,t4.rightcode as rightcoderelate
FROM person p
LEFT JOIN ctitle pr
ON p.prename=pr.titlecode 
LEFT JOIN  cfamilyposition f
ON p.familyposition=f.famposcode
LEFT JOIN persontype t 
ON p.pcucodeperson=t.pcucodeperson AND p.pid=t.pid 
LEFT JOIN cpersontype tn
ON t.typecode=tn.persontypecode
LEFT JOIN 
(
SELECT p.idcard ,'4' AS relate,p.rightcode FROM person p
WHERE p.dischargetype='9'
) as t4 
ON p.motherid=t4.idcard
WHERE p.typelive in ('1','3')
AND p.dischargetype='9'
AND t.typecode='09'

-- mate 
UNION 
SELECT p.pcucodeperson,p.pid,p.hcode,p.idcard
,pr.titlename
,p.fname,p.lname,p.birth,p.typelive,p.rightcode
,p.mumoi,p.hnomoi
,tn.persontypename
,p.fatherid,p.motherid,p.mateid 
,t5.idcard as ref_cid
,t5.relate as relate
,t5.rightcode as rightcoderelate
FROM person p
LEFT JOIN ctitle pr
ON p.prename=pr.titlecode 
LEFT JOIN  cfamilyposition f
ON p.familyposition=f.famposcode
LEFT JOIN persontype t 
ON p.pcucodeperson=t.pcucodeperson AND p.pid=t.pid 
LEFT JOIN cpersontype tn
ON t.typecode=tn.persontypecode
LEFT JOIN 
(
SELECT p.idcard ,'5' AS relate,p.rightcode FROM person p
WHERE p.dischargetype='9'
) as t5 
ON p.mateid=t5.idcard
WHERE p.typelive in ('1','3')
AND p.dischargetype='9'
AND t.typecode='09'
) as t9
LEFT JOIN person t10
ON t9.ref_cid=t10.idcard 
LEFT JOIN personaddresscontact a
ON t9.pcucodeperson=a.pcucodeperson AND t9.pid=a.pid  
LEFT JOIN house h
ON t9.pcucodeperson=h.pcucode and	t9.hcode=h.hcode 
WHERE NOT ISNULL(t9.ref_cid) AND t9.ref_cid<>''
-- WHERE t9.fname='กันยารัตน์'
ORDER BY homevillage,fname,lname,homeno

