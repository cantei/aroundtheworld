################################################################################
# JHCIS
################################################################################
SELECT d.drugcode
,c.drugname,c.drugflag 
,n.item,n.tradename,n.comp 
FROM visitdrug d
LEFT  JOIN cdrug c
ON d.drugcode=c.drugcode 
LEFT JOIN drug_thailand n
ON c.drugcode24=n.id 
WHERE c.drugflag='1'
GROUP BY d.drugcode
ORDER BY c.drugname 
################################################################################
