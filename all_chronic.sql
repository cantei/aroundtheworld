# drop table 
	DROP TABLE IF EXISTS `tmp_chronic_all` ;
#create table
		CREATE TABLE `tmp_chronic_all` (
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
			`hnomoi` varchar(75) default NULL,
			`roadmoi` varchar(50) default NULL,
			`mumoi` char(2) default NULL,
			`telephoneperson` varchar(35) default NULL,
			`volanteer` varchar(100) default NULL,
			`dm` date default NULL,
			`ht` date default NULL,
			`cvd` date default NULL,
			`stroke` date default NULL,
			`ihd` date default NULL,
			`copd` date default NULL,
			`asthma` date default NULL,
			`emphysema` date default NULL,
			`obesity` date default NULL,
			`cancer` date default NULL,
			`hiv` date default NULL,
			`cirrhosis` date default NULL,
			`chepatitis` date default NULL,
			`osteoarthritis` date default NULL,
			`crheumatoid` date default NULL,
			`crenalfailure` date default NULL
		) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# add profile 
INSERT INTO `tmp_chronic_all` ( pcucodeperson,pid,hcode,prename,fname,lname,birth,sex,idcard,typelive,dischargetype,hnomoi,roadmoi,mumoi,telephoneperson)
SELECT p.pcucodeperson,p.pid,p.hcode,p.prename,p.fname,p.lname,p.birth,p.sex,p.idcard,p.typelive,p.dischargetype,p.hnomoi,p.roadmoi,p.mumoi,p.telephoneperson
FROM person	 p
WHERE p.typelive in ('1','3') AND 
EXISTS 
	(
		SELECT * FROM personchronic c WHERE p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid
	);

#  add volanteer 
UPDATE tmp_chronic_all  t0
INNER JOIN
(
		SELECT t.*,h.pcucodepersonvola,h.pidvola
		,concat(p.fname, '  ',p.lname) as volanteers
		FROM tmp_chronic_all t 
		INNER JOIN house h
		ON t.pcucodeperson=h.pcucodeperson AND t.hcode=h.hcode
		LEFT JOIN person p
		ON h.pcucodepersonvola=p.pcucodeperson AND h.pidvola=p.pid 
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.volanteer=t1.volanteers;

# add DM
UPDATE tmp_chronic_all  t0
INNER JOIN
(
	SELECT p.pcucodeperson,p.pid
	,SPLIT_STR(GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag DESC SEPARATOR ','),',',1) as datediag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE substr(REPLACE(chroniccode,'.',''),1,3) BETWEEN 'E10' AND 'E14' 
	GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.dm=t1.datediag;


# add HT
UPDATE tmp_chronic_all  t0
INNER JOIN
(
	SELECT p.pcucodeperson,p.pid
	,SPLIT_STR(GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag DESC SEPARATOR ','),',',1) as datediag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE substr(REPLACE(chroniccode,'.',''),1,3) BETWEEN 'I10' AND 'I15' 
	GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.ht=t1.datediag;


# add CVD
UPDATE tmp_chronic_all  t0
INNER JOIN
(
	SELECT p.pcucodeperson,p.pid
	,SPLIT_STR(GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag DESC SEPARATOR ','),',',1) as datediag  
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE substr(REPLACE(chroniccode,'.',''),1,3) BETWEEN 'I60' AND 'I69' 
	GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.cvd=t1.datediag;


# add stroke
UPDATE tmp_chronic_all  t0
INNER JOIN
(
	SELECT p.pcucodeperson,p.pid
	,SPLIT_STR(GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag DESC SEPARATOR ','),',',1) as datediag  
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE substr(REPLACE(chroniccode,'.',''),1,3) BETWEEN 'I64' AND 'I64' 
	GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.stroke=t1.datediag;

# add ihd
UPDATE tmp_chronic_all  t0
INNER JOIN
(
	SELECT p.pcucodeperson,p.pid
	,SPLIT_STR(GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag DESC SEPARATOR ','),',',1) as datediag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE substr(REPLACE(chroniccode,'.',''),1,3) BETWEEN 'I20' AND 'I25' 
	GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.ihd=t1.datediag;

# add copd
UPDATE tmp_chronic_all  t0
INNER JOIN
(
	SELECT p.pcucodeperson,p.pid
	,SPLIT_STR(GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag DESC SEPARATOR ','),',',1) as datediag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE substr(REPLACE(chroniccode,'.',''),1,4) BETWEEN 'J449' AND 'J449' 
	GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.copd=t1.datediag;

# add Asthma 
UPDATE tmp_chronic_all  t0
INNER JOIN
(
	SELECT p.pcucodeperson,p.pid
	,SPLIT_STR(GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag DESC SEPARATOR ','),',',1) as datediag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE substr(REPLACE(chroniccode,'.',''),1,3) BETWEEN 'J45' AND 'J46' 
	GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.asthma=t1.datediag;



# add Emphysema        J43
UPDATE tmp_chronic_all  t0
INNER JOIN
(
	SELECT p.pcucodeperson,p.pid
	,SPLIT_STR(GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag DESC SEPARATOR ','),',',1) as datediag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE substr(REPLACE(chroniccode,'.',''),1,3) BETWEEN 'J43' AND 'J43' 
	GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.emphysema=t1.datediag;


# add Obesity              E66
UPDATE tmp_chronic_all  t0
INNER JOIN
(
	SELECT p.pcucodeperson,p.pid
	,SPLIT_STR(GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag DESC SEPARATOR ','),',',1) as datediag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE substr(REPLACE(chroniccode,'.',''),1,3) BETWEEN 'E66' AND 'E66' 
	GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.obesity=t1.datediag;

# add Cancer  C00 – C97
UPDATE tmp_chronic_all  t0
INNER JOIN
(
	SELECT p.pcucodeperson,p.pid
	,SPLIT_STR(GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag DESC SEPARATOR ','),',',1) as datediag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE substr(REPLACE(chroniccode,'.',''),1,3) BETWEEN 'C00' AND 'C97' 
	GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.cancer=t1.datediag;



# add  HIV/AIDS           B20 – B24
UPDATE tmp_chronic_all  t0
INNER JOIN
(
	SELECT p.pcucodeperson,p.pid
	,SPLIT_STR(GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag DESC SEPARATOR ','),',',1) as datediag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE substr(REPLACE(chroniccode,'.',''),1,3) BETWEEN 'B20' AND 'B24' 
	GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.hiv=t1.datediag;



# add   Cirrhosis of liver  K70.3 ,K71.7,K74
UPDATE tmp_chronic_all  t0
INNER JOIN
(

	SELECT p.pcucodeperson,p.pid
	,SPLIT_STR(GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag DESC SEPARATOR ','),',',1) as datediag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE substr(REPLACE(chroniccode,'.',''),1,4) in ('K703','K717') OR substr(REPLACE(chroniccode,'.',''),1,3)='K74'
	GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.cirrhosis=t1.datediag;

# add   Chronic hepatitis K73
UPDATE tmp_chronic_all  t0
INNER JOIN
(
	SELECT p.pcucodeperson,p.pid
	,SPLIT_STR(GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag DESC SEPARATOR ','),',',1) as datediag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE substr(REPLACE(chroniccode,'.',''),1,3)='K73'
	GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.chepatitis=t1.datediag;

# add    Chronic Renal failure  N18

UPDATE tmp_chronic_all  t0
INNER JOIN
(
	SELECT p.pcucodeperson,p.pid
	,SPLIT_STR(GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag DESC SEPARATOR ','),',',1) as datediag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE substr(REPLACE(chroniccode,'.',''),1,3)='N18'
	GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.crenalfailure =t1.datediag;


# add    Osteoarthritis      M15-M19,M47

UPDATE tmp_chronic_all  t0
INNER JOIN
(
	SELECT p.pcucodeperson,p.pid
	,SPLIT_STR(GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag DESC SEPARATOR ','),',',1) as datediag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE (substr(REPLACE(chroniccode,'.',''),1,3) BETWEEN 'M15' AND 'M19')  OR (substr(REPLACE(chroniccode,'.',''),1,3)='K74')
	GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.osteoarthritis=t1.datediag;

# add     Rheumatoid arthritis   M05 – M06

UPDATE tmp_chronic_all  t0
INNER JOIN
(
	SELECT p.pcucodeperson,p.pid
	,SPLIT_STR(GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag DESC SEPARATOR ','),',',1) as datediag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE (substr(REPLACE(chroniccode,'.',''),1,3) BETWEEN 'M105' AND 'M06')  
	GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.crheumatoid=t1.datediag;

###### Report 
SELECT idcard,dm,CASE WHEN dm IS NOT NULL 
THEN concat(DATE_FORMAT(dm,'%d-%M'),'-',(year(dm)+543))
ELSE NULL
END AS date_dm
FROM tmp_chronic_all
ORDER BY (mumoi*1),(SPLIT_STR(hnomoi,'/', 1)*1),(SPLIT_STR(hnomoi,'/',2)*1);
