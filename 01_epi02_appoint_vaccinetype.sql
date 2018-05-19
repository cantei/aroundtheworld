# เบิกวัคซีน
-- Appointment VaccineType  ON Any Month

SET  @y=YEAR(CURDATE()) ;
SET  @m=(MONTH(CURDATE())+0) ;

SELECT 'vaccinetype' as vaccinetype
,sum(if(vaccinecode in ('DHB1','DHB2','DHB3'),1,0)) as DHB
,sum(if(vaccinecode in ('OPV1','OPV2','OPV3','OPV4','OPV5'),1,0)) as OPV
,sum(if(vaccinecode in ('IPV-P'),1,0)) as IPV
,sum(if(vaccinecode in ('MMR','MMR2'),1,0)) as MMR
,sum(if(vaccinecode in ('DTP4','DTP5'),1,0)) as DTP
,sum(if(vaccinecode in ('J11','J12'),1,0)) as LAJE
FROM visitepiappoint 
WHERE YEAR(dateappoint)=@y AND MONTH(dateappoint)=@m;
GROUP BY vaccinetype;
