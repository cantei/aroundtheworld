<!-- Chronic Registration  UPDATE @20151108 --> 
<?php
$con=mysql_connect("localhost","root","6701sso");
mysql_select_db("dhdc");
mysql_query("SET character_set_results=utf8");
mysql_query("SET character_set_client=utf8");
mysql_query("SET character_set_connection=utf8");

$t1= date('Y-m-d h:i:s');

// drop table
$drops="DROP TABLE IF EXISTS `me_chroniclastvisit`  ";
$resdrop = mysql_query($drops) or die (mysql_error());

// create table

$create = "CREATE TABLE  `me_chroniclastvisit` 
(
`ID` int(11) NOT NULL AUTO_INCREMENT
,`HN_HMAIN` varchar(15)
,`HOSPCODE` varchar(5)
,`HOSPNAME` varchar(50)
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
,`INSCL`	varchar(5)
,`DM_FIRST_DX` varchar(10) 
,`DM_DX` varchar(255) 
,`DM_FIRST_REG` varchar(10) 
,`DM_CHRONICCODE`	varchar(4) 
,`DM_DATE_DISCH` varchar(10) 
,`DM_TYPEDISCH` varchar(2) 
,`DM_LASTVISIT`  date
,`DM_HOSP_RX` varchar(5)  
,`HT_FIRST_DX` varchar(10)
,`HT_DX` varchar(255)
,`HT_FIRST_REG` varchar(10)
,`HT_CHRONICCODE`	varchar(4)
,`HT_DATE_DISCH` varchar(10) 
,`HT_TYPEDISCH` varchar(2) 
,`HT_LASTVISIT`  date
,`HT_HOSP_RX` varchar(5)  
,`LAST_VISIT`  date
,`LAST_HOSPCODE` varchar(5)  
,`LAST_DX` varchar(255)
,`UPDATE_AT`  varchar(200)
,PRIMARY KEY (`ID`)
,INDEX `personid_idx` (`HOSPCODE`,`PID`)
,INDEX `cid_idx` (`CID`))";
$rescreate = mysql_query($create) or die (mysql_error());
echo "The tables have been created".'<br>';


// insert 

		$insertsql =   "INSERT INTO me_chroniclastvisit  
						(`HOSPCODE`, `HOSPNAME`,`PID`,`CID`,`NAME`,`LNAME`,`BIRTH`,`AGE`,`SEX`,`TYPEAREA`,`DISCHARGE`,`DDISCHARGE`
							,`HOUSE`,`VILLAGE_ID`,`AREA_ID`)
						SELECT p.HOSPCODE
							,o.hosname AS HOSPNAME
							, p.PID,p.CID,p.NAME,p.LNAME,p.BIRTH, TIMESTAMPDIFF(YEAR,p.BIRTH,CURDATE()) AS AGE
							,p.SEX,p.TYPEAREA,p.DISCHARGE,p.DDISCHARGE 
						 	,h.HOUSE,h.VILLAGE AS VILLAGE_ID
							,CONCAT(h.CHANGWAT,h.AMPUR,h.TAMBON,h.VILLAGE) AS AREA_ID
							FROM person  p
							INNER JOIN chospital o
							ON p.HOSPCODE=o.hoscode 
							INNER JOIN  home h
							ON p.HOSPCODE=h.HOSPCODE AND p.HID=h.HID 
							INNER JOIN chronic c 
							ON p.HOSPCODE = c.HOSPCODE AND p.PID = c.PID
							GROUP BY p.HOSPCODE, p.PID";


$resinsert = mysql_query($insertsql) or die (mysql_error());
if (isset($resinsert )){
	echo "Insert Already".'<br>';
}
// update HN of HMAIN 

$sql="UPDATE `me_chroniclastvisit` t 
									INNER JOIN 
									(
									SELECT HN,CID
									FROM  person 
									WHERE person.HOSPCODE='10727'
									) as t0
									SET t.HN_HMAIN = t0.HN
									WHERE t.CID=t0.CID" ;
mysql_query($sql);	


// update INSCL 

$sql="UPDATE `me_chroniclastvisit` t 
									INNER JOIN 
									(
									SELECT PID,MAININSCL  
									FROM  dbpop_2558
									) as t0
									SET t.INSCL = t0.MAININSCL
									WHERE t.CID=t0.PID" ;
		mysql_query($sql);	

if (isset($sql )){
	echo "update INSCL Already".'<br>';
}
// update DM_FIRST_DX
					$hthistory="UPDATE `me_chroniclastvisit` t
									INNER JOIN 
									(
										SELECT p.CID,o.HOSPCODE,o.PID
										,SPLIT_STR(GROUP_CONCAT(o.DATE_SERV ORDER BY o.DATE_SERV ASC SEPARATOR ',' ),',',1) AS DM_FIRST_DX
										,GROUP_CONCAT(o.DIAGCODE ORDER BY o.DATE_SERV ASC SEPARATOR ',' ) AS DM_DX
										FROM diagnosis_opd o
										LEFT JOIN person p
										ON o.HOSPCODE=p.HOSPCODE AND o.PID=p.PID 
										WHERE  
										(SUBSTR(o.DIAGCODE,1,3) BETWEEN 'E10' AND 'E14')
										AND  NOT ISNULL(p.CID)
										GROUP BY p.CID 					
									) as t0
									SET 
										t.DM_FIRST_DX = t0.DM_FIRST_DX
										,t.DM_DX = t0.DM_DX
									WHERE t.CID=t0.CID ;";
					mysql_query($hthistory);

					
if (isset($hthistory )){
	echo "update DM as OP  history Already".'<br>';
}


// update DM HISTORY
					$dmhistory="UPDATE `me_chroniclastvisit` t
									INNER JOIN 
									(
									SELECT	HOSPCODE,PID
											,group_concat(chronic.DATE_DIAG ORDER BY chronic.DATE_DIAG ASC  separator ', ') as	DM_FIRST_REG
											,group_concat(chronic.CHRONIC ORDER BY chronic.DATE_DIAG ASC  separator ', ') as	DM_CHRONICCODE	
											,group_concat(chronic.DATE_DISCH ORDER BY chronic.DATE_DIAG DESC  separator ', ') as DM_DATE_DISCH											
											,group_concat(chronic.TYPEDISCH ORDER BY chronic.DATE_DIAG DESC  separator ', ') as	DM_TYPEDISCH
											,group_concat(chronic.HOSP_RX ORDER BY chronic.DATE_DIAG DESC  separator ', ') as	DM_HOSP_RX
											FROM chronic 
											WHERE (SUBSTR(chronic.CHRONIC,1,3) BETWEEN 'E10' AND 'E14')
											GROUP BY HOSPCODE,PID									
									) as t0
									SET 
										t.DM_FIRST_REG = SUBSTR(t0.DM_FIRST_REG,1,10) 
										,t.DM_CHRONICCODE = SUBSTR(t0.DM_CHRONICCODE,1,4)	
										,t.DM_DATE_DISCH = SUBSTR(t0.DM_DATE_DISCH,1,10) 										
										,t.DM_TYPEDISCH = SUBSTR(t0.DM_TYPEDISCH,1,2) 
										,t.DM_HOSP_RX = SUBSTR(t0.DM_HOSP_RX,1,5)
									WHERE t.HOSPCODE=t0.HOSPCODE AND t.PID=t0.PID ;";
					mysql_query($dmhistory);

if (isset($dmhistory )){
	echo "update DM history Already".'<br>';
}




// update HT HISTORY
					$hthistory="UPDATE `me_chroniclastvisit` t
									INNER JOIN 
									(
									SELECT	HOSPCODE,PID
											,group_concat(chronic.DATE_DIAG ORDER BY chronic.DATE_DIAG ASC  separator ', ') as	HT_FIRST_REG
											,group_concat(chronic.CHRONIC ORDER BY chronic.DATE_DIAG ASC  separator ', ') as	HT_CHRONICCODE												
											,group_concat(chronic.DATE_DISCH ORDER BY chronic.DATE_DIAG DESC  separator ', ') as HT_DATE_DISCH											
											,group_concat(chronic.TYPEDISCH ORDER BY chronic.DATE_DIAG DESC  separator ', ') as	HT_TYPEDISCH
											,group_concat(chronic.HOSP_RX ORDER BY chronic.DATE_DIAG DESC  separator ', ') as	HT_HOSP_RX
											FROM chronic 
											WHERE (SUBSTR(chronic.CHRONIC,1,3) BETWEEN 'I10' AND 'I15')
											GROUP BY HOSPCODE,PID									
									) as t0
									SET 
										t.HT_FIRST_REG = SUBSTR(t0.HT_FIRST_REG,1,10) 
										,t.HT_CHRONICCODE = SUBSTR(t0.HT_CHRONICCODE,1,3)	
										,t.HT_DATE_DISCH = SUBSTR(t0.HT_DATE_DISCH,1,10) 										
										,t.HT_TYPEDISCH = SUBSTR(t0.HT_TYPEDISCH,1,2) 
										,t.HT_HOSP_RX = SUBSTR(t0.HT_HOSP_RX,1,5)
									WHERE t.HOSPCODE=t0.HOSPCODE AND t.PID=t0.PID ;";
					mysql_query($hthistory);

			
	// update HT_FIRST_DX
					$hthistory="UPDATE `me_chroniclastvisit` t
									INNER JOIN 
									(
										SELECT p.CID,o.HOSPCODE,o.PID
										,SPLIT_STR(GROUP_CONCAT(o.DATE_SERV ORDER BY o.DATE_SERV ASC SEPARATOR ',' ),',',1) AS HT_FIRST_DX
										,GROUP_CONCAT(o.DIAGCODE ORDER BY o.DATE_SERV ASC SEPARATOR ',' ) AS HT_DX
										FROM diagnosis_opd o
										LEFT JOIN person p
										ON o.HOSPCODE=p.HOSPCODE AND o.PID=p.PID 
										WHERE  
										(SUBSTR(o.DIAGCODE,1,3) BETWEEN 'I10' AND 'I15')
										AND  NOT ISNULL(p.CID)
										GROUP BY p.CID 					
									) as t0
									SET 
										t.HT_FIRST_DX = t0.HT_FIRST_DX
										,t.HT_DX = t0.HT_DX
									WHERE t.CID=t0.CID ;";
					mysql_query($hthistory);

					
if (isset($hthistory )){
	echo "update DM as OP  history Already".'<br>';
}
				


	// LASTVISIT DM
					$sql="UPDATE `me_chroniclastvisit` t
									INNER JOIN 
									(
										SELECT p.CID,o.HOSPCODE,o.PID
										,SPLIT_STR(GROUP_CONCAT(o.DATE_SERV ORDER BY o.DATE_SERV DESC SEPARATOR ',' ),',',1) AS DM_LASTVISIT
										,SPLIT_STR(GROUP_CONCAT(o.HOSPCODE ORDER BY o.DATE_SERV DESC SEPARATOR ',' ),',',1) AS DM_HOSP_RX
										FROM diagnosis_opd o
										LEFT JOIN person p
										ON o.HOSPCODE=p.HOSPCODE AND o.PID=p.PID 
										WHERE  
										(SUBSTR(o.DIAGCODE,1,3) BETWEEN 'E10' AND 'E14')
										AND  NOT ISNULL(p.CID)
										GROUP BY p.CID 					
									) as t0
									SET 
										t.DM_LASTVISIT = t0.DM_LASTVISIT
										,t.DM_HOSP_RX = t0.DM_HOSP_RX
									WHERE t.CID=t0.CID ;";
					mysql_query($sql);


	// LASTVISIT HT
					$sql="UPDATE `me_chroniclastvisit` t
									INNER JOIN 
									(
										SELECT p.CID,o.HOSPCODE,o.PID
										,SPLIT_STR(GROUP_CONCAT(o.DATE_SERV ORDER BY o.DATE_SERV DESC SEPARATOR ',' ),',',1) AS HT_LASTVISIT
										,SPLIT_STR(GROUP_CONCAT(o.HOSPCODE ORDER BY o.DATE_SERV DESC SEPARATOR ',' ),',',1) AS HT_HOSP_RX
										FROM diagnosis_opd o
										LEFT JOIN person p
										ON o.HOSPCODE=p.HOSPCODE AND o.PID=p.PID 
										WHERE  
										(SUBSTR(o.DIAGCODE,1,3) BETWEEN 'I10' AND 'I15')
										AND  NOT ISNULL(p.CID)
										GROUP BY p.CID 					
									) as t0
									SET 
										t.HT_LASTVISIT = t0.HT_LASTVISIT
										,t.HT_HOSP_RX = t0.HT_HOSP_RX
									WHERE t.CID=t0.CID ;";
					mysql_query($sql);


			
	// LASTVISIT 
					$sql="UPDATE `me_chroniclastvisit` t
									INNER JOIN 
									(
										SELECT t1.*
										,GROUP_CONCAT(t2.DIAGCODE ORDER BY t2.DIAGTYPE SEPARATOR ','  ) as LAST_DX
FROM 
(
SELECT p.CID,o.HOSPCODE,o.PID
										,SPLIT_STR(GROUP_CONCAT(o.HOSPCODE ORDER BY o.DATE_SERV DESC SEPARATOR ',' ),',',1) AS LAST_HOSPCODE
										,SPLIT_STR(GROUP_CONCAT(o.PID ORDER BY o.DATE_SERV DESC SEPARATOR ',' ),',',1) AS LAST_PID
										,SPLIT_STR(GROUP_CONCAT(o.DATE_SERV ORDER BY o.DATE_SERV DESC SEPARATOR ',' ),',',1) AS LAST_VISIT	
										,SPLIT_STR(GROUP_CONCAT(o.SEQ ORDER BY o.DATE_SERV DESC SEPARATOR ',' ),',',1) AS LAST_SEQ															
										FROM diagnosis_opd o
										LEFT JOIN person p
										ON o.HOSPCODE=p.HOSPCODE AND o.PID=p.PID 
										WHERE NOT ISNULL(p.CID) 
										GROUP BY p.CID 
) as t1 
LEFT JOIN diagnosis_opd t2 
ON t1.LAST_HOSPCODE=t2.HOSPCODE AND t1.LAST_PID=t2.PID  AND t1.LAST_SEQ=t2.SEQ
GROUP BY t1.CID
									) as t0
									SET t.LAST_HOSPCODE=t0.LAST_HOSPCODE
										,t.LAST_VISIT = t0.LAST_VISIT										
										,t.LAST_DX = t0.LAST_DX
									WHERE t.CID=t0.CID ;";
					mysql_query($sql);
$t2= date('Y-m-d h:i:s');
$sqlproc="UPDATE `me_chroniclastvisit` 
			SET UPDATE_AT=CONCAT((TIMESTAMPDIFF(MINUTE,'".$t1."','".$t2."')),'-','".$t1."','-','".$t2."');";
mysql_query($sqlproc);

?>
