SELECT h.hoscode AS HOSPCODE
,h.hosname AS HOSPNAME
,COUNT(DISTINCT t.CID ) AS TOTAL_PT
,COUNT(DISTINCT t.CID,t.SEQ ) AS TOTAL_VISIT 
,COUNT(DISTINCT t.CID,t.LABTEST ) AS TOTAL_LABTEST
FROM chospital h
LEFT JOIN 
(
SELECT  l.HOSPCODE,l.PID,l.DATE_SERV,l.SEQ,p.CID,l.LABTEST
										FROM labfu l
										LEFT JOIN person p
										ON l.HOSPCODE=p.HOSPCODE AND l.PID=p.PID 
											
WHERE l.DATE_SERV BETWEEN '2014-10-01' AND '2015-09-30'
) as t
ON h.hoscode=t.HOSPCODE 
WHERE h.provcode='67' AND h.distcode='01' AND h.hostype in('03','06') AND h.hoscode<>'99832' 
GROUP BY t.HOSPCODE
ORDER BY h.subdistcode,h.hoscode
