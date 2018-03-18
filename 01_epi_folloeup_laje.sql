# เริ่มใช้ มีนาคม 2558  #
# ฉะนั้น  เด็กที่เกิดปีงบประมาณ 2557 บางส่วนควรจะได้รับ  #

SET @startdate='2016-10-01';
SET @stoptdate='2017-09-30';

SELECT t2.hospcode,t2.person_id,t2.cid,t2.fname,t2.lname,t2.birth
,t2.age_day,t2.hno,substr(t2.villcode,7,2) as moo
,if(AGE_DAY >365 AND NOT ISNULL(t2.J11),'1',IF(AGE_DAY >365 AND ISNULL(t2.J11) ,'0','9')) as LAJE1
,if(AGE_DAY >868 AND NOT ISNULL(t2.J12),'1',IF(AGE_DAY >868 AND ISNULL(t2.J12) ,'0','9')) as LAJE2
,if(AGE_DAY >365 AND NOT ISNULL(t2.JE1),'1',IF(AGE_DAY >365 AND ISNULL(t2.JE1) ,'0','9')) as JE1
,if(AGE_DAY >365 AND NOT ISNULL(t2.JE2),'1',IF(AGE_DAY >365 AND ISNULL(t2.JE2) ,'0','9')) as JE2
,if(AGE_DAY >840 AND NOT ISNULL(t2.JE2),'1',IF(AGE_DAY >840 AND ISNULL(t2.JE2) ,'0','9')) as JE3
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
,MIN(IF(e.vaccinecode='J11',e.dateepi,NULL)) AS J11
,MIN(IF(e.vaccinecode='J12',e.dateepi,NULL)) AS J12
,MIN(IF(e.vaccinecode='JE1',e.dateepi,NULL)) AS JE1
,MIN(IF(e.vaccinecode='JE2',e.dateepi,NULL)) AS JE2
,MIN(IF(e.vaccinecode='JE3',e.dateepi,NULL)) AS JE3
FROM visitepi e
GROUP BY e.pcucodeperson,e.pid
) as t1
ON t1.pcucodeperson=p.pcucodeperson AND t1.pid=p.pid 
WHERE p.birth  BETWEEN DATE_SUB(@startdate,INTERVAL 3 YEAR) AND DATE_SUB(@stoptdate,INTERVAL 3 YEAR)
AND p.typelive in ('1','3')  and	 p.dischargetype='9'
) as t2
ORDER BY t2.birth DESC ;

