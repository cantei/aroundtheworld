
SELECT t1.village
,COUNT(*) total_house
,count(case when all_live > 0 then 1 else null end) as live_house
,count(case when all_live = 0 then 1 else null end) as empty_house
,sum(n_moi) as n_moi
,(sum(type1)+sum(type2)) as n_regist
,sum(type1) as n_type1
,sum(type2) as n_type2
,sum(all_live) as n_live
FROM (
		SELECT SUBSTR(h.villcode,8,1) as village
		,h.pcucode,h.hcode,h.hno
		,sum(if(p.typelive in ('1','2'),1,0)) as n_moi
		,SUM(if(p.typelive IN ('1'),1,0)) as type1
		,SUM(if(p.typelive IN ('2'),1,0)) as type2
		,SUM(if(p.typelive IN ('1','3'),1,0)) as all_live
		FROM house h
		LEFT JOIN person p
		ON h.pcucode=p.pcucodeperson AND h.hcode=p.hcode
		WHERE h.villcode<>'84120700'
		GROUP BY h.villcode,h.pcucode,h.hcode
) as t1 
GROUP BY t1.village

UNION ALL 

SELECT 'TOTAL' as village
,COUNT(*) total_house
,count(case when all_live > 0 then 1 else null end) as live_house
,count(case when all_live = 0 then 1 else null end) as empty_house
,sum(n_moi) as n_moi
,(sum(type1)+sum(type2)) as n_regist
,sum(type1) as n_type1
,sum(type2) as n_type2
,sum(all_live) as n_live
FROM (
		SELECT SUBSTR(h.villcode,8,1) as village
		,h.pcucode,h.hcode,h.hno
		,sum(if(p.typelive in ('1','2'),1,0)) as n_moi
		,SUM(if(p.typelive IN ('1'),1,0)) as type1
		,SUM(if(p.typelive IN ('2'),1,0)) as type2
		,SUM(if(p.typelive IN ('1','3'),1,0)) as all_live
		FROM house h
		LEFT JOIN person p
		ON h.pcucode=p.pcucodeperson AND h.hcode=p.hcode
		WHERE h.villcode<>'84120700'
		GROUP BY h.villcode,h.pcucode,h.hcode
) as t1 


