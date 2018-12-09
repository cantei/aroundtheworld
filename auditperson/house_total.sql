# หลังคาเรือนจากการสำรวจ 

SELECT  t3.villcode
,COUNT(*) total_house
,COUNT(case when all_live > 0 then 1 else null end) as live_house
,COUNT(case when all_live = 0 then 1 else null end) as empty_house
,SUM(all_live) as n_live 
FROM 
(
		SELECT t2.villcode,t2.hcode,t2.hno,t2.houseowner
				,SUM(if(t2.typelive IN ('1','3'),1,0)) as all_live 
		,t2.volanteer
		FROM 
		(
		SELECT t0.villcode
		,concat(' ',t0.hno) as hno
		,concat(t0.fname,'   ',t0.lname) as houseowner
		,t0.hcode
		,t1.hnomoi,concat(t1.provcodemoi,t1.distcodemoi,t1.subdistcodemoi,t1.mumoi) as areamoi
		,t1.pcucodeperson,t1.pid,concat(t1.fname,' ',t1.lname) as member,t1.typelive,t1.dischargetype
		,concat(v.fname,' ',v.lname) as volanteer
		FROM
		-- houseowner 
		(
			SELECT 
			SPLIT_STR(if(substr(h.hno,1,1)='0',SPLIT_STR(h.hno,'-',2),h.hno),'/',1) as x1
			,SPLIT_STR(if(substr(h.hno,1,1)='0',SPLIT_STR(h.hno,'-',2),h.hno),'/',2) as x2
			,if(substr(h.hno,1,1)='0',1,0) as x3
			,h.pcucode,h.hcode,h.hno,h.villcode,h.pcucodeperson,h.pid,h.pcucodepersonvola,h.pidvola
			,p.fname,p.lname,p.hnomoi,p.mumoi,p.subdistcodemoi,p.distcodemoi,p.provcodemoi  	
			FROM house h
			LEFT   JOIN person p
			ON h.pcucode=p.pcucodeperson AND h.pid=p.pid
		) as t0
		LEFT JOIN person t1
		ON t0.pcucode=t1.pcucodeperson AND t0.hcode=t1.hcode
		LEFT JOIN person v
		ON t0.pcucodepersonvola=v.pcucodeperson AND t0.pidvola=v.pid 
		WHERE t0.villcode<>'84120700'
		AND t1.dischargetype='9'
		GROUP BY t0.villcode,t0.hno,t1.pid
		ORDER BY t0.villcode,volanteer,t0.x1*1,t0.x2*1,t0.x3*1
		) as t2 
		GROUP BY t2.villcode,t2.hcode
) as t3 
GROUP BY t3.villcode
UNION ALL 
SELECT  'TOTAL' as villcode
,COUNT(*) total_house
,COUNT(case when all_live > 0 then 1 else null end) as live_house
,COUNT(case when all_live = 0 then 1 else null end) as empty_house
,SUM(all_live) as n_live 
FROM 
(
		SELECT t2.villcode,t2.hcode,t2.hno,t2.houseowner
				,SUM(if(t2.typelive IN ('1','3'),1,0)) as all_live 
		,t2.volanteer
		FROM 
		(
		SELECT t0.villcode
		,concat(' ',t0.hno) as hno
		,concat(t0.fname,'   ',t0.lname) as houseowner
		,t0.hcode
		,t1.hnomoi,concat(t1.provcodemoi,t1.distcodemoi,t1.subdistcodemoi,t1.mumoi) as areamoi
		,t1.pcucodeperson,t1.pid,concat(t1.fname,' ',t1.lname) as member,t1.typelive,t1.dischargetype
		,concat(v.fname,' ',v.lname) as volanteer
		FROM
		-- houseowner 
		(
			SELECT 
			SPLIT_STR(if(substr(h.hno,1,1)='0',SPLIT_STR(h.hno,'-',2),h.hno),'/',1) as x1
			,SPLIT_STR(if(substr(h.hno,1,1)='0',SPLIT_STR(h.hno,'-',2),h.hno),'/',2) as x2
			,if(substr(h.hno,1,1)='0',1,0) as x3
			,h.pcucode,h.hcode,h.hno,h.villcode,h.pcucodeperson,h.pid,h.pcucodepersonvola,h.pidvola
			,p.fname,p.lname,p.hnomoi,p.mumoi,p.subdistcodemoi,p.distcodemoi,p.provcodemoi  	
			FROM house h
			LEFT   JOIN person p
			ON h.pcucode=p.pcucodeperson AND h.pid=p.pid
		) as t0
		LEFT JOIN person t1
		ON t0.pcucode=t1.pcucodeperson AND t0.hcode=t1.hcode
		LEFT JOIN person v
		ON t0.pcucodepersonvola=v.pcucodeperson AND t0.pidvola=v.pid 
		WHERE t0.villcode<>'84120700'
		AND t1.dischargetype='9'
		GROUP BY t0.villcode,t0.hno,t1.pid
		ORDER BY t0.villcode,volanteer,t0.x1*1,t0.x2*1,t0.x3*1
		) as t2 
		GROUP BY t2.villcode,t2.hcode
) as t3 
