SELECT p.CID,p.`NAME`,p.LNAME,p.SEX
            ,h.HOUSE,h.VILLAGE 
            ,t.VISIT,t.ITEMS,t.LAST_VISIT
            FROM person p
            INNER JOIN home h
            ON p.HOSPCODE=h.HOSPCODE AND p.HID=h.HID 
            INNER  JOIN 
            (
                    SELECT  p.CID
                    ,count(DISTINCT l.HOSPCODE,l.PID,l.SEQ) AS VISIT 
                    ,count(DISTINCT l.HOSPCODE,l.PID,l.SEQ,l.LABTEST) AS ITEMS 
                    ,SPLIT_STR(GROUP_CONCAT(l.DATE_SERV ORDER BY l.DATE_SERV DESC SEPARATOR ','),',',1) AS LAST_VISIT
                    FROM labfu l 	
                    INNER JOIN person p 
                    ON l.HOSPCODE=p.HOSPCODE AND l.PID=p.PID  
                    WHERE l.DATE_SERV BETWEEN  DATE_SUB( CURDATE(),INTERVAL 1 YEAR) AND   DATE_SUB(CURDATE(),INTERVAL 1 day)  
                    GROUP BY p.CID
            ) 
            AS t
            ON p.CID=t.CID
            WHERE p.HOSPCODE='07733' AND p.typearea in ('1','3')
            HAVING NOT ISNULL(t.VISIT)
            ORDER BY h.VILLAGE,h.HOUSE
