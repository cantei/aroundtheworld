SELECT s.ID,s.PID
,CONCAT(c.titlename,p.fname,'   ',p.lname) as fullname
,s.HbA1CDATE,s.HbA1CHOSPCODE,s.HbA1CRESULT
,CASE WHEN s.HbA1CRESULT BETWEEN 7 AND 100 then	  "Red"
WHEN s.HbA1CRESULT =""  then	  "Unknown"
WHEN s.HbA1CRESULT < 7  then	  "Green"
ELSE NULL
END as ball
,CONCAT(' ',a.hno) as hno,(a.mu*1) as mu
,CONCAT(v.fname,'    ',v.lname) as volanteer
FROM sheet1 s
LEFT JOIN person p
ON s.pid=p.pid 
LEFT JOIN ctitle c
ON p.prename=c.titlecode
LEFT JOIN personaddresscontact a
ON a.pcucodeperson=p.pcucodeperson AND a.pid=p.pid 
LEFT JOIN house h
ON a.hno=h.hno AND  concat(a.provcode,a.distcode ,a.subdistcode,a.mu)=h.villcode 
LEFT JOIN person v
ON h.pcucodepersonvola=v.pcucodeperson AND h.pidvola=v.pid 
