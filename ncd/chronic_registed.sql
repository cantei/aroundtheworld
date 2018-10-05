SELECT t0.pid as hn,t0.fullname,t0.birth
,CONCAT(t0.hno,'  ','หมู่ที่ ',substr(t0.villcode,8,1)) as address
,substr(t0.villcode,8,1) as village
,t0.volanteer
,SPLIT_STR(GROUP_CONCAT(CAST(h.chroniccode  AS CHAR(10000) CHARACTER SET utf8) ORDER BY h.datedxfirst  DESC SEPARATOR ','),',',1) as last_ht_dx
,SPLIT_STR(GROUP_CONCAT(CAST(h.datedxfirst  AS CHAR(10000) CHARACTER SET utf8) ORDER BY h.datedxfirst  DESC SEPARATOR ','),',',1) as last_ht_fu
-- ,SPLIT_STR(GROUP_CONCAT(CAST(h.typedischart  AS CHAR(10000) CHARACTER SET utf8) ORDER BY h.datedxfirst  DESC SEPARATOR ','),',',1) as last_ht_dsc
,SPLIT_STR(GROUP_CONCAT(CAST(d.chroniccode  AS CHAR(10000) CHARACTER SET utf8) ORDER BY d.datedxfirst  DESC SEPARATOR ','),',',1) as last_dm_dx
,SPLIT_STR(GROUP_CONCAT(CAST(d.datedxfirst  AS CHAR(10000) CHARACTER SET utf8) ORDER BY d.datedxfirst  DESC SEPARATOR ','),',',1) as last_dm_fu
-- ,SPLIT_STR(GROUP_CONCAT(CAST(d.typedischart  AS CHAR(10000) CHARACTER SET utf8) ORDER BY d.datedxfirst  DESC SEPARATOR ','),',',1) as last_dm_dsc
FROM
(
SELECT p.pid,p.pcucodeperson,p.hcode,CONCAT(t.titlename,p.fname,'    ',p.lname) as fullname,p.birth
,h.hno,h.villcode
,concat(v.fname,'   ',v.lname) as volanteer
FROM person p
LEFT JOIN ctitle t
ON p.prename=t.titlecode
LEFT JOIN house h
ON h.pcucode=p.pcucodeperson AND h.hcode=p.hcode 
LEFT JOIN person v
ON h.pcucodepersonvola=v.pcucodeperson AND h.pidvola=v.pid 
INNER JOIN personchronic c
ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
WHERE p.typelive in ('1','3')
AND p.dischargetype='9'
AND (substr(c.chroniccode,1,3) BETWEEN 'I10' AND 'I15' OR substr(c.chroniccode,1,3) BETWEEN 'E10' AND 'E14')
AND  c.typedischart='03'
) as t0
LEFT JOIN personchronic h
ON t0.pid=h.pid AND substr(h.chroniccode,1,3) BETWEEN 'I10' AND 'I15'
LEFT JOIN personchronic d
ON t0.pid=d.pid AND substr(d.chroniccode,1,3) BETWEEN 'E10' AND 'E14'
GROUP BY t0.pid 
-- HAVING NOT ISNULL(last_dm_fu)
ORDER BY substr(t0.villcode,8,1),(SPLIT_STR(t0.hno,'/', 1)*1),(SPLIT_STR(t0.hno,'/',2)*1)
