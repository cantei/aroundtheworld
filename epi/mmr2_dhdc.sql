
SELECT person.HOSPCODE,person.PID AS HN,person.CID
,concat(person.`NAME`,'  ',person.LNAME) as fullname
,person.BIRTH,person.TYPEAREA
-- ,home.HOUSE
-- ,CONCAT(home.CHANGWAT ,home.AMPUR,home.TAMBON,home.VILLAGE) as VILLCODE
-- ,person.DISCHARGE 
,t1.measle1,t1.measle2
,t1.visitdate1,t1.visitdate2
,t1.hospcode1,t1.hospcode2 
FROM person 
-- LEFT JOIN home 
-- ON person.HOSPCODE=home.HOUSE AND person.HID=home.HID 
LEFT JOIN 
(
SELECT p.cid,e.cid as idcard
,SPLIT_STR(GROUP_CONCAT(e.VACCINETYPE ORDER BY e.DATE_SERV SEPARATOR ',') ,',',1) as measle1
,SPLIT_STR(GROUP_CONCAT(e.VACCINETYPE ORDER BY e.DATE_SERV SEPARATOR ',') ,',',2) as measle2
,SPLIT_STR(GROUP_CONCAT(e.DATE_SERV ORDER BY e.DATE_SERV SEPARATOR ',') ,',',1) as visitdate1
,SPLIT_STR(GROUP_CONCAT(e.DATE_SERV ORDER BY e.DATE_SERV SEPARATOR ',') ,',',2) as visitdate2
,SPLIT_STR(GROUP_CONCAT(e.VACCINEPLACE ORDER BY e.DATE_SERV SEPARATOR ',') ,',',1) as hospcode1
,SPLIT_STR(GROUP_CONCAT(e.VACCINEPLACE ORDER BY e.DATE_SERV SEPARATOR ',') ,',',2) as hospcode2
FROM epi e
LEFT JOIN  person p 
ON e.hospcode=p.hospcode AND e.pid=p.pid
WHERE VACCINETYPE in ('061','071','072','073','074','075','076')
GROUP BY  e.pid
HAVING visitdate1<>visitdate2
ORDER BY e.DATE_SERV
) as t1 
ON person.CID=t1.idcard
WHERE person.TYPEAREA in ('1','3')
AND person.DISCHARGE='9'
AND TIMESTAMPDIFF(MONTH,person.birth,'2018-11-01') BETWEEN 13 AND 144 
-- AND person.HOSPCODE='09248'
GROUP BY person.CID  
-- HAVING ISNULL(visitdate2) OR visitdate2=''
ORDER BY person.HOSPCODE 
