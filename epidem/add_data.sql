INSERT INTO epidemtotal 
( `E0`,`E1`,`DISEASECODE`,`DISEASENAME`
,`FULLNAME`,`ADDRESS`,`ADDRCODE`,`SEX`,`AGEY`,`AGEM`,`AGED`,`OCCUPAT`,`HOSPITAL`,`PTTYPE`,`RESULTS`,`HSERV`,`DAY4`,`DAY5`,`NATION`)

SELECT 
 `E0`,`E1`,`DISEASE`
,t2.group506name as `DISEASENAME`
,`NAME`,`ADDRESS`,`ADDRCODE`,`SEX`,`AGEY`,`AGEM`,`AGED`,`OCCUPAT`,`HOSPITAL`,`TYPE`,`RESULT`,`HSERV`,`DATESICK`,`DATEDEFINE`,`RACE`
FROM p8461_1_38443 t1
LEFT JOIN cdisease506 t2  
ON t1.DISEASE=t2.group506code 
WHERE substr(ADDRCODE,1,6)='841207'
