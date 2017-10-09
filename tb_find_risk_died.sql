CREATE TABLE me_tb_cc (
    be int NOT NULL,
    tb_id int NOT NULL,
    age int NOT NULL,
		dm date,
		ht date,
		hiv date,
		ckd date,
		copd date,
		asthma date,
    PRIMARY KEY (be,tb_id);
);

INSERT INTO me_tb_cc (be,tb_id)
SELECT be,tb_id FROM me_tb_reg ;

-- AGE  (NOT FOUND HN in PERSON 172 case)
update me_tb_cc t0
inner join 
(
SELECT t.be,t.tb_id,t.hn
,DATE_FORMAT(t.date_reg,'%Y-%m-%d') as date_start
,p.BIRTH
,TIMESTAMPDIFF(YEAR,p.BIRTH,DATE_FORMAT(t.date_reg,'%Y-%m-%d')) as age
FROM me_tb_reg t
INNER JOIN person p
ON concat('0',t.hn)=p.hn 
WHERE p.HOSPCODE='10727'
) t1 
on t0.be = t1.be AND t0.tb_id=t1.tb_id 
set t0.age=t1.age;

-- DM 
update me_tb_cc t0
inner join 
(
SELECT t.be,t.tb_id,tbno
,p.CID,p.birth
,SPLIT_STR(GROUP_CONCAT(d.DATE_SERV ORDER BY d.date_serv SEPARATOR ','),',',1) as visit 
FROM me_tb_reg t
LEFT JOIN person p
ON CONCAT('0',t.hn)=p.HN 
LEFT JOIN diagnosis_opd d
ON p.HOSPCODE=d.HOSPCODE AND p.PID=d.PID 
WHERE p.HOSPCODE='10727'
AND SUBSTR(d.DIAGCODE,1,3) BETWEEN 'E10' AND 'E14'
GROUP BY t.be,t.tb_id
) t1 
on t0.be = t1.be AND t0.tb_id=t1.tb_id 
set t0.dm=t1.visit;

-- HT 
update me_tb_cc t0
inner join 
(
SELECT t.be,t.tb_id,tbno
,p.CID,p.birth
,SPLIT_STR(GROUP_CONCAT(d.DATE_SERV ORDER BY d.date_serv SEPARATOR ','),',',1) as visit 
FROM me_tb_reg t
LEFT JOIN person p
ON CONCAT('0',t.hn)=p.HN 
LEFT JOIN diagnosis_opd d
ON p.HOSPCODE=d.HOSPCODE AND p.PID=d.PID 
WHERE p.HOSPCODE='10727'
AND SUBSTR(d.DIAGCODE,1,3) BETWEEN 'I10' AND 'I15'
GROUP BY t.be,t.tb_id
) t1 
on t0.be = t1.be AND t0.tb_id=t1.tb_id 
set t0.ht=t1.visit;


-- HIV
update me_tb_cc t0
inner join 
(
SELECT t.be,t.tb_id,tbno
,p.CID,p.birth
,SPLIT_STR(GROUP_CONCAT(d.DATE_SERV ORDER BY d.date_serv SEPARATOR ','),',',1) as visit 
FROM me_tb_reg t
LEFT JOIN person p
ON CONCAT('0',t.hn)=p.HN 
LEFT JOIN diagnosis_opd d
ON p.HOSPCODE=d.HOSPCODE AND p.PID=d.PID 
WHERE p.HOSPCODE='10727'
AND SUBSTR(d.DIAGCODE,1,3) BETWEEN 'B20' AND 'B24'
GROUP BY t.be,t.tb_id
) t1 
on t0.be = t1.be AND t0.tb_id=t1.tb_id 
set t0.hiv=t1.visit;

-- CKD
update me_tb_cc t0
inner join 
(
SELECT t.be,t.tb_id,tbno
,p.CID,p.birth
,SPLIT_STR(GROUP_CONCAT(d.DATE_SERV ORDER BY d.date_serv SEPARATOR ','),',',1) as visit 
FROM me_tb_reg t
LEFT JOIN person p
ON CONCAT('0',t.hn)=p.HN 
LEFT JOIN diagnosis_opd d
ON p.HOSPCODE=d.HOSPCODE AND p.PID=d.PID 
WHERE p.HOSPCODE='10727'
AND SUBSTR(d.DIAGCODE,1,3)='N18'
GROUP BY t.be,t.tb_id
) t1 
on t0.be = t1.be AND t0.tb_id=t1.tb_id 
set t0.ckd=t1.visit;

-- COPD
update me_tb_cc t0
inner join 
(
SELECT t.be,t.tb_id,tbno
,p.CID,p.birth
,SPLIT_STR(GROUP_CONCAT(d.DATE_SERV ORDER BY d.date_serv SEPARATOR ','),',',1) as visit 
FROM me_tb_reg t
LEFT JOIN person p
ON CONCAT('0',t.hn)=p.HN 
LEFT JOIN diagnosis_opd d
ON p.HOSPCODE=d.HOSPCODE AND p.PID=d.PID 
WHERE p.HOSPCODE='10727'
AND SUBSTR(d.DIAGCODE,1,3)='J44'
GROUP BY t.be,t.tb_id
) t1 
on t0.be = t1.be AND t0.tb_id=t1.tb_id 
set t0.copd=t1.visit;


-- ASTHMA
update me_tb_cc t0
inner join 
(
SELECT t.be,t.tb_id,tbno
,p.CID,p.birth
,SPLIT_STR(GROUP_CONCAT(d.DATE_SERV ORDER BY d.date_serv SEPARATOR ','),',',1) as visit 
FROM me_tb_reg t
LEFT JOIN person p
ON CONCAT('0',t.hn)=p.HN 
LEFT JOIN diagnosis_opd d
ON p.HOSPCODE=d.HOSPCODE AND p.PID=d.PID 
WHERE p.HOSPCODE='10727'
AND SUBSTR(d.DIAGCODE,1,3)='J45'
GROUP BY t.be,t.tb_id
) t1 
on t0.be = t1.be AND t0.tb_id=t1.tb_id 
set t0.asthma=t1.visit;

# report 
SELECT  t.be,t.tb_id,t.hn
,t1.age,t1.dm,t1.ht,t1.hiv,t1.ckd,t1.copd,t1.asthma 
,t.outcomes
FROM me_tb_reg t
LEFT JOIN me_tb_cc t1
ON t.be=t1.be AND t.tb_id=t1.tb_id 
WHERE t.outcomes='Died' 
AND t.age > 60
