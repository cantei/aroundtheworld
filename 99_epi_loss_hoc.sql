select SUBSTRING(EPI.villcode,7,2) as moo,EPI.hno,EPI.pid,CONCAT(EPI.fname,' ',EPI.lname)as pname 
,EPI.birth,EPI.age,EPI.BCG,EPI.DHB1,EPI.OPV1,EPI.DHB2,EPI.HBV1,EPI.IPV,EPI.OPV2,EPI.DHB3,EPI.OPV3,EPI.MMR,EPI.JE1,EPI.JE2,EPI.JE11,EPI.JE12 
,case when (EPI.BCG and EPI.HBV1 and EPI.DHB3 and EPI.OPV3 and EPI.MMR )!='0' then 'com'else'notcom'end as cover ,EPI.pcucodeperson
,COUNT(DISTINCT concat(EPI.pcucodeperson,EPI.pid))as total 
FROM (
SELECT house.villcode,house.hno,person.pcucodeperson,person.pid,person.birth,person.fname,person.lname,getagemonth(person.birth,CURDATE() )as age 
,max(case when cdrug.files18epi='010'then visitepi.dateepi else '0' end)as BCG 
,max(case when cdrug.files18epi in('041')then visitepi.dateepi else '0' end)as HBV1 
,max(case when cdrug.files18epi in ('031','091')then visitepi.dateepi else '0' end)as DHB1 
,max(case when cdrug.files18epi in('032','092')then visitepi.dateepi else '0' end)as DHB2 
,max(case when cdrug.files18epi in('401')then visitepi.dateepi else '0' end)as IPV 
,max(case when cdrug.files18epi in('033','093')then visitepi.dateepi else '0' end)as DHB3 
,max(case when cdrug.files18epi='034'then visitepi.dateepi else '0' end)as DTP4 
,max(case when cdrug.files18epi='035'then visitepi.dateepi else '0' end)as DTP5 
,max(case when cdrug.files18epi='081'then visitepi.dateepi else '0' end)as OPV1 
,max(case when cdrug.files18epi='082'then visitepi.dateepi else '0' end)as OPV2 
,max(case when cdrug.files18epi='083'then visitepi.dateepi else '0' end)as OPV3 
,max(case when cdrug.files18epi='084'then visitepi.dateepi else '0' end)as OPV4 
,max(case when cdrug.files18epi='085'then visitepi.dateepi else '0' end)as OPV5 
,max(case when cdrug.files18epi='061'then visitepi.dateepi else '0' end)as MMR 
,max(case when cdrug.files18epi='051'then visitepi.dateepi else '0' end)as JE1 
,max(case when cdrug.files18epi='052'then visitepi.dateepi else '0' end)as JE2 
,max(case when cdrug.files18epi='JE11'then visitepi.dateepi else '0' end)as JE11 
,max(case when cdrug.files18epi='JE12'then visitepi.dateepi else '0' end)as JE12 
,max(case when cdrug.files18epi='053'then visitepi.dateepi else '0' end)as JE3 
FROM person 
INNER JOIN house 
on person.hcode=house.hcode AND person.pcucodeperson=house.pcucodeperson 
LEFT JOIN visitepi 
on person.pid=visitepi.pid AND person.pcucodeperson=visitepi.pcucodeperson 
LEFT JOIN cdrug on visitepi.vaccinecode=cdrug.drugcode 
WHERE person.typelive in ('1','3') and getagemonth(person.birth,CURDATE() ) between 49 and 60
GROUP BY CONCAT(person.pcucodeperson,person.pid)
)as EPI 
-- WHERE EPI.MMR = 0 or EPI.DHB3= 0 or EPI.OPV3= 0 or EPI.BCG= 0 
GROUP BY EPI.pid 
ORDER BY EPI.birth
