SELECT drugcode,drugname,drugflag
,item,comp
,STR0 AS v1,STR1 as v2,STR2 as v3,STR3 as v4
FROM 
(
SELECT drugcode,drugcode24,drugname,drugflag,drugtype
,REPLACE(drugname,' ','') AS STR0
FROM cdrug 
WHERE drugtype='01'
) as t1 
LEFT JOIN 
(SELECT s.id,s.item,s.comp
,REPLACE(s.item,' ','') AS STR1
,REPLACE(g.GENERICNAME,' ','') AS STR2
,REPLACE(t.STRENGTH_DSC,' ','') AS STR3
FROM std_drug s
LEFT JOIN cgeneric g
ON substr(s.id,2,10)=g.GENERIC
LEFT JOIN cstrength t
ON substr(s.id,12,5)=t.STRENGTH 
) as t2
ON t1.drugcode=t2.id
-- GROUP BY drugname
GROUP BY drugcode
-- HAVING STR0 NOT LIKE CONCAT('%',STR2,'%') 
-- OR STR0 NOT LIKE CONCAT('%',STR3,'%')
ORDER BY drugname
