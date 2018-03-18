SET @birth_start_d := '20170101';
SET @birth_end_d := '20171231';
SET @death_start_d := '20170101';
SET @death_end_d := '20171231';
SET @pop_day := '20170701';
SELECT 
/*village.villno AS 'หมู่ที่',
village.villname AS 'ชื่อหมู่บ้าน',*/
person.pcucodeperson,chospital.hosname,
COUNT( case when TIMESTAMPDIFF(year,birth,now())between 0 and 300 and person.sex = 1 then chospital.hoscode = person.pcucodeperson else null end)as ชาย,
concat(round(count(case when TIMESTAMPDIFF(year,birth,now())between 0 and 300 and person.sex = 1 then chospital.hoscode = person.pcucodeperson else null end)*100/ 
count( case when TIMESTAMPDIFF(year,birth,now())between 0 and 300 then chospital.hoscode = person.pcucodeperson else null end),2),' %') as 'ร้อยละ ชาย',
COUNT( case when TIMESTAMPDIFF(year,birth,now())between 0 and 300 and person.sex = 2 then chospital.hoscode = person.pcucodeperson else null end)as หญิง,
concat(round(count(case when TIMESTAMPDIFF(year,birth,now())between 0 and 300 and person.sex = 2 then chospital.hoscode = person.pcucodeperson else null end)*100/ 
count( case when TIMESTAMPDIFF(year,birth,now())between 0 and 300 then chospital.hoscode = person.pcucodeperson else null end),2),' %') as 'ร้อยละหญิง',
COUNT( case when TIMESTAMPDIFF(year,birth,now())between 0 and 300 then chospital.hoscode = person.pcucodeperson else null end)as รวม,
concat(round(count(case when TIMESTAMPDIFF(year,birth,now())between 0 and 300 then chospital.hoscode = person.pcucodeperson else null end)*100/ 
count( case when TIMESTAMPDIFF(year,birth,now())between 0 and 300 then chospital.hoscode = person.pcucodeperson else null end),2),' %') as 'ร้อยละรวม'
,COUNT( case when TIMESTAMPDIFF(year,birth,@pop_day)between 0 and 300 then chospital.hoscode = person.pcucodeperson else null end)as ประชากรกลางปี
,COUNT( case when person.BIRTH BETWEEN @birth_start_d and @birth_end_d then chospital.hoscode = person.pcucodeperson else null end)as 'คนเกิด2560'
,(SELECT COUNT(DISTINCT concat(person.pid,person.pcucodeperson))from person 
INNER JOIN persondeath ON persondeath.pcucodeperson = person.pcucodeperson AND persondeath.pid = person.pid
where chospital.hoscode = person.pcucodeperson and persondeath.deaddate BETWEEN @death_start_d and @death_end_d ) AS 'คนเสียชีวิต2560'
,concat(round(count(case when person.birth BETWEEN @birth_start_d and @birth_end_d then chospital.hoscode = person.pcucodeperson else null end)*1000/ 
count( case when TIMESTAMPDIFF(year,birth,@pop_day)between 0 and 300 then chospital.hoscode = person.pcucodeperson else null end),2),' %') as 'อัตราเกิด'
,concat(round((SELECT COUNT(DISTINCT concat(person.pid,person.pcucodeperson))from person 
left JOIN persondeath ON persondeath.pcucodeperson = person.pcucodeperson AND persondeath.pid = person.pid
where chospital.hoscode = person.pcucodeperson and persondeath.deaddate BETWEEN @death_start_d and @death_end_d
)*1000/ count( case when TIMESTAMPDIFF(year,birth,@pop_day)between 0 and 300 then chospital.hoscode = person.pcucodeperson else null end),2),' %') as 'อัตราตาย'
,concat(round(count(case when person.birth BETWEEN @birth_start_d and @birth_end_d then chospital.hoscode = person.pcucodeperson else null end
)- (SELECT COUNT(DISTINCT concat(person.pid,person.pcucodeperson))from person 
INNER JOIN persondeath ON persondeath.pcucodeperson = person.pcucodeperson AND persondeath.pid = person.pid
where chospital.hoscode = person.pcucodeperson and persondeath.deaddate BETWEEN @death_start_d and @death_end_d))) as 'เพิ่ม หรือ ลด'
FROM
person 
INNER JOIN house ON house.pcucodeperson = person.pcucodeperson AND house.hcode = person.hcode
INNER JOIN village ON village.pcucode = house.pcucode AND village.villcode = house.villcode
INNER JOIN personaddresscontact ON personaddresscontact.pcucodeperson = person.pcucodeperson AND personaddresscontact.pid = person.pid
INNER JOIN chospital ON chospital.hoscode = person.pcucodeperson
WHERE person.dischargetype = '9' AND person.typelive IN ('0','1','3') and person.nation = 099
GROUP BY person.pcucodeperson;
