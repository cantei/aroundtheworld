SET @y='2016';
SET @proc='8070';
SELECT *
FROM 
(
SELECT HOSPCODE,DATE_SERV,COUNT(*) N
FROM procedure_opd 
WHERE YEAR(DATE_SERV)=@y
AND substr(PROCEDCODE,4,4)=@proc
AND HOSPCODE='07711'
GROUP BY HOSPCODE,DATE_SERV
ORDER BY N DESC 
LIMIT 1
) as t
UNION 
(
SELECT HOSPCODE,DATE_SERV,COUNT(*) N
FROM procedure_opd 
WHERE YEAR(DATE_SERV)=@y
AND substr(PROCEDCODE,4,4)=@proc
AND HOSPCODE='07712'
GROUP BY HOSPCODE,DATE_SERV
ORDER BY N DESC 
LIMIT 1
) 

UNION 
(
SELECT HOSPCODE,DATE_SERV,COUNT(*) N
FROM procedure_opd 
WHERE YEAR(DATE_SERV)=@y
AND substr(PROCEDCODE,4,4)=@proc
AND HOSPCODE='07713'
GROUP BY HOSPCODE,DATE_SERV
ORDER BY N DESC 
LIMIT 1
) 
UNION 
(
SELECT HOSPCODE,DATE_SERV,COUNT(*) N
FROM procedure_opd 
WHERE YEAR(DATE_SERV)=@y
AND substr(PROCEDCODE,4,4)=@proc
AND HOSPCODE='07714'
GROUP BY HOSPCODE,DATE_SERV
ORDER BY N DESC 
LIMIT 1
) 
UNION 
(
SELECT HOSPCODE,DATE_SERV,COUNT(*) N
FROM procedure_opd 
WHERE YEAR(DATE_SERV)=@y
AND substr(PROCEDCODE,4,4)=@proc
AND HOSPCODE='07715'
GROUP BY HOSPCODE,DATE_SERV
ORDER BY N DESC 
LIMIT 1
) 
UNION 
(
SELECT HOSPCODE,DATE_SERV,COUNT(*) N
FROM procedure_opd 
WHERE YEAR(DATE_SERV)=@y
AND substr(PROCEDCODE,4,4)=@proc
AND HOSPCODE='07716'
GROUP BY HOSPCODE,DATE_SERV
ORDER BY N DESC 
LIMIT 1
) 
UNION 
(
SELECT HOSPCODE,DATE_SERV,COUNT(*) N
FROM procedure_opd 
WHERE YEAR(DATE_SERV)=@y
AND substr(PROCEDCODE,4,4)=@proc
AND HOSPCODE='07717'
GROUP BY HOSPCODE,DATE_SERV
ORDER BY N DESC 
LIMIT 1
) 
UNION 
(
SELECT HOSPCODE,DATE_SERV,COUNT(*) N
FROM procedure_opd 
WHERE YEAR(DATE_SERV)=@y
AND substr(PROCEDCODE,4,4)=@proc
AND HOSPCODE='07718'
GROUP BY HOSPCODE,DATE_SERV
ORDER BY N DESC 
LIMIT 1
) 
UNION 
(
SELECT HOSPCODE,DATE_SERV,COUNT(*) N
FROM procedure_opd 
WHERE YEAR(DATE_SERV)=@y
AND substr(PROCEDCODE,4,4)=@proc
AND HOSPCODE='07719'
GROUP BY HOSPCODE,DATE_SERV
ORDER BY N DESC 
LIMIT 1
) 
UNION 
(
SELECT HOSPCODE,DATE_SERV,COUNT(*) N
FROM procedure_opd 
WHERE YEAR(DATE_SERV)=@y
AND substr(PROCEDCODE,4,4)=@proc
AND HOSPCODE='07720'
GROUP BY HOSPCODE,DATE_SERV
ORDER BY N DESC 
LIMIT 1
) 

UNION 
(
SELECT HOSPCODE,DATE_SERV,COUNT(*) N
FROM procedure_opd 
WHERE YEAR(DATE_SERV)=@y
AND substr(PROCEDCODE,4,4)=@proc
AND HOSPCODE='07721'
GROUP BY HOSPCODE,DATE_SERV
ORDER BY N DESC 
LIMIT 1
) 
UNION 
(
SELECT HOSPCODE,DATE_SERV,COUNT(*) N
FROM procedure_opd 
WHERE YEAR(DATE_SERV)=@y
AND substr(PROCEDCODE,4,4)=@proc
AND HOSPCODE='07722'
GROUP BY HOSPCODE,DATE_SERV
ORDER BY N DESC 
LIMIT 1
) 
UNION 
(
SELECT HOSPCODE,DATE_SERV,COUNT(*) N
FROM procedure_opd 
WHERE YEAR(DATE_SERV)=@y
AND substr(PROCEDCODE,4,4)=@proc
AND HOSPCODE='07723'
GROUP BY HOSPCODE,DATE_SERV
ORDER BY N DESC 
LIMIT 1
) 
UNION 
(
SELECT HOSPCODE,DATE_SERV,COUNT(*) N
FROM procedure_opd 
WHERE YEAR(DATE_SERV)=@y
AND substr(PROCEDCODE,4,4)=@proc
AND HOSPCODE='07724'
GROUP BY HOSPCODE,DATE_SERV
ORDER BY N DESC 
LIMIT 1
) 
UNION 
(
SELECT HOSPCODE,DATE_SERV,COUNT(*) N
FROM procedure_opd 
WHERE YEAR(DATE_SERV)=@y
AND substr(PROCEDCODE,4,4)=@proc
AND HOSPCODE='07725'
GROUP BY HOSPCODE,DATE_SERV
ORDER BY N DESC 
LIMIT 1
) 
UNION 
(
SELECT HOSPCODE,DATE_SERV,COUNT(*) N
FROM procedure_opd 
WHERE YEAR(DATE_SERV)=@y
AND substr(PROCEDCODE,4,4)=@proc
AND HOSPCODE='07726'
GROUP BY HOSPCODE,DATE_SERV
ORDER BY N DESC 
LIMIT 1
) 
UNION 
(
SELECT HOSPCODE,DATE_SERV,COUNT(*) N
FROM procedure_opd 
WHERE YEAR(DATE_SERV)=@y
AND substr(PROCEDCODE,4,4)=@proc
AND HOSPCODE='07727'
GROUP BY HOSPCODE,DATE_SERV
ORDER BY N DESC 
LIMIT 1
) 
UNION 
(
SELECT HOSPCODE,DATE_SERV,COUNT(*) N
FROM procedure_opd 
WHERE YEAR(DATE_SERV)=@y
AND substr(PROCEDCODE,4,4)=@proc
AND HOSPCODE='07728'
GROUP BY HOSPCODE,DATE_SERV
ORDER BY N DESC 
LIMIT 1
) 
UNION 
(
SELECT HOSPCODE,DATE_SERV,COUNT(*) N
FROM procedure_opd 
WHERE YEAR(DATE_SERV)=@y
AND substr(PROCEDCODE,4,4)=@proc
AND HOSPCODE='07729'
GROUP BY HOSPCODE,DATE_SERV
ORDER BY N DESC 
LIMIT 1
) 
UNION 
(
SELECT HOSPCODE,DATE_SERV,COUNT(*) N
FROM procedure_opd 
WHERE YEAR(DATE_SERV)=@y
AND substr(PROCEDCODE,4,4)=@proc
AND HOSPCODE='07730'
GROUP BY HOSPCODE,DATE_SERV
ORDER BY N DESC 
LIMIT 1
) 
UNION 
(
SELECT HOSPCODE,DATE_SERV,COUNT(*) N
FROM procedure_opd 
WHERE YEAR(DATE_SERV)=@y
AND substr(PROCEDCODE,4,4)=@proc
AND HOSPCODE='07731'
GROUP BY HOSPCODE,DATE_SERV
ORDER BY N DESC 
LIMIT 1
) 
UNION 
(
SELECT HOSPCODE,DATE_SERV,COUNT(*) N
FROM procedure_opd 
WHERE YEAR(DATE_SERV)=@y
AND substr(PROCEDCODE,4,4)=@proc
AND HOSPCODE='07732'
GROUP BY HOSPCODE,DATE_SERV
ORDER BY N DESC 
LIMIT 1
) 
UNION 
(
SELECT HOSPCODE,DATE_SERV,COUNT(*) N
FROM procedure_opd 
WHERE YEAR(DATE_SERV)=@y
AND substr(PROCEDCODE,4,4)=@proc
AND HOSPCODE='07733'
GROUP BY HOSPCODE,DATE_SERV
ORDER BY N DESC 
LIMIT 1
) 