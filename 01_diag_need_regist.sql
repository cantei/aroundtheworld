SELECT * 
FROM 
(
SELECT p.pcucodeperson as pcucode
,concat(c.titlename,p.fname,'    ',p.lname) as fullname
,p.idcard,p.birth
,p.pid,p.typelive,p.dischargetype  
,GROUP_CONCAT(d.diagcode) as diag 
,GROUP_CONCAT(v.visitdate) as visit 
,h.hno,substr(h.villcode,8,1) village 
,concat(a.fname,'    ',a.lname) as 'volanteer'
FROM person p
LEFT JOIN house h 
ON p.pcucodeperson=h.pcucode AND p.pid=h.pid 
LEFT JOIN ctitle c
ON p.prename=c.titlecode
LEFT JOIN person a
on a.hcode=h.hcode AND a.pcucodeperson=h.pcucode
INNER JOIN visit v 
ON p.pcucodeperson=v.pcucodeperson AND p.pid=v.pid 
LEFT JOIN visitdiag d 
ON v.pcucode=d.pcucode AND v.visitno=d.visitno 
WHERE substr(REPLACE( d.diagcode,'.',''),1,3) BETWEEN 'E10' AND 'E14' 
OR substr(REPLACE( d.diagcode,'.',''),1,3) BETWEEN 'I10' AND 'I15' 
OR substr(REPLACE( d.diagcode,'.',''),1,3) BETWEEN 'I60' AND 'I69' 
OR substr(REPLACE( d.diagcode,'.',''),1,3) BETWEEN 'I64' AND 'I64'  
OR substr(REPLACE( d.diagcode,'.',''),1,3) BETWEEN 'I20' AND 'I25'  
OR substr(REPLACE(d.diagcode,'.',''),1,4) BETWEEN 'J449' AND 'J449' 
OR substr(REPLACE( d.diagcode,'.',''),1,3) BETWEEN 'J45' AND 'J46' 
OR substr(REPLACE(d.diagcode,'.',''),1,3) BETWEEN 'J43' AND 'J43' 
OR substr(REPLACE(d.diagcode,'.',''),1,3) BETWEEN 'E66' AND 'E66' 
OR substr(REPLACE(d.diagcode,'.',''),1,3) BETWEEN 'C00' AND 'C97' 
OR substr(REPLACE(d.diagcode,'.',''),1,3) BETWEEN 'B20' AND 'B24' 
OR substr(REPLACE(d.diagcode,'.',''),1,4) in ('K703','K717') OR substr(REPLACE(d.diagcode,'.',''),1,3)='K74'
OR substr(REPLACE(d.diagcode,'.',''),1,3)='K73'
OR substr(REPLACE(d.diagcode,'.',''),1,3)='N18'


GROUP BY  p.idcard
) as t 

WHERE t.typelive in ('1','3') 
AND  NOT EXISTS 
(
	SELECT *
	FROM me_chronic_all_indiv WHERE t.idcard=me_chronic_all_indiv.idcard 
)
ORDER BY  t.village,(SPLIT_STR(t.hno,'/', 1)*1),(SPLIT_STR(t.hno,'/',2)*1);
