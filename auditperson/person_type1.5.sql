SELECT concat(v.fname,' ',v.lname) as volanteer,concat(' ',h.hno) as homeno
			,h.villcode as homevilage
			,p.pid,p.fname,p.lname,p.typelive
			,p.hnomoi
			,CASE WHEN LENGTH(p.mumoi)=1 THEN concat('0',p.mumoi)  
						WHEN LENGTH(p.mumoi)=2 THEN p.mumoi
			END as addressmumoi
			,t.hno as address
			,CASE WHEN LENGTH(t.mu)=1 THEN concat('0',t.mu)  
						WHEN LENGTH(t.mu)=2 THEN t.mu 
			END as addressmoo
			,concat(p.provcodemoi,p.distcodemoi,p.subdistcodemoi) as tambonmoi
			,concat(t.provcode,t.distcode,t.subdistcode) as tambonaddress
			FROM person p
			LEFT JOIN house	h
			ON p.pcucodeperson=h.pcucode AND p.hcode=h.hcode 
			LEFT JOIN personaddresscontact t
			ON p.pcucodeperson=t.pcucodeperson AND p.pid=t.pid 
			LEFT JOIN person v
			ON v.pcucodeperson=h.pcucodeperson AND v.pid=h.pidvola 
			WHERE p.typelive IN ('1')
			AND concat(p.provcodemoi,p.distcodemoi,p.subdistcodemoi)='841207' 
			HAVING  trim(homeno)<>trim(hnomoi)
			ORDER BY addressmumoi,(SPLIT_STR(p.hnomoi,'/', 1)*1),(SPLIT_STR(p.hnomoi,'/',2)*1);
