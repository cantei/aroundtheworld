# ทะเบียนผู้รับบริการทันตกรรม
SELECT 
v.pid,v.visitno ,v.visitdate
,CONCAT(t.titlename,p.fname,'  ',p.lname) as fullname 
,GROUP_CONCAT(DISTINCT dx.diagcode) as diag 
,GROUP_CONCAT(DISTINCT s.diseasename) as disease
,GROUP_CONCAT(DISTINCT dr.dentcode) as dentaldelivery
,GROUP_CONCAT(DISTINCT c.drugname) as drugname
,GROUP_CONCAT(DISTINCT dr.tootharea) as tootharea
,dx.doctordiag 
FROM visit v 
LEFT JOIN visitdiag dx 
ON v.pcucode = dx.pcucode AND v.visitno = dx.visitno
LEFT JOIN visitdrugdental dr 
ON dx.pcucode = dr.pcucode AND dx.visitno = dr.visitno
LEFT JOIN cdisease s 
ON dx.diagcode = s.diseasecode
LEFT JOIN cdrug c 
ON dr.dentcode = c.drugcode
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
LEFT  JOIN ctitle t 
ON t.titlecode = p.prename
WHERE NOT  ISNULL(dr.dentcode) 
AND v.visitdate BETWEEN '2018-03-01' AND '2018-03-31'
GROUP BY v.pid,v.visitno
ORDER BY v.visitno
-- HAVING substr(dx.diagcode,1,1) ='K'

