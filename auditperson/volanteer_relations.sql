SELECT v.volanteer,v.hnomoi,(substr(areacode,1,2)*1) as moo
,v.rightcode as herright,v.hosmain,v.hossub,v.dateexpire
,v.ref_cid
,concat(r.fname,'   ',r.lname) as personrelate
,v.relate 
,CASE WHEN  v.relate in ('1','2') THEN 'บุตรของ อสม.'
		WHEN  v.relate in ('3') THEN 'บิดาของ อสม.'
		WHEN  v.relate in ('4') THEN 'มารดาของ อสม.'
		WHEN  v.relate in ('5') THEN 'คู่สมรถของ อสม.'
ELSE NULL 
END as 'relatename'

,r.rightcode as righttype
,c.rightname
,r.dateexpire as exp_date
,TIMESTAMPDIFF(year,r.birth,CURDATE()) as age 
FROM 
(
SELECT p.idcard as vola_id,concat(p.fname,'   ',p.lname) as volanteer
,p.hnomoi,concat(p.mumoi,p.subdistcodemoi,p.distcodemoi,p.provcodemoi) as areacode
,p.rightcode 
,p.hosmain,p.hossub
,p.dateexpire 
,CONCAT_WS(' ', t1.idchildfather, t2.idchildmother) as ref_cid
,CONCAT_WS(' ', t1.relate, t2.relate) as relate
FROM person p
LEFT JOIN cright r	 
on	p.rightcode=r.rightcode 
LEFT JOIN crightgroup g
ON r.rightgroup=g.rightgroupcode 
LEFT JOIN 
(
SELECT p.idcard as idchildfather,p.fatherid,'1' AS relate
FROM person p 
WHERE p.dischargetype='9'
) t1
ON p.idcard=t1.fatherid 
LEFT JOIN 
(
SELECT p.idcard as idchildmother,p.motherid,'2' AS relate
FROM person p
WHERE p.dischargetype='9'
) t2
ON p.idcard=t2.motherid 
WHERE p.dischargetype='9'
AND r.rightcode='82'
AND p.dateexpire > CURDATE()

-- father(3) & mother(4)
UNION 
SELECT p.idcard as vola_id,concat(p.fname,'   ',p.lname) as volanteer
,p.hnomoi,concat(p.mumoi,p.subdistcodemoi,p.distcodemoi,p.provcodemoi) as areacode
,p.rightcode 
,p.hosmain,p.hossub
,p.dateexpire 
,t1.idcard as ref_cid,t1.relate
FROM person p
LEFT JOIN cright r	 
on	p.rightcode=r.rightcode 
LEFT JOIN crightgroup g
ON r.rightgroup=g.rightgroupcode 
LEFT JOIN 
(
SELECT p.idcard,'3' AS relate,TIMESTAMPDIFF(year,p.birth,CURDATE()) as age
FROM person p 
WHERE p.dischargetype='9'
) t1
ON p.fatherid=t1.idcard 
WHERE p.dischargetype='9'
AND r.rightcode='82'
AND p.dateexpire > CURDATE()
UNION 
SELECT p.idcard as vola_id,concat(p.fname,'   ',p.lname) as volanteer
,p.hnomoi,concat(p.mumoi,p.subdistcodemoi,p.distcodemoi,p.provcodemoi) as areacode
,p.rightcode 
,p.hosmain,p.hossub
,p.dateexpire 
,t1.idcard as ref_cid,t1.relate
FROM person p
LEFT JOIN cright r	 
on	p.rightcode=r.rightcode 
LEFT JOIN crightgroup g
ON r.rightgroup=g.rightgroupcode 
LEFT JOIN 
(
SELECT p.idcard,'4' AS relate,TIMESTAMPDIFF(year,p.birth,CURDATE()) as age
FROM person p 
WHERE p.dischargetype='9'
) t1
ON p.motherid=t1.idcard 
WHERE p.dischargetype='9'
AND r.rightcode='82'
AND p.dateexpire > CURDATE()

UNION 
SELECT p.idcard as vola_id,concat(p.fname,'   ',p.lname) as volanteer
,p.hnomoi,concat(p.mumoi,p.subdistcodemoi,p.distcodemoi,p.provcodemoi) as areacode
,p.rightcode 
,p.hosmain,p.hossub
,p.dateexpire 
,t1.idcard as ref_cid,t1.relate
FROM person p
LEFT JOIN cright r	 
on	p.rightcode=r.rightcode 
LEFT JOIN crightgroup g
ON r.rightgroup=g.rightgroupcode 
LEFT JOIN 
(
SELECT p.idcard,'5' AS relate,TIMESTAMPDIFF(year,p.birth,CURDATE()) as age
FROM person p 
WHERE p.dischargetype='9'
) t1
ON p.mateid=t1.idcard 
WHERE p.dischargetype='9'
AND r.rightcode='82'
AND p.dateexpire > CURDATE()
) as v
LEFT JOIN person r
ON v.ref_cid=r.idcard 
LEFT JOIN cright  c
ON r.rightcode=c.rightcode 
HAVING NOT ISNULL(ref_cid) AND relate  in ('1','2','3','4','5')
ORDER BY substr(areacode,1,2)*1,v.volanteer;
