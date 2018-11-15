# map : 
            1) buffers.php
            2) housegis.php
            src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCTeUbgScU5eMv6Q2j2Ngh-2ea2K6enh0w&callback=initialize"
            3) genxml_housegis.php
               hhouse > pname

# วันเกิด พ.ศ.
,CONCAT(DATE_FORMAT(p.birth,'%d-%m'),'-',year(p.birth)+543) as born 
=======================================================================================================================================
# Start New VAccine
# LAJE เริ่มใช้ มีนาคม 2558  ฉะนั้น เด็กที่เกิดปีงบประมาณ 2557 บางส่วนควรจะได้รับ  
# IPV เริ่มใช้ธันวาคม 2558 ฉะนั้น เด็กที่เกิดตั้งแต่ 2015-08-01 ควรจะได้รับทุกราย เพื่อให้มีภูมิคุ้มกันทั้ง 3 types
# ROTA เริ่มใช้สิงหาคม 2559 ฉะนั้น เด็กที่เกิดก่อน 2016-05-01  ไม่ควรจะได้รับ (โด๊สแรก อายุไม่เกิน 15 wks)  (โด๊ส 2 ,3 อายุไม่เกิน 32 wks) 


=======================================================================================================================================
# fix date BLOB

SELECT p.pcucodeperson,p.pid
,GROUP_CONCAT(CAST(c.datefirstdiag AS CHAR(10000) CHARACTER SET utf8)  ORDER BY c.datefirstdiag SEPARATOR ',') as dx_date
,GROUP_CONCAT(CAST(c.chroniccode AS CHAR(10000) CHARACTER SET utf8)  ORDER BY c.datefirstdiag SEPARATOR ',') as dx
,SPLIT_STR(GROUP_CONCAT(c.datefirstdiag ORDER BY c.datefirstdiag SEPARATOR ','),',',1) as datediag 
FROM  person p
LEFT JOIN personchronic c
ON p.pcucodeperson=c.pcucodeperson AND p.pid=c.pid 
WHERE substr(REPLACE(chroniccode,'.',''),1,3) BETWEEN 'I10' AND 'I14' 
GROUP BY p.pcucodeperson,p.pid

=======================================================================================================================================
# ICD10 - Chronic 
            CVD                   I60 –I69
            HT                    I10 – I15
            Stroke                I64
            IHD                   I20 – I25
            DM                    E10 – E14
            COPD                  J449
            Asthma                J45 – J46
            Emphysema             J43
            Obesity               E66
            Cancer                C00 – C97
            TB                    A15 – A19
            HIV/AIDS              B20 – B24
            Cirrhosis of liver    K70.3 ,K71.7,K74
            Chronic hepatitis     K73
            Chronic Renal failure N18
            Osteoarthritis        M15-M19,M47
            Rheumatoid arthritis  M05 – M06

=======================================================================================================================================
# ORDER BY moo

ORDER BY (substr(h.villcode,7,2) ),(SPLIT_STR(h.hno,'/', 1)*1),(SPLIT_STR(h.hno,'/',2)*1)

=======================================================================================================================================
#  ชื่อจริงๆ ไม่มีวงเล็บ
SELECT fname
,LEFT(fname,LOCATE('(',fname) - 1) as realname
FROM person 
where fname LIKE '%(%'
# fix hoc to edit markhouse.php
<script type="text/javascript" src="http://maps.google.com/maps/api/js?key=AIzaSyCTeUbgScU5eMv6Q2j2Ngh-2ea2K6enh0w"></script>
