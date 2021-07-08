SELECT  pcucode,pid,screen_date
,substring_index(group_concat(screen_date ORDER BY screen_date DESC  SEPARATOR ','), ',', 1) as visit
,(substring_index(group_concat(height ORDER BY screen_date DESC  SEPARATOR ','), ',', 1)/100) as height
,(substring_index(group_concat(weight ORDER BY screen_date DESC  SEPARATOR ','), ',', 1)) as weight
-- ,substring_index(group_concat(bmi ORDER BY screen_date DESC  SEPARATOR ','), ',', 1) as bmi
,ROUND((substring_index(group_concat(weight ORDER BY screen_date DESC  SEPARATOR ','), ',', 1)) /((substring_index(group_concat(height ORDER BY screen_date DESC  SEPARATOR ','), ',', 1)/100)*(substring_index(group_concat(height ORDER BY screen_date DESC  SEPARATOR ','), ',', 1)/100)),2) as bmi
FROM ncd_person_ncd_screen
WHERE screen_date > '2020-09-30'
GROUP BY pid 
