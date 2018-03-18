SELECT d.drugcode
,c.drugname,c.drugflag 
,s.didstd,s.Generic_Name,s.TRADE_NAME,s.product_owner
FROM visitdrug d
LEFT  JOIN cdrug c
ON d.drugcode=c.drugcode 
LEFT JOIN cdrug_std s
ON c.drugcode24=s.didstd
WHERE c.drugflag='1'
GROUP BY d.drugcode
ORDER BY c.drugname ;
