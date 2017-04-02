###############################################################################
# JHCIS
###############################################################################
SELECT p.idcard,p.fname,p.lname
,case WHEN p.sex=1 THEN 'ชาย'
			WHEN p.sex=2 THEN 'หญิง'
			ELSE 'กระเทย'
END AS gender
,p.typelive,p.hnomoi,p.mumoi,p.rightcode 
,c.rightname
,g.rightgroupcode,g.rightgroupname 
FROM person p
LEFT JOIN cright c
ON p.rightcode=c.rightcode 
LEFT JOIN crightgroup g
ON c.rightgroup=g.rightgroupcode 
WHERE p.typelive in ('1','3')
AND p.dischargetype='9'
