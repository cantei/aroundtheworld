SELECT t1.pcucode,t1.pid
,t1.fullname,t1.born,t1.age,t1.typelive
,t1.address,t1.hno,t1.moo
,t1.hnomoi,t1.mumoi
,t1.homeno
,t1.seq,t1.bw,t1.height,t1.waist,t1.ass
,substr(t1.his_ciga,1,4) as his_ciga
,t2.ppspecial as q_smoking
,t3.ppspecial as t_smoking
,t4.ppspecial as unspec_smoking
,t1.noalcohol
,t1.stopalcohol
,t1.low_alcohol
,t1.mild_alcohol
,t1.heavy_alcohol
,volanteer
FROM 
(
	SELECT s.pcucode,s.pid
	,CONCAT(c.titlename,p.fname,'   ',p.lname) as fullname
	,concat(DATE_FORMAT(p.birth, "%d"),'-',DATE_FORMAT(p.birth, "%m"),'-',(DATE_FORMAT(p.birth, "%Y")+543)) as born
	,TIMESTAMPDIFF(year,p.birth,CURDATE()) as  age
	,p.typelive
	,CONCAT(a.hno,'  ','หมู่ที่ ',a.mu )as address
	,a.hno,a.mu as moo
	,p.hnomoi,p.mumoi
	,h.hno as homeno
	,SPLIT_STR(GROUP_CONCAT(CAST(s.visitno AS CHAR(10000) CHARACTER SET utf8)  ORDER BY s.dateserv  DESC SEPARATOR ','),',',1) as seq
	,SPLIT_STR(GROUP_CONCAT(CAST(v.weight AS CHAR(10000) CHARACTER SET utf8)  ORDER BY s.dateserv  DESC SEPARATOR ','),',',1) as bw
	,SPLIT_STR(GROUP_CONCAT(CAST(v.height AS CHAR(10000) CHARACTER SET utf8)  ORDER BY s.dateserv  DESC SEPARATOR ','),',',1) as height
	,SPLIT_STR(GROUP_CONCAT(CAST(v.waist AS CHAR(10000) CHARACTER SET utf8)  ORDER BY s.dateserv  DESC SEPARATOR ','),',',1) as waist
	,SPLIT_STR(GROUP_CONCAT(CAST(v.ass AS CHAR(10000) CHARACTER SET utf8)  ORDER BY s.dateserv  DESC SEPARATOR ','),',',1) as ass
	,SPLIT_STR(GROUP_CONCAT(s.ppspecial  ORDER BY s.dateserv  DESC  SEPARATOR ','),',',1) as his_ciga
	,if(s.ppspecial='1B600',s.ppspecial,NULL) as 'noalcohol'
	,if(s.ppspecial='1B600',s.ppspecial,NULL) as 'stopalcohol'
	,if(s.ppspecial='1B600',s.ppspecial,NULL) as 'low_alcohol'
	,if(s.ppspecial='1B600',s.ppspecial,NULL) as 'mild_alcohol'
	,if(s.ppspecial='1B600',s.ppspecial,NULL) as 'heavy_alcohol'
	,if(s.ppspecial='1B600',s.ppspecial,NULL) as 'drink_unknown'
	,CONCAT(o.fname,'  ',o.lname) as 'volanteer'
	FROM  f43specialpp s 
	INNER JOIN visit v
	ON s.pcucode=v.pcucode AND s.visitno=v.visitno 
	INNER JOIN person p
	ON v.pcucode=p.pcucodeperson AND v.pid=p.pid
	LEFT JOIN ctitle c
	ON p.prename=c.titlecode
	LEFT JOIN personaddresscontact a
	ON p.pcucodeperson=a.pcucodeperson AND p.pid=a.pid 
	LEFT JOIN house h
	ON a.hno=h.hno AND concat(a.provcode,a.distcode,a.subdistcode,a.mu)=h.villcode  
	LEFT JOIN person o
	ON h.pcucodepersonvola=o.pcucodeperson and	h.pidvola=o.pid
	WHERE (substr(s.ppspecial,1,4) in ('1B50','1B51','1B52') OR substr(s.ppspecial,1,4)='1B60')
	AND p.typelive in ('1','3')
	GROUP BY s.pid
) as t1 
LEFT JOIN 
(
	SELECT s.pid,s.visitno 
	,s.ppspecial
	FROM  f43specialpp s 
	WHERE  substr(s.ppspecial,1,5) in ('1B501','1B502','1B503')  
) as t2 
ON  t1.pid=t2.pid AND t1.seq=t2.visitno
LEFT JOIN 
(
	SELECT s.pid,s.visitno 
	,s.ppspecial
	FROM  f43specialpp s 
	WHERE  substr(s.ppspecial,1,5) in ('1B504','1B505','1B506')  
) as t3 
ON  t1.pid=t3.pid AND t1.seq=t3.visitno
LEFT JOIN 
(
	SELECT s.pid,s.visitno 
	,s.ppspecial
	FROM  f43specialpp s 
	WHERE  substr(s.ppspecial,1,5) in ('1B509')  
) as t4 
ON  t1.pid=t4.pid AND t1.seq=t4.visitno
-- HAVING his_ciga ='1B50' AND ISNULL(t_smoking)
ORDER BY t1.moo,volanteer,(SPLIT_STR(t1.hno,'/', 1)*1),(SPLIT_STR(t1.hno,'/',2)*1)
