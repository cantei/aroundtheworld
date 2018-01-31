SELECT YEAR(e.dateepi) as year_id,DATE_FORMAT(e.dateepi,'%m') as month_id
-- ,e.vaccinecode,e.hosservice
,sum(if(e.vaccinecode='BCG',1,0)) as BCG
,sum(if(e.vaccinecode='DHB1',1,0)) as DHB1
,sum(if(e.vaccinecode='DHB2',1,0)) as DHB2
,sum(if(e.vaccinecode='DHB3',1,0)) as DHB3
,sum(if(e.vaccinecode='OPV1',1,0)) as OPV1
,sum(if(e.vaccinecode='OPV2',1,0)) as OPV2
,sum(if(e.vaccinecode='OPV3',1,0)) as OPV3
,sum(if(e.vaccinecode='OPV4',1,0)) as OPV4
,sum(if(e.vaccinecode='OPV5',1,0)) as OPV5
,sum(if(e.vaccinecode='OPV6',1,0)) as OPV6
,sum(if(e.vaccinecode='DTP1',1,0)) as DTP1
,sum(if(e.vaccinecode='DTP2',1,0)) as DTP2
,sum(if(e.vaccinecode='DTP3',1,0)) as DTP3
,sum(if(e.vaccinecode='DTP4',1,0)) as DTP4
,sum(if(e.vaccinecode='DTP5',1,0)) as DTP5
,sum(if(e.vaccinecode='JE1',1,0)) as JE1
,sum(if(e.vaccinecode='JE2',1,0)) as JE2
,sum(if(e.vaccinecode='JE3',1,0)) as JE3
,sum(if(e.vaccinecode='J11',1,0)) as J11
,sum(if(e.vaccinecode='J12',1,0)) as J12
,sum(if(e.vaccinecode='MEAS',1,0)) as MEAS
,sum(if(e.vaccinecode='MMR',1,0)) as MMR
,sum(if(e.vaccinecode='MMR2',1,0)) as MMR2
,sum(if(e.vaccinecode='TT1',1,0)) as TT1
,sum(if(e.vaccinecode='TT2',1,0)) as TT2
,sum(if(e.vaccinecode='TT3',1,0)) as TT3
,sum(if(e.vaccinecode='TT4',1,0)) as TT4
,sum(if(e.vaccinecode='TT5',1,0)) as TT5
FROM visitepi e
WHERE e.hosservice=e.pcucode
GROUP BY  YEAR(e.dateepi),DATE_FORMAT(e.dateepi,'%m')
ORDER BY concat(year_id,month_id) DESC 
