# เริ่ม มีนาคม 2559 # 
# เด็กที่เกิดก่อน 2015-12-01  ไม่ควรจะได้รับ (โด๊สแรก อายุไม่เกิน 15 wks) #
#  (โด๊ส 2 ,3 อายุไม่เกิน 32 wks) #


SET @startdate='2016-10-01';
SET @stoptdate='2017-09-30';

SELECT t2.hospcode,t2.person_id,t2.cid,t2.fname,t2.lname,t2.birth
,t2.age_day,t2.hno,substr(t2.villcode,7,2) as moo
,if(AGE_DAY >56 AND NOT ISNULL(t2.R21),'1',IF(AGE_DAY >56 AND ISNULL(t2.R21) ,'0','9')) as R21
,if(AGE_DAY >112 AND NOT ISNULL(t2.R22),'1',IF(AGE_DAY >112 AND ISNULL(t2.R21) ,'0','9')) as R22
,if(AGE_DAY >168 AND NOT ISNULL(t2.R23),'1',IF(AGE_DAY >168 AND ISNULL(t2.R23) ,'0','9')) as R23

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
,MIN(IF(e.vaccinecode='R21',e.dateepi,NULL)) AS R21
,MIN(IF(e.vaccinecode='R22',e.dateepi,NULL)) AS R22
,MIN(IF(e.vaccinecode='R23',e.dateepi,NULL)) AS R23
FROM visitepi e
GROUP BY e.pcucodeperson,e.pid
) as t1
ON t1.pcucodeperson=p.pcucodeperson AND t1.pid=p.pid 
WHERE p.birth  BETWEEN DATE_SUB(@startdate,INTERVAL 1 YEAR) AND DATE_SUB(@stoptdate,INTERVAL 1 YEAR)
AND p.typelive in ('1','3')  and	 p.dischargetype='9'
) as t2
ORDER BY t2.birth;
