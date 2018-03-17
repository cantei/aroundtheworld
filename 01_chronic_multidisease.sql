
DROP TABLE	IF EXISTS `me_chronic_multidisease` ;
		CREATE TABLE `me_chronic_multidisease` (
			`pcucodeperson` char(5) NOT NULL default '',
			`pid` int(11) NOT NULL,
			`hcode` int(11) NOT NULL,
			`prename` varchar(20) default NULL,
			`fname` varchar(25) NOT NULL,
			`lname` varchar(35) default NULL,
			`birth` date default NULL,
			`sex` varchar(1) NOT NULL,
			`idcard` varchar(13) default NULL,
			`typelive` varchar(1) default NULL,
			`dischargetype` varchar(1) default NULL,
			`hno` varchar(75) default NULL,
			`moo` varchar(8) default NULL,
			`telephoneperson` varchar(35) default NULL,
			`pcucodepersonvola` char(5) default NULL,
			`pidvola` int(11) default NULL,
			`volanteer` varchar(100) default NULL,
			`lmp_pregage` varchar(50) default NULL,
			`age_month` varchar(50) default NULL,
			`copd` varchar(10) default NULL,
			`asthma` varchar(10) default NULL,
			`ihd` varchar(10) default NULL,
			`stroke` varchar(10) default NULL,
			`renalfailure` varchar(10) default NULL,
			`dm` varchar(10) default NULL,
			INDEX `vola_idx` (`pcucodepersonvola`,`pidvola`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8;
		
INSERT INTO `me_chronic_multidisease` ( pcucodeperson,pid,hcode,prename,fname,lname,birth,sex,idcard,typelive,dischargetype,hno,moo,telephoneperson,pcucodepersonvola,pidvola)
SELECT p.pcucodeperson,p.pid,p.hcode,p.prename,p.fname,p.lname,p.birth,p.sex,p.idcard,p.typelive,p.dischargetype
,h.hno,substr(h.villcode,7,2) as moo
,p.telephoneperson
,h.pcucodepersonvola,h.pidvola
FROM person	 p
INNER JOIN house h 
ON p.pcucodeperson=h.pcucode and	 p.hcode=h.hcode 
WHERE p.typelive in ('1','3') AND p.dischargetype='9';


# หญิงตั้งครรภ์	

UPDATE `me_chronic_multidisease`  t0
INNER JOIN
(
	SELECT pcucodeperson,pid,concat(TIMESTAMPDIFF(week,visitancpregnancy.lmp,'2018-05-01'),"  " ,"[" ,lmp,"]") as lmp_pregage
	FROM visitancpregnancy 
	HAVING lmp_pregage BETWEEN 16 AND 40
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.lmp_pregage=t1.lmp_pregage;



#  เด็ก 6 ด  - 2 ปี	

UPDATE `me_chronic_multidisease`  t0
INNER JOIN
(
	SELECT p.pcucodeperson,p.pid,TIMESTAMPDIFF(MONTH,p.birth,'2018-01-01') as age_month
	FROM person p
	WHERE TIMESTAMPDIFF(MONTH,p.birth,'2018-05-01') BETWEEN 6 AND 35
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.age_month=t1.age_month;
	
########################################################## diag ###########################################################
	
# COPD 

UPDATE `me_chronic_multidisease`  t0
INNER JOIN
(
		SELECT p.pcucodeperson,p.pid
		,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate DESC  SEPARATOR ',')),',',1) as visit
		,SPLIT_STR((GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate DESC  SEPARATOR ',')),',',1) as lastdiag
		FROM person p
		INNER JOIN visit v
		ON	 p.pcucodeperson=v.pcucodeperson AND p.pid=v.pid 
		INNER JOIN visitdiag d 
		ON v.pcucode=d.pcucode AND v.visitno=d.visitno 
		WHERE p.typelive in ('1','3') 
		AND p.dischargetype='9'
		AND 	 substr(d.diagcode,1,3) BETWEEN 'J44' AND 'J44'
		GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.copd=t1.lastdiag;


# ASTHMA
UPDATE `me_chronic_multidisease`  t0
INNER JOIN
(
		SELECT p.pcucodeperson,p.pid
		,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate DESC  SEPARATOR ',')),',',1) as visit
		,SPLIT_STR((GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate DESC  SEPARATOR ',')),',',1) as lastdiag
		FROM person p
		INNER JOIN visit v
		ON	 p.pcucodeperson=v.pcucodeperson AND p.pid=v.pid 
		INNER JOIN visitdiag d 
		ON v.pcucode=d.pcucode AND v.visitno=d.visitno 
		WHERE p.typelive in ('1','3') 
		AND p.dischargetype='9'
		AND 	 substr(d.diagcode,1,3) BETWEEN 'J45' AND 'J45'
		GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.asthma=t1.lastdiag;

# IHD

UPDATE `me_chronic_multidisease`  t0
INNER JOIN
(
		SELECT p.pcucodeperson,p.pid
		,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate DESC  SEPARATOR ',')),',',1) as visit
		,SPLIT_STR((GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate DESC  SEPARATOR ',')),',',1) as lastdiag
		FROM person p
		INNER JOIN visit v
		ON	 p.pcucodeperson=v.pcucodeperson AND p.pid=v.pid 
		INNER JOIN visitdiag d 
		ON v.pcucode=d.pcucode AND v.visitno=d.visitno 
		WHERE p.typelive in ('1','3') 
		AND p.dischargetype='9'
		AND 	 substr(d.diagcode,1,3) BETWEEN 'I20' AND 'I25'
		GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.ihd=t1.lastdiag;


# STROKE 
UPDATE `me_chronic_multidisease`  t0
INNER JOIN
(
		SELECT p.pcucodeperson,p.pid
		,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate DESC  SEPARATOR ',')),',',1) as visit
		,SPLIT_STR((GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate DESC  SEPARATOR ',')),',',1) as lastdiag
		FROM person p
		INNER JOIN visit v
		ON	 p.pcucodeperson=v.pcucodeperson AND p.pid=v.pid 
		INNER JOIN visitdiag d 
		ON v.pcucode=d.pcucode AND v.visitno=d.visitno 
		WHERE p.typelive in ('1','3') 
		AND p.dischargetype='9'
		AND 	 substr(d.diagcode,1,3) BETWEEN 'I64' AND 'I64'
		GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.stroke=t1.lastdiag;


# RENAL FAILURE` 
UPDATE `me_chronic_multidisease`  t0
INNER JOIN
(
		SELECT p.pcucodeperson,p.pid
		,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate DESC  SEPARATOR ',')),',',1) as visit
		,SPLIT_STR((GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate DESC  SEPARATOR ',')),',',1) as lastdiag
		FROM person p
		INNER JOIN visit v
		ON	 p.pcucodeperson=v.pcucodeperson AND p.pid=v.pid 
		INNER JOIN visitdiag d 
		ON v.pcucode=d.pcucode AND v.visitno=d.visitno 
		WHERE p.typelive in ('1','3') 
		AND p.dischargetype='9'
		AND 	 substr(d.diagcode,1,3) BETWEEN 'N17' AND 'N19'
		GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.renalfailure=t1.lastdiag;

# DM 
UPDATE `me_chronic_multidisease`  t0
INNER JOIN
(
		SELECT p.pcucodeperson,p.pid
		,SPLIT_STR((GROUP_CONCAT(CAST(v.visitdate AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate DESC  SEPARATOR ',')),',',1) as visit
		,SPLIT_STR((GROUP_CONCAT(CAST(d.diagcode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY v.visitdate DESC  SEPARATOR ',')),',',1) as lastdiag
		FROM person p
		INNER JOIN visit v
		ON	 p.pcucodeperson=v.pcucodeperson AND p.pid=v.pid 
		INNER JOIN visitdiag d 
		ON v.pcucode=d.pcucode AND v.visitno=d.visitno 
		WHERE p.typelive in ('1','3') 
		AND p.dischargetype='9'
		AND 	 substr(d.diagcode,1,3) BETWEEN 'E10' AND 'E14'
		GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.dm=t1.lastdiag;


########################################################## chronic ###########################################################
	

# COPD 
UPDATE `me_chronic_multidisease`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
	,SPLIT_STR(GROUP_CONCAT(CAST(c.chroniccode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag DESC SEPARATOR ','),',',1) as lastdiag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE  substr(REPLACE(c.chroniccode,'.',''),1,3) BETWEEN 'J44' AND 'J44' 
	GROUP BY p.pcucodeperson,p.pid	
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.copd=t1.lastdiag
WHERE ISNULL(copd);


# ASTHMA 

UPDATE `me_chronic_multidisease`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
	,SPLIT_STR(GROUP_CONCAT(CAST(c.chroniccode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag DESC SEPARATOR ','),',',1) as lastdiag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE substr(REPLACE(c.chroniccode,'.',''),1,3) BETWEEN 'J45' AND 'J45' 
	GROUP BY p.pcucodeperson,p.pid	
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.asthma=t1.lastdiag
WHERE ISNULL(asthma);

		
		
# IHD
UPDATE `me_chronic_multidisease`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
	,SPLIT_STR(GROUP_CONCAT(CAST(c.chroniccode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag DESC SEPARATOR ','),',',1) as lastdiag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE substr(REPLACE(c.chroniccode,'.',''),1,3) BETWEEN 'I20' AND 'I25' 
	GROUP BY p.pcucodeperson,p.pid	
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.ihd=t1.lastdiag
WHERE ISNULL(ihd);		
		
		
		
# STROKE
UPDATE `me_chronic_multidisease`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
	,SPLIT_STR(GROUP_CONCAT(CAST(c.chroniccode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag DESC SEPARATOR ','),',',1) as lastdiag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE substr(REPLACE(c.chroniccode,'.',''),1,3) BETWEEN 'I64' AND 'I64' 
	GROUP BY p.pcucodeperson,p.pid	
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.stroke=t1.lastdiag
WHERE ISNULL(stroke);



# RENAL FAILURE` 

UPDATE `me_chronic_multidisease`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
	,SPLIT_STR(GROUP_CONCAT(CAST(c.chroniccode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag DESC SEPARATOR ','),',',1) as lastdiag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE substr(REPLACE(c.chroniccode,'.',''),1,3) BETWEEN 'N17' AND 'N19' 
	GROUP BY p.pcucodeperson,p.pid	
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.renalfailure=t1.lastdiag
WHERE ISNULL(t0.renalfailure);

# DM 

UPDATE `me_chronic_multidisease`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
	,SPLIT_STR(GROUP_CONCAT(CAST(c.chroniccode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag DESC SEPARATOR ','),',',1) as lastdiag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE substr(REPLACE(c.chroniccode,'.',''),1,3) BETWEEN 'E10' AND 'E14' 
	GROUP BY p.pcucodeperson,p.pid	
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.dm=t1.lastdiag
WHERE ISNULL(t0.dm);



# Volanteer 

UPDATE `me_chronic_multidisease`  t0
INNER JOIN
(
SELECT * 
FROM person 
) as t1
ON t0.pcucodepersonvola=t1.pcucodeperson AND t0.pidvola=t1.pid 
SET t0.volanteer=concat(t1.fname,'  ',t1.lname);


# report 
SELECT m.moo,m.hno
,concat(c.titlename,m.fname,"  ",m.lname)  as fullname
,concat(DATE_FORMAT(m.birth,'%d-%m'),'-',(YEAR(m.birth)+543)) as born
,lmp_pregage,age_month
,copd,asthma,ihd,stroke,renalfailure,dm
,concat(copd,asthma,ihd,stroke,renalfailure,dm) as chronic
,volanteer
,IF(ISNULL(copd),'', concat(copd,',')) as a1
,IF(ISNULL(asthma),'', concat(asthma,',')) as a2
,IF(ISNULL(ihd),'', concat(ihd,',')) as a3
,IF(ISNULL(stroke),'', concat(stroke,',')) as a4
,IF(ISNULL(renalfailure),'', concat(renalfailure,',')) as a5
,IF(ISNULL(dm),'',dm )as a6
,COALESCE(copd,dm) as a7

FROM me_chronic_multidisease m
LEFT JOIN ctitle c
ON m.prename=c.titlecode 
WHERE (NOT ISNULL(lmp_pregage) 
OR NOT ISNULL(age_month)
OR NOT ISNULL(copd)
OR NOT ISNULL(ihd)
OR NOT ISNULL(stroke)
OR NOT ISNULL(renalfailure)
OR NOT ISNULL(dm)
) 
-- AND TIMESTAMPDIFF(YEAR,birth,'2018-05-01') > 65

ORDER BY moo,(SPLIT_STR(hno,'/', 1)*1),(SPLIT_STR(hno,'/',2)*1)
