# IPV เริ่มใช้เดือนธันวาคม 2558 ฉะนั้น เด็กที่เกิดตั้งแต่ 2015-08-01 ควรจะได้รับทุกราย เพื่อให้มีภูมิคุ้มกันทั้ง 3 types

SET @startdate='2016-10-01';
SET @stoptdate='2017-09-30';

SELECT t2.hospcode,t2.person_id,t2.cid,t2.fname,t2.lname,t2.birth
,t2.age_day,t2.hno,substr(t2.villcode,7,2) as moo
,if(AGE_DAY >112 AND NOT ISNULL(t2.IPV),'1',IF(AGE_DAY >112 AND ISNULL(t2.IPV) ,'0','9')) as IPV
,if(AGE_DAY >112 AND NOT ISNULL(t2.OPV2),'1',IF(AGE_DAY >112 AND ISNULL(t2.OPV2) ,'0','9')) as OPV2
FROM (
SELECT p.pcucodeperson as hospcode,p.pid as person_id,p.idcard as cid,p.fname,p.lname,p.birth
,TIMESTAMPDIFF(DAY,p.birth,CURDATE()) as age_day
,p.typelive,p.dischargetype
,h.hno,h.villcode
,t1.*
FROM person p
LEFT JOIN house h
ON p.pcucodeperson=h.pcucode AND p.hcode=h.hcode
LEFT JOIN 
(
SELECT e.pcucodeperson,e.pid
,MIN(IF(e.vaccinecode='IPV-P',e.dateepi,NULL)) AS IPV
,MIN(IF(e.vaccinecode='OPV2',e.dateepi,NULL)) AS OPV2
FROM visitepi e
GROUP BY e.pcucodeperson,e.pid
) as t1
ON t1.pcucodeperson=p.pcucodeperson AND t1.pid=p.pid 
WHERE p.birth  BETWEEN DATE_SUB(@startdate,INTERVAL 1 YEAR) AND DATE_SUB(@stoptdate,INTERVAL 1 YEAR)
AND p.typelive in ('1','3')  and	 p.dischargetype='9'
) as t2
HAVING IPV='0'
