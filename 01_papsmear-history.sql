#######################################################################################################################################
# JHCIS
#######################################################################################################################################
SELECT p.pcucodeperson,p.pid,p.idcard,p.fname,p.lname,p.birth
,TIMESTAMPDIFF(YEAR,p.birth,NOW()) as age 
,p.hnomoi,p.mumoi
,p.typelive,p.dischargetype 
,concat(h.hno,'หมู่ที่',h.mu) as address
,MAX(if(v.datecheck BETWEEN '2014-10-01' AND '2015-09-30' AND v.typecancer='2' ,v.datecheck ,NULL )) as y2558
,MAX(if(v.datecheck BETWEEN '2015-10-01' AND '2016-09-30' AND v.typecancer='2' ,v.datecheck ,NULL )) as y2559
,MAX(if(v.datecheck BETWEEN '2016-10-01' AND '2017-09-30' AND v.typecancer='2',v.datecheck ,NULL )) as y2560
FROM person p 
LEFT JOIN visitlabcancer v
ON v.pcucodeperson=p.pcucodeperson AND v.pid=p.pid 
LEFT JOIN personaddresscontact h
ON p.pcucodeperson=h.pcucodeperson AND p.pid=h.pid 

WHERE  p.typelive in ('1','3') AND p.dischargetype='9'
AND   p.sex='2'
AND p.birth BETWEEN '1957-09-30' AND '1986-10-01' 
GROUP BY v.pcucodeperson,v.pid 
-- HAVING  NOT ISNULL(y2559)
-- ORDER BY p.mumoi,p.hnomoi 
ORDER BY  CONVERT(SUBSTRING_INDEX(p.mumoi,'-',-1),UNSIGNED INTEGER),p.hnomoi 
