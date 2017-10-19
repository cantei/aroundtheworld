DROP TABLE IF EXISTS `me_tb_acf`;
CREATE TABLE  `me_tb_acf` (
		hospcode VARCHAR(5),
		pid VARCHAR(15),
		hn VARCHAR(15),
		cid VARCHAR(13),
		fname  VARCHAR(30),
		lname  VARCHAR(30),
		birth date,
		sex  VARCHAR(13),
    age int ,
		hno VARCHAR(20),
		villagecode VARCHAR(8),
		dm date,
		ht date,
		hiv date,
		ckd date,
		copd date,
		asthma date,
		silicosis date,
		bmi int(11),
    PRIMARY KEY (hospcode,pid)
);
CREATE INDEX idx_cid
ON me_tb_acf (cid);

INSERT INTO  `me_tb_acf` (hospcode,pid,hn,cid,fname,lname,birth,sex)
SELECT HOSPCODE,PID,HN,CID,`NAME` as FNAME,LNAME,BIRTH,SEX 
FROM person p
WHERE  p.HOSPCODE<>'10727'
AND p.TYPEAREA in ('1','3') 
AND p.DISCHARGE='9';

update me_tb_acf 
SET age=TIMESTAMPDIFF(YEAR,birth,'2017-10-01');

update me_tb_acf t0
inner join 
(
SELECT p.CID
,SPLIT_STR(GROUP_CONCAT(d.DATE_SERV ORDER BY d.date_serv SEPARATOR ','),',',1) as visit 
FROM  person p
LEFT JOIN diagnosis_opd d
ON p.HOSPCODE=d.HOSPCODE AND p.PID=d.PID 
WHERE SUBSTR(d.DIAGCODE,1,3) BETWEEN 'E10' AND 'E14'
GROUP BY p.CID
) as t1
on t0.cid=t1.cid
set t0.dm=t1.visit;


update me_tb_acf t0
inner join 
(
SELECT p.CID
,SPLIT_STR(GROUP_CONCAT(d.DATE_SERV ORDER BY d.date_serv SEPARATOR ','),',',1) as visit 
FROM  person p
LEFT JOIN diagnosis_opd d
ON p.HOSPCODE=d.HOSPCODE AND p.PID=d.PID 
WHERE SUBSTR(d.DIAGCODE,1,3)='N18'
GROUP BY p.CID
) as t1
on t0.cid=t1.cid
set t0.ckd=t1.visit;



update me_tb_acf t0
inner join 
(
SELECT p.CID
,SPLIT_STR(GROUP_CONCAT(d.DATE_SERV ORDER BY d.date_serv SEPARATOR ','),',',1) as visit 
FROM  person p
LEFT JOIN diagnosis_opd d
ON p.HOSPCODE=d.HOSPCODE AND p.PID=d.PID 
WHERE SUBSTR(d.DIAGCODE,1,3)='J44'
GROUP BY p.CID
) as t1
on t0.cid=t1.cid
set t0.copd=t1.visit;

update me_tb_acf t0
inner join 
(
SELECT p.CID
,SPLIT_STR(GROUP_CONCAT(d.DATE_SERV ORDER BY d.date_serv SEPARATOR ','),',',1) as visit 
FROM  person p
LEFT JOIN diagnosis_opd d
ON p.HOSPCODE=d.HOSPCODE AND p.PID=d.PID 
WHERE SUBSTR(d.DIAGCODE,1,3)='J45'
GROUP BY p.CID
) as t1
on t0.cid=t1.cid
set t0.asthma=t1.visit;


update me_tb_acf t0
inner join 
(
SELECT p.CID
,SPLIT_STR(GROUP_CONCAT(d.DATE_SERV ORDER BY d.date_serv SEPARATOR ','),',',1) as visit 
FROM  person p
LEFT JOIN diagnosis_opd d
ON p.HOSPCODE=d.HOSPCODE AND p.PID=d.PID 
WHERE SUBSTR(d.DIAGCODE,1,3)='J62'
GROUP BY p.CID
) as t1
on t0.cid=t1.cid
set t0.silicosis=t1.visit;
