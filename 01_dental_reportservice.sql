# กำหนดช่วงเวลา
SET 
@date_start='2017-10-01'
,@date_stop='2018-09-30';
SELECT t0.agegroup,t0.nhead as x0,t0.nvisit as y0
,t1.nhead as x1,t1.nvisit as y1  
,t2.nhead as x2,t2.nvisit as y2
,t3.nhead as x3,t3.nvisit as y3
FROM 
(
SELECT '0-6' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN @date_start AND @date_stop
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN 0 AND 6 
UNION
SELECT '7-12' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN @date_start AND @date_stop
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN 7 AND 12
UNION
SELECT '13-19' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN @date_start AND @date_stop
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN 13 AND 19
UNION
SELECT '20-29' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN @date_start AND @date_stop
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN 20 AND 29
UNION
SELECT '30-39' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN @date_start AND @date_stop
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN 30 AND 39
UNION
SELECT '40-49' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN @date_start AND @date_stop
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN  40 AND 49
UNION
SELECT '50-59' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN @date_start AND @date_stop
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN  50 AND 59
UNION
SELECT '60-69' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN @date_start AND @date_stop
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN  60 AND 69
UNION
SELECT '70-79' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN @date_start AND @date_stop
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN  70 AND 79
UNION
SELECT '80-89' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN @date_start AND @date_stop
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN  80 AND 89
UNION
SELECT '90-99' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN @date_start AND @date_stop
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN  90 AND 99
UNION
SELECT 'รวม' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN @date_start AND @date_stop
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN  0 AND 99
) as t0
LEFT JOIN 
(
SELECT '0-6' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 1 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 1 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN 0 AND 6 
UNION
SELECT '7-12' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 1 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 1 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN 7 AND 12
UNION
SELECT '13-19' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 1 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 1 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN 13 AND 19
UNION
SELECT '20-29' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 1 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 1 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN 20 AND 29
UNION
SELECT '30-39' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 1 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 1 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN 30 AND 39
UNION
SELECT '40-49' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 1 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 1 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN  40 AND 49
UNION
SELECT '50-59' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 1 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 1 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN  50 AND 59
UNION
SELECT '60-69' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 1 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 1 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN  60 AND 69
UNION
SELECT '70-79' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 1 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 1 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN  70 AND 79
UNION
SELECT '80-89' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 1 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 1 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN  80 AND 89
UNION
SELECT '90-99' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 1 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 1 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN  90 AND 99
UNION
SELECT 'รวม' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 1 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 1 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN  0 AND 99
) as t1
ON t0.agegroup=t1.agegroup 
-- date add -2 
LEFT JOIN 
(
SELECT '0-6' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 2 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 2 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN 0 AND 6 
UNION
SELECT '7-12' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 2 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 2 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN 7 AND 12
UNION
SELECT '13-19' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 2 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 2 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN 13 AND 19
UNION
SELECT '20-29' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 2 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 2 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN 20 AND 29
UNION
SELECT '30-39' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 2 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 2 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN 30 AND 39
UNION
SELECT '40-49' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 2 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 2 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN  40 AND 49
UNION
SELECT '50-59' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 2 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 2 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN  50 AND 59
UNION
SELECT '60-69' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 2 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 2 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN  60 AND 69
UNION
SELECT '70-79' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 2 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 2 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN  70 AND 79
UNION
SELECT '80-89' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 2 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 2 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN  80 AND 89
UNION
SELECT '90-99' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 2 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 2 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN  90 AND 99
UNION
SELECT 'รวม' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 2 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 2 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN  0 AND 99
) as t2
ON t0.agegroup=t2.agegroup 
-- date add -3 
LEFT JOIN 
(
SELECT '0-6' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 3 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 3 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN 0 AND 6 
UNION
SELECT '7-12' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 3 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 3 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN 7 AND 12
UNION
SELECT '13-19' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 3 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 3 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN 13 AND 19
UNION
SELECT '20-29' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 3 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 3 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN 20 AND 29
UNION
SELECT '30-39' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 3 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 3 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN 30 AND 39
UNION
SELECT '40-49' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 3 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 3 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN  40 AND 49
UNION
SELECT '50-59' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 3 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 3 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN  50 AND 59
UNION
SELECT '60-69' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 3 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 3 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN  60 AND 69
UNION
SELECT '70-79' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 3 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 3 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN  70 AND 79
UNION
SELECT '80-89' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 3 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 3 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN  80 AND 89
UNION
SELECT '90-99' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 3 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 3 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN  90 AND 99
UNION
SELECT 'รวม' as agegroup
,count(DISTINCT p.pid) as nhead
,count(DISTINCT v.visitno) as nvisit
FROM visit v 
LEFT JOIN visitdrugdental d 
ON v.pcucode = d.pcucode AND v.visitno = d.visitno
LEFT JOIN person p
ON p.pcucodeperson = v.pcucodeperson AND p.pid = v.pid
WHERE v.visitdate BETWEEN DATE_ADD(@date_start, INTERVAL - 3 YEAR) AND DATE_ADD(@date_stop, INTERVAL - 3 YEAR)
AND NOT ISNULL(d.dentcode)
AND TIMESTAMPDIFF(year,p.birth,v.visitdate) BETWEEN  0 AND 99
) as t3
ON t0.agegroup=t3.agegroup 
