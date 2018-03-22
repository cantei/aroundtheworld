SELECT count(DISTINCT pid) n
,sum(if(substr(vaccinecode,1,3)='DHB',1,0)) as DHB
,sum(if(substr(vaccinecode,1,3)='OPV',1,0)) as OPV
,sum(if(substr(vaccinecode,1,3)='IPV',1,0)) as IPV
,sum(if(substr(vaccinecode,1,3)='MMR',1,0)) as MMR
,sum(if(substr(vaccinecode,1,3)='DTP',1,0)) as DTP
,sum(if(substr(vaccinecode,1,3) IN ('J11','JE12'),1,0)) as LAJE
FROM visitepi 
WHERE pcucode=hosservice
and dateepi BETWEEN '2018-03-01' AND '2018-03-31'
