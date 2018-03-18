SELECT t0.pcucodeperson,t0.pid,t0.idcard,t0.fname,t0.lname,t0.birth,t0.sex,t0.typelive,t0.dischargetype 
,t1.lastscreen,t1.lastbmi
FROM (
SELECT p.pcucodeperson,p.pid,p.idcard,p.fname,p.lname,p.birth,p.sex,p.typelive,p.dischargetype 
FROM person p
WHERE p.typelive in ('1','3')
AND p.dischargetype='9'
AND TIMESTAMPDIFF(YEAR,p.birth,CURDATE()) BETWEEN 30 AND 60
) as t0 
LEFT JOIN 
(
SELECT s.pcucode,s.pid
-- ,s.screen_date,s.height,s.weight,s.waist,s.bmi 
,SPLIT_STR((GROUP_CONCAT(CAST(s.screen_date AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  s.screen_date DESC  SEPARATOR ',')),',',1) as lastscreen
,SPLIT_STR((GROUP_CONCAT(CAST(s.bmi AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  s.screen_date DESC  SEPARATOR ',')),',',1) as lastbmi
FROM  ncdpersonscreenall s
WHERE s.screen_date BETWEEN '2015-10-01' AND  '2018-09-30'
GROUP BY s.pcucode,s.pid

) as t1 
ON t0.pcucodeperson=t1.pcucode AND t0.pid=t1.pid 
HAVING lastscreen BETWEEN '2016-01-01' AND  '2016-03-31';
