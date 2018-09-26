SELECT t1.*
,p.fname,p.lname,p.typelive,p.dischargetype
,concat(' ',h.hno) as hno,SUBSTR(h.villcode,8,1) as village
,concat(o.fname,'  ',o.lname) as volanteer
,p.hnomoi,p.mumoi
FROM 
(
# HT
SELECT  v.pcucode,v.pid as  hn
,GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',') as each_diag
,SPLIT_STR((GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',')),',',1) as firstdiag
,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',')),',',1) as firstvisit
,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate DESC  SEPARATOR ',')),',',1) as lastvisit
FROM visitdiag d
LEFT JOIN visit v
ON d.pcucode=v.pcucode AND d.visitno=v.visitno 
WHERE 
(SUBSTR(d.diagcode,1,3) BETWEEN 'I10' AND 'I15')
AND NOT EXISTS 
(
SELECT *  FROM	personchronic c WHERE c.chroniccode BETWEEN 'I10' AND 'I15' and v.pid=c.pid
)
GROUP BY v.pid
# DM
UNION 
SELECT  v.pcucode,v.pid as  hn
,GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',') as each_diag
,SPLIT_STR((GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',')),',',1) as firstdiag
,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',')),',',1) as firstvisit
,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate DESC  SEPARATOR ',')),',',1) as lastvisit
FROM visitdiag d
LEFT JOIN visit v
ON d.pcucode=v.pcucode AND d.visitno=v.visitno 
WHERE 
(SUBSTR(d.diagcode,1,3) BETWEEN 'E10' AND 'E14')
AND NOT EXISTS 
(
SELECT *  FROM	personchronic c WHERE c.chroniccode BETWEEN 'E10' AND 'E14' and v.pid=c.pid
)
GROUP BY v.pid
# COPD
UNION 
SELECT  v.pcucode,v.pid as  hn
,GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',') as each_diag
,SPLIT_STR((GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',')),',',1) as firstdiag
,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',')),',',1) as firstvisit
,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate DESC  SEPARATOR ',')),',',1) as lastvisit
FROM visitdiag d
LEFT JOIN visit v
ON d.pcucode=v.pcucode AND d.visitno=v.visitno 
WHERE 
(SUBSTR(d.diagcode,1,3) BETWEEN 'J44' AND 'J44')
AND NOT EXISTS 
(
SELECT *  FROM	personchronic c WHERE c.chroniccode BETWEEN 'J44' AND 'J44' and v.pid=c.pid
)
GROUP BY v.pid

#  Asthma    J45 – J46
UNION 
SELECT  v.pcucode,v.pid as  hn
,GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',') as each_diag
,SPLIT_STR((GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',')),',',1) as firstdiag
,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',')),',',1) as firstvisit
,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate DESC  SEPARATOR ',')),',',1) as lastvisit
FROM visitdiag d
LEFT JOIN visit v
ON d.pcucode=v.pcucode AND d.visitno=v.visitno 
WHERE 
(SUBSTR(d.diagcode,1,3) BETWEEN 'J45' AND 'J46')
AND NOT EXISTS 
(
SELECT *  FROM	personchronic c WHERE c.chroniccode BETWEEN 'J45' AND 'J46' and v.pid=c.pid
)
GROUP BY v.pid

# Emphysema    J43

UNION 
SELECT  v.pcucode,v.pid as  hn
,GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',') as each_diag
,SPLIT_STR((GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',')),',',1) as firstdiag
,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',')),',',1) as firstvisit
,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate DESC  SEPARATOR ',')),',',1) as lastvisit
FROM visitdiag d
LEFT JOIN visit v
ON d.pcucode=v.pcucode AND d.visitno=v.visitno 
WHERE 
(SUBSTR(d.diagcode,1,3) BETWEEN 'J43' AND 'J43')
AND NOT EXISTS 
(
SELECT *  FROM	personchronic c WHERE c.chroniccode BETWEEN 'J43' AND 'J43' and v.pid=c.pid
)
GROUP BY v.pid

# Obesity      E66

UNION 
SELECT  v.pcucode,v.pid as  hn
,GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',') as each_diag
,SPLIT_STR((GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',')),',',1) as firstdiag
,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',')),',',1) as firstvisit
,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate DESC  SEPARATOR ',')),',',1) as lastvisit
FROM visitdiag d
LEFT JOIN visit v
ON d.pcucode=v.pcucode AND d.visitno=v.visitno 
WHERE 
(SUBSTR(d.diagcode,1,3) BETWEEN 'E66' AND 'E66')
AND NOT EXISTS 
(
SELECT *  FROM	personchronic c WHERE c.chroniccode BETWEEN 'E66' AND 'E66' and v.pid=c.pid
)
GROUP BY v.pid
# CA           C00-C97
UNION 
SELECT  v.pcucode,v.pid as  hn
,GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',') as each_diag
,SPLIT_STR((GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',')),',',1) as firstdiag
,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',')),',',1) as firstvisit
,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate DESC  SEPARATOR ',')),',',1) as lastvisit
FROM visitdiag d
LEFT JOIN visit v
ON d.pcucode=v.pcucode AND d.visitno=v.visitno 
WHERE 
(SUBSTR(d.diagcode,1,3) BETWEEN 'C00' AND 'C97')
AND NOT EXISTS 
(
SELECT *  FROM	personchronic c WHERE c.chroniccode BETWEEN 'C00' AND 'C97' and v.pid=c.pid
)
GROUP BY v.pid
# HIV          B20-B24

UNION 
SELECT  v.pcucode,v.pid as  hn
,GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',') as each_diag
,SPLIT_STR((GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',')),',',1) as firstdiag
,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',')),',',1) as firstvisit
,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate DESC  SEPARATOR ',')),',',1) as lastvisit
FROM visitdiag d
LEFT JOIN visit v
ON d.pcucode=v.pcucode AND d.visitno=v.visitno 
WHERE 
(SUBSTR(d.diagcode,1,3) BETWEEN 'B20' AND 'B24')
AND NOT EXISTS 
(
SELECT *  FROM	personchronic c WHERE c.chroniccode BETWEEN 'B20' AND 'B24' and v.pid=c.pid
)
GROUP BY v.pid

# Cirrhosis of liver    K70.3 ,K71.7,K74
UNION 
SELECT  v.pcucode,v.pid as  hn
,GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',') as each_diag
,SPLIT_STR((GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',')),',',1) as firstdiag
,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',')),',',1) as firstvisit
,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate DESC  SEPARATOR ',')),',',1) as lastvisit
FROM visitdiag d
LEFT JOIN visit v
ON d.pcucode=v.pcucode AND d.visitno=v.visitno 
WHERE 
(d.diagcode in ('K70.3' ,'K71.7') OR SUBSTR(d.diagcode,1,3)='K74' )
AND NOT EXISTS 
(
SELECT *  FROM	personchronic c WHERE (c.chroniccode in ('K70.3' ,'K71.7') OR SUBSTR(c.chroniccode,1,3)='K74') and v.pid=c.pid
)
GROUP BY v.pid
# Chronic hepatitis     K73
UNION 
SELECT  v.pcucode,v.pid as  hn
,GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',') as each_diag
,SPLIT_STR((GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',')),',',1) as firstdiag
,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',')),',',1) as firstvisit
,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate DESC  SEPARATOR ',')),',',1) as lastvisit
FROM visitdiag d
LEFT JOIN visit v
ON d.pcucode=v.pcucode AND d.visitno=v.visitno 
WHERE 
(SUBSTR(d.diagcode,1,3) BETWEEN 'K73' AND 'K73')
AND NOT EXISTS 
(
SELECT *  FROM	personchronic c WHERE c.chroniccode BETWEEN 'K73' AND 'K73' and v.pid=c.pid
)
GROUP BY v.pid
# Chronic Renal failure N18
UNION 
SELECT  v.pcucode,v.pid as  hn
,GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',') as each_diag
,SPLIT_STR((GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',')),',',1) as firstdiag
,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',')),',',1) as firstvisit
,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate DESC  SEPARATOR ',')),',',1) as lastvisit
FROM visitdiag d
LEFT JOIN visit v
ON d.pcucode=v.pcucode AND d.visitno=v.visitno 
WHERE 
(SUBSTR(d.diagcode,1,3) BETWEEN 'N18' AND 'N18')
AND NOT EXISTS 
(
SELECT *  FROM	personchronic c WHERE c.chroniccode BETWEEN 'N18' AND 'N18' and v.pid=c.pid
)
GROUP BY v.pid

# Osteoarthritis        M15-M19,M47
UNION 
SELECT  v.pcucode,v.pid as  hn
,GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',') as each_diag
,SPLIT_STR((GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',')),',',1) as firstdiag
,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',')),',',1) as firstvisit
,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate DESC  SEPARATOR ',')),',',1) as lastvisit
FROM visitdiag d
LEFT JOIN visit v
ON d.pcucode=v.pcucode AND d.visitno=v.visitno 
WHERE 
(SUBSTR(d.diagcode,1,3) BETWEEN 'M15' AND 'M19' OR SUBSTR(d.diagcode,1,3)='M47')
AND NOT EXISTS 
(
SELECT *  FROM	personchronic c WHERE (c.chroniccode BETWEEN 'M15' AND 'M19' OR SUBSTR(c.chroniccode,1,3)='M47' )and v.pid=c.pid
)
GROUP BY v.pid

# Rheumatoid arthritis  M05 – M06
UNION 
SELECT  v.pcucode,v.pid as  hn
,GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',') as each_diag
,SPLIT_STR((GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',')),',',1) as firstdiag
,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',')),',',1) as firstvisit
,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate DESC  SEPARATOR ',')),',',1) as lastvisit
FROM visitdiag d
LEFT JOIN visit v
ON d.pcucode=v.pcucode AND d.visitno=v.visitno 
WHERE 
(SUBSTR(d.diagcode,1,3) BETWEEN 'M05' AND 'M06')
AND NOT EXISTS 
(
SELECT *  FROM	personchronic c WHERE c.chroniccode BETWEEN 'M05' AND 'M06' and v.pid=c.pid
)
GROUP BY v.pid

#  CVD   I60 –I69
UNION 
SELECT  v.pcucode,v.pid as  hn
,GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',') as each_diag
,SPLIT_STR((GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',')),',',1) as firstdiag
,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',')),',',1) as firstvisit
,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate DESC  SEPARATOR ',')),',',1) as lastvisit
FROM visitdiag d
LEFT JOIN visit v
ON d.pcucode=v.pcucode AND d.visitno=v.visitno 
WHERE 
(SUBSTR(d.diagcode,1,3) BETWEEN 'I60' AND 'I69')
AND NOT EXISTS 
(
SELECT *  FROM	personchronic c WHERE c.chroniccode BETWEEN 'I60' AND 'I69' and v.pid=c.pid
)
GROUP BY v.pid
#Stroke   I64
UNION 
SELECT  v.pcucode,v.pid as  hn
,GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',') as each_diag
,SPLIT_STR((GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',')),',',1) as firstdiag
,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',')),',',1) as firstvisit
,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate DESC  SEPARATOR ',')),',',1) as lastvisit
FROM visitdiag d
LEFT JOIN visit v
ON d.pcucode=v.pcucode AND d.visitno=v.visitno 
WHERE 
(SUBSTR(d.diagcode,1,3) BETWEEN 'I64' AND 'I64')
AND NOT EXISTS 
(
SELECT *  FROM	personchronic c WHERE c.chroniccode BETWEEN 'I64' AND 'I64' and v.pid=c.pid
)
GROUP BY v.pid

# IHD  I20 – I25
UNION 
SELECT  v.pcucode,v.pid as  hn
,GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',') as each_diag
,SPLIT_STR((GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',')),',',1) as firstdiag
,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate ASC  SEPARATOR ',')),',',1) as firstvisit
,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate DESC  SEPARATOR ',')),',',1) as lastvisit
FROM visitdiag d
LEFT JOIN visit v
ON d.pcucode=v.pcucode AND d.visitno=v.visitno 
WHERE 
(SUBSTR(d.diagcode,1,3) BETWEEN 'I20' AND 'I25')
AND NOT EXISTS 
(
SELECT *  FROM	personchronic c WHERE c.chroniccode BETWEEN 'I20' AND 'I25' and v.pid=c.pid
)
GROUP BY v.pid

) as t1
LEFT JOIN person p
ON t1.pcucode=p.pcucodeperson AND t1.hn=p.pid 
LEFT JOIN house h
ON  p.pcucodeperson=h.pcucode AND p.hcode=h.hcode
LEFT JOIN person o
ON h.pcucodepersonvola=o.pcucodeperson and	h.pidvola=o.pid 
WHERE hn='1622'
