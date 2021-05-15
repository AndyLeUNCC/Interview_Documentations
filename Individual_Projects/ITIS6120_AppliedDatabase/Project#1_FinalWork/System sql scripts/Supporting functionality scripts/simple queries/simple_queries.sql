
/**************************************************************
Simple queries on the tables
***************************************************************/
use outpatient_clinic;

-- get all the patient 
SELECT * FROM patient_clinic_management.patient;

-- searching all patient records based on the patient id
SELECT * FROM patient_clinic_management.patient
where patient_id = 1;

-- searching all patient records based on the first name
SELECT * FROM patient_clinic_management.patient
where first_name like '%u%';

-- searching all patient records based on the middle name has "ut" character
SELECT * FROM patient_clinic_management.patient
where middle_name like '%ut%';

-- searching all the list of room
SELECT * FROM patient_clinic_management.rooms;

-- change of patient address by update statement
UPDATE `patient_clinic_management`.`contact_info` SET `address` = 'Pangle Dr, Charlotte' WHERE (`patient_id` = '1');
-- change of patient insurrance by update statement
UPDATE `patient_clinic_management`.`financial_info` SET `insurrance_info` = 'insurrance_correct' WHERE (`patient_id` = '1');
-- change the phone number of patient
UPDATE `patient_clinic_management`.`contact_info` SET `phone_number` = '123-777-999' WHERE (`patient_id` = '2');
-- change the disease type of patient has id = 2
UPDATE `patient_clinic_management`.`disease` SET `disease_type` = 'circulatory' WHERE (`patient_id` = '2');
-- change the type of laboratory which patient id = 1
UPDATE `patient_clinic_management`.`laboratory` SET `type` = 'type1' WHERE (`patient_id` = '1');
-- change the specialist of provider which id = 2
UPDATE `patient_clinic_management`.`provider` SET `specialist` = 'Cardiologists doctors' WHERE (`provider_id` = '2');



