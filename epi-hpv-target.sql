SELECT personstudent.pid,person.idcard,CONCAT(ctitle.titlename,person.fname," ",person.lname) as fullname
-- ,convert(concat(getAgeYearNum(birth,curdate())," ปี ",getAgeMonthNum(birth,curdate())," เดือน ",getAgeDayNum(birth,curdate())," วัน ")using utf8)as age 
,getageymd(person.birth,CURRENT_DATE()) AS age
,house.hno,right(house.villcode,2)as mu,cschoolclass.classname,villageschool.schoolname#,studenthealthcheck.result,LAST_DAY(studenthealthcheck.dateservice)
FROM personstudent
INNER JOIN person on personstudent.pcucodeperson = person.pcucodeperson and personstudent.pid=person.pid
INNER JOIN ctitle on person.prename=ctitle.titlecode
INNER JOIN house on person.pcucodeperson=house.pcucodeperson and person.hcode=house.hcode
INNER JOIN cschoolclass on personstudent.classeducate=cschoolclass.classcode
INNER JOIN villageschool on personstudent.schoolno=villageschool.schoolno
#LEFT JOIN studenthealthcheck ON personstudent.pid=studenthealthcheck.pid AND personstudent.pcucodeperson=studenthealthcheck.pcucodeperson
WHERE
personstudent.classeducate = '7' AND person.sex='2' AND personstudent.yeareducate='2557'
ORDER BY villageschool.schoolname ASC
