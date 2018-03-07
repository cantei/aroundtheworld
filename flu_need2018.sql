DROP TABLE	IF EXISTS `me_flu_needs` ;
		CREATE TABLE `me_flu_needs` (
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
		
INSERT INTO `me_flu_needs` ( pcucodeperson,pid,hcode,prename,fname,lname,birth,sex,idcard,typelive,dischargetype,hno,moo,telephoneperson,pcucodepersonvola,pidvola)
SELECT p.pcucodeperson,p.pid,p.hcode,p.prename,p.fname,p.lname,p.birth,p.sex,p.idcard,p.typelive,p.dischargetype
,h.hno,substr(h.villcode,7,2) as moo
,p.telephoneperson
,h.pcucodepersonvola,h.pidvola
FROM person	 p
INNER JOIN house h 
ON p.pcucodeperson=h.pcucode and	 p.hcode=h.hcode 
WHERE p.typelive in ('1','3') AND p.dischargetype='9';


# หญิงตั้งครรภ์	

UPDATE `me_flu_needs`  t0
INNER JOIN
(
	SELECT pcucodeperson,pid,concat(TIMESTAMPDIFF(week,visitancpregnancy.lmp,'2018-05-01'),"  " ,"[" ,lmp,"]") as lmp_pregage
	FROM visitancpregnancy 
	HAVING lmp_pregage BETWEEN 16 AND 40
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.lmp_pregage=t1.lmp_pregage;



#  เด็ก 6 ด  - 2 ปี	

UPDATE `me_flu_needs`  t0
INNER JOIN
(
	SELECT p.pcucodeperson,p.pid,TIMESTAMPDIFF(MONTH,p.birth,'2018-05-01') as age_month
	FROM person p
	WHERE TIMESTAMPDIFF(MONTH,p.birth,'2018-05-01') BETWEEN 6 AND 35
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.age_month=t1.age_month;
	
########################################################## diag ###########################################################
	
# COPD 

UPDATE `me_flu_needs`  t0
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
		AND TIMESTAMPDIFF(MONTH,p.birth,'2018-05-01') > 65
		GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.copd=t1.lastdiag;


# ASTHMA
UPDATE `me_flu_needs`  t0
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
		AND TIMESTAMPDIFF(MONTH,p.birth,'2018-05-01') > 65
		GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.asthma=t1.lastdiag;

# IHD

UPDATE `me_flu_needs`  t0
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
		AND TIMESTAMPDIFF(MONTH,p.birth,'2018-05-01') > 65
		GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.ihd=t1.lastdiag;


# STROKE 
UPDATE `me_flu_needs`  t0
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
		AND TIMESTAMPDIFF(MONTH,p.birth,'2018-05-01') > 65
		GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.stroke=t1.lastdiag;


# RENAL FAILURE` 
UPDATE `me_flu_needs`  t0
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
		AND TIMESTAMPDIFF(MONTH,p.birth,'2018-05-01') > 65
		GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.renalfailure=t1.lastdiag;

# DM 
UPDATE `me_flu_needs`  t0
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
		AND TIMESTAMPDIFF(MONTH,p.birth,'2018-05-01') > 65
		GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.dm=t1.lastdiag;


########################################################## chronic ###########################################################
	

# COPD 
UPDATE `me_flu_needs`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
	,SPLIT_STR(GROUP_CONCAT(CAST(c.chroniccode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag DESC SEPARATOR ','),',',1) as lastdiag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE TIMESTAMPDIFF(MONTH,p.birth,'2018-05-01') > 65
	AND substr(REPLACE(c.chroniccode,'.',''),1,3) BETWEEN 'J44' AND 'J44' 
	GROUP BY p.pcucodeperson,p.pid	
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.copd=t1.lastdiag
WHERE ISNULL(copd);


# ASTHMA 

UPDATE `me_flu_needs`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
	,SPLIT_STR(GROUP_CONCAT(CAST(c.chroniccode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag DESC SEPARATOR ','),',',1) as lastdiag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE TIMESTAMPDIFF(MONTH,p.birth,'2018-05-01') > 65
	AND substr(REPLACE(c.chroniccode,'.',''),1,3) BETWEEN 'J45' AND 'J45' 
	GROUP BY p.pcucodeperson,p.pid	
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.asthma=t1.lastdiag
WHERE ISNULL(asthma);

		
		
# IHD
UPDATE `me_flu_needs`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
	,SPLIT_STR(GROUP_CONCAT(CAST(c.chroniccode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag DESC SEPARATOR ','),',',1) as lastdiag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE TIMESTAMPDIFF(MONTH,p.birth,'2018-05-01') > 65
	AND substr(REPLACE(c.chroniccode,'.',''),1,3) BETWEEN 'I20' AND 'I25' 
	GROUP BY p.pcucodeperson,p.pid	
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.ihd=t1.lastdiag
WHERE ISNULL(ihd);		
		
		
		
# STROKE
UPDATE `me_flu_needs`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
	,SPLIT_STR(GROUP_CONCAT(CAST(c.chroniccode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag DESC SEPARATOR ','),',',1) as lastdiag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE TIMESTAMPDIFF(MONTH,p.birth,'2018-05-01') > 65
	AND substr(REPLACE(c.chroniccode,'.',''),1,3) BETWEEN 'I64' AND 'I64' 
	GROUP BY p.pcucodeperson,p.pid	
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.stroke=t1.lastdiag
WHERE ISNULL(stroke);



# RENAL FAILURE` 

UPDATE `me_flu_needs`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
	,SPLIT_STR(GROUP_CONCAT(CAST(c.chroniccode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag DESC SEPARATOR ','),',',1) as lastdiag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE TIMESTAMPDIFF(MONTH,p.birth,'2018-05-01') > 65
	AND substr(REPLACE(c.chroniccode,'.',''),1,3) BETWEEN 'N17' AND 'N19' 
	GROUP BY p.pcucodeperson,p.pid	
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.renalfailure=t1.lastdiag
WHERE ISNULL(t0.renalfailure);

# DM 

UPDATE `me_flu_needs`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
	,SPLIT_STR(GROUP_CONCAT(CAST(c.chroniccode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag DESC SEPARATOR ','),',',1) as lastdiag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE TIMESTAMPDIFF(MONTH,p.birth,'2018-05-01') > 65
	AND substr(REPLACE(c.chroniccode,'.',''),1,3) BETWEEN 'E10' AND 'E14' 
	GROUP BY p.pcucodeperson,p.pid	
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.dm=t1.lastdiag
WHERE ISNULL(t0.dm);



# Volanteer 

UPDATE `me_flu_needs`  t0
INNER JOIN
(
SELECT * 
FROM person 
) as t1
ON t0.pcucodepersonvola=t1.pcucodeperson AND t0.pidvola=t1.pid 
SET t0.volanteer=concat(t1.fname,'  ',t1.lname)
