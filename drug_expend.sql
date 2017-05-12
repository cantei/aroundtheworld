SELECT substr(d.drugcode,2,10) as genericcode,g.GENERICNAME as genericname,d.drugcode,sum(d.unit) AS outed 
FROM visitdrug d 
LEFT JOIN cgeneric g  
ON g.GENERIC=substr(d.drugcode,2,10) 
LEFT JOIN visit v
ON d.visitno=v.visitno 
WHERE v.visitdate BETWEEN '2013-10-01' AND '2014-10-31'
GROUP BY substr(d.drugcode,2,10) 
HAVING NOT ISNULL(GENERICNAME)
