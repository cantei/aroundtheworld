SELECT v.pcucode,v.pid
,p.fname,p.lname,p.birth,TIMESTAMPDIFF(year,p.birth,CURDATE()) as age_year
,v.visitno,v.visitdate,v.symptoms,v.pulse
,REPLACE(GROUP_CONCAT(d.diagcode ORDER BY d.dxtype SEPARATOR ','),'.','') as diagcode
,GROUP_CONCAT(d.dxtype  ORDER BY d.dxtype SEPARATOR ',' ) as diagtype
,v.refertohos  
FROM visit v
LEFT JOIN visitdiag d
ON v.pcucode=d.pcucode AND d.visitno=v.visitno
LEFT JOIN person p
ON v.pcucode=p.pcucodeperson AND v.pid=p.PID
WHERE refer='01'
AND v.visitdate  BETWEEN '2015-01-01' AND '2015-12-31'
GROUP BY v.visitno
