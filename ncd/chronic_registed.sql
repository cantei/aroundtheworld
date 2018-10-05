SELECT concat(v.fname,' ',v.lname) as volanteer
,t0.pid as hn
,CONCAT(c.titlename,t0.fname,'   ',t0.lname) as fullname
,t0.birth
,b.hno,b.villcode
,SPLIT_STR(GROUP_CONCAT(CAST(h.chroniccode  AS CHAR(10000) CHARACTER SET utf8) ORDER BY h.datedxfirst  DESC SEPARATOR ','),',',1) as last_ht_dx
,SPLIT_STR(GROUP_CONCAT(CAST(h.datedxfirst  AS CHAR(10000) CHARACTER SET utf8) ORDER BY h.datedxfirst  DESC SEPARATOR ','),',',1) as last_ht_fu
,SPLIT_STR(GROUP_CONCAT(CAST(h.typedischart  AS CHAR(10000) CHARACTER SET utf8) ORDER BY h.datedxfirst  DESC SEPARATOR ','),',',1) as last_ht_dsc
,SPLIT_STR(GROUP_CONCAT(CAST(d.chroniccode  AS CHAR(10000) CHARACTER SET utf8) ORDER BY d.datedxfirst  DESC SEPARATOR ','),',',1) as last_dm_dx
,SPLIT_STR(GROUP_CONCAT(CAST(d.datedxfirst  AS CHAR(10000) CHARACTER SET utf8) ORDER BY d.datedxfirst  DESC SEPARATOR ','),',',1) as last_dm_fu
,SPLIT_STR(GROUP_CONCAT(CAST(d.typedischart  AS CHAR(10000) CHARACTER SET utf8) ORDER BY d.datedxfirst  DESC SEPARATOR ','),',',1) as last_dm_dsc
FROM 
(
SELECT p.pid,p.pcucodeperson,p.hcode,p.prename,p.fname,p.lname,p.birth
FROM person p
INNER JOIN personchronic c
ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
WHERE p.typelive in ('1','3')
AND p.dischargetype='9'
AND (substr(c.chroniccode,1,3) BETWEEN 'I10' AND 'I15' OR substr(c.chroniccode,1,3) BETWEEN 'E10' AND 'E14')
AND  c.typedischart='03'
) as t0 
LEFT JOIN ctitle c
ON t0.prename=c.titlecode
LEFT JOIN personchronic h
ON t0.pid=h.pid AND substr(h.chroniccode,1,3) BETWEEN 'I10' AND 'I15'
LEFT JOIN personchronic d
ON t0.pid=d.pid AND substr(d.chroniccode,1,3) BETWEEN 'E10' AND 'E14'
LEFT JOIN house b
ON b.pcucode=t0.pcucodeperson AND b.hcode=t0.hcode 
LEFT JOIN person v
ON b.pcucodepersonvola=v.pcucodeperson AND b.pidvola=v.pid 
GROUP BY t0.pid 
-- HAVING NOT ISNULL(last_dm_fu)
ORDER BY substr(b.villcode,8,1),(SPLIT_STR(b.hno,'/', 1)*1),(SPLIT_STR(b.hno,'/',2)*1)

