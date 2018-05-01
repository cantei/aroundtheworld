# drugflag ='1'
====================================================================================
update 	cdrug 
set	drugname='บีซีจีแรกเกิด (BCG)',files18epi='010',files18epiappoint='Z23.2',drugflag ='1'
where	drugcode='BCG';

update 	cdrug 
set	drugname='บีซีจี นักเรียน ป.1 (BCGS)',files18epi='011',files18epiappoint='Z23.2',drugflag ='1'
where	drugcode='BCGS1';

update 	cdrug 
set	drugname='ตับอักเสบบี  1',files18epi='041',files18epiappoint='Z24.6',drugflag ='1'
where	drugcode='HBV1';

update 	cdrug 
set	drugname='ตับอักเสบบี  2',files18epi='042',files18epiappoint='Z24.6',drugflag ='1'
where	drugcode='HBV2';

update 	cdrug 
set	drugname='ตับอักเสบบี  3',files18epi='043',files18epiappoint='Z24.6',drugflag ='1'
where	drugcode='HBV3';

update 	cdrug 
set	drugname='วัคซีนรวม DTPHB 1',files18epi='091',files18epiappoint='Z27.1,Z24.6',drugflag ='1'
where	drugcode='DHB1';

update 	cdrug 
set	drugname='วัคซีนรวม DTPHB 2',files18epi='092',files18epiappoint='Z27.1,Z24.6',drugflag ='1'
where	drugcode='DHB2';

update 	cdrug 
set	drugname='วัคซีนรวม DTPHB 3',files18epi='093',files18epiappoint='Z27.1,Z24.6',drugflag ='1'
where	drugcode='DHB3';

update 	cdrug 
set	drugname='โอพีวี 1'  ,files18epi='081',files18epiappoint='Z24.0',drugflag ='1'
where	drugcode='OPV1';

update 	cdrug 
set	drugname='โอพีวี 2'  ,files18epi='082',files18epiappoint='Z24.0',drugflag ='1'
where	drugcode='OPV2';

update 	cdrug 
set	drugname='โอพีวี 3'  ,files18epi='083',files18epiappoint='Z24.0',drugflag ='1'
where	drugcode='OPV3';

update 	cdrug 
set	drugname='โอพีวี กระตุ้น 1'  ,files18epi='084',files18epiappoint='Z24.0',drugflag ='1'
where	drugcode='OPV4';

update 	cdrug 
set	drugname='โอพีวี กระตุ้น 2'  ,files18epi='085',files18epiappoint='Z24.0',drugflag ='1'
where	drugcode='OPV5';

update 	cdrug 
set	drugname='วัคซีนรวม MMR1(เก้าเดือน)'  ,files18epi='061',files18epiappoint='Z27.4',drugflag ='1'
where	drugcode='MMR';

update 	cdrug 
set	drugname='วัคซีนรวม MMR2 (สองขวบครึ่ง)'  ,files18epi='073',files18epiappoint='Z27.4',drugflag ='1'
where	drugcode='MMR2';

update 	cdrug 
set	drugname='วัคซีน JE เชื้อเป็น 1'  ,files18epi='J11',files18epiappoint='Z24.1',drugflag ='1'
where	drugcode='J11';

update 	cdrug 
set	drugname='วัคซีน JE เชื้อเป็น 2'  ,files18epi='J12',files18epiappoint='Z24.1',drugflag ='1'
where	drugcode='J12';


update 	cdrug 
set	drugname='โปลีโอชนิดฉีด (IPV)'  ,files18epi='IPV-P',files18epiappoint='Z24.0',drugflag ='1'
where	drugcode='IPV-P'; 

update 	cdrug 
set	drugname='ดีทีพี กระตุ้น 1'  ,files18epi='034',files18epiappoint='Z27.1',drugflag ='1'
where	drugcode='DTP4'; 

update 	cdrug 
set	drugname='ดีทีพี กระตุ้น 2'  ,files18epi='035',files18epiappoint='Z27.1',drugflag ='1'
where	drugcode='DTP5'; 

update 	cdrug 
set	drugname='ดีที'  ,files18epi='106',files18epiappoint='Z23.5+Z23.6',drugflag ='1'
where	drugcode='dT'; 

update 	cdrug 
set	drugname='ดีทีเอเอ็นซี 1 (TT สำหรับหญิงตั้งครรภ์ 1)'  ,files18epi='201',files18epiappoint='Z27.8',drugflag ='1'
where	drugcode='DTANC1'; 

update 	cdrug 
set	drugname='ดีทีเอเอ็นซี 2 (TT สำหรับหญิงตั้งครรภ์ 2)'  ,files18epi='202',files18epiappoint='Z27.8',drugflag ='1'
where	drugcode='DTANC2'; 

update 	cdrug 
set	drugname='ดีทีเอเอ็นซี 3 (TT สำหรับหญิงตั้งครรภ์ 3)'  ,files18epi='203',files18epiappoint='Z27.8',drugflag ='1'
where	drugcode='DTANC3'; 

update 	cdrug 
set	drugname='ดีทีเอเอ็นซี 4 (กระตุ้น TT สำหรับหญิงตั้งครรภ์)	'  ,files18epi='204',files18epiappoint='Z27.8',drugflag ='1'
where	drugcode='DTANC4'; 

update 	cdrug 
set	drugname='ดีทีเอเอ็นซี 5 (กระตุ้น TT สำหรับหญิงตั้งครรภ์)	'  ,files18epi='205',files18epiappoint='Z27.8',drugflag ='1'
where	drugcode='DTANC5'; 


==============================================================================================================================================
drugcode	drugname	files18export		files18epiappoint

BCG			BCG						010  		Z23.2				
BCGS1		BCGS					011			Z23.2

HBV1		ับอักเสบบี 1					041			Z24.6
HBV2		ตับอักเสบบี 2					042			Z24.6
HBV3		ตับอักเสบบี 3					043			Z24.6
					
DHB1		วัคซีนรวม DTPHB 1			091			Z27.1,Z24.6
DHB2		วัคซีนรวม DTPHB 2			092			Z27.1,Z24.6
DHB3		วัคซีนรวม DTPHB 3			093			Z27.1,Z24.6

OPV1		โอพีวี1					081			Z24.0
OPV2		โอพีวี2					082			Z24.0
OPV3		โอพีวี3					083			Z24.0
OPV4		โอพีวี กระตุ้น 1				084			Z24.0
OPV5		โอพีวี กระตุ้น 2				085			Z24.0
# OPVS1		โอพีวีเอส 1 (OPV นักเรียน(ป. 1))	086			Z24.0
# OPVS2		โอพีวีเอส 2 (OPV นักเรียน(ป. 1))	087			Z24.0
# OPVS3		โอพีวีเอส 3 (OPV นักเรียน(ป. 2))	088			Z24.0

MMR			MMR						061			Z27.4
MMR2		หัด คางทูม หัดเยอรมัน อายุ 2 ปีครึ่ง	073			Z27.4

J11			JE เชื้อเป็น 1(Lived attenuated 1)		Z24.1
J12			JE เชื้อเป็น 2(Lived attenuated 2)		Z24.1

IPV-P		IPV-P(ฉีด) อายุ 4 เดือน ป้องกันโปลีโอ		401		Z24.0

DTP4		ดีทีพี กระตุ้น 1			034				Z27.1
DTP5		ดีทีพี กระตุ้น 2			035				Z27.1

dT			ดีที  					106				Z23.5+Z23.6

#Dta1		Dtanc1				201				Z27.8
#Dta2		Dtanc2				202				Z27.8
#Dta1		Dtanc3				203				Z27.8
#Dta1		Dtanc4				204				Z27.8

DTANC1		ดีทีเอเอ็นซี 1 (TT สำหรับหญิงตั้งครรภ์ 1)		201				Z27.8
DTANC2		ดีทีเอเอ็นซี 2 (TT สำหรับหญิงตั้งครรภ์ 2)		202				Z27.8
DTANC3		ดีทีเอเอ็นซี 3 (TT สำหรับหญิงตั้งครรภ์ 3)		203				Z27.8
DTANC4	ดีทีเอเอ็นซี 4 (กระตุ้น TT สำหรับหญิงตั้งครรภ์)		204				Z27.8
DTANC5	ดีทีเอเอ็นซี 5 (กระตุ้น TT สำหรับหญิงตั้งครรภ์)		205				Z27.8


====================================================================================
# alternate vaccine 

update 	cdrug 
set	drugname='DTP-Hib 1'  ,files18epi='D11',files18epiappoint='Z27.1,Z24.1',drugflag ='1'
where	drugcode='D11'; 

update 	cdrug 
set	drugname='DTP-Hib 2'  ,files18epi='D12',files18epiappoint='Z27.1,Z24.1',drugflag ='1'
where	drugcode='D12'; 

update 	cdrug 
set	drugname='DTP-Hib 3'  ,files18epi='D13',files18epiappoint='Z27.1,Z24.1',drugflag ='1'
where	drugcode='D13'; 

update 	cdrug 
set	drugname='DTP-Hib 4'  ,files18epi='D14',files18epiappoint='Z27.1,Z24.1',drugflag ='1'
where	drugcode='D14'; 

update 	cdrug 
set	drugname='DTP-HB+Hib 1'  ,files18epi='D21',files18epiappoint='Z27.1,Z24.6,Z24.1',drugflag ='1'
where	drugcode='D21'; 

update 	cdrug 
set	drugname='DTP-HB+Hib 2'  ,files18epi='D22',files18epiappoint='Z27.1,Z24.6,Z24.1',drugflag ='1'
where	drugcode='D22'; 

update 	cdrug 
set	drugname='DTP-HB+Hib 3'  ,files18epi='D23',files18epiappoint='Z27.1,Z24.6,Z24.1',drugflag ='1'
where	drugcode='D23'; 

update 	cdrug 
set	drugname='DTP-HB+Hib 4'  ,files18epi='D24',files18epiappoint='Z27.1,Z24.6,Z24.1',drugflag ='1'
where	drugcode='D24'; 

update 	cdrug 
set	drugname='DTP-IPV 1'  ,files18epi='D31',files18epiappoint='Z27.3',drugflag ='1'
where	drugcode='D31'; 

update 	cdrug 
set	drugname='DTP-IPV 2'  ,files18epi='D32',files18epiappoint='Z27.3',drugflag ='1'
where	drugcode='D32';

update 	cdrug 
set	drugname='DTP-IPV 3'  ,files18epi='D33',files18epiappoint='Z27.3',drugflag ='1'
where	drugcode='D33'; 

update 	cdrug 
set	drugname='DTP-IPV 4'  ,files18epi='D34',files18epiappoint='Z27.3',drugflag ='1'
where	drugcode='D34';

update 	cdrug 
set	drugname='DTP-IPV 5'  ,files18epi='D35',files18epiappoint='Z27.3',drugflag ='1'
where	drugcode='D35';

update 	cdrug 
set	drugname='DTP-IPV-Hib 1'  ,files18epi='D41',files18epiappoint='Z27.3,Z24.1',drugflag ='1'
where	drugcode='D41';

update 	cdrug 
set	drugname='DTP-IPV-Hib 2'  ,files18epi='D42',files18epiappoint='Z27.3,Z24.1',drugflag ='1'
where	drugcode='D42';

update 	cdrug 
set	drugname='DTP-IPV-Hib 3'  ,files18epi='D43',files18epiappoint='Z27.3,Z24.1',drugflag ='1'
where	drugcode='D43';

update 	cdrug 
set	drugname='DTP-IPV-Hib 4'  ,files18epi='D44',files18epiappoint='Z27.3,Z24.1',drugflag ='1'
where	drugcode='D44';

update 	cdrug 
set	drugname='DTP-IPV-Hib 5'  ,files18epi='D45',files18epiappoint='Z27.3,Z24.1',drugflag ='1'
where	drugcode='D45';

update 	cdrug 
set	drugname='DTP-IPV-HB-Hib 1'  ,files18epi='D51',files18epiappoint='Z27.3,Z24.6,Z24.1',drugflag ='1'
where	drugcode='D51';

update 	cdrug 
set	drugname='DTP-IPV-HB-Hib 2'  ,files18epi='D52',files18epiappoint='Z27.3,Z24.6,Z24.1',drugflag ='1'
where	drugcode='D52';

update 	cdrug 
set	drugname='DTP-IPV-HB-Hib 3'  ,files18epi='D53',files18epiappoint='Z27.3,Z24.6,Z24.1',drugflag ='1'
where	drugcode='D53';

update 	cdrug 
set	drugname='DTP-IPV-HB-Hib 4'  ,files18epi='D54',files18epiappoint='Z27.3,Z24.6,Z24.1',drugflag ='1'
where	drugcode='D54';

update 	cdrug 
set	drugname='DTP-IPV-HB-Hib 5'  ,files18epi='D55',files18epiappoint='Z27.3,Z24.6,Z24.1',drugflag ='1'
where	drugcode='D55';



D11				ดีทีพีฮิบ1(DTP-Hib 1)								Z27.1,Z24.1
D12				ดีทีพีฮิบ2(DTP-Hib 2)								Z27.1,Z24.1
D13				ดีทีพีฮิบ3(DTP-Hib 3)								Z27.1,Z24.1
D14				ดีทีพีฮิบ4(DTP-Hib 4)								Z27.1,Z24.1
D21				ดีทีพีตับอักเสบบีฮิบ1 (DTP-HB+Hib 1)						Z27.1,Z24.6,Z24.1
D22				ดีทีพีตับอักเสบบีฮิบ2 (DTP-HB+Hib 2)						Z27.1,Z24.6,Z24.1
D23				ดีทีพีตับอักเสบบีฮิบ3 (DTP-HB+Hib 3)						Z27.1,Z24.6,Z24.1
D24				ดีทีพีตับอักเสบบีฮิบ4 (DTP-HB+Hib 4)						Z27.1,Z24.6,Z24.1
D31				ดีทีพีไอพีวี 1(DTP-IPV 1)								Z27.3
D32				ดีทีพีไอพีวี 2(DTP-IPV 2)								Z27.3
D33				ดีทีพีไอพีวี 3(DTP-IPV 3)								Z27.3
D34				ดีทีพีไอพีวี 4(DTP-IPV 4)								Z27.3
D35				ดีทีพีไอพีวี 5(DTP-IPV 5)								Z27.3
D41				ดีทีพีไอพีวีฮิบ 1 (DTP-IPV-Hib 1)						Z27.3,Z24.1
D42				ดีทีพีไอพีวีฮิบ 2 (DTP-IPV-Hib 2)						Z27.3,Z24.1
D43				ดีทีพีไอพีวีฮิบ 3 (DTP-IPV-Hib 3)						Z27.3,Z24.1
D44				ดีทีพีไอพีวีฮิบ 4 (DTP-IPV-Hib 4)						Z27.3,Z24.1
D45				ดีทีพีไอพีวีฮิบ 5 (DTP-IPV-Hib 5)						Z27.3,Z24.1
D51				ดีทีพีไอพีวีตับอักเสบบีฮิบ1 1 (DTP-IPV-HB-Hib 1)				Z27.3,Z24.6,Z24.1
D52				ดีทีพีไอพีวีตับอักเสบบีฮิบ1 2 (DTP-IPV-HB-Hib 2)				Z27.3,Z24.6,Z24.1
D53				ดีทีพีไอพีวีตับอักเสบบีฮิบ1 3 (DTP-IPV-HB-Hib 3)				Z27.3,Z24.6,Z24.1
D54				ดีทีพีไอพีวีตับอักเสบบีฮิบ1 4 (DTP-IPV-HB-Hib 4)				Z27.3,Z24.6,Z24.1
D55				ดีทีพีไอพีวีตับอักเสบบีฮิบ1 5 (DTP-IPV-HB-Hib 5)				Z27.3,Z24.6,Z24.1

====================================================================================







coverage 

files18export+drugname
