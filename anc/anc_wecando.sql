SELECT a.pid,a.pregno 
-- ,a.pregage
-- ,datecheck

,GROUP_CONCAT(CAST(a.pregage AS CHAR(10000) CHARACTER SET utf8)  ORDER BY a.datecheck DESC SEPARATOR ',') as ga
,TIMESTAMPDIFF(week,n.lmp ,CURDATE()) as timega
,n.lmp,n.edc
,l.datedeliver a
FROM visitanc a 
LEFT JOIN visitancpregnancy n 
ON a.pcucodeperson=n.pcucodeperson AND a.pid=n.pid AND a.pregno=n.pregno
LEFT JOIN  visitancdeliver l
ON a.pcucodeperson=l.pcucodeperson AND a.pid=l.pid AND a.pregno=l.pregno 
-- WHERE TIMESTAMPDIFF(week,n.lmp ,CURDATE()) < 36
where a.datecheck between '2016-10-01' and '2017-09-30'
GROUP BY  a.pid,a.pregno 
ORDER BY n.lmp  DESC 
