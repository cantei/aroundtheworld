SELECT 
p.pid,concat(t.titlename,p.fname,'   ',p.lname) as fullname,p.idcard,p.birth,TIMESTAMPDIFF(year,p.birth,CURDATE()) as age
,h.hno AS 'เลขที่'
,substr(h.villcode,8,1)AS'หมู่' 
,SPLIT_STR(GROUP_CONCAT(CAST(s.screen_date AS CHAR(10000) CHARACTER SET utf8)  ORDER BY s.screen_date DESC  SEPARATOR ',') ,',',1) as lastscreen
,SPLIT_STR(GROUP_CONCAT(CAST(FORMAT(s.bmi,2) AS CHAR(10000) CHARACTER SET utf8)  ORDER BY s.screen_date DESC  SEPARATOR ','),',',1) as lastbmi
-- ,s.screen_date,s.height,s.weight,FORMAT(s.bmi,2) as bmi
FROM person p 
LEFT JOIN ctitle t 
ON p.prename=t.titlecode
INNER JOIN house h 
ON p.hcode=h.hcode 
INNER JOIN ncd_person_ncd_screen s 
ON p.pid=s.pid
WHERE p.typelive in ('1','3')
AND p.dischargetype='9'
AND s.screen_date BETWEEN '2015-10-01' AND '2016-09-30'
-- AND s.bmi>30
GROUP BY p.pid
