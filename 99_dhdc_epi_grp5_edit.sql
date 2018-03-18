UPDATE hdc_rpt_sql h
SET h.sql_sum="SET @b_year:=(SELECT yearprocess FROM sys_config LIMIT 1);
SET	@start_d:=concat(@b_year-1,'1001');
SET @end_d:=concat(@b_year,'0930');
SELECT t.HOSPCODE,t.HOSNAME,t.B,t.A,ROUND(t.A/t.B*100,2) RATE from (
SELECT 
t1.check_hosp HOSPCODE,h.hosname HOSNAME

,SUM(CASE WHEN DATE_FORMAT(t1.birth,'%Y%m%d') BETWEEN concat(@b_year-6,'1001') AND concat(@b_year-5,'0930') 
THEN 1 ELSE 0 END) B
,SUM(CASE WHEN DATE_FORMAT(t1.birth,'%Y%m%d') BETWEEN concat(@b_year-6,'1001') AND concat(@b_year-5,'0930') 
AND t1.bcg_date is not null AND t1.hbv1_date is not null 
AND t1.opv3_date is not null AND t1.dtp3_date is not null 
AND t1.mmr1_date is not null AND t1.hbv3_date is not null 
AND t1.dtp4_date is not null AND t1.opv4_date is not null 
AND t1.mmr2_date is not null 
AND 
(
(NOT ISNULL(je1_date) and	NOT ISNULL(je2_date) and	NOT ISNULL(je3_date))
OR (NOT ISNULL(je1_date) and	NOT ISNULL(je2_date) and	( NOT ISNULL(j11_date)))
OR (NOT ISNULL(je1_date) and	NOT ISNULL(je2_date) and	( NOT ISNULL(j12_date))) /*  where  key in is error  */
OR (NOT ISNULL(je1_date) and	NOT ISNULL(j11_date) and	NOT ISNULL(j12_date))
OR (NOT ISNULL(j11_date) and	NOT ISNULL(j12_date)) 
OR (NOT ISNULL(je1_date) and	NOT ISNULL(j11_date))
)
AND t1.opv5_date is not null AND t1.dtp5_date is not null 
THEN 1 ELSE 0 END) A

FROM
(
		SELECT 
		*
		FROM
		(
		SELECT
		a.*,p.check_hosp,p.check_vhid as areacode
		FROM
		t_person_cid p 
		LEFT JOIN t_person_epi a ON p.cid=a.cid
		WHERE
		p.check_typearea in(1,3) AND p.DISCHARGE =9
		AND (p.birth BETWEEN concat(@b_year-6,'1001') AND concat(@b_year-5,'0931'))
		ORDER BY p.check_typearea
		) as t3
		GROUP BY t3.check_hosp,t3.cid
) as t1 
LEFT JOIN chospital_amp h ON t1.check_hosp=h.hoscode

GROUP BY t1.check_hosp
) t"
WHERE h.rpt_id='f033ab37c30201f73f142449d037028d';

######################################################################################################################################
UPDATE hdc_rpt_sql h
SET h.sql_indiv="SET @b_year:=(SELECT yearprocess FROM sys_config LIMIT 1);
SET	@start_d:=concat(@b_year-1,'1001');
SET @end_d:=concat(@b_year,'0930');
SELECT * from (
SELECT 
t1.check_hosp HOSPCODE,t1.CID,p.`NAME`,p.LNAME,p.BIRTH

,CASE WHEN DATE_FORMAT(t1.birth,'%Y%m%d') BETWEEN concat(@b_year-6,'1001') AND concat(@b_year-5,'0930') 
THEN 'Y' ELSE NULL END as B
,CASE WHEN DATE_FORMAT(t1.birth,'%Y%m%d') BETWEEN concat(@b_year-6,'1001') AND concat(@b_year-5,'0930') 
AND t1.bcg_date is not null AND t1.hbv1_date is not null 
AND t1.opv3_date is not null AND t1.dtp3_date is not null 
AND t1.mmr1_date is not null AND t1.hbv3_date is not null 
AND t1.dtp4_date is not null AND t1.opv4_date is not null 
AND t1.mmr2_date is not null 
AND 
(
(NOT ISNULL(je1_date) and	NOT ISNULL(je2_date) and	NOT ISNULL(je3_date))
OR (NOT ISNULL(je1_date) and	NOT ISNULL(je2_date) and	( NOT ISNULL(j11_date)))
OR (NOT ISNULL(je1_date) and	NOT ISNULL(je2_date) and	( NOT ISNULL(j12_date))) /*  where  key in is error  */
OR (NOT ISNULL(je1_date) and	NOT ISNULL(j11_date) and	NOT ISNULL(j12_date))
OR (NOT ISNULL(j11_date) and	NOT ISNULL(j12_date)) 
OR (NOT ISNULL(je1_date) and	NOT ISNULL(j11_date))
)

AND t1.opv5_date is not null AND t1.dtp5_date is not null 
THEN 'Y' ELSE NULL END as A
,t1.bcg_date BCG,t1.hbv1_date HBV1
,t1.opv3_date OPV3 , t1.dtp3_date DTP3
,t1.mmr1_date MMR1 , t1.hbv3_date  HBV3
,t1.dtp4_date DTP4,t1.opv4_date OPV4
,t1.mmr2_date MMR2
,je1_date JE1, je2_date JE2, je3_date JE3 ,j11_date J11, j12_date J12
,t1.opv5_date OPV5,t1.dtp5_date DTP5


FROM
(
SELECT 
*
FROM
(SELECT
a.*,p.check_hosp,p.check_vhid as areacode
FROM
t_person_cid p 
LEFT JOIN t_person_epi a ON p.cid=a.cid
WHERE
p.check_typearea in(1,3) AND p.DISCHARGE =9
AND (p.birth BETWEEN concat(@b_year-6,'1001') AND concat(@b_year-5,'0931'))
ORDER BY p.check_typearea
) as t3
GROUP BY t3.check_hosp,t3.cid
) as t1 
LEFT JOIN t_person_cid p on p.CID = t1.cid
) t WHERE 1=1"
WHERE h.rpt_id='f033ab37c30201f73f142449d037028d';
