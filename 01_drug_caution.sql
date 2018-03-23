-- para syrup
UPDATE cdrug 
SET drugcaution='อย่าใช้เกิน 5 ครั้งต่อวัน เพราะอาจเป็นพิษต่อตับ'
WHERE drugcode24='100752000000940330581506';
-- IBU
UPDATE cdrug 
SET drugcaution='ไม่ควรใช้ขณะท้องว่าง  เพื่อลดการระคายเคืองทางเดินอาหาร'
WHERE drugcode24='100722000004410220381189';

-- Amoxy
UPDATE cdrug 
SET drugcaution='ใช้ติดต่อกันจนหมด  เพื่อป้องกันเชื้อดื้อยาหรือโรคแทรกซ้อน'
WHERE drugcode24='100176000004493120181506';

-- DOMPERIDONE 
UPDATE cdrug 
SET drugcaution='อย่าใช้ยาเกินขนาดที่ระบุ  เพราะอาจทำให้หัวใจเต้นผิดจังหวัด'
WHERE drugcode24 in ('101314190003620120381506' ,'101314000000531430581630');


-- Enalapril 
UPDATE cdrug 
SET drugcaution='โปรดแจ้งแพทย์  หากเกิดอาการไอต่อเนื่องหลังการใช้ยา'
WHERE drugcode24='100619000003521120381438';

-- Amlodipine
UPDATE cdrug 
SET drugcaution='โปรดแจ้งแพทย์  หากเกิดอาการบวมที่เท้าหลังการใช้ยา'
WHERE drugcode24='124813000003521120381506';


-- Metformin
UPDATE cdrug 
SET drugcaution='พบแพทย์ทันที  หากมีอาการคลื่นไส้  ปวดท้อง ร่วมกับหอบเหนื่อย'
WHERE drugcode24 in ('101434000004493121781506' ,'101434000004590120381247');

-- Glipizide 5 mg
UPDATE cdrug 
SET drugcaution='ระวังการเกิดน้ำตาลต่ำในเลือด  เช่น  หิว  เหงื่อตก  ใจสั่น'
WHERE drugcode24='101444000003521120381457';

-- simvastatin  20  mg
UPDATE cdrug 
SET drugcaution='หยุดยาและพบแพทย์  หากมีอาการเจ็บกล้ามเนื้อโดยไม่มีสาเหตุ'
WHERE drugcode24='105573000003721120381506';

-- Allopurinol 
UPDATE cdrug 
SET drugcaution='พบแพทย์ทันที  หากมีผื่น  เป็นไข้  ตาแดง  มีแผลในปาก'
WHERE drugcode24='105573000003721120381506';

# atenolol 
100439000003850120381421  50  mg 

100439000004021220381506  100 mg

# amitrip 10 mg  100789000003620121781506








