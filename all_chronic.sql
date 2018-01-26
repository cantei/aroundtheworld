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
			`copd` date default NULL,
			`renalfailure` date default NULL
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
	,SPLIT_STR(GROUP_CONCAT(c.datefirstdiag ORDER BY c.datefirstdiag SEPARATOR ','),',',1) as datediag 
	FROM  person p
	LEFT JOIN personchronic c
	ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
	WHERE substr(REPLACE(chroniccode,'.',''),1,3) BETWEEN 'E10' AND 'E14' 
	GROUP BY p.pcucodeperson,p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.dm=t1.datediag;

