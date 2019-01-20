SELECT p.fname,p.lname 
,TIMESTAMPDIFF(year,p.birth,'2018-10-01') as age
,p.dischargetype,p.dischargedate
,ht.ht
,dm.dm  
,t1.*
,a.hno as address,a.mu as moo
,h.hno as homeno,h.villcode as homevillage 
,concat(v.fname,' ',v.lname) as volanteer
FROM person p
LEFT JOIN personaddresscontact a
ON p.pcucodeperson=a.pcucodeperson AND p.pid=a.pid  
LEFT JOIN house h
ON p.pcucodeperson=h.pcucode and p.hcode=h.hcode 
LEFT JOIN person v
ON h.pcucodepersonvola=v.pcucodeperson AND h.pidvola=v.pid 
LEFT JOIN 
(
SELECT 
c.pid,GROUP_CONCAT(c.chroniccode ORDER BY c.datefirstdiag) as ht 
FROM personchronic c
WHERE substr(c.chroniccode,1,3) BETWEEN 'I10' AND 'I15'
GROUP BY c.pid
) as ht
ON p.pid=ht.pid
LEFT JOIN 
(
SELECT 
c.pid,GROUP_CONCAT(c.chroniccode ORDER BY c.datefirstdiag) as dm
FROM personchronic c
WHERE substr(c.chroniccode,1,3) BETWEEN 'E10' AND 'E14'
GROUP BY c.pid
) as dm
ON p.pid=dm.pid


LEFT JOIN 
(
				SELECT s.pid as hn
				,s.visitno
				,s.screen_date 
				,s.age_year
				,s.weight
				,s.height  
				,s.waist
				,s.bmi 
				,concat(hbp_s1,' / ',hbp_d1) as bp1
				,concat(hbp_s2,' / ',hbp_d2) as bp2
				,s.bsl
				,s.smoke
				,CASE WHEN s.smoke='1' THEN 'ไม่สูบ' 
				WHEN s.smoke='2' THEN 'นานๆครั้ง' 
				WHEN s.smoke='3' THEN 'เป็นครั้งคราว' 
				WHEN s.smoke='4' THEN 'ประจำ' 
				WHEN s.smoke='9' THEN 'ไม่ทราบ' 
				ELSE NULL
				END as 'useTobacco'
				,s.alcohol  
				,CASE WHEN s.alcohol='1' THEN 'ไม่ดื่ม' 
				WHEN s.alcohol='2' THEN 'นานๆครั้ง' 
				WHEN s.alcohol='3' THEN 'เป็นครั้งคราว' 
				WHEN s.alcohol='4' THEN 'ประจำ' 
				WHEN s.smoke='9' THEN 'ไม่ทราบ' 
				ELSE NULL
				END as 'useAlchohol'
				,d.codescreen
				,CASE WHEN d.coderesult='1' THEN 'Normal'
						WHEN d.coderesult='2' THEN 'AbNormal'
					ELSE 'UnKnown'
				END as 'result2q'
				,CASE WHEN d.depressed='0' THEN 'ไม่มี'
							WHEN d.depressed='1' THEN 'มี'
				ELSE 'UnKnown'
				END as 'q1'
				,CASE WHEN d.fedup='0' THEN 'ไม่มี'
							WHEN d.fedup='1' THEN 'มี'
				ELSE 'UnKnown'
				END as 'q2'
				FROM ncd_person_ncd_screen s
				LEFT JOIN visitscreenspecialdisease d
				ON s.visitno=d.visitno 
				WHERE s.screen_date BETWEEN '2018-10-01' AND '2019-09-30'
) as t1
ON p.pid=t1.hn 
WHERE  p.typelive in ('1','3')
AND p.dischargetype='9'
AND TIMESTAMPDIFF(year,p.birth,'2018-10-01') BETWEEN 60 AND 200 
AND ISNULL(ht)
ORDER BY age DESC 
-- HAVING dischargetype='1' AND NOT ISNULL(visitno)
