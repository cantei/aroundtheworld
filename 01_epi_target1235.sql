SET @d1='2017-10-01';
SET @d2='2018-09-30';

SELECT t1.*,t2.followup
FROM 
(
SELECT 
-- p.pcucodeperson,p.pid
concat(c.titlename,p.fname,'    ',p.lname) as fullname
,substr(h.villcode,7,2) as moo,h.hno
,concat(h.hno,'  ','หมู่','  ',substr(h.villcode,7,2)) as address
,p.birth
,p.idcard
,TIMESTAMPDIFF(month,p.birth,CURDATE()) as agemonth
,p.mother
/*
,MIN(if(e.vaccinecode='BCG',e.dateepi,NULL)) as 'BCG'
,MIN(if(e.vaccinecode='HBV1',e.dateepi,NULL)) as 'HBV1'
,MIN(if(e.vaccinecode in ('DTP1','DHB1'),e.dateepi,NULL)) as 'DHB1'
,MIN(if(e.vaccinecode='OPV1',e.dateepi,NULL)) as 'OPV1'
,MIN(if(e.vaccinecode in ('DTP2','DHB2'),e.dateepi,NULL)) as 'DHB2'
,MIN(if(e.vaccinecode='OPV2',e.dateepi,NULL)) as 'OPV2'
,MIN(if(e.vaccinecode='IPV-P',e.dateepi,NULL)) as 'IPV'
,MIN(if(e.vaccinecode in ('DTP3','DHB3'),e.dateepi,NULL)) as 'DHB3'
,MIN(if(e.vaccinecode='OPV3',e.dateepi,NULL)) as 'OPV3'
,MIN(if(e.vaccinecode='MMR',e.dateepi,NULL)) as 'MMR1'
*/
,concat(v.fname,'    ',v.lname) as 'volanteer'
FROM person p
LEFT JOIN ctitle c
ON p.prename=c.titlecode
LEFT JOIN house h
on p.hcode=h.hcode AND p.pcucodeperson=h.pcucode
LEFT JOIN visitepi e
on p.pid=e.pid AND p.pcucodeperson=e.pcucodeperson 
LEFT JOIN person v
on v.hcode=h.hcode AND v.pcucodeperson=h.pcucodeperson 
WHERE p.typelive in ('1','3') 
AND p.dischargetype='9'
AND p.nation='99'
AND 
(
	p.birth BETWEEN DATE_SUB(@d1, INTERVAL 1 YEAR) AND DATE_SUB(@d2, INTERVAL 1 YEAR)
	OR p.birth BETWEEN DATE_SUB(@d1, INTERVAL 2 YEAR) AND DATE_SUB(@d2, INTERVAL 2 YEAR)
	OR p.birth BETWEEN DATE_SUB(@d1, INTERVAL 3 YEAR) AND DATE_SUB(@d2, INTERVAL 3 YEAR)
	OR p.birth BETWEEN DATE_SUB(@d1, INTERVAL 5 YEAR) AND DATE_SUB(@d2, INTERVAL 5 YEAR)
)
GROUP BY CONCAT(p.pcucodeperson,p.pid)
ORDER BY p.birth 
) as t1
LEFT JOIN
(
SELECT idcard,'2018-03-21' as 'followup' FROM person 
WHERE person.idcard in 
-- follow letter 20180321
	(
'1939901003946',
'1849801266806',
'1849902794344',
'1849902802886',
'1849801266792',
'1849902765913',
'1849902809104',
'1849902814221',
'1849801266199',
'1849902756311',
'1849902813454',
'1849902796142',
'1849801266024',
'1849801266946',
'1849801267187',
'1849902614168',
'1849801260191',
'1849902665544',
'1849902651098',
'1849801260000',
'1849902666672'
	)
) as t2
ON t1.idcard=t2.idcard 
-- WHERE t1.idcard='1840100171774'
ORDER BY moo,(SPLIT_STR(hno,'/', 1)*1),(SPLIT_STR(hno,'/',2)*1)
