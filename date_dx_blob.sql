SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY c.datefirstdiag SEPARATOR ',') as dx_date
,GROUP_CONCAT(CAST(c.chroniccode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY c.datefirstdiag SEPARATOR ',') as dx
,SPLIT_STR(GROUP_CONCAT(c.datefirstdiag ORDER BY c.datefirstdiag SEPARATOR ','),',',1) as datediag 
FROM  person p
LEFT JOIN personchronic c
ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
WHERE substr(REPLACE(chroniccode,'.',''),1,3) BETWEEN 'I10' AND 'I14' 
GROUP BY p.pcucodeperson,p.pid
