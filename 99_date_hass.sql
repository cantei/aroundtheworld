SELECT *
,CONCAT(STR_TO_DATE(SPLIT_STR(dateupdate,' ',1), '%d/%m/%Y'),' ',SPLIT_STR(dateupdate,' ',2)) as d_update
FROM epi_test  
LIMIT 10 
