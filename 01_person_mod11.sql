select p.pid , fname , lname, idcard , hnomoi AS 'ban' , mumoi AS 'mu' ,  p.pcucodeperson AS 'pcu' 
,substr(h.villcode,8,1) as village,h.hno 
, substr(idcard,13,1) AS d13 ,
    MOD ( 11- MOD ( 
    ((substr(idcard,1,1) * 13) +
        (substr(idcard,2,1) * 12) +
    (substr(idcard,3,1) * 11) +
    (substr(idcard,4,1) * 10) +
        (substr(idcard,5,1) * 9) +
        (substr(idcard,6,1) * 8) +
    (substr(idcard,7,1) * 7) +
        (substr(idcard,8,1) * 6) +
        (substr(idcard,9,1) * 5) +
    (substr(idcard,10,1) * 4) +
        (substr(idcard,11,1) * 3) +
        (substr(idcard,12,1) * 2))   , 11 ) ,10) AS vf
from person p
LEFT JOIN house h
ON p.pcucodeperson=h.pcucode AND p.pid=h.pid  
where length(idcard) = 13 
having d13 != vf 
