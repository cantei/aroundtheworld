SELECT t5.pcucodeperson,t5.pid,t5.idcard,t5.fname,t5.lname,t5.birth,t5.born,t5.age_y,t5.age_m,t5.age_d,t5.sex,t5.hcode,t5.typelive
		,t5.parent
		,t5.hno,t5.moo,t5.xgis,t5.ygis
		,concat(t5.fname,'  ',t5.lname) as volanteer
,CONCAT(COALESCE(cbcg1,''),',',COALESCE(chbv1,'')
					,',',COALESCE(cdhb1,''),',',COALESCE(copv1,'')
					,',',COALESCE(cdhb2,''),',',COALESCE(copv2,''),',',COALESCE(cipv1,'')
					,',',COALESCE(cdhb3,''),',',COALESCE(copv3,'')
					,',',IFNULL(cmmr1,'') 
					,',',IFNULL(clje1,'')
					,',',COALESCE(cdtp4,''),',',COALESCE(copv4,'')
					,',',IFNULL(clje2,'')
					,',',IFNULL(cmmr2,'')
					,',',COALESCE(cdtp5,''),',',COALESCE(copv5,'')

)  as missed_items
FROM 
(
		SELECT t3.pcucodeperson,t3.pid,t3.idcard,t3.fname,t3.lname,t3.birth,t3.born,t3.age_y,t3.age_m,t3.age_d,t3.sex,t3.hcode,t3.typelive
		,t3.parent
		,t3.hno,t3.moo,t3.xgis,t3.ygis
		,concat(t4.fname,'  ',t4.lname) as volanteer
		,t3.BCG,t3.HBV1,t3.DHB1,t3.OPV1,t3.DHB2,t3.OPV2,t3.DHB3,t3.OPV3	,t3.IPV,t3.MMR1
		,t3.LAJE1
		,t3.DTP4,t3.OPV4,t3.LAJE2,t3.MMR2
		,t3.DTP5,t3.OPV5
		,if((getAgeDayNum(t3.birth,CURDATE()) > 1)  AND ISNULL(BCG ) ,'BCG',NULL) as cbcg1
		,if((getAgeDayNum(t3.birth,CURDATE()) > 1) AND (ISNULL(HBV1)),'HBV1',NULL) as chbv1
		,if((TIMESTAMPDIFF(MONTH,t3.birth,CURDATE()) > 2) AND (ISNULL(DHB1)),'DHB1',NULL) as cdhb1
		,if((TIMESTAMPDIFF(MONTH,t3.birth,CURDATE()) > 4) AND (ISNULL(DHB2)),'DHB2',NULL) as cdhb2
		,if((TIMESTAMPDIFF(MONTH,t3.birth,CURDATE()) > 6) AND (ISNULL(DHB3)),'DHB3',NULL) as cdhb3
		,if((TIMESTAMPDIFF(MONTH,t3.birth,CURDATE()) > 2) AND (ISNULL(OPV1)),'OPV1',NULL) as copv1
		,if((TIMESTAMPDIFF(MONTH,t3.birth,CURDATE()) > 4) AND (ISNULL(OPV2)),'OPV2',NULL) as copv2
		,if((TIMESTAMPDIFF(MONTH,t3.birth,CURDATE()) > 6) AND (ISNULL(OPV3)),'OPV3',NULL) as copv3
		,if((TIMESTAMPDIFF(MONTH,t3.birth,CURDATE()) > 4) AND (t3.birth > '2015-08-01') AND (ISNULL(IPV)),'IPV',NULL) as cipv1
		,if((TIMESTAMPDIFF(MONTH,t3.birth,CURDATE()) > 9) AND (ISNULL(MMR1)),'MMR1',NULL) as cmmr1
		,if((TIMESTAMPDIFF(MONTH,t3.birth,CURDATE()) > 12) AND (t3.birth > '2015-10-01') AND (ISNULL(LAJE1)),'LAJE1',NULL) as clje1
		,if((TIMESTAMPDIFF(MONTH,t3.birth,CURDATE()) > 18) AND (ISNULL(DTP4)),'DTP4',NULL) as cdtp4
		,if((TIMESTAMPDIFF(MONTH,t3.birth,CURDATE()) > 18) AND (ISNULL(OPV4)),'OPV4',NULL) as copv4
		,if((TIMESTAMPDIFF(MONTH,t3.birth,CURDATE()) > 30) AND (t3.birth > '2015-10-01')  AND (ISNULL(LAJE2)),'LAJE2',NULL) as clje2
		,if((TIMESTAMPDIFF(MONTH,t3.birth,CURDATE()) > 30) AND (ISNULL(MMR2)),'MMR2',NULL) as cmmr2
		,if((TIMESTAMPDIFF(MONTH,t3.birth,CURDATE()) > 48) AND (ISNULL(DTP5)),'DTP5',NULL) as cdtp5
		,if((TIMESTAMPDIFF(MONTH,t3.birth,CURDATE()) > 48) AND (ISNULL(OPV5)),'OPV5',NULL) as copv5
		FROM 
		(
				SELECT t0.pcucodeperson,t0.pid,t0.idcard
				,t0.fname,t0.lname,t0.birth
				,concat(DATE_FORMAT(t0.birth,'%d-%m'),'-',(YEAR(t0.birth))+543) as born
				,GetAgeYearNum(t0.birth,CURDATE())  as age_y
				,getAgeMonthNum(t0.birth,CURDATE())  as age_m
				,getAgeDayNum(t0.birth,CURDATE())  as age_d
				,t0.sex,t0.hcode,t0.typelive
				,concat(t0.mother,' - ',t0.father) as parent
				,t1.BCG,t1.HBV1,t1.DHB1,t1.OPV1,t1.DHB2,t1.OPV2,t1.DHB3,t1.OPV3	,t1.IPV,t1.MMR1
				,t1.LAJE1
				,t1.DTP4,t1.OPV4,t1.LAJE2,t1.MMR2
				,t1.DTP5,t1.OPV5
				,t2.hno,substr(t2.villcode,7,2) as moo,t2.xgis,t2.ygis,t2.pcucodepersonvola,t2.pidvola
				FROM person t0
				LEFT JOIN 
				(
									SELECT e.pcucodeperson,e.pid
									,MIN(IF(e.vaccinecode='BCG',e.dateepi,NULL)) AS BCG
									,MIN(IF(e.vaccinecode='HBV1',e.dateepi,NULL)) AS HBV1
									,MIN(IF(e.vaccinecode='DHB1',e.dateepi,NULL)) AS DHB1
									,MIN(IF(e.vaccinecode='OPV1',e.dateepi,NULL)) AS OPV1
									,MIN(IF(e.vaccinecode='DHB2',e.dateepi,NULL)) AS DHB2
									,MIN(IF(e.vaccinecode='OPV2',e.dateepi,NULL)) AS OPV2
									,MIN(IF(e.vaccinecode='IPV-P',e.dateepi,NULL)) AS IPV
									,MIN(IF(e.vaccinecode='DHB3',e.dateepi,NULL)) AS DHB3
									,MIN(IF(e.vaccinecode='OPV3',e.dateepi,NULL)) AS OPV3
									,MIN(IF(e.vaccinecode='MMR1' OR e.vaccinecode='MMR',e.dateepi,NULL)) AS MMR1
									,MIN(IF(e.vaccinecode='J11',e.dateepi,NULL)) AS LAJE1
									,MIN(IF(e.vaccinecode='DTP4',e.dateepi,NULL)) AS DTP4
									,MIN(IF(e.vaccinecode='OPV4',e.dateepi,NULL)) AS OPV4
									,MIN(IF(e.vaccinecode='J12',e.dateepi,NULL)) AS LAJE2
									,MIN(IF(e.vaccinecode='MMR2' OR e.vaccinecode='MMR',e.dateepi,NULL)) AS MMR2
									,MIN(IF(e.vaccinecode='DTP5',e.dateepi,NULL)) AS DTP5
									,MIN(IF(e.vaccinecode='OPV5',e.dateepi,NULL)) AS OPV5
									FROM visitepi e
									GROUP BY e.pcucodeperson,e.pid
				) as t1 
				ON t0.pcucodeperson=t1.pcucodeperson AND t0.pid=t1.pid
				LEFT JOIN house t2
				ON t0.pcucodeperson=t2.pcucode AND t0.hcode=t2.hcode
				WHERE t0.birth  BETWEEN 	DATE_SUB(CURDATE(), INTERVAL 5 YEAR) AND CURDATE()
				AND t0.typelive in ('1','3')  and	 t0.dischargetype='9'
		) as t3
		LEFT JOIN person t4
		ON t3.pcucodeperson=t4.pcucodeperson AND t3.pid=t4.pid
) as t5
HAVING missed_items LIKE '%1%' OR  missed_items LIKE '%2%' OR missed_items LIKE '%3%' OR missed_items LIKE '%4%' OR missed_items LIKE '%5%'


