SELECT p.pcucodeperson,p.pid
-- , t1.pcucodeperson,t1.pcucode,t1.pid
,CONCAT(c.titlename,p.fname,'   ',p.lname) as fullname
	,concat(DATE_FORMAT(p.birth, "%d"),'-',DATE_FORMAT(p.birth, "%m"),'-',(DATE_FORMAT(p.birth, "%Y")+543)) as born
	,TIMESTAMPDIFF(year,p.birth,CURDATE()) as  age
	,p.typelive
	,CONCAT(a.hno,'  ','หมู่ที่ ',a.mu )as address
	,a.hno,a.mu as moo
	,p.hnomoi,p.mumoi
	,h.hno as homeno,(substr(h.villcode,7,2)*1) as homevillage
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
,CONCAT(o.fname,'  ',o.lname) as 'volanteer'
FROM person p
LEFT JOIN ctitle c
ON p.prename=c.titlecode
LEFT JOIN personaddresscontact a
ON p.pcucodeperson=a.pcucodeperson AND p.pid=a.pid 
LEFT JOIN house h
ON a.hno=h.hno AND concat(a.provcode,a.distcode,a.subdistcode,a.mu)=h.villcode  
LEFT JOIN person o
ON h.pcucodepersonvola=o.pcucodeperson and	h.pidvola=o.pid
LEFT JOIN 
(
	SELECT v.pcucodeperson,v.pcucode,v.pid
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
	FROM  visit v
	INNER JOIN  f43specialpp s 
	ON v.pcucode=s.pcucode AND v.visitno=s.visitno 
	WHERE (substr(s.ppspecial,1,4) in ('1B50','1B51','1B52') OR substr(s.ppspecial,1,4)='1B60')
GROUP BY v.pid
) as t1 
ON p.pcucodeperson=t1.pcucodeperson AND p.pid=t1.pid
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
WHERE  TIMESTAMPDIFF(year,p.birth,CURDATE()) > 15  
AND p.typelive in ('1','3')
AND p.dischargetype='9'
ORDER BY a.mu ,volanteer,(SPLIT_STR(a.hno,'/', 1)*1),(SPLIT_STR(a.hno,'/',2)*1)
