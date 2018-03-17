# 1 DM HbA1C > 7
# 2 COPD or Asthma
# 3 ADL low score 
SELECT t0.fullname,t0.birth,t0.age,t0.hno,t0.moo
-- ,t0.ref,t0.grp
,GROUP_CONCAT(t0.ref ORDER BY t0.grp ) as factors
,t0.volanteer
FROM 
(
		SELECT p.idcard
		,concat(c.titlename,p.fname,'   ',p.lname) as fullname
		,p.birth
		,TIMESTAMPDIFF(year,p.birth,CURDATE()) as age
		,h.hno,substr(h.villcode,7,2) as moo 
		-- ,t1.dm 
		-- ,t2.hb as hba1c
		,'DM_uncontrol' as ref
		,'1' as grp
		,concat(v.fname,'  ',v.lname) as 'volanteer' 
		FROM person p
		INNER  JOIN ctitle c
		ON p.prename=c.titlecode
		INNER JOIN house h
		ON p.pcucodeperson=h.pcucode AND p.hcode=h.hcode
		LEFT JOIN person v
		ON h.pcucodepersonvola=v.pcucodeperson and	h.pidvola=v.pid 
		INNER JOIN me_dmht2find_hmain t1
		ON p.idcard=t1.idcard 
		INNER JOIN me_4findservice_hmain t2
		ON p.idcard=t2.cid 
		WHERE  p.typelive in('1','3')
		AND p.dischargetype='9'
		AND NOT ISNULL(t1.dm) AND t2.hb>7
		UNION 
		-- COPD  OR ASTHMA
		SELECT p.idcard
		,concat(c.titlename,p.fname,'   ',p.lname) as fullname
		,p.birth
		,TIMESTAMPDIFF(year,p.birth,CURDATE()) as age
		,h.hno,substr(h.villcode,7,2) as moo 
		-- ,t1.copd,t1.asthma 
		,'COPD/Asthma' as ref
		,'2' as grp
		,concat(v.fname,'  ',v.lname) as 'volanteer' 
		FROM person p
		INNER  JOIN ctitle c
		ON p.prename=c.titlecode
		INNER JOIN house h
		ON p.pcucodeperson=h.pcucode AND p.hcode=h.hcode
		LEFT JOIN person v
		ON h.pcucodepersonvola=v.pcucodeperson and	h.pidvola=v.pid 
		INNER JOIN me_chronic_multidisease t1
		ON p.idcard=t1.idcard 
		WHERE  p.typelive in('1','3')
		AND p.dischargetype='9'
		AND (NOT ISNULL(t1.copd) OR NOT ISNULL(t1.asthma))

		-- ADL  Low Score
		UNION 
		SELECT p.idcard
		, concat(ct.titlename,p.fname,'   ',p.lname) as fullname
		,p.birth
		,TIMESTAMPDIFF(year,p.birth,CURDATE()) as age
		,h.hno,substr(h.villcode,7,2) as moo 
		,'สูงอายุติดเตียง' as ref
		,'3' as grp
		,concat(v.fname,'  ',v.lname) as 'volanteer' 
		FROM person p 
		LEFT JOIN ctitle ct ON p.prename=ct.titlecode
		INNER JOIN house h ON p.hcode=h.hcode 
		INNER JOIN f43specialpp spp ON p.pid=spp.pid
		LEFT JOIN person v
		ON h.pcucodepersonvola=v.pcucodeperson and	h.pidvola=v.pid 
		WHERE p.typelive IN ('1','3')
		AND p.dischargetype='9'
		AND getAgeYearNum(p.birth,CURDATE())>= '60' 
		AND p.pid NOT IN (
					SELECT pd.pid FROM persondeath pd
		) 
		AND spp.dateserv BETWEEN '2016-10-01'AND CURDATE()
		AND spp.ppspecial='1B1282'
		-- WHERE  adl in ('1B1280','1B1281','1B1282')
		/*
		AND (
					spp.ppspecial BETWEEN '1B1280'AND'1B1289' OR spp.ppspecial BETWEEN '1B1273'AND'1B1279'
					OR spp.ppspecial BETWEEN '1B0280'AND'1B0289' OR spp.ppspecial BETWEEN '1B1200'AND'1B1209'
					OR spp.ppspecial BETWEEN '1B1220'AND'1B1229' OR spp.ppspecial BETWEEN '1B1230'AND'1B1239'
					OR spp.ppspecial BETWEEN '1B1240'AND'1B1249' OR spp.ppspecial BETWEEN '1B1260'AND'1B1269'
					OR spp.ppspecial BETWEEN '1B1283'AND'1B1285' OR spp.ppspecial BETWEEN '1B1270'AND'1B1279'
		)
		*/
) as t0
GROUP BY t0.idcard 
ORDER BY (moo*1),volanteer;
