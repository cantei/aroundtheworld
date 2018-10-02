# เด็กอายุครบ 1 ปี 
SET @d1='2018-10-01';
SET @d2='2019-09-30';

SELECT concat(c.titlename,p.fname,'    ',p.lname) as fullname
,concat(DATE_FORMAT(p.birth, "%d/%m"),'/',(DATE_FORMAT(p.birth, "%Y")+543)) as born
,concat(' ',h.hno) as homeno
,substr(h.villcode,8,1) as moo
,p.mother
,p.telephoneperson
,'' as school
,'' as hosservice

,concat(v.fname,'    ',v.lname) as 'volanteer'
,SPLIT_STR(GROUP_CONCAT(CAST(e.dateepi AS CHAR(10000) CHARACTER SET utf8)  ORDER BY e.dateepi DESC SEPARATOR ','),',',1) as lastvisit 
,SPLIT_STR(GROUP_CONCAT(CAST(e.vaccinecode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY e.dateepi DESC SEPARATOR ','),',',1) as lastitems 
FROM person p
LEFT JOIN ctitle c
ON p.prename=c.titlecode
LEFT JOIN house h
on p.hcode=h.hcode AND p.pcucodeperson=h.pcucode 
LEFT JOIN person v
ON h.pcucodepersonvola=v.pcucodeperson AND h.pidvola=v.pid 
LEFT JOIN visitepi e
on p.pid=e.pid AND p.pcucodeperson=e.pcucodeperson 
WHERE p.typelive in ('1','3') 
AND p.dischargetype='9'
AND p.nation='99'
AND e.vaccinecode<>'FLU'
AND p.birth BETWEEN DATE_SUB(@d1, INTERVAL 1 YEAR) AND DATE_SUB(@d2, INTERVAL 1 YEAR)
GROUP BY CONCAT(p.pcucodeperson,p.pid)
ORDER BY  h.villcode,(SPLIT_STR(h.hno,'/', 1)*1),(SPLIT_STR(h.hno,'/',2)*1);
