SELECT p.pid ,concat(t.titlename,p.fname,'  ', p.lname) as fullname, p.idcard
,p.birth,p.nation,p.typelive
,h.hno,substr(h.villcode,8,1) as moo 
, substr(p.idcard,13,1) AS d13, 
MOD ( 11- MOD ( 
((substr(p.idcard,1,1) * 13) + 
(substr(p.idcard,2,1) * 12) + 
(substr(p.idcard,3,1) * 11) + 
(substr(p.idcard,4,1) * 10) + 
(substr(p.idcard,5,1) * 9) + 
(substr(p.idcard,6,1) * 8) + 
(substr(p.idcard,7,1) * 7) + 
(substr(p.idcard,8,1) * 6) + 
(substr(p.idcard,9,1) * 5) + 
(substr(p.idcard,10,1) * 4) + 
(substr(p.idcard,11,1) * 3) + 
(substr(p.idcard,12,1) * 2)) , 11 ) ,10) AS vf 
FROM person p
LEFT JOIN ctitle t
ON p.prename=t.titlecode
LEFT JOIN house h
ON p.hcode=h.hcode AND p.pcucodeperson=h.pcucode 
WHERE length(p.idcard) = 13  AND substr(h.villcode,8,1)<>'0'
HAVING d13 != vf 
