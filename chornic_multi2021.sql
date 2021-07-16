
DROP TABLE	IF EXISTS `me_chronic_multidisease` ;
		CREATE TABLE `me_chronic_multidisease` (
			`pcucodeperson` char(5) NOT NULL default '',
			`pid` int(11) NOT NULL,
			`hcode` int(11) NOT NULL,
			`titlename` varchar(20) default NULL,
			`fname` varchar(25) NOT NULL,
			`lname` varchar(35) default NULL,
			`fullname` varchar(50) default NULL,
			`birth` date default NULL,
			`idcard` varchar(13) default NULL,
			`sex` varchar(5) NOT NULL,
			`age` int(11) NOT NULL,
			`typelive` varchar(1) default NULL,
			`dischargetype` varchar(1) default NULL,
			`hno` varchar(75) default NULL,
			`village` varchar(8) default NULL,
			`houseowner` varchar(50) default NULL,
			`volunteer` varchar(100) default NULL,
			`telephoneperson` varchar(35) default NULL,
			`bmi` int(3) default NULL,
			`bw` int(3) default NULL,
			
			`crd_c` varchar(30) default NULL,  /* J44,J45 */
			`cvd_c` varchar(30) default NULL,   /* I05-I09 ,I20-I28 */
			`ckd_c` varchar(30) default NULL,     /* N18 */
			`stroke_c` varchar(30) default NULL,	 /* I60-I69  */
			`obesity_c` varchar(30) default NULL,	 /* E66  */
			`cancer_c` varchar(30) default NULL,	 /*  C00-C97 */
			`dm_c` varchar(30) default NULL,		 /* E10-E14  */
			
			`crd_d` varchar(30) default NULL,
			`cvd_d` varchar(30) default NULL,
			`ckd_d` varchar(30) default NULL,
			`stroke_d` varchar(30) default NULL,
			`obesity_d` varchar(30) default NULL,
			`cancer_d` varchar(30) default NULL,
			`dm_d` varchar(30) default NULL,
			`covid1` varchar(10) default NULL,
			`covid2` varchar(10) default NULL,
			`covid_appoint` varchar(50) default NULL,
			`str_flu_visit` varchar(100) default NULL
			
		) ENGINE=InnoDB DEFAULT CHARSET=utf8;
		

# person 
INSERT INTO `me_chronic_multidisease` ( pcucodeperson,pid,hcode,titlename,fname,lname,fullname,idcard,birth,sex,age,typelive,hno,village,houseowner,volunteer,telephoneperson)
SELECT p.pcucodeperson,p.pid,p.hcode
,c.titlename,p.fname,p.lname,concat(c.titlename,p.fname,'   ',p.lname) as fullname
,p.idcard,p.birth
,if(p.sex='1','ชาย','หญิง') as sex
,getAgeYearNum(p.birth,CURDATE()) as age
,p.typelive
,h.hno,substr(h.villcode,8,1) as village 
,concat(ho.fname,'   ',ho.lname) as houseowner
,concat(hv.fname,'   ',hv.lname) as volunteer
,p.telephoneperson
FROM	 person p
INNER JOIN ctitle c
ON p.prename=c.titlecode 
left join house h
ON  h.pcucode=p.pcucodeperson AND h.hcode=p.hcode 
left join  person  ho
ON	h.pcucode=ho.pcucodeperson AND h.pid=ho.pid 
left join  person  hv
ON	h.pcucode=hv.pcucodeperson AND h.pidvola=hv.pid 
WHERE p.typelive in ('1','3') AND p.dischargetype='9';




########################################################## chronic ###########################################################
	

# chronic respiratory disease  (COPD & ASTHMA)
UPDATE `me_chronic_multidisease`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
	,GROUP_CONCAT(c.chroniccode ORDER BY  c.datefirstdiag DESC SEPARATOR ',') as diag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE  substr(REPLACE(c.chroniccode,'.',''),1,3) BETWEEN 'J44' AND 'J45' 
	GROUP BY p.pcucodeperson,p.pid	
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.crd_c=t1.diag
WHERE ISNULL(crd_c);



# chronic vascular disease  
UPDATE `me_chronic_multidisease`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
	,GROUP_CONCAT(c.chroniccode ORDER BY  c.datefirstdiag DESC SEPARATOR ',') as diag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE  (substr(REPLACE(c.chroniccode,'.',''),1,3) BETWEEN 'I05' AND 'I09'  OR substr(REPLACE(c.chroniccode,'.',''),1,3) BETWEEN 'I20' AND 'I28' )
	GROUP BY p.pcucodeperson,p.pid	
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.cvd_c=t1.diag
WHERE ISNULL(cvd_c);



# chronic kidney  disease  
UPDATE `me_chronic_multidisease`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
	,GROUP_CONCAT(c.chroniccode ORDER BY  c.datefirstdiag DESC SEPARATOR ',') as diag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE  substr(REPLACE(c.chroniccode,'.',''),1,3) BETWEEN 'N18' AND 'N18'  
	GROUP BY p.pcucodeperson,p.pid	
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.ckd_c=t1.diag
WHERE ISNULL(ckd_c);


# stroke  
UPDATE `me_chronic_multidisease`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
	,GROUP_CONCAT(c.chroniccode ORDER BY  c.datefirstdiag DESC SEPARATOR ',') as diag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE  substr(REPLACE(c.chroniccode,'.',''),1,3) BETWEEN 'I60' AND 'I69'  
	GROUP BY p.pcucodeperson,p.pid	
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.stroke_c=t1.diag
WHERE ISNULL(stroke_c);



# obesity  
UPDATE `me_chronic_multidisease`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
	,GROUP_CONCAT(c.chroniccode ORDER BY  c.datefirstdiag DESC SEPARATOR ',') as diag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE  substr(REPLACE(c.chroniccode,'.',''),1,3) BETWEEN 'E66' AND 'E66'  
	GROUP BY p.pcucodeperson,p.pid	
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.obesity_c=t1.diag
WHERE ISNULL(obesity_c);


# DM  
UPDATE `me_chronic_multidisease`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
	,GROUP_CONCAT(c.chroniccode ORDER BY  c.datefirstdiag DESC SEPARATOR ',') as diag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE  substr(REPLACE(c.chroniccode,'.',''),1,3) BETWEEN 'E10' AND 'E14'  
	GROUP BY p.pcucodeperson,p.pid	
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.dm_c=t1.diag
WHERE ISNULL(dm_c);

		
	
########################################################## diag ###########################################################
	
# chronic respiratory disease  (COPD & ASTHMA)

UPDATE `me_chronic_multidisease`  t0
INNER JOIN
(
		SELECT p.pcucodeperson,p.pid
		,substring_index(group_concat(d.diagcode ORDER BY v.visitdate DESC  SEPARATOR ','), ',', 5) as diag
		FROM person p
		INNER JOIN visit v
		ON	 p.pcucodeperson=v.pcucodeperson AND p.pid=v.pid 
		INNER JOIN visitdiag d 
		ON v.pcucode=d.pcucode AND v.visitno=d.visitno 
		WHERE p.typelive in ('1','3') 
		AND p.dischargetype='9'
		AND 	 substr(d.diagcode,1,3) BETWEEN 'J44' AND 'J45'
		GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.crd_d=t1.diag;


# chronic vascular disease  
UPDATE `me_chronic_multidisease`  t0
INNER JOIN
(
		SELECT p.pcucodeperson,p.pid
			,substring_index(group_concat(d.diagcode ORDER BY v.visitdate DESC  SEPARATOR ','), ',', 5) as diag
		FROM person p
		INNER JOIN visit v
		ON	 p.pcucodeperson=v.pcucodeperson AND p.pid=v.pid 
		INNER JOIN visitdiag d 
		ON v.pcucode=d.pcucode AND v.visitno=d.visitno 
		WHERE p.typelive in ('1','3') 
		AND p.dischargetype='9'
		AND 	( substr(d.diagcode,1,3) BETWEEN 'I05' AND 'I09'  OR  substr(d.diagcode,1,3) BETWEEN 'I20' AND 'I28')
		GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.cvd_d=t1.diag;


# chronic kidney  disease  
UPDATE `me_chronic_multidisease`  t0
INNER JOIN
(
		SELECT p.pcucodeperson,p.pid
			,substring_index(group_concat(d.diagcode ORDER BY v.visitdate DESC  SEPARATOR ','), ',', 5) as diag
		FROM person p
		INNER JOIN visit v
		ON	 p.pcucodeperson=v.pcucodeperson AND p.pid=v.pid 
		INNER JOIN visitdiag d 
		ON v.pcucode=d.pcucode AND v.visitno=d.visitno 
		WHERE p.typelive in ('1','3') 
		AND p.dischargetype='9'
		AND 	 substr(d.diagcode,1,3) BETWEEN 'N18' AND 'N18'
		GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.ckd_d=t1.diag;


# stroke  
UPDATE `me_chronic_multidisease`  t0
INNER JOIN
(
		SELECT p.pcucodeperson,p.pid
			,substring_index(group_concat(d.diagcode ORDER BY v.visitdate DESC  SEPARATOR ','), ',', 5) as diag
		FROM person p
		INNER JOIN visit v
		ON	 p.pcucodeperson=v.pcucodeperson AND p.pid=v.pid 
		INNER JOIN visitdiag d 
		ON v.pcucode=d.pcucode AND v.visitno=d.visitno 
		WHERE p.typelive in ('1','3') 
		AND p.dischargetype='9'
		AND 	 substr(d.diagcode,1,3) BETWEEN 'I69' AND 'I69'
		GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.cvd_d=t1.diag;



# obesity  
UPDATE `me_chronic_multidisease`  t0
INNER JOIN
(
		SELECT p.pcucodeperson,p.pid
			,substring_index(group_concat(d.diagcode ORDER BY v.visitdate DESC  SEPARATOR ','), ',', 5) as diag
		FROM person p
		INNER JOIN visit v
		ON	 p.pcucodeperson=v.pcucodeperson AND p.pid=v.pid 
		INNER JOIN visitdiag d 
		ON v.pcucode=d.pcucode AND v.visitno=d.visitno 
		WHERE p.typelive in ('1','3') 
		AND p.dischargetype='9'
		AND 	 substr(d.diagcode,1,3) BETWEEN 'E66' AND 'E66'
		GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.obesity_d=t1.diag;


#DM
UPDATE `me_chronic_multidisease`  t0
INNER JOIN
(
		SELECT p.pcucodeperson,p.pid
		,substring_index(group_concat(d.diagcode ORDER BY v.visitdate DESC  SEPARATOR ','), ',', 5) as diag
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
SET t0.dm_d=t1.diag;

# BMI & BW

# BMI & BW
UPDATE `me_chronic_multidisease`  t0
INNER JOIN
(
	SELECT  pcucode,pid,screen_date
	,substring_index(group_concat(screen_date ORDER BY screen_date DESC  SEPARATOR ','), ',', 1) as visit
	,(substring_index(group_concat(height ORDER BY screen_date DESC  SEPARATOR ','), ',', 1)/100) as height
	,(substring_index(group_concat(weight ORDER BY screen_date DESC  SEPARATOR ','), ',', 1)) as weight
	-- ,substring_index(group_concat(bmi ORDER BY screen_date DESC  SEPARATOR ','), ',', 1) as bmi
	,ROUND((substring_index(group_concat(weight ORDER BY screen_date DESC  SEPARATOR ','), ',', 1)) /((substring_index(group_concat(height ORDER BY screen_date DESC  SEPARATOR ','), ',', 1)/100)*(substring_index(group_concat(height ORDER BY screen_date DESC  SEPARATOR ','), ',', 1)/100)),2) as bmi
	FROM ncd_person_ncd_screen
	WHERE screen_date > '2020-09-30'
	GROUP BY pid 
) as t1
ON t0.pcucodeperson=t1.pcucode AND t0.pid=t1.pid 
SET t0.bw=t1.weight,t0.bmi=t1.bmi;

# flu visit

UPDATE `me_chronic_multidisease`  t0
INNER JOIN
(
		SELECT pcucodeperson,pid
		 ,GROUP_CONCAT(DISTINCT CONVERT( dateepi USING utf8) ORDER BY dateepi DESC ) as str_flu_visit
		FROM visitepi 
		WHERE vaccinecode='FLU'
		GROUP BY pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.str_flu_visit=t1.str_flu_visit;
