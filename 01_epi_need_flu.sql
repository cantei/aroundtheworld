DROP TABLE	IF EXISTS `me_flu_needs2` ;
		CREATE TABLE `me_flu_needs2` (
			`pcucodeperson` char(5) NOT NULL default '',
			`pid` int(11) NOT NULL,
			`hcode` int(11) NOT NULL,
			`prename` varchar(20) default NULL,
			`fname` varchar(25) NOT NULL,
			`lname` varchar(35) default NULL,
			`birth` date default NULL,
			`age` int(11) default NULL,
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
			`copd` varchar(10) default NULL,
			`asthma` varchar(10) default NULL,
			`ihd` varchar(10) default NULL,
			`stroke` varchar(10) default NULL,
			`renalfailure` varchar(10) default NULL,
			`dm` varchar(10) default NULL,
			`ht65` varchar(10) default NULL,
			`heavy_weight` int(11) default NULL,
			`gestational_age` varchar(50) default NULL,
			`child` int(11) default NULL,
			`aging` int(11) default NULL,
			INDEX `vola_idx` (`pcucodepersonvola`,`pidvola`)
		) ENGINE=InnoDB DEFAULT CHARSET=utf8;
		
# property
INSERT INTO `me_flu_needs2` ( pcucodeperson,pid,hcode,prename,fname,lname,birth,age,sex,idcard,typelive,dischargetype,hno,moo,telephoneperson,pcucodepersonvola,pidvola)
SELECT p.pcucodeperson,p.pid,p.hcode,p.prename,p.fname,p.lname,p.birth
,TIMESTAMPDIFF(YEAR,p.birth,'2018-06-01') as age
,p.sex,p.idcard,p.typelive,p.dischargetype
,h.hno,substr(h.villcode,7,2) as moo
,p.telephoneperson
,h.pcucodepersonvola,h.pidvola
FROM person	 p
INNER JOIN house h 
ON p.pcucodeperson=h.pcucode and	 p.hcode=h.hcode 
WHERE p.typelive in ('1','3') AND p.dischargetype='9';

########################################################## diag ###########################################################
	
# COPD 

UPDATE `me_flu_needs2`  t0
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

	# asthma 

UPDATE `me_flu_needs2`  t0
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
	
#IHD
UPDATE `me_flu_needs2`  t0
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
		AND 	 substr(d.diagcode,1,3)  BETWEEN 'I20' AND 'I25'
		GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.ihd=t1.lastdiag;
	
# STROKE
UPDATE `me_flu_needs2`  t0
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
		AND 	substr(d.diagcode,1,3) BETWEEN 'I64' AND 'I64'
		GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.stroke=t1.lastdiag;

# renalfailure
UPDATE `me_flu_needs2`  t0
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
		AND 	substr(d.diagcode,1,3) BETWEEN 'N17' AND 'N19'
		GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.renalfailure=t1.lastdiag;


# DM
UPDATE `me_flu_needs2`  t0
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

# HT 65+ =591
UPDATE `me_flu_needs2`  t0
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
		AND 	 substr(d.diagcode,1,3) BETWEEN 'I10' AND 'I15'
		AND TIMESTAMPDIFF(YEAR,p.birth,'2018-06-01') > 65
		GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.ht65=t1.lastdiag;


# heavy_weight
UPDATE `me_flu_needs2`  t0
INNER JOIN
(
SELECT pcucodeperson,pid,weight 
FROM visit 
WHERE weight >100
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.heavy_weight=t1.weight;

# pregnancy

UPDATE `me_flu_needs2`  t0
INNER JOIN
(
	SELECT pcucodeperson,pid,concat(TIMESTAMPDIFF(week,visitancpregnancy.lmp,'2018-06-01'),"  " ,"[" ,lmp,"]") as lmp_pregage
	FROM visitancpregnancy 
	HAVING lmp_pregage BETWEEN 16 AND 40
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.gestational_age=t1.lmp_pregage;

#  เด็ก 6 ด  - 2 ปี	

UPDATE `me_flu_needs2`  t0
INNER JOIN
(
	SELECT p.pcucodeperson,p.pid,TIMESTAMPDIFF(MONTH,p.birth,'2018-06-01') as age_month
	FROM person p
	WHERE TIMESTAMPDIFF(MONTH,p.birth,'2018-06-01') BETWEEN 6 AND 35
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.child=t1.age_month;

#  aging

UPDATE `me_flu_needs2`  t0
INNER JOIN
(
	SELECT p.pcucodeperson,p.pid,TIMESTAMPDIFF(YEAR,p.birth,'2018-06-01') as age
	FROM person p
	WHERE TIMESTAMPDIFF(YEAR,p.birth,'2018-06-01') BETWEEN 75 AND 120
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.aging=t1.age;


########################################################## chronic ###########################################################
# COPD 
UPDATE `me_flu_needs2`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
	,SPLIT_STR(GROUP_CONCAT(CAST(c.chroniccode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag DESC SEPARATOR ','),',',1) as lastdiag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE substr(REPLACE(c.chroniccode,'.',''),1,3) BETWEEN 'J44' AND 'J44' 
	GROUP BY p.pcucodeperson,p.pid	
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.copd=t1.lastdiag
WHERE ISNULL(copd);


########################################################## chronic ###########################################################
	

# COPD 
UPDATE `me_flu_needs2`  t0
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
SET t0.copd=t1.lastdiag
WHERE ISNULL(copd);


UPDATE `me_flu_needs2`  t0
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


#IHD

UPDATE `me_flu_needs2`  t0
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


#stroke
UPDATE `me_flu_needs2`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
	,SPLIT_STR(GROUP_CONCAT(CAST(c.chroniccode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag DESC SEPARATOR ','),',',1) as lastdiag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE substr(REPLACE(c.chroniccode,'.',''),1,3) BETWEEN 'I69' AND 'I69' 
	GROUP BY p.pcucodeperson,p.pid	
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.stroke=t1.lastdiag
WHERE ISNULL(stroke);

# renalfailure

UPDATE `me_flu_needs2`  t0
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
WHERE ISNULL(renalfailure);

# DM 
UPDATE `me_flu_needs2`  t0
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
WHERE ISNULL(dm);

# ht65 
UPDATE `me_flu_needs2`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
	,SPLIT_STR(GROUP_CONCAT(CAST(c.chroniccode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag DESC SEPARATOR ','),',',1) as lastdiag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE substr(REPLACE(c.chroniccode,'.',''),1,3) BETWEEN 'I10' AND 'I15' 
	AND TIMESTAMPDIFF(YEAR,p.birth,'2018-06-01') > 65
	GROUP BY p.pcucodeperson,p.pid	
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.ht65=t1.lastdiag
WHERE ISNULL(ht65);

# volanteer 

UPDATE `me_flu_needs2`  t0
INNER JOIN
(
SELECT pcucodeperson,pid,concat(fname,"    " ,lname) as volanteer
FROM person 
) as t1
ON t0.pcucodepersonvola=t1.pcucodeperson AND t0.pidvola=t1.pid 
SET t0.volanteer=t1.volanteer;

# report
select concat(t1.titlename,t0.fname,"    ",t0.lname) as fullname
,t0.birth,t0.age,t0.sex
,t0.hno,substr(t0.moo,2,1) as village
,t0.telephoneperson 
,t0.volanteer 
,t0.copd,t0.asthma,t0.ihd,t0.stroke,t0.renalfailure,t0.dm,t0.ht65 as ht 
,t0.heavy_weight,t0.gestational_age,t0.child,t0.aging  
from	 me_flu_needs2 t0
LEFT JOIN ctitle t1
ON  t0.prename=t1.titlecode
WHERE not ISNULL(copd) 
OR not ISNULL(asthma) 
OR not ISNULL(ihd)
OR not ISNULL(stroke)
OR not ISNULL(renalfailure)
OR not ISNULL(dm)
OR not ISNULL(ht65)
OR not ISNULL(heavy_weight)
OR not ISNULL(gestational_age)
OR not ISNULL(child)
OR not ISNULL(aging)
ORDER BY  moo,(SPLIT_STR(hno,'/', 1)*1),(SPLIT_STR(hno,'/',2)*1)


