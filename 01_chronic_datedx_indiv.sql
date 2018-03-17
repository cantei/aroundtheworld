# drop table 
	DROP TABLE IF EXISTS `me_chronic_datedx` ;
#create table
		CREATE TABLE `me_chronic_datedx`  (
			`pcucodeperson` char(5) NOT NULL default '',
			`hcode` int(11) NOT NULL,
			`pid` int(11) NOT NULL,
			`idcard` varchar(13) default NULL,
			`prename` varchar(20) default NULL,
			`fname` varchar(25) NOT NULL,
			`lname` varchar(35) default NULL,
			`birth` date default NULL,
			`born` varchar(10) default NULL,
			`age_y` int(11) ,
			`age_m` int(11) ,
			`sex` varchar(1) NOT NULL,
			`typelive` varchar(1) default NULL,
			`dischargetype` varchar(1) default NULL,
			`telephoneperson` varchar(35) default NULL,
			`hno` varchar(75) default NULL,
			`moo` char(2) default NULL,
			`xgis`	varchar(55) default NULL,
			`ygis`	varchar(55) default NULL,
			`pcucodepersonvola` char(5) NOT NULL default '',
			`pidvola` int(11) NOT NULL,
			`volanteer` varchar(100) default NULL,
			`dm`	varchar(55) default NULL,
			`dm_dxdate` varchar(10) default NULL,
			`ht`	varchar(55) default NULL,			
			`ht_dxdate` varchar(10) default NULL,
			`cvd`	varchar(55) default NULL,			
			`cvd_dxdate` varchar(10) default NULL,
			`stroke`	varchar(55) default NULL,			
			`stroke_dxdate` varchar(10) default NULL,
			`ihd`	varchar(55) default NULL,			
			`ihd_dxdate` varchar(10) default NULL,
			`copd`	varchar(55) default NULL,			
			`copd_dxdate` varchar(10) default NULL,
			`asthma`	varchar(55) default NULL,			
			`asthma_dxdate` varchar(10) default NULL,
			`emphysema`	varchar(55) default NULL,			
			`emphysema_dxdate` varchar(10) default NULL,
			`obesity`	varchar(55) default NULL,			
			`obesity_dxdate` varchar(10) default NULL,
			`cancer`	varchar(55) default NULL,
			`cancer_dxdate` varchar(10) default NULL,
			`hiv`	varchar(55) default NULL,			
			`hiv_dxdate` varchar(10) default NULL,
			`cirrhosis`	varchar(55) default NULL,			
			`cirrhosis_dxdate` varchar(10) default NULL,
			`chepatitis`	varchar(55) default NULL,
			`chepatitis_dxdate` varchar(10) default NULL,
			`osteoarthritis`	varchar(55) default NULL,			
			`osteoarthritis_dxdate` varchar(10) default NULL,
			`crheumatoid`	varchar(55) default NULL,			
			`crheumatoid_dxdate` varchar(10) default NULL,
			`crenalfailure`	varchar(55) default NULL,			
			`crenalfailure_dxdate` varchar(10) default NULL
		
		) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# add profile
INSERT INTO `me_chronic_datedx`(pcucodeperson,hcode,pid,idcard,prename,fname,lname,birth,born,age_y,age_m
,sex,typelive,dischargetype,telephoneperson
,hno,moo,xgis,ygis,pcucodepersonvola,pidvola
)
SELECT p.pcucodeperson,p.hcode,p.pid,p.idcard
,t.titlename as prename
,p.fname,p.lname,p.birth
,concat(DATE_FORMAT(p.birth,'%d-%m'),'-',(YEAR(p.birth))+543) as born
				,GetAgeYearNum(p.birth,CURDATE())  as age_y
				,getAgeMonthNum(p.birth,CURDATE())  as age_m
,p.sex
,p.typelive,p.dischargetype,p.telephoneperson
,h.hno,substr(h.villcode,7,2) as moo,h.xgis,h.ygis,h.pcucodepersonvola,h.pidvola
FROM person	 p
LEFT JOIN ctitle t
on	 p.prename=t.titlecode 
INNER JOIN personchronic c
ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
LEFT JOIN house h 
ON p.pcucodeperson=h.pcucode AND p.hcode=h.hcode
WHERE p.typelive in ('1','3')  
AND p.dischargetype='9'
GROUP BY p.pcucodeperson,p.pid;


# add volanteers 
UPDATE `me_chronic_datedx`  t0
INNER JOIN
(
		SELECT m.pcucodepersonvola,m.pidvola,concat(m.fname,'  ',m.lname) as volanteer
		FROM person p
		INNER JOIN me_chronic_datedx m
		ON p.pcucodeperson=m.pcucodepersonvola AND p.pid=m.pidvola 
) as t1
ON t0.pcucodeperson=t1.pcucodepersonvola AND t0.pidvola=t1.pidvola 
SET t0.volanteer=t1.volanteer;


# add DM

UPDATE `me_chronic_datedx`  t0
INNER JOIN
(
	SELECT c.pcucodeperson,c.pid
	,GROUP_CONCAT(c.chroniccode ORDER BY c.datefirstdiag SEPARATOR ',') as diag
	,CONCAT(DATE_FORMAT((SPLIT_STR((GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ',')),',',1)),'%d-%m'),'-'
			,(YEAR((SPLIT_STR((GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ',')),',',1)))+543)
	) as firstdiag 
	FROM  personchronic c
	WHERE substr(REPLACE(chroniccode,'.',''),1,3) BETWEEN 'E10' AND 'E14' 
	GROUP BY c.pcucodeperson,c.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.dm=t1.diag
		,t0.dm_dxdate=t1.firstdiag;


# add HT

UPDATE `me_chronic_datedx`  t0
INNER JOIN
(
	SELECT c.pcucodeperson,c.pid
	,GROUP_CONCAT(c.chroniccode ORDER BY c.datefirstdiag SEPARATOR ',') as diag
	,CONCAT(DATE_FORMAT((SPLIT_STR((GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ',')),',',1)),'%d-%m'),'-'
			,(YEAR((SPLIT_STR((GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ',')),',',1)))+543)
	) as firstdiag 
	FROM  personchronic c
	WHERE substr(REPLACE(chroniccode,'.',''),1,3) BETWEEN 'I10' AND 'I15' 
	GROUP BY c.pcucodeperson,c.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.ht=t1.diag
		,t0.ht_dxdate=t1.firstdiag;		
		
# add CVD

UPDATE `me_chronic_datedx`  t0
INNER JOIN
(
	SELECT c.pcucodeperson,c.pid
	,GROUP_CONCAT(c.chroniccode ORDER BY c.datefirstdiag SEPARATOR ',') as diag
	,CONCAT(DATE_FORMAT((SPLIT_STR((GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ',')),',',1)),'%d-%m'),'-'
			,(YEAR((SPLIT_STR((GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ',')),',',1)))+543)
	) as firstdiag 
	FROM  personchronic c
	WHERE substr(REPLACE(chroniccode,'.',''),1,3) BETWEEN 'I60' AND 'I69' 
	GROUP BY c.pcucodeperson,c.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.cvd=t1.diag
		,t0.cvd_dxdate=t1.firstdiag;		
				
# add stroke

UPDATE `me_chronic_datedx`  t0
INNER JOIN
(
	SELECT c.pcucodeperson,c.pid
	,GROUP_CONCAT(c.chroniccode ORDER BY c.datefirstdiag SEPARATOR ',') as diag
	,CONCAT(DATE_FORMAT((SPLIT_STR((GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ',')),',',1)),'%d-%m'),'-'
			,(YEAR((SPLIT_STR((GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ',')),',',1)))+543)
	) as firstdiag 
	FROM  personchronic c
	WHERE substr(REPLACE(chroniccode,'.',''),1,3) BETWEEN 'I64' AND 'I64' 
	GROUP BY c.pcucodeperson,c.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.stroke=t1.diag
		,t0.stroke_dxdate=t1.firstdiag;		

	# add ihd

UPDATE `me_chronic_datedx`  t0
INNER JOIN
(
	SELECT c.pcucodeperson,c.pid
	,GROUP_CONCAT(c.chroniccode ORDER BY c.datefirstdiag SEPARATOR ',') as diag
	,CONCAT(DATE_FORMAT((SPLIT_STR((GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ',')),',',1)),'%d-%m'),'-'
			,(YEAR((SPLIT_STR((GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ',')),',',1)))+543)
	) as firstdiag 
	FROM  personchronic c
WHERE substr(REPLACE(chroniccode,'.',''),1,3) BETWEEN 'I20' AND 'I25' 
	GROUP BY c.pcucodeperson,c.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.ihd=t1.diag
		,t0.ihd_dxdate=t1.firstdiag;		
	
		
	# add COPD

UPDATE `me_chronic_datedx`  t0
INNER JOIN
(
	SELECT c.pcucodeperson,c.pid
	,GROUP_CONCAT(c.chroniccode ORDER BY c.datefirstdiag SEPARATOR ',') as diag
	,CONCAT(DATE_FORMAT((SPLIT_STR((GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ',')),',',1)),'%d-%m'),'-'
			,(YEAR((SPLIT_STR((GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ',')),',',1)))+543)
	) as firstdiag 
	FROM  personchronic c
	WHERE substr(REPLACE(chroniccode,'.',''),1,4) BETWEEN 'J449' AND 'J449' 
	GROUP BY c.pcucodeperson,c.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.copd=t1.diag
		,t0.copd_dxdate=t1.firstdiag;		

	# add asthma

UPDATE `me_chronic_datedx`  t0
INNER JOIN
(
	SELECT c.pcucodeperson,c.pid
	,GROUP_CONCAT(c.chroniccode ORDER BY c.datefirstdiag SEPARATOR ',') as diag
	,CONCAT(DATE_FORMAT((SPLIT_STR((GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ',')),',',1)),'%d-%m'),'-'
			,(YEAR((SPLIT_STR((GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ',')),',',1)))+543)
	) as firstdiag 
	FROM  personchronic c
	WHERE substr(REPLACE(chroniccode,'.',''),1,3) BETWEEN 'J45' AND 'J46' 
	GROUP BY c.pcucodeperson,c.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.asthma=t1.diag
		,t0.asthma_dxdate=t1.firstdiag;		

		
# add Emphysema        

UPDATE `me_chronic_datedx`  t0
INNER JOIN
(
	SELECT c.pcucodeperson,c.pid
	,GROUP_CONCAT(c.chroniccode ORDER BY c.datefirstdiag SEPARATOR ',') as diag
	,CONCAT(DATE_FORMAT((SPLIT_STR((GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ',')),',',1)),'%d-%m'),'-'
			,(YEAR((SPLIT_STR((GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ',')),',',1)))+543)
	) as firstdiag 
	FROM  personchronic c
	WHERE substr(REPLACE(chroniccode,'.',''),1,3) BETWEEN 'J43' AND 'J43' 
	GROUP BY c.pcucodeperson,c.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.emphysema=t1.diag
		,t0.emphysema_dxdate=t1.firstdiag;		



# add Obesity                      

UPDATE `me_chronic_datedx`  t0
INNER JOIN
(
	SELECT c.pcucodeperson,c.pid
	,GROUP_CONCAT(c.chroniccode ORDER BY c.datefirstdiag SEPARATOR ',') as diag
	,CONCAT(DATE_FORMAT((SPLIT_STR((GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ',')),',',1)),'%d-%m'),'-'
			,(YEAR((SPLIT_STR((GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ',')),',',1)))+543)
	) as firstdiag 
	FROM  personchronic c
	WHERE substr(REPLACE(chroniccode,'.',''),1,3) BETWEEN 'E66' AND 'E66' 
	GROUP BY c.pcucodeperson,c.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.obesity=t1.diag
		,t0.obesity_dxdate=t1.firstdiag;		

# add Cancer  C00 – C97

UPDATE `me_chronic_datedx`  t0
INNER JOIN
(
	SELECT c.pcucodeperson,c.pid
	,GROUP_CONCAT(c.chroniccode ORDER BY c.datefirstdiag SEPARATOR ',') as diag
	,CONCAT(DATE_FORMAT((SPLIT_STR((GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ',')),',',1)),'%d-%m'),'-'
			,(YEAR((SPLIT_STR((GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ',')),',',1)))+543)
	) as firstdiag 
	FROM  personchronic c
	WHERE substr(REPLACE(chroniccode,'.',''),1,3) BETWEEN 'C00' AND 'C97' 
	GROUP BY c.pcucodeperson,c.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.cancer=t1.diag
		,t0.cancer_dxdate=t1.firstdiag;		

		
# add HIV/AIDS

UPDATE `me_chronic_datedx`  t0
INNER JOIN
(
	SELECT c.pcucodeperson,c.pid
	,GROUP_CONCAT(c.chroniccode ORDER BY c.datefirstdiag SEPARATOR ',') as diag
	,CONCAT(DATE_FORMAT((SPLIT_STR((GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ',')),',',1)),'%d-%m'),'-'
			,(YEAR((SPLIT_STR((GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ',')),',',1)))+543)
	) as firstdiag 
	FROM  personchronic c
	WHERE substr(REPLACE(chroniccode,'.',''),1,3) BETWEEN 'B20' AND 'B24' 
	GROUP BY c.pcucodeperson,c.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.hiv=t1.diag
		,t0.hiv_dxdate=t1.firstdiag;		

# add   Cirrhosis of liver  K70.3 ,K71.7,K74

UPDATE `me_chronic_datedx`  t0
INNER JOIN
(
	SELECT c.pcucodeperson,c.pid
	,GROUP_CONCAT(c.chroniccode ORDER BY c.datefirstdiag SEPARATOR ',') as diag
	,CONCAT(DATE_FORMAT((SPLIT_STR((GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ',')),',',1)),'%d-%m'),'-'
			,(YEAR((SPLIT_STR((GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ',')),',',1)))+543)
	) as firstdiag 
	FROM  personchronic c
	WHERE substr(REPLACE(chroniccode,'.',''),1,4) in ('K703','K717') OR substr(REPLACE(chroniccode,'.',''),1,3)='K74'
	GROUP BY c.pcucodeperson,c.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.cirrhosis=t1.diag
		,t0.cirrhosis_dxdate=t1.firstdiag;	

# add   Chronic hepatitis K73
UPDATE `me_chronic_datedx`  t0
INNER JOIN
(
	SELECT c.pcucodeperson,c.pid
	,GROUP_CONCAT(c.chroniccode ORDER BY c.datefirstdiag SEPARATOR ',') as diag
	,CONCAT(DATE_FORMAT((SPLIT_STR((GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ',')),',',1)),'%d-%m'),'-'
			,(YEAR((SPLIT_STR((GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ',')),',',1)))+543)
	) as firstdiag 
	FROM  personchronic c
	WHERE substr(REPLACE(chroniccode,'.',''),1,3)='K73'
	GROUP BY c.pcucodeperson,c.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.chepatitis=t1.diag
		,t0.chepatitis_dxdate=t1.firstdiag;	


# add    Chronic Renal failure  N18
UPDATE `me_chronic_datedx`  t0
INNER JOIN
(
	SELECT c.pcucodeperson,c.pid
	,GROUP_CONCAT(c.chroniccode ORDER BY c.datefirstdiag SEPARATOR ',') as diag
	,CONCAT(DATE_FORMAT((SPLIT_STR((GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ',')),',',1)),'%d-%m'),'-'
			,(YEAR((SPLIT_STR((GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ',')),',',1)))+543)
	) as firstdiag 
	FROM  personchronic c
	WHERE substr(REPLACE(chroniccode,'.',''),1,3)='N18'
	GROUP BY c.pcucodeperson,c.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.crenalfailure=t1.diag
		,t0.crenalfailure_dxdate=t1.firstdiag;	
		

# add    Osteoarthritis      
UPDATE `me_chronic_datedx`  t0
INNER JOIN
(
	SELECT c.pcucodeperson,c.pid
	,GROUP_CONCAT(c.chroniccode ORDER BY c.datefirstdiag SEPARATOR ',') as diag
	,CONCAT(DATE_FORMAT((SPLIT_STR((GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ',')),',',1)),'%d-%m'),'-'
			,(YEAR((SPLIT_STR((GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ',')),',',1)))+543)
	) as firstdiag 
	FROM  personchronic c
	WHERE (substr(REPLACE(chroniccode,'.',''),1,3) BETWEEN 'M15' AND 'M19')  OR (substr(REPLACE(chroniccode,'.',''),1,3)='K74')
	GROUP BY c.pcucodeperson,c.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.osteoarthritis=t1.diag
		,t0.osteoarthritis_dxdate=t1.firstdiag;	
		
# add     Rheumatoid arthritis   M05 – M06			
UPDATE `me_chronic_datedx`  t0
INNER JOIN
(
	SELECT c.pcucodeperson,c.pid
	,GROUP_CONCAT(c.chroniccode ORDER BY c.datefirstdiag SEPARATOR ',') as diag
	,CONCAT(DATE_FORMAT((SPLIT_STR((GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ',')),',',1)),'%d-%m'),'-'
			,(YEAR((SPLIT_STR((GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY  c.datefirstdiag ASC SEPARATOR ',')),',',1)))+543)
	) as firstdiag 
	FROM  personchronic c
	WHERE (substr(REPLACE(chroniccode,'.',''),1,3) BETWEEN 'M105' AND 'M06')  
	GROUP BY c.pcucodeperson,c.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.osteoarthritis=t1.diag
		,t0.osteoarthritis_dxdate=t1.firstdiag;		
