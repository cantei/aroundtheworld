SELECT p.pid,concat(t.titlename,p.fname,'   ',p.lname) as fullname,p.idcard,p.birth,TIMESTAMPDIFF(year,p.birth,CURDATE()) as age
,h.hno AS 'เลขที่'
,substr(h.villcode,8,1)AS'หมู่' 
,SPLIT_STR(GROUP_CONCAT(CAST(spp.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY spp.dateserv DESC  SEPARATOR ',') ,',',1) as lastscreen
,SPLIT_STR(GROUP_CONCAT(CAST(spp.ppspecial AS CHAR(10000) CHARACTER SET utf8)  ORDER BY spp.dateserv DESC  SEPARATOR ',') ,',',1) as lastadl
FROM person p 
LEFT JOIN ctitle t ON p.prename=t.titlecode
INNER JOIN house h ON p.hcode=h.hcode 
INNER JOIN f43specialpp spp ON p.pid=spp.pid
WHERE p.typelive in ('1','3')
AND p.dischargetype='9'
AND	getAgeYearNum(p.birth,CURDATE())>= '60' AND p.typelive IN ('1','3')
AND p.pid NOT IN
(SELECT pd.pid FROM persondeath pd) 
AND spp.dateserv BETWEEN '2017-10-01'AND CURDATE()
AND spp.ppspecial in ('1B1280','1B1281','1B1282')
GROUP BY p.pid
HAVING lastadl='1B1282'
