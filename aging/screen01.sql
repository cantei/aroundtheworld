DROP TABLE	IF EXISTS `me_sreen_aging` ;
CREATE TABLE `me_sreen_aging` (
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
		`dm_chronic` varchar(100) default NULL,
		`ht_Chronic` varchar(100) default NULL,
		`dm_screen` varchar(100) default NULL,
		`ht_screen` varchar(100) default NULL,
		`cvd_screen` varchar(100) default NULL,				
		-- การได้ยิน
		`1B114X` varchar(100) default NULL,
		`1B1141` varchar(100) default NULL,
		`1B1142` varchar(100) default NULL,
		`1B1143` varchar(100) default NULL,
		`1B1149` varchar(100) default NULL,
		-- ช่องปาก	
		`1B1260` varchar(100) default NULL,
		`1B1261` varchar(100) default NULL,
		-- การมองเห็น
		`1B1250` varchar(100) default NULL,
		`1B1251` varchar(100) default NULL,
		`1B1252` varchar(100) default NULL,
		`1B1253` varchar(100) default NULL,
		`1B1254` varchar(100) default NULL,
		`1B1255` varchar(100) default NULL,
		`1B1256` varchar(100) default NULL,
		`1B1257` varchar(100) default NULL,
		`1B1258` varchar(100) default NULL,
		-- ข้อเข่าเสื่อม
		`1B1270` varchar(100) default NULL,
		`1B1271` varchar(100) default NULL,
		`1B1272` varchar(100) default NULL,
		-- สมอง
		`1B1220` varchar(100) default NULL,
		`1B1221` varchar(100) default NULL,	
		`1B1223` varchar(100) default NULL,
		`1B1224` varchar(100) default NULL,			
		`1B1225` varchar(100) default NULL,
		`1B1226` varchar(100) default NULL,						
		-- ซึมเศร้า
		`1B0280` varchar(100) default NULL,
		`1B0281` varchar(100) default NULL,
		`1B0282` varchar(100) default NULL,
		`1B0283` varchar(100) default NULL,
		`1B0284` varchar(100) default NULL,
		`1B0285` varchar(100) default NULL,

		-- หกล้ม 
		`1B1200` varchar(100) default NULL,
		`1B1201` varchar(100) default NULL,
		`1B1202` varchar(100) default NULL,
		-- กิจวัตรประจำวัน
		`1B1280` varchar(100) default NULL,
		`1B1281` varchar(100) default NULL,
		`1B1282` varchar(100) default NULL,

		-- else 
		`1B0030` varchar(100) default NULL,  /* ตรวจคัดกรองได้ผลปกติ ผู้รับบริการเคยตรวจด้วยตนเองได้ผลปกติ (Z123)  */
		`1B1230` varchar(100) default NULL,  /* การตรวจคัดกรองความเสี่ยงโรคหัวใจและหลอดเลือดสมองในผู้สูงอายุ พบว่าไม่มีความเสี่ยง (Z136)  */

INDEX `vola_idx` (`pcucodepersonvola`,`pidvola`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `me_sreen_aging` ( pcucodeperson,pid,hcode,prename,fname,lname,birth,sex,idcard,typelive,dischargetype,hno,moo,telephoneperson,pcucodepersonvola,pidvola)
SELECT p.pcucodeperson,p.pid,p.hcode,p.prename,p.fname,p.lname,p.birth,p.sex,p.idcard,p.typelive,p.dischargetype
,h.hno,substr(h.villcode,7,2) as moo
,p.telephoneperson
,h.pcucodepersonvola,h.pidvola
FROM person	 p
INNER JOIN house h 
ON p.pcucodeperson=h.pcucode and	 p.hcode=h.hcode 
WHERE p.typelive in ('1','3') 
AND p.dischargetype='9'
AND getAgeYearNum(p.birth,'2020-10-01') >60;

-- การได้ยิน

UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B114'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B114X`=t1.visits;

UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B1141'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B1141`=t1.visits;


UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B1142'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B1142`=t1.visits;

UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B1143'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B1143`=t1.visits;

UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B1149'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B1149`=t1.visits;


-- ช่องปาก	

UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B1260'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B1260`=t1.visits;

UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B1261'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B1261`=t1.visits;


-- การมองเห็น


UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B1250'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B1250`=t1.visits;



UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B1251'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B1251`=t1.visits;


UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B1252'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B1252`=t1.visits;



UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B1253'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B1253`=t1.visits;

UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B1254'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B1254`=t1.visits;


UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B1255'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B1255`=t1.visits;


UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B1256'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B1256`=t1.visits;


UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B1257'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B1257`=t1.visits;


UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B1258'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B1258`=t1.visits;

-- ข้อเข่าเสื่อม


UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B1270'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B1270`=t1.visits;


UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B1271'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B1271`=t1.visits;


UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B1272'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B1272`=t1.visits;



-- สมอง


UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B1220'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B1220`=t1.visits;

UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B1221'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B1221`=t1.visits;


UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B1223'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B1223`=t1.visits;

UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B1224'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B1224`=t1.visits;

UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B1225'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B1225`=t1.visits;


UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B1226'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B1226`=t1.visits;


-- ซึมเศร้า

UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B0280'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B0280`=t1.visits;

UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B0281'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B0281`=t1.visits;

UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B0282'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B0282`=t1.visits;

UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B0283'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B0283`=t1.visits;


UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B0284'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B0284`=t1.visits;


UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B0285'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B0285`=t1.visits;


-- หกล้ม 

UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B1200'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B1200`=t1.visits;

UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B1201'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B1201`=t1.visits;

UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B1202'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B1202`=t1.visits;



-- กิจวัตรประจำวัน

UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B1280'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B1280`=t1.visits;

UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B1281'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B1281`=t1.visits;



UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B1282'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B1282`=t1.visits;


/* ตรวจคัดกรองได้ผลปกติ ผู้รับบริการเคยตรวจด้วยตนเองได้ผลปกติ (Z123)  */
UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B0030'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B0030`=t1.visits;


/* การตรวจคัดกรองความเสี่ยงโรคหัวใจและหลอดเลือดสมองในผู้สูงอายุ พบว่าไม่มีความเสี่ยง (Z136)  */
UPDATE `me_sreen_aging`  t0
INNER JOIN
(
SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(ppspecial  ORDER BY f.dateserv ASC ) as ppvisits
,GROUP_CONCAT(CAST(f.dateserv AS CHAR(10000) CHARACTER SET utf8)  ORDER BY f.dateserv ASC ) as visits
FROM person p
LEFT  JOIN f43specialpp f 
ON p.pcucodeperson=f.pcucodeperson AND p.pid=f.pid
WHERE getAgeYearNum(p.birth,'2020-10-01') >60
AND p.typelive in ('1','3')
AND p.dischargetype='9'
AND dateserv BETWEEN'2020-10-01' AND '2021-09-30'
AND f.ppspecial='1B1230'
GROUP BY p.pid
) as t1
ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid 
SET t0.`1B1230`=t1.visits;



