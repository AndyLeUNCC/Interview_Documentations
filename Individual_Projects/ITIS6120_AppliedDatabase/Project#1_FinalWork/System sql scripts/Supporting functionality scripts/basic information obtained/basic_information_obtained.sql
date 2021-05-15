/**************************************************************
Basic information obtained queries on the tables
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

-- get all the provider
SELECT * FROM patient_clinic_management.provider;

-- get all the provider has the year of practice at least 6 years
SELECT * FROM patient_clinic_management.provider
where year_of_practice >=6;

-- get all the provider male has the year of practice at least 6 years
SELECT * FROM patient_clinic_management.provider
where gender = "male" and year_of_practice >=6;

-- get all the provider graduated from the certain school such as Harvard
SELECT * FROM patient_clinic_management.provider
where school = "Harvard" ;


