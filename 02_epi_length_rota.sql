# first  dose 
SELECT p.HOSPCODE,p.PID,p.CID,p.BIRTH

,e.DATE_SERV
,TIMESTAMPDIFF(week,p.BIRTH,e.DATE_SERV)  as LEN
FROM person p
INNER JOIN epi e
ON p.HOSPCODE=e.HOSPCODE AND p.PID=e.PID 
WHERE e.VACCINETYPE='R21' 
HAVING LEN >  15
ORDER BY LEN DESC ;

# 2,3 
SELECT p.HOSPCODE,p.PID,p.CID,p.BIRTH
,e.VACCINETYPE,e.DATE_SERV
,TIMESTAMPDIFF(week,p.BIRTH,e.DATE_SERV)  as LEN
FROM person p
INNER JOIN epi e
ON p.HOSPCODE=e.HOSPCODE AND p.PID=e.PID 
WHERE e.VACCINETYPE='R22' OR e.VACCINETYPE='R23'
HAVING LEN >  32
ORDER BY LEN DESC ;
