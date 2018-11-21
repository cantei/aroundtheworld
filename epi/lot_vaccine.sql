# OPV
# SELECT drugcode,drugname,lotno,dateexpire 
FROM cdrug
WHERE drugtype='05'
AND  substr(drugcode,1,3)='OPV';

# IPV-P
UPDATE cdrug 
SET lotno='0308L001A' ,dateexpire='2019-12-31'
WHERE drugtype='05' AND drugcode in ('IPV-P');

# DHB
UPDATE cdrug 
SET lotno='0308L001A' ,dateexpire='2019-12-31'
WHERE drugtype='05' AND drugcode in ('DHB1','DHB2','DHB3');

# MMR
UPDATE cdrug 
SET lotno='AMJRD592AA' ,dateexpire='2019-09-30'
WHERE drugtype='05' AND drugcode in ('MMR','MMR2');

#
UPDATE cdrug 
SET lotno='201704A057-2' ,dateexpire='2019-04-25'
WHERE drugtype='05' AND drugcode in ('J11','J12');

# DTP
UPDATE cdrug 
SET lotno='2821X7004A' ,dateexpire='2019-07-31'
WHERE drugtype='05' AND drugcode in ('DTP4','DTP5');
