SET @thisyear=YEAR(CURDATE());
SET @drugtype='01';
SELECT c.drugcode
,c.drugname
,c.drugtype
,c.pack
,t1.*
FROM cdrug c
LEFT JOIN 
(
SELECT d.drugcode
,SUM(CASE WHEN MONTH(v.visitdate) = 1 THEN d.unit ELSE 0 END) AS January
,SUM(CASE WHEN MONTH(v.visitdate) = 2 THEN d.unit ELSE 0 END) AS February
,SUM(CASE WHEN MONTH(v.visitdate) = 3 THEN d.unit ELSE 0 END) AS March
,SUM(CASE WHEN MONTH(v.visitdate) = 4 THEN d.unit ELSE 0 END) AS April
,SUM(CASE WHEN MONTH(v.visitdate) = 5 THEN d.unit ELSE 0 END) AS May
,SUM(CASE WHEN MONTH(v.visitdate) = 6 THEN d.unit ELSE 0 END) AS June
,SUM(CASE WHEN MONTH(v.visitdate) = 7 THEN d.unit ELSE 0 END) AS July
,SUM(CASE WHEN MONTH(v.visitdate) = 8 THEN d.unit ELSE 0 END) AS August
,SUM(CASE WHEN MONTH(v.visitdate) = 9 THEN d.unit ELSE 0 END) AS September
,SUM(CASE WHEN MONTH(v.visitdate) = 10 THEN d.unit ELSE 0 END) AS October
,SUM(CASE WHEN MONTH(v.visitdate) = 11 THEN d.unit ELSE 0 END) AS November
,SUM(CASE WHEN MONTH(v.visitdate) = 12 THEN d.unit ELSE 0 END) AS December
FROM  visitdrug d 
LEFT JOIN visit v
ON d.pcucode=v.pcucode AND d.visitno=v.visitno 
WHERE YEAR(v.visitdate)=@thisyear
GROUP BY d.drugcode
) as t1
ON c.drugcode=t1.drugcode
WHERE c.drugtype=@drugtype
