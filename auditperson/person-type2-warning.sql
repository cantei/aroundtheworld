# ทะเบียนบ้านต้องอยู่ในเขต  ที่อยู่จริงต้องไม่อยู่ในเขต  และบ้านต้องไม่อยู่ในเขต   
SELECT p.pid,p.fname,p.lname,p.typelive
,p.hnomoi,concat(p.provcodemoi,p.distcodemoi,p.subdistcodemoi,p.mumoi) as mumoi
,a.hno as hno_address,concat(a.provcode,a.distcode ,a.subdistcode,a.mu) as mu_address
,h.hno as homeno,h.villcode
,concat(v.fname,' ',v.lname) as volanteer
FROM personaddresscontact a
LEFT JOIN house h
ON a.hno=h.hno AND  concat(a.provcode,a.distcode ,a.subdistcode,a.mu)=h.villcode 
LEFT JOIN person v
ON h.pcucodepersonvola=v.pcucodeperson AND h.pidvola=v.pid 
LEFT JOIN person p
ON a.pcucodeperson=p.pcucodeperson AND a.pid=p.pid 
WHERE  p.typelive='2'
AND 
(
concat(p.provcodemoi,p.distcodemoi,p.subdistcodemoi)<>'841207'
OR substr(h.villcode,1,6)='841207'
OR concat(a.provcode,a.distcode ,a.subdistcode)='841207'
)
