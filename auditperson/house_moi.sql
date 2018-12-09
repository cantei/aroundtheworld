SELECT concat(p.provcodemoi,p.distcodemoi,p.subdistcodemoi,p.mumoi) as moo
,count(DISTINCT hnomoi) n 
,sum(if(p.typelive in ('1','2'),1,0)) as n_moi
,sum(if(p.typelive in ('1'),1,0)) as type1
,sum(if(p.typelive in ('2'),1,0)) as type2

FROM person p
WHERE concat(p.provcodemoi,p.distcodemoi,p.subdistcodemoi)='841207'
AND p.typelive in('1','2')
AND p.dischargetype='9'
GROUP BY moo
UNION ALL 
SELECT 'TOTAL' as moo
,count(DISTINCT hnomoi) n 
,sum(if(p.typelive in ('1','2'),1,0)) as n_moi
,sum(if(p.typelive in ('1'),1,0)) as type1
,sum(if(p.typelive in ('2'),1,0)) as type2
FROM person p
WHERE concat(p.provcodemoi,p.distcodemoi,p.subdistcodemoi)='841207'
AND p.typelive in('1','2')
AND p.dischargetype='9'

