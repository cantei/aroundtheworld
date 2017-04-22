SELECT p.CID,m.HN
,v.villagecode,v.villagename,v.tamboncode
,m.DISEASE,m.`NAME`,m.sex,m.AGEY,m.AGEM,m.AGED,m.ADDRESS,DATE_FORMAT(m.DATESICK,'%Y-%m-%d') as DATESICK,DATE_FORMAT(m.DATERECORD,'%Y-%m-%d') as DATERECORD 
FROM me_epidem m  /* temp  TABLE  */
LEFT JOIN person p
ON m.HN=p.HN 
LEFT JOIN cvillage v
ON m.ADDRCODE=v.villagecodefull 
WHERE m.DISEASE='78'
ORDER BY DATEDEFINE DESC 
