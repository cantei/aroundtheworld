# 

SELECT
	p.pcucodeperson,
		p.pid,
		p.fname,
		CONCAT(c.titlename,p.fname,' ',p.lname) AS pname,
		p.birth,
		h.hno,
		h.villcode,
		h.xgis,
		h.ygis,
visit.pid as pid1,
visit.visitno,
count(distinct visit.visitno) as count_visit,
max(visit.visitdate) as visitdate,
visithomehealthindividual.homehealthtype,
max(chomehealthtype.homehealthmeaning) as homehealthmeaning,
max(visithomehealthindividual.patientsign) as patientsign,
max(visithomehealthindividual.homehealthdetail) as homehealthdetail,
max(visithomehealthindividual.homehealthresult) as homehealthresult,
max(visithomehealthindividual.homehealthplan) as homehealthplan,
max(visithomehealthindividual.dateappoint) as dateappoint,
concat(ctitle.titlename,`user`.fname,`user`.lname) as userh,
max(visithomehealthindividual.`user`) as `user`
FROM visit
LEFT JOIN person p
ON p.pcucodeperson=visit.pcucode AND p.pid=visit.pid 
		Inner Join house h ON p.pcucodeperson = h.pcucode AND p.hcode = h.hcode
		Inner Join village v ON h.pcucode = v.pcucode AND h.villcode = v.villcode
		left Join ctitle c ON p.prename = c.titlecode
Inner Join visithomehealthindividual ON visit.pcucode = visithomehealthindividual.pcucode AND visit.visitno = visithomehealthindividual.visitno
Inner Join chomehealthtype ON visithomehealthindividual.homehealthtype = chomehealthtype.homehealthcode
INNER JOIN `user` ON visit.pcucodeperson = `user`.pcucode AND visithomehealthindividual.`user` = `user`.username
left JOIN ctitle ON `user`.prename = ctitle.titlecode
where visit.visitdate between '2017-01-01' and '2017-10-01' 
and (visit.flagservice <'04' OR visit.flagservice is null OR length(trim(visit.flagservice))=0 )
AND visithomehealthindividual.homehealthtype='1A014'
group by visit.pcucodeperson,visit.pid;



# before update 

SELECT *
FROM 
(
		SELECT
		p.pcucodeperson,
		p.pid,
		p.fname,
		CONCAT(c.titlename,p.fname,' ',p.lname) AS pname,
		p.birth,
		h.hno,
		h.villcode,
		h.xgis,
		h.ygis
		
		-- FLOOR((TO_DAYS(NOW())-TO_DAYS(p.birth))/365.25) AS age
		FROM  person p
		Inner Join house h ON p.pcucodeperson = h.pcucode AND p.hcode = h.hcode
		Inner Join village v ON h.pcucode = v.pcucode AND h.villcode = v.villcode
		left Join ctitle c ON p.prename = c.titlecode
		left Join visit i ON p.pcucodeperson=i.pcucode AND p.pid=i.pid 
		left Join visitdiag d ON i.pcucode=d.pcucode AND i.visitno=d.visitno
		WHERE substr(d.diagcode,1,3)  BETWEEN 'A15' AND 'A19'
		AND  ((p.dischargetype is null) or (p.dischargetype = '9')) 
		AND SUBSTRING(h.villcode,7,2) <> '00' 
		AND i.visitdate between '2017-01-01' and '2017-10-01' 
		-- AND  $wvill 
		-- ORDER BY h.villcode, p.fname
group by p.pcucodeperson,p.pid
) as t1 
LEFT JOIN 
(
		SELECT
visit.pcucodeperson as pcucodeperson1,
visit.pid as pid1,
visit.visitno,
count(distinct visit.visitno) as count_visit,
max(visit.visitdate) as visitdate,
visithomehealthindividual.homehealthtype,
max(chomehealthtype.homehealthmeaning) as homehealthmeaning,
max(visithomehealthindividual.patientsign) as patientsign,
max(visithomehealthindividual.homehealthdetail) as homehealthdetail,
max(visithomehealthindividual.homehealthresult) as homehealthresult,
max(visithomehealthindividual.homehealthplan) as homehealthplan,
max(visithomehealthindividual.dateappoint) as dateappoint,
concat(ctitle.titlename,`user`.fname,`user`.lname) as userh,
max(visithomehealthindividual.`user`) as `user`
FROM visit
Inner Join visithomehealthindividual ON visit.pcucode = visithomehealthindividual.pcucode AND visit.visitno = visithomehealthindividual.visitno
Inner Join chomehealthtype ON visithomehealthindividual.homehealthtype = chomehealthtype.homehealthcode
INNER JOIN `user` ON visit.pcucodeperson = `user`.pcucode AND visithomehealthindividual.`user` = `user`.username
left JOIN ctitle ON `user`.prename = ctitle.titlecode
where visit.visitdate between '2017-01-01' and '2017-10-01' 
and (visit.flagservice <'04' OR visit.flagservice is null OR length(trim(visit.flagservice))=0 )
AND visithomehealthindividual.homehealthtype='1A014'
group by visit.pcucodeperson,visit.pid
) as t2 
ON t1.pcucodeperson=t2.pcucodeperson1 AND t1.pid=t2.pid1
