<?php
$con=mysql_connect("localhost","root","6701sso");
mysql_select_db("hdc");
mysql_query("SET character_set_results=utf8");
mysql_query("SET character_set_client=utf8");
mysql_query("SET character_set_connection=utf8");

$t1= date('Y-m-d h:i:s');
$today=date('Y-m-d');
$startyear = date ("Y-m-d", strtotime("-4  year", strtotime($today)));	
$startdate=date("Y",strtotime($startyear)).'-'.'10'.'-'.'01';

// drop table
$drops="DROP TABLE IF EXISTS me_ncd_risk ";
$resultdrop = mysql_query($drops) or die (mysql_error());

// create table

$create ="CREATE TABLE IF NOT EXISTS `me_ncd_risk` 
(
`ID` int(11) NOT NULL AUTO_INCREMENT
,`TIME_ID`	 varchar(10)
,`HN_HMAIN`	varchar(15)
,`HOSPCODE` varchar(5)
,`PID`	varchar(15)
,`CID`	varchar(13)
,`NAME` 	varchar(50)
,`LNAME`	varchar(50)
,`BIRTH`	date
,`AGE` varchar(3)
,`SEX` varchar(1)
,`TYPEAREA` varchar(1)
,`DISCHARGE`	varchar(1)
,`DDISCHARGE`	date
,`HOUSE`	varchar(75)
,`VILLAGE_ID`	varchar(2)
,`AREA_ID`	varchar(8)
,`MOOBAN`	varchar(100)
,`INSCL`	varchar(4)
,`DM_DATE_DX`	date
,`HT_DATE_DX`	date	
,`DATE_SCREEN_DM` date
,`DATE_SCREEN_HT` date
,`WEIGHT` int(6)
,`HEIGHT` int(6)
,`WAIST_CM` int(6)
,`BMI` DOUBLE
,`BSLEVEL` int	(6)
,`SBP` int	(6)
,`DBP` int	(6)
,`DM_RISK`  varchar(2)
,`HT_RISK`  varchar(3)

,`DM_APPOINT1`	date
,`DM_APPOINT2`	date	
,`DM_APPOINT3`	date	
,`DM_APPOINT6`	date

,`HT_APPOINT1`	date
,`HT_APPOINT2`	date	
,`HT_APPOINT3`	date	
,`HT_APPOINT6`	date

,`DATE_BS_FU1`	date	
,`DATE_BS_FU2`	date	
,`DATE_BS_FU3`	date	
,`DATE_BS_FU6`	date	
,`DATE_BS_FU_LAST`	date

,`DATE_BP_FU1`	date	
,`DATE_BP_FU2`	date
,`DATE_BP_FU3`	date
,`DATE_BP_FU6`	date
,`DATE_BP_FU_LAST`	date

,`BS_FU1`  int	(6)
,`BS_FU2`  int	(6)
,`BS_FU3`  int	(6)
,`BS_FU6`  int	(6)
,`BS_FU_LAST`  int	(6)

,`SBP_FU1`  int	(6)
,`SBP_FU2`  int	(6)
,`SBP_FU3`  int	(6)
,`SBP_FU6`  int	(6)
,`SBP_FU_LAST`  int	(6)	
,`DBP_FU1`  int	(6)
,`DBP_FU2`  int	(6)
,`DBP_FU3`  int	(6)
,`DBP_FU6`  int	(6)
,`DBP_FU_LAST`  int	(6)		
,`PRE_DM_OUTCOMES`  VARCHAR	(1)
,`PRE_HT_OUTCOMES`  VARCHAR	(1)

,`UPDATE_AT`  VARCHAR	(255)
,PRIMARY KEY (`ID`)
,INDEX `time_id_idx` (`TIME_ID`)
,INDEX `personid_idx` (`HOSPCODE`,`PID`)
,INDEX `cid_idx` (`CID`)
,INDEX `date_screen_dm_idx` (`DATE_SCREEN_DM`)
,INDEX `date_screen_ht_idx` (`DATE_SCREEN_HT`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8 AUTO_INCREMENT=1; ";
$resultcreate = mysql_query($create) or die (mysql_error());

// INSERT DATA 

while ($startdate < $today) {	
$stopdate= date("Y-m-d", strtotime("+1 year", strtotime($startdate)));
// echo $startdate.'-'.date("Y-m-d", strtotime("-1 day", strtotime($stopdate))) .'<br>';
// DATE_SUB('".$month6."' ,INTERVAL 1 day)

	$insert = "INSERT INTO `me_ncd_risk`   
	(`TIME_ID`
		,`HOSPCODE`,`PID`,`CID`,`NAME`,`LNAME`,`BIRTH`,`SEX`,`TYPEAREA`,`DISCHARGE`,`DDISCHARGE`
		,`HOUSE`,`VILLAGE_ID`,`AREA_ID`,`MOOBAN`) 		
		SELECT  '".$startdate."' AS TIME_ID
				,p.HOSPCODE, p.PID,p.CID,p.NAME,p.LNAME,p.BIRTH
				,p.SEX,p.TYPEAREA,p.DISCHARGE,p.DDISCHARGE 
				,h.HOUSE,h.VILLAGE AS VILLAGE_ID
				,CONCAT(h.CHANGWAT,h.AMPUR,h.TAMBON,h.VILLAGE) AS AREA_ID
				,v.villagename AS MOOBAN		
				FROM person  p
				INNER JOIN chospital o
				ON p.HOSPCODE=o.hoscode 
				INNER JOIN  home h
				ON p.HOSPCODE=h.HOSPCODE AND p.HID=h.HID 
				INNER JOIN cvillagelast v
				ON concat(h.CHANGWAT,h.AMPUR,h.TAMBON,h.VILLAGE)=v.villagecodefull 
		WHERE p.TYPEAREA in('1','3')  
		GROUP BY p.HOSPCODE,p.PID ;";
		$result = mysql_query($insert) or die (mysql_error());	
		
	$startdate=date("Y-m-d", strtotime("+1 year", strtotime($startdate)));
} 

// update DM HISTORY
					$dmhistory="UPDATE me_ncd_risk t
									INNER JOIN 
									(
									SELECT	HOSPCODE,PID,group_concat(chronic.DATE_DIAG ORDER BY chronic.DATE_DIAG ASC  separator ', ') as	DM_DATE_DX
									FROM chronic 
									WHERE (SUBSTR(chronic.CHRONIC,1,3) BETWEEN 'E10' AND 'E14')
								
									GROUP BY HOSPCODE,PID
									) as t0
									SET t.DM_DATE_DX = t0.DM_DATE_DX
									WHERE t.HOSPCODE=t0.HOSPCODE AND t.PID=t0.PID ;";
					mysql_query($dmhistory);

if($dmhistory){
	echo  'DM HISTORY Already'.'<br>';
}

// update HT HISTORY

$hthistory="UPDATE me_ncd_risk t
						INNER JOIN 
						(
						SELECT	HOSPCODE,PID,group_concat(chronic.DATE_DIAG ORDER BY chronic.DATE_DIAG ASC  separator ', ') as	HT_DATE_DX
						FROM chronic 
						WHERE SUBSTR(chronic.CHRONIC,1,3) BETWEEN 'I10' AND 'I15'
						GROUP BY HOSPCODE,PID
						) as t0
						SET t.HT_DATE_DX = t0.HT_DATE_DX
						WHERE t.HOSPCODE=t0.HOSPCODE AND t.PID=t0.PID ;";
mysql_query($hthistory);

if($hthistory){
	echo  'HT HISTORY Already'.'<br>';
}

// BLOOD SUGAR
$sql = "SELECT DISTINCT TIME_ID FROM `me_ncd_risk` ;";
$res = mysql_query($sql);
while ($row = mysql_fetch_array($res)){
$bs="UPDATE `me_ncd_risk`    t1
		INNER JOIN 
		(
		SELECT n.HOSPCODE,n.PID
			,MAX(n.DATE_SERV) as DATE_SCREEN_DM
			FROM  ncdscreen n
			WHERE  n.DATE_SERV BETWEEN '".$row['TIME_ID']."'  AND DATE_SUB((DATE_ADD('".$row['TIME_ID']."',INTERVAL 1 year)),INTERVAL 1 day)
			AND NOT ISNULL(n.BSLEVEL)	
			GROUP BY n.HOSPCODE,n.PID
		) as t2
		SET  t1.DATE_SCREEN_DM=t2.DATE_SCREEN_DM 
		WHERE  t1.HOSPCODE=t2.HOSPCODE AND t1.PID=t2.PID AND t1.TIME_ID='".$row['TIME_ID']."'  ;";
mysql_query($bs);
}						
					
if($bs){
	echo  'RESULT BLOOD SUGAR IS OK'.'<br>';
}


// BLOOD PRESURE
$sql = "SELECT DISTINCT TIME_ID FROM `me_ncd_risk` ;";
$res = mysql_query($sql);
while ($row = mysql_fetch_array($res)){
$bs="UPDATE `me_ncd_risk`    t1
		INNER JOIN 
		(
		SELECT n.HOSPCODE,n.PID
			,MAX(n.DATE_SERV) as DATE_SCREEN_HT
			FROM  ncdscreen n
			WHERE  n.DATE_SERV BETWEEN '".$row['TIME_ID']."'  AND DATE_SUB((DATE_ADD('".$row['TIME_ID']."',INTERVAL 1 year)),INTERVAL 1 day)
			AND NOT ISNULL(n.SBP_1)	AND NOT ISNULL(n.SBP_2) AND NOT ISNULL(n.DBP_1) AND NOT ISNULL(n.DBP_2)
			GROUP BY n.HOSPCODE,n.PID
		) as t2
		SET  t1.DATE_SCREEN_HT=t2.DATE_SCREEN_HT 
		WHERE  t1.HOSPCODE=t2.HOSPCODE AND t1.PID=t2.PID AND t1.TIME_ID='".$row['TIME_ID']."'  ;";
mysql_query($bs);
}						
					
if($bs){
	echo  'RESULT BLOOD PRESURE IS OK'.'<br>';
}

// UPDATE BSLEVEL 

$bs="UPDATE `me_ncd_risk`    t1
		INNER JOIN 
		(
		SELECT n.HOSPCODE,n.PID
			,n.DATE_SERV as VISIT
			,n.BSLEVEL 
			FROM  ncdscreen n			
		) as t2
		SET  t1.BSLEVEL=t2.BSLEVEL 
		WHERE  t1.HOSPCODE=t2.HOSPCODE AND t1.PID=t2.PID and t1.DATE_SCREEN_DM=t2.VISIT  ;";
mysql_query($bs);

// UPDATE BP  
$bs="UPDATE `me_ncd_risk`    t1
		INNER JOIN 
		(
		SELECT n.HOSPCODE,n.PID
			,n.DATE_SERV as VISIT
			,FORMAT(((n.SBP_1+n.SBP_2)/2),0) as SBP 
			,FORMAT(((n.DBP_1+n.DBP_2)/2),0) as DBP 
			FROM  ncdscreen n			
		) as t2
		SET  t1.SBP=t2.SBP ,t1.DBP=t2.DBP 
		WHERE  t1.HOSPCODE=t2.HOSPCODE AND t1.PID=t2.PID and t1.DATE_SCREEN_HT=t2.VISIT  ;";
mysql_query($bs);

// who is DM_RISK
$dmrisk=" UPDATE me_ncd_risk  t1
				INNER JOIN 
				(
				SELECT	TIME_ID,HOSPCODE,PID,BSLEVEL
					,CASE 
						WHEN BSLEVEL > 125 THEN 3
						WHEN BSLEVEL BETWEEN 100 AND 125 THEN 2
						WHEN BSLEVEL < 100 THEN 1
						ELSE NULL
					END AS DM_RISK
					FROM 	me_ncd_risk 
				) as t2
				SET t1.DM_RISK = t2.DM_RISK
				WHERE t1.HOSPCODE=t2.HOSPCODE AND t1.PID=t2.PID AND t1.TIME_ID=t2.TIME_ID ;";
mysql_query($dmrisk);

// who is HT_RISK
$htrisk=" UPDATE me_ncd_risk  t1
				INNER JOIN 
				(
				SELECT	TIME_ID,HOSPCODE,PID,SBP,DBP
					,CASE 
						WHEN (SBP < 120 AND DBP < 80 ) THEN '11A'
						WHEN (SBP < 120 AND (DBP BETWEEN 80 AND 89) ) THEN '12B'
						WHEN (SBP < 120 AND (DBP BETWEEN 90 AND 99) ) THEN '13C'
						WHEN (SBP < 120 AND (DBP > 99) ) THEN '14D'			
						WHEN ((SBP BETWEEN 120 AND 139) AND DBP < 80) THEN '21B'
						WHEN ((SBP BETWEEN 120 AND 139) AND (DBP BETWEEN 80 AND 89)) THEN '22B'
						WHEN ((SBP BETWEEN 120 AND 139) AND (DBP BETWEEN 90 AND 99)) THEN '23C'
						WHEN ((SBP BETWEEN 120 AND 139) AND (DBP > 99)) THEN '24D'
						WHEN ((SBP BETWEEN 140 AND 159) AND DBP < 80) THEN '31C'
						WHEN ((SBP BETWEEN 140 AND 159) AND (DBP BETWEEN 80 AND 89)) THEN '32C'
						WHEN ((SBP BETWEEN 140 AND 159) AND (DBP BETWEEN 90 AND 99)) THEN '33C'
						WHEN ((SBP BETWEEN 140 AND 159) AND (DBP > 99)) THEN '34D'
						WHEN ((SBP > 159) AND DBP < 80) THEN '41D'
						WHEN ((SBP > 159) AND (DBP BETWEEN 80 AND 89)) THEN '42D'
						WHEN ((SBP > 159) AND (DBP BETWEEN 90 AND 99)) THEN '43D'
						WHEN ((SBP > 159) AND (DBP > 99)) THEN '44D'
						ELSE NULL
					END AS HT_RISK
					FROM 	me_ncd_risk 
				) as t2
				SET t1.HT_RISK = t2.HT_RISK
				WHERE t1.HOSPCODE=t2.HOSPCODE AND t1.PID=t2.PID  AND t1.TIME_ID=t2.TIME_ID;";
mysql_query($htrisk);



// update PRE-DM APPOINT FOR LIFTSTYLE INTERVENTOIN
					$dm_appoint="UPDATE me_ncd_risk 
					SET DM_APPOINT1= DATE_ADD(DATE_SCREEN_DM,INTERVAL +1 MONTH),
						DM_APPOINT2= DATE_ADD(DATE_SCREEN_DM,INTERVAL +2 MONTH),
						DM_APPOINT3= DATE_ADD(DATE_SCREEN_DM,INTERVAL +3 MONTH),
						DM_APPOINT6= DATE_ADD(DATE_SCREEN_DM,INTERVAL +6 MONTH);";
					mysql_query($dm_appoint);
					
// update PRE-DM APPOINT FOR LIFTSTYLE INTERVENTOIN
					$ht_appoint="UPDATE me_ncd_risk 
					SET HT_APPOINT1= DATE_ADD(DATE_SCREEN_HT,INTERVAL +1 MONTH),
						HT_APPOINT2= DATE_ADD(DATE_SCREEN_HT,INTERVAL +2 MONTH),
						HT_APPOINT3= DATE_ADD(DATE_SCREEN_HT,INTERVAL +3 MONTH),
						HT_APPOINT6= DATE_ADD(DATE_SCREEN_HT,INTERVAL +6 MONTH);";
					mysql_query($ht_appoint);					
				
// BS_FU1
$bsfu1=" UPDATE me_ncd_risk  t1
				INNER JOIN 
				(
				SELECT r.TIME_ID,r.HOSPCODE,r.PID,r.CID
					,r.DATE_SCREEN_DM,r.BSLEVEL,r.DM_RISK
					,r.DM_APPOINT1
					,GROUP_CONCAT(j.VISITDATE ORDER BY  j.VISITDATE DESC SEPARATOR ',' ) AS DATE_BS_FU
					,GROUP_CONCAT(j.DTX ORDER BY j.VISITDATE  DESC SEPARATOR ',') as BS_FU
					FROM me_ncd_risk r
					LEFT JOIN diagnosis_opd d
					ON r.HOSPCODE=d.HOSPCODE AND r.PID=d.PID 
					LEFT JOIN j_dtx  j
					ON d.HOSPCODE=j.HOSPCODE AND d.PID=j.PID  AND d.DATE_SERV=j.VISITDATE
					WHERE  SUBSTR(d.DIAGCODE,1,4)='Z713'
					AND d.DATE_SERV BETWEEN DATE_ADD(r.DM_APPOINT1,INTERVAL -7 DAY) and	DATE_ADD(r.DM_APPOINT1,INTERVAL 7 DAY)
					GROUP BY r.TIME_ID,r.HOSPCODE,r.PID
					HAVING NOT ISNULL(DATE_BS_FU) 
				) as t2
				SET t1.DATE_BS_FU1=t2.DATE_BS_FU,t1.BS_FU1 = t2.BS_FU
				WHERE t1.HOSPCODE=t2.HOSPCODE AND t1.PID=t2.PID AND t1.TIME_ID=t2.TIME_ID;";
mysql_query($bsfu1);

					
// BS_FU2
$bsfu2=" UPDATE me_ncd_risk  t1
				INNER JOIN 
				(
				SELECT r.TIME_ID,r.HOSPCODE,r.PID,r.CID
					,r.DATE_SCREEN_DM,r.BSLEVEL,r.DM_RISK
					,r.DM_APPOINT1
					,GROUP_CONCAT(j.VISITDATE ORDER BY  j.VISITDATE DESC SEPARATOR ',' ) AS DATE_BS_FU
					,GROUP_CONCAT(j.DTX ORDER BY j.VISITDATE  DESC SEPARATOR ',') as BS_FU
					FROM me_ncd_risk r
					LEFT JOIN diagnosis_opd d
					ON r.HOSPCODE=d.HOSPCODE AND r.PID=d.PID 
					LEFT JOIN j_dtx  j
					ON d.HOSPCODE=j.HOSPCODE AND d.PID=j.PID  AND d.DATE_SERV=j.VISITDATE
					WHERE  SUBSTR(d.DIAGCODE,1,4)='Z713'
					AND d.DATE_SERV BETWEEN DATE_ADD(r.DM_APPOINT2,INTERVAL -7 DAY) and	DATE_ADD(r.DM_APPOINT2,INTERVAL 7 DAY)
					GROUP BY r.TIME_ID,r.HOSPCODE,r.PID
					HAVING NOT ISNULL(DATE_BS_FU) 
				) as t2
				SET t1.DATE_BS_FU2=t2.DATE_BS_FU,t1.BS_FU2 = t2.BS_FU
				WHERE t1.HOSPCODE=t2.HOSPCODE AND t1.PID=t2.PID AND t1.TIME_ID=t2.TIME_ID;";
mysql_query($bsfu2);

// BS_FU3
$bsfu3=" UPDATE me_ncd_risk  t1
				INNER JOIN 
				(
				SELECT r.TIME_ID,r.HOSPCODE,r.PID,r.CID
					,r.DATE_SCREEN_DM,r.BSLEVEL,r.DM_RISK
					,r.DM_APPOINT1
					,GROUP_CONCAT(j.VISITDATE ORDER BY  j.VISITDATE DESC SEPARATOR ',' ) AS DATE_BS_FU
					,GROUP_CONCAT(j.DTX ORDER BY j.VISITDATE  DESC SEPARATOR ',') as BS_FU
					FROM me_ncd_risk r
					LEFT JOIN diagnosis_opd d
					ON r.HOSPCODE=d.HOSPCODE AND r.PID=d.PID 
					LEFT JOIN j_dtx  j
					ON d.HOSPCODE=j.HOSPCODE AND d.PID=j.PID  AND d.DATE_SERV=j.VISITDATE
					WHERE  SUBSTR(d.DIAGCODE,1,4)='Z713'
					AND d.DATE_SERV BETWEEN DATE_ADD(r.DM_APPOINT3,INTERVAL -7 DAY) and	DATE_ADD(r.DM_APPOINT3,INTERVAL 7 DAY)
					GROUP BY r.TIME_ID,r.HOSPCODE,r.PID
					HAVING NOT ISNULL(DATE_BS_FU) 
				) as t2
				SET t1.DATE_BS_FU3=t2.DATE_BS_FU,t1.BS_FU3 = t2.BS_FU
				WHERE t1.HOSPCODE=t2.HOSPCODE AND t1.PID=t2.PID AND t1.TIME_ID=t2.TIME_ID;";
mysql_query($bsfu3);


// BS_FU6
$bsfu6=" UPDATE me_ncd_risk  t1
				INNER JOIN 
				(
				SELECT r.TIME_ID,r.HOSPCODE,r.PID,r.CID
					,r.DATE_SCREEN_DM,r.BSLEVEL,r.DM_RISK
					,r.DM_APPOINT1
					,GROUP_CONCAT(j.VISITDATE ORDER BY  j.VISITDATE DESC SEPARATOR ',' ) AS DATE_BS_FU
					,GROUP_CONCAT(j.DTX ORDER BY j.VISITDATE  DESC SEPARATOR ',') as BS_FU
					FROM me_ncd_risk r
					LEFT JOIN diagnosis_opd d
					ON r.HOSPCODE=d.HOSPCODE AND r.PID=d.PID 
					LEFT JOIN j_dtx  j
					ON d.HOSPCODE=j.HOSPCODE AND d.PID=j.PID  AND d.DATE_SERV=j.VISITDATE
					WHERE  SUBSTR(d.DIAGCODE,1,4)='Z713'
					AND d.DATE_SERV BETWEEN DATE_ADD(r.DM_APPOINT6,INTERVAL -7 DAY) and	DATE_ADD(r.DM_APPOINT6,INTERVAL 7 DAY)
					GROUP BY r.TIME_ID,r.HOSPCODE,r.PID
					HAVING NOT ISNULL(DATE_BS_FU) 
				) as t2
				SET t1.DATE_BS_FU6=t2.DATE_BS_FU,t1.BS_FU6 = t2.BS_FU
				WHERE t1.HOSPCODE=t2.HOSPCODE AND t1.PID=t2.PID AND t1.TIME_ID=t2.TIME_ID;";
mysql_query($bsfu6);


// BS_FU LAST
$bsfu_last=" UPDATE me_ncd_risk  t1
				INNER JOIN 
				(
				SELECT r.TIME_ID,r.HOSPCODE,r.PID,r.CID
					,r.DATE_SCREEN_DM,r.BSLEVEL,r.DM_RISK
					,r.DM_APPOINT1
					,GROUP_CONCAT(d.DATE_SERV ORDER BY  d.DATE_SERV DESC SEPARATOR ',' ) AS DATE_VISIT
					,SPLIT_STR(GROUP_CONCAT(j.VISITDATE ORDER BY  j.VISITDATE DESC SEPARATOR ',' ),',',1) AS DATE_BS_FU
					,SPLIT_STR(GROUP_CONCAT(j.DTX ORDER BY j.VISITDATE  DESC SEPARATOR ','),',',1) AS BS_FU
					FROM me_ncd_risk r
					LEFT JOIN diagnosis_opd d
					ON r.HOSPCODE=d.HOSPCODE AND r.PID=d.PID 
					LEFT JOIN j_dtx  j
					ON d.HOSPCODE=j.HOSPCODE AND d.PID=j.PID  AND d.DATE_SERV=j.VISITDATE
					WHERE  SUBSTR(d.DIAGCODE,1,4)='Z713'
					AND d.DATE_SERV BETWEEN DATE_ADD(r.DM_APPOINT1,INTERVAL -7 DAY) and	DATE_ADD(r.DM_APPOINT6,INTERVAL 7 DAY)
					GROUP BY r.TIME_ID,r.HOSPCODE,r.PID
					HAVING NOT ISNULL(DATE_BS_FU) 
				) as t2
				SET t1.DATE_BS_FU_LAST=t2.DATE_BS_FU,t1.BS_FU_LAST= t2.BS_FU
				WHERE t1.HOSPCODE=t2.HOSPCODE AND t1.PID=t2.PID AND t1.TIME_ID=t2.TIME_ID;";
mysql_query($bsfu_last);

// BP_FU 1
$bpfu1=" UPDATE me_ncd_risk  t1
				INNER JOIN 
				(
				SELECT
					t.TIME_ID,t.HOSPCODE,t.PID
					,t.DATE_SCREEN_HT
					,t.HT_RISK
					,t.HT_APPOINT1
					,SPLIT_STR(GROUP_CONCAT(s.DATE_SERV ORDER BY  s.DATE_SERV DESC SEPARATOR ',' ),',',1) AS DATE_BP_FU
					,SPLIT_STR(GROUP_CONCAT(s.SBP  ORDER BY  s.DATE_SERV DESC SEPARATOR ',' ),',',1) AS SBP_FU
					,SPLIT_STR(GROUP_CONCAT(s.DBP  ORDER BY  s.DATE_SERV DESC SEPARATOR ',' ),',',1) AS DBP_FU
					FROM me_ncd_risk t
					INNER JOIN service s
					ON t.HOSPCODE=s.HOSPCODE AND t.PID=s.PID 
					INNER JOIN diagnosis_opd d
					ON s.HOSPCODE=d.HOSPCODE AND s.PID=d.PID  AND s.SEQ=d.SEQ
					WHERE SUBSTR(d.DIAGCODE,1,4)='Z713'
					AND  s.DATE_SERV BETWEEN DATE_ADD(t.HT_APPOINT1,INTERVAL -7 DAY) and	DATE_ADD(t.HT_APPOINT1,INTERVAL 7 DAY)
					GROUP BY t.HOSPCODE,t.PID,t.TIME_ID		
				) as t2
				SET 	t1.DATE_BP_FU1=t2.DATE_BP_FU
						,t1.SBP_FU1= t2.SBP_FU
						,t1.DBP_FU1= t2.DBP_FU
				WHERE t1.HOSPCODE=t2.HOSPCODE AND t1.PID=t2.PID AND t1.TIME_ID=t2.TIME_ID;";
mysql_query($bpfu1);

// BP_FU 2
$bpfu2=" UPDATE me_ncd_risk  t1
				INNER JOIN 
				(
				SELECT
					t.TIME_ID,t.HOSPCODE,t.PID
					,t.DATE_SCREEN_HT
					,t.HT_RISK
					,t.HT_APPOINT1
					,SPLIT_STR(GROUP_CONCAT(s.DATE_SERV ORDER BY  s.DATE_SERV DESC SEPARATOR ',' ),',',1) AS DATE_BP_FU
					,SPLIT_STR(GROUP_CONCAT(s.SBP  ORDER BY  s.DATE_SERV DESC SEPARATOR ',' ),',',1) AS SBP_FU
					,SPLIT_STR(GROUP_CONCAT(s.DBP  ORDER BY  s.DATE_SERV DESC SEPARATOR ',' ),',',1) AS DBP_FU
					FROM me_ncd_risk t
					INNER JOIN service s
					ON t.HOSPCODE=s.HOSPCODE AND t.PID=s.PID 
					INNER JOIN diagnosis_opd d
					ON s.HOSPCODE=d.HOSPCODE AND s.PID=d.PID  AND s.SEQ=d.SEQ
					WHERE SUBSTR(d.DIAGCODE,1,4)='Z713'
					AND  s.DATE_SERV BETWEEN DATE_ADD(t.HT_APPOINT2,INTERVAL -7 DAY) and	DATE_ADD(t.HT_APPOINT2,INTERVAL 7 DAY)
					GROUP BY t.HOSPCODE,t.PID,t.TIME_ID
				) as t2
				SET 	t1.DATE_BP_FU2=t2.DATE_BP_FU
						,t1.SBP_FU2= t2.SBP_FU
						,t1.DBP_FU2= t2.DBP_FU
				WHERE t1.HOSPCODE=t2.HOSPCODE AND t1.PID=t2.PID AND t1.TIME_ID=t2.TIME_ID;";
mysql_query($bpfu2);


// BP_FU 3
$bpfu3=" UPDATE me_ncd_risk  t1
				INNER JOIN 
				(
				SELECT
					t.TIME_ID,t.HOSPCODE,t.PID
					,t.DATE_SCREEN_HT
					,t.HT_RISK
					,t.HT_APPOINT1
					,SPLIT_STR(GROUP_CONCAT(s.DATE_SERV ORDER BY  s.DATE_SERV DESC SEPARATOR ',' ),',',1) AS DATE_BP_FU
					,SPLIT_STR(GROUP_CONCAT(s.SBP  ORDER BY  s.DATE_SERV DESC SEPARATOR ',' ),',',1) AS SBP_FU
					,SPLIT_STR(GROUP_CONCAT(s.DBP  ORDER BY  s.DATE_SERV DESC SEPARATOR ',' ),',',1) AS DBP_FU
					FROM me_ncd_risk t
					INNER JOIN service s
					ON t.HOSPCODE=s.HOSPCODE AND t.PID=s.PID 
					INNER JOIN diagnosis_opd d
					ON s.HOSPCODE=d.HOSPCODE AND s.PID=d.PID  AND s.SEQ=d.SEQ
					WHERE SUBSTR(d.DIAGCODE,1,4)='Z713'
					AND  s.DATE_SERV BETWEEN DATE_ADD(t.HT_APPOINT3,INTERVAL -7 DAY) and	DATE_ADD(t.HT_APPOINT3,INTERVAL 7 DAY)
					GROUP BY t.HOSPCODE,t.PID,t.TIME_ID
				) as t2
				SET 	t1.DATE_BP_FU3=t2.DATE_BP_FU
						,t1.SBP_FU3= t2.SBP_FU
						,t1.DBP_FU3= t2.DBP_FU
				WHERE t1.HOSPCODE=t2.HOSPCODE AND t1.PID=t2.PID AND t1.TIME_ID=t2.TIME_ID;";
mysql_query($bpfu3);

// BP_FU 6
$bpfu6=" UPDATE me_ncd_risk  t1
				INNER JOIN 
				(
				SELECT
					t.TIME_ID,t.HOSPCODE,t.PID
					,t.DATE_SCREEN_HT
					,t.HT_RISK
					,t.HT_APPOINT1
					,SPLIT_STR(GROUP_CONCAT(s.DATE_SERV ORDER BY  s.DATE_SERV DESC SEPARATOR ',' ),',',1) AS DATE_BP_FU
					,SPLIT_STR(GROUP_CONCAT(s.SBP  ORDER BY  s.DATE_SERV DESC SEPARATOR ',' ),',',1) AS SBP_FU
					,SPLIT_STR(GROUP_CONCAT(s.DBP  ORDER BY  s.DATE_SERV DESC SEPARATOR ',' ),',',1) AS DBP_FU
					FROM me_ncd_risk t
					INNER JOIN service s
					ON t.HOSPCODE=s.HOSPCODE AND t.PID=s.PID 
					INNER JOIN diagnosis_opd d
					ON s.HOSPCODE=d.HOSPCODE AND s.PID=d.PID  AND s.SEQ=d.SEQ
					WHERE SUBSTR(d.DIAGCODE,1,4)='Z713'
					AND  s.DATE_SERV BETWEEN DATE_ADD(t.HT_APPOINT6,INTERVAL -7 DAY) and	DATE_ADD(t.HT_APPOINT6,INTERVAL 7 DAY)
					GROUP BY t.HOSPCODE,t.PID,t.TIME_ID
				) as t2
				SET 	t1.DATE_BP_FU6=t2.DATE_BP_FU
						,t1.SBP_FU6= t2.SBP_FU
						,t1.DBP_FU6= t2.DBP_FU
				WHERE t1.HOSPCODE=t2.HOSPCODE AND t1.PID=t2.PID AND t1.TIME_ID=t2.TIME_ID;";
mysql_query($bpfu6);

// BP_FU LAST
$bpfu_last=" UPDATE me_ncd_risk  t1
				INNER JOIN 
				(
				SELECT
					t.TIME_ID,t.HOSPCODE,t.PID
					,t.DATE_SCREEN_HT
					,t.HT_RISK
					,t.HT_APPOINT1
					,SPLIT_STR(GROUP_CONCAT(s.DATE_SERV ORDER BY  s.DATE_SERV DESC SEPARATOR ',' ),',',1) AS DATE_BP_FU
					,SPLIT_STR(GROUP_CONCAT(s.SBP  ORDER BY  s.DATE_SERV DESC SEPARATOR ',' ),',',1) AS SBP_FU
					,SPLIT_STR(GROUP_CONCAT(s.DBP  ORDER BY  s.DATE_SERV DESC SEPARATOR ',' ),',',1) AS DBP_FU
					FROM me_ncd_risk t
					INNER JOIN service s
					ON t.HOSPCODE=s.HOSPCODE AND t.PID=s.PID 
					INNER JOIN diagnosis_opd d
					ON s.HOSPCODE=d.HOSPCODE AND s.PID=d.PID  AND s.SEQ=d.SEQ
					WHERE SUBSTR(d.DIAGCODE,1,4)='Z713'
					AND  s.DATE_SERV BETWEEN DATE_ADD(t.HT_APPOINT1,INTERVAL -7 DAY) AND DATE_ADD(t.HT_APPOINT6,INTERVAL 7 DAY)
					GROUP BY t.HOSPCODE,t.PID,t.TIME_ID
				) as t2
				SET 	t1.DATE_BP_FU_LAST=t2.DATE_BP_FU
						,t1.SBP_FU_LAST= t2.SBP_FU
						,t1.DBP_FU_LAST= t2.DBP_FU
				WHERE t1.HOSPCODE=t2.HOSPCODE AND t1.PID=t2.PID AND t1.TIME_ID=t2.TIME_ID;";
mysql_query($bpfu_last);

$t2= date('Y-m-d h:i:s');
$sqlproc="UPDATE `me_ncd_risk` 
			SET UPDATE_AT=CONCAT((TIMESTAMPDIFF(MINUTE,'".$t1."','".$t2."')),'-','".$t1."','-','".$t2."');";
mysql_query($sqlproc);

/*

SELECT TIME_ID,HOSPCODE,PID,CID,`NAME`,LNAME
,DATE_SCREEN_DM,BSLEVEL,DM_RISK
,DATE_SCREEN_HT,SBP,DBP,HT_RISK
,DATE_BS_FU1,DATE_BP_FU2,DATE_BP_FU3,DATE_BP_FU6,DATE_BP_FU_LAST
,BS_FU1,BS_FU2,BS_FU3,BS_FU6,BS_FU_LAST
FROM me_ncd_risk r
WHERE HT_RISK='1'
AND TIME_ID='2015-10-01'
ORDER BY DBP DESC 

SELECT TIME_ID,HOSPCODE
,COUNT(*) AS TOTAL
,SUM(IF(HT_RISK LIKE '%A',1,0)) AS LEVEL1
,SUM(IF(HT_RISK LIKE '%B',1,0)) AS LEVEL2
,SUM(IF(HT_RISK LIKE '%C',1,0)) AS LEVEL3
,SUM(IF(HT_RISK LIKE '%D',1,0)) AS LEVEL4

FROM me_ncd_risk r
WHERE TIME_ID='2015-10-01'
AND NOT ISNULL(DATE_SCREEN_HT)
GROUP BY HOSPCODE
*/
?>
