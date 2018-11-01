SELECT v.pid,v.visitno,v.visitdate 
,d.drugcode  
,c.drugname
,substr(d.drugcode,6,2) as grp
,count(*) n 
FROM visit v
LEFT JOIN visitdrug d
ON v.pcucode=d.pcucode AND v.visitno=d.visitno 
LEFT JOIN cdrug c
ON d.drugcode=c.drugcode 
WHERE v.visitdate BETWEEN '2017-10-01' AND '2018-09-30'
AND substr(d.drugcode,4,2) in ('77','78','79')
AND substr(d.drugcode,6,2) in ('00','01','02','08','09')
GROUP BY d.drugcode 
