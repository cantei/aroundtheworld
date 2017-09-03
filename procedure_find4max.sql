set	@proc='8070';
set @startdate='2017-01-01';
set @enddate='2017-07-31';

SELECT * FROM 
(
SELECT HOSPCODE,PROCEDCODE,DATE_SERV,count(DISTINCT pid) n
FROM procedure_opd p
WHERE SUBSTR(PROCEDCODE,4,4)=@proc
AND DATE_SERV BETWEEN @startdate AND @enddate
AND HOSPCODE='07711'
GROUP BY HOSPCODE,DATE_SERV 
ORDER BY n DESC 
LIMIT 1 
) as t
UNION 
(
SELECT HOSPCODE,PROCEDCODE,DATE_SERV,count(DISTINCT pid) n
FROM procedure_opd p
WHERE SUBSTR(PROCEDCODE,4,4)=@proc
AND DATE_SERV BETWEEN @startdate AND @enddate
AND HOSPCODE='07712'
GROUP BY HOSPCODE,DATE_SERV 
ORDER BY n DESC 
LIMIT 1 
)
UNION 
(
SELECT HOSPCODE,PROCEDCODE,DATE_SERV,count(DISTINCT pid) n
FROM procedure_opd p
WHERE SUBSTR(PROCEDCODE,4,4)=@proc
AND DATE_SERV BETWEEN @startdate AND @enddate
AND HOSPCODE='07713'
GROUP BY HOSPCODE,DATE_SERV 
ORDER BY n DESC 
LIMIT 1 
)
UNION 
(
SELECT HOSPCODE,PROCEDCODE,DATE_SERV,count(DISTINCT pid) n
FROM procedure_opd p
WHERE SUBSTR(PROCEDCODE,4,4)=@proc
AND DATE_SERV BETWEEN @startdate AND @enddate
AND HOSPCODE='07714'
GROUP BY HOSPCODE,DATE_SERV 
ORDER BY n DESC 
LIMIT 1 
)
UNION 
(
SELECT HOSPCODE,PROCEDCODE,DATE_SERV,count(DISTINCT pid) n
FROM procedure_opd p
WHERE SUBSTR(PROCEDCODE,4,4)=@proc
AND DATE_SERV BETWEEN @startdate AND @enddate
AND HOSPCODE='07715'
GROUP BY HOSPCODE,DATE_SERV 
ORDER BY n DESC 
LIMIT 1 
)
UNION 
(
SELECT HOSPCODE,PROCEDCODE,DATE_SERV,count(DISTINCT pid) n
FROM procedure_opd p
WHERE SUBSTR(PROCEDCODE,4,4)=@proc
AND DATE_SERV BETWEEN @startdate AND @enddate
AND HOSPCODE='07716'
GROUP BY HOSPCODE,DATE_SERV 
ORDER BY n DESC 
LIMIT 1 
)
UNION 
(
SELECT HOSPCODE,PROCEDCODE,DATE_SERV,count(DISTINCT pid) n
FROM procedure_opd p
WHERE SUBSTR(PROCEDCODE,4,4)=@proc
AND DATE_SERV BETWEEN @startdate AND @enddate
AND HOSPCODE='07717'
GROUP BY HOSPCODE,DATE_SERV 
ORDER BY n DESC 
LIMIT 1 
)
UNION 
(
SELECT HOSPCODE,PROCEDCODE,DATE_SERV,count(DISTINCT pid) n
FROM procedure_opd p
WHERE SUBSTR(PROCEDCODE,4,4)=@proc
AND DATE_SERV BETWEEN @startdate AND @enddate
AND HOSPCODE='07718'
GROUP BY HOSPCODE,DATE_SERV 
ORDER BY n DESC 
LIMIT 1 
)
UNION 
(
SELECT HOSPCODE,PROCEDCODE,DATE_SERV,count(DISTINCT pid) n
FROM procedure_opd p
WHERE SUBSTR(PROCEDCODE,4,4)=@proc
AND DATE_SERV BETWEEN @startdate AND @enddate
AND HOSPCODE='07719'
GROUP BY HOSPCODE,DATE_SERV 
ORDER BY n DESC 
LIMIT 1 
)
UNION 
(
SELECT HOSPCODE,PROCEDCODE,DATE_SERV,count(DISTINCT pid) n
FROM procedure_opd p
WHERE SUBSTR(PROCEDCODE,4,4)=@proc
AND DATE_SERV BETWEEN @startdate AND @enddate
AND HOSPCODE='07720'
GROUP BY HOSPCODE,DATE_SERV 
ORDER BY n DESC 
LIMIT 1 
)
UNION 
(
SELECT HOSPCODE,PROCEDCODE,DATE_SERV,count(DISTINCT pid) n
FROM procedure_opd p
WHERE SUBSTR(PROCEDCODE,4,4)=@proc
AND DATE_SERV BETWEEN @startdate AND @enddate
AND HOSPCODE='07721'
GROUP BY HOSPCODE,DATE_SERV 
ORDER BY n DESC 
LIMIT 1 
)
UNION 
(
SELECT HOSPCODE,PROCEDCODE,DATE_SERV,count(DISTINCT pid) n
FROM procedure_opd p
WHERE SUBSTR(PROCEDCODE,4,4)=@proc
AND DATE_SERV BETWEEN @startdate AND @enddate
AND HOSPCODE='07722'
GROUP BY HOSPCODE,DATE_SERV 
ORDER BY n DESC 
LIMIT 1 
)
UNION 
(
SELECT HOSPCODE,PROCEDCODE,DATE_SERV,count(DISTINCT pid) n
FROM procedure_opd p
WHERE SUBSTR(PROCEDCODE,4,4)=@proc
AND DATE_SERV BETWEEN @startdate AND @enddate
AND HOSPCODE='07723'
GROUP BY HOSPCODE,DATE_SERV 
ORDER BY n DESC 
LIMIT 1 
)
UNION 
(
SELECT HOSPCODE,PROCEDCODE,DATE_SERV,count(DISTINCT pid) n
FROM procedure_opd p
WHERE SUBSTR(PROCEDCODE,4,4)=@proc
AND DATE_SERV BETWEEN @startdate AND @enddate
AND HOSPCODE='07724'
GROUP BY HOSPCODE,DATE_SERV 
ORDER BY n DESC 
LIMIT 1 
) 
UNION 
(
SELECT HOSPCODE,PROCEDCODE,DATE_SERV,count(DISTINCT pid) n
FROM procedure_opd p
WHERE SUBSTR(PROCEDCODE,4,4)=@proc
AND DATE_SERV BETWEEN @startdate AND @enddate
AND HOSPCODE='07725'
GROUP BY HOSPCODE,DATE_SERV 
ORDER BY n DESC 
LIMIT 1 
)

UNION 
(
SELECT HOSPCODE,PROCEDCODE,DATE_SERV,count(DISTINCT pid) n
FROM procedure_opd p
WHERE SUBSTR(PROCEDCODE,4,4)=@proc
AND DATE_SERV BETWEEN @startdate AND @enddate
AND HOSPCODE='07726'
GROUP BY HOSPCODE,DATE_SERV 
ORDER BY n DESC 
LIMIT 1 
) 
UNION 
(
SELECT HOSPCODE,PROCEDCODE,DATE_SERV,count(DISTINCT pid) n
FROM procedure_opd p
WHERE SUBSTR(PROCEDCODE,4,4)=@proc
AND DATE_SERV BETWEEN @startdate AND @enddate
AND HOSPCODE='07727'
GROUP BY HOSPCODE,DATE_SERV 
ORDER BY n DESC 
LIMIT 1 
) 
UNION 
(
SELECT HOSPCODE,PROCEDCODE,DATE_SERV,count(DISTINCT pid) n
FROM procedure_opd p
WHERE SUBSTR(PROCEDCODE,4,4)=@proc
AND DATE_SERV BETWEEN @startdate AND @enddate
AND HOSPCODE='07728'
GROUP BY HOSPCODE,DATE_SERV 
ORDER BY n DESC 
LIMIT 1 
) 
UNION 
(
SELECT HOSPCODE,PROCEDCODE,DATE_SERV,count(DISTINCT pid) n
FROM procedure_opd p
WHERE SUBSTR(PROCEDCODE,4,4)=@proc
AND DATE_SERV BETWEEN @startdate AND @enddate
AND HOSPCODE='07729'
GROUP BY HOSPCODE,DATE_SERV 
ORDER BY n DESC 
LIMIT 1 
) 

UNION 
(
SELECT HOSPCODE,PROCEDCODE,DATE_SERV,count(DISTINCT pid) n
FROM procedure_opd p
WHERE SUBSTR(PROCEDCODE,4,4)=@proc
AND DATE_SERV BETWEEN @startdate AND @enddate
AND HOSPCODE='07730'
GROUP BY HOSPCODE,DATE_SERV 
ORDER BY n DESC 
LIMIT 1 
) 
UNION 
(
SELECT HOSPCODE,PROCEDCODE,DATE_SERV,count(DISTINCT pid) n
FROM procedure_opd p
WHERE SUBSTR(PROCEDCODE,4,4)=@proc
AND DATE_SERV BETWEEN @startdate AND @enddate
AND HOSPCODE='07731'
GROUP BY HOSPCODE,DATE_SERV 
ORDER BY n DESC 
LIMIT 1 
) 
UNION 
(
SELECT HOSPCODE,PROCEDCODE,DATE_SERV,count(DISTINCT pid) n
FROM procedure_opd p
WHERE SUBSTR(PROCEDCODE,4,4)=@proc
AND DATE_SERV BETWEEN @startdate AND @enddate
AND HOSPCODE='07732'
GROUP BY HOSPCODE,DATE_SERV 
ORDER BY n DESC 
LIMIT 1 
) 
UNION 
(
SELECT HOSPCODE,PROCEDCODE,DATE_SERV,count(DISTINCT pid) n
FROM procedure_opd p
WHERE SUBSTR(PROCEDCODE,4,4)=@proc
AND DATE_SERV BETWEEN @startdate AND @enddate
AND HOSPCODE='07733'
GROUP BY HOSPCODE,DATE_SERV 
ORDER BY n DESC 
LIMIT 1 
) 
