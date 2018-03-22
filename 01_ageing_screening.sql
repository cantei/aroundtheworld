SELECT t1.*
,if(t1.ppspecial_ageing LIKE '%1B126%','OK',NULL)   as Teeth
,if(t1.ppspecial_ageing LIKE '%1B123%','OK',NULL)   as ATM
,if(t1.ppspecial_ageing LIKE '%1B028%','OK',NULL)   as 2Q
,if(t1.ppspecial_ageing LIKE '%1B127%','OK',NULL)   as Knee
,if(t1.ppspecial_ageing LIKE '%1B120%','OK',NULL)   as Fall
,if(t1.ppspecial_ageing LIKE '%1B128%','OK',NULL)   as ADL
FROM 
(
SELECT idcard,fname,lname,birth, TIMESTAMPDIFF(year,birth,CURDATE()) as age
,GROUP_CONCAT(ppspecial ORDER BY seq SEPARATOR ',') as ppspecial_ageing
FROM 
(
-- teeth
SELECT p.idcard,p.fname,p.lname,p.birth 
,s.dateserv,IFNULL(s.ppspecial,'555') as ppspecial
,'1' as seq
FROM person p
LEFT JOIN f43specialpp s 
ON p.pcucodeperson=s.pcucodeperson AND p.pid=s.pid 
WHERE TIMESTAMPDIFF(year,p.birth,CURDATE()) > 60
AND s.dateserv BETWEEN '2017-10-01' AND '2018-09-30'
AND substr(s.ppspecial,1,5)='1B126'
-- ATM
UNION 
SELECT p.idcard,p.fname,p.lname,p.birth 
,s.dateserv,s.ppspecial
,'2' as seq
FROM person p
LEFT JOIN f43specialpp s 
ON p.pcucodeperson=s.pcucodeperson AND p.pid=s.pid 
WHERE TIMESTAMPDIFF(year,p.birth,CURDATE()) > 60
AND s.dateserv BETWEEN '2017-10-01' AND '2018-09-30'
AND substr(s.ppspecial,1,5)='1B123'
-- 2Q
UNION 
SELECT p.idcard,p.fname,p.lname,p.birth 
,s.dateserv,s.ppspecial
,'3' as seq
FROM person p
LEFT JOIN f43specialpp s 
ON p.pcucodeperson=s.pcucodeperson AND p.pid=s.pid 
WHERE TIMESTAMPDIFF(year,p.birth,CURDATE()) > 60
AND s.dateserv BETWEEN '2017-10-01' AND '2018-09-30'
AND substr(s.ppspecial,1,5)='1B028'
-- join's Knee 
UNION 
SELECT p.idcard,p.fname,p.lname,p.birth 
,s.dateserv,s.ppspecial
,'4' as seq
FROM person p
LEFT JOIN f43specialpp s 
ON p.pcucodeperson=s.pcucodeperson AND p.pid=s.pid 
WHERE TIMESTAMPDIFF(year,p.birth,CURDATE()) > 60
AND s.dateserv BETWEEN '2017-10-01' AND '2018-09-30'
AND substr(s.ppspecial,1,5)='1B127'
-- fall
UNION 
SELECT p.idcard,p.fname,p.lname,p.birth 
,s.dateserv,s.ppspecial
,'5' as seq
FROM person p
LEFT JOIN f43specialpp s 
ON p.pcucodeperson=s.pcucodeperson AND p.pid=s.pid 
WHERE TIMESTAMPDIFF(year,p.birth,CURDATE()) > 60
AND s.dateserv BETWEEN '2017-10-01' AND '2018-09-30'
AND substr(s.ppspecial,1,5)='1B120'
-- ADL 
UNION 
SELECT p.idcard,p.fname,p.lname,p.birth 
,s.dateserv,s.ppspecial
,'6' as seq
FROM person p
LEFT JOIN f43specialpp s 
ON p.pcucodeperson=s.pcucodeperson AND p.pid=s.pid 
WHERE TIMESTAMPDIFF(year,p.birth,CURDATE()) > 60
AND s.dateserv BETWEEN '2017-10-01' AND '2018-09-30'
AND substr(s.ppspecial,1,5)='1B128'
) as t

GROUP BY idcard 

) as t1
