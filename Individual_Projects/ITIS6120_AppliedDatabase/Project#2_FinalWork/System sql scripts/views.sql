-- views
use outpatient_clinic_updated;
-- searching all the list of room
CREATE OR REPLACE VIEW all_list_room
AS
SELECT * FROM rooms;


-- get all the patient 
CREATE OR REPLACE VIEW all_patient
AS
SELECT * FROM patient;

-- searching all patient records based on the patient id
CREATE OR REPLACE VIEW first_five_patient
AS
SELECT * FROM patient
LIMIT 5;

-- searching all patient records based on the first name
CREATE OR REPLACE VIEW patient_first_name_contain_u_character
AS
SELECT * FROM patient
where first_name like '%u%';

-- searching all patient records based on the middle name has "ut" character
CREATE OR REPLACE VIEW patient_middle_name_contain_u_character
AS
SELECT * FROM patient
where middle_name like '%ut%';

-- get all the provider has the year of practice at least 6 years
CREATE OR REPLACE VIEW provider_practice
AS
SELECT * FROM provider
where year_of_practice >=6;

-- get all the provider male has the year of practice at least 6 years
CREATE OR REPLACE VIEW provider_male_practice
AS
SELECT * FROM provider
where gender = "male" and year_of_practice >=6;

-- get all the provider graduated from the certain school such as Harvard
CREATE OR REPLACE VIEW provider_school
AS
SELECT * FROM provider
where school = "Harvard" ;

-- searching of patient records based on visit dates
CREATE OR REPLACE VIEW patient_visit_date
AS
 SELECT concat(p.first_name ,' ', p.last_name) as "Patient Name", 
 v.date_time_of_visit as "Visit Dates"
 FROM visit as v, patient as p
 where v.patient_id = p.patient_id
 order by v.date_time_of_visit;
 
 
 -- the listing of all patients who satisfy certain selection criteria, such as those who have been given a certain diagnosis
 CREATE OR REPLACE VIEW patient_disease
AS
 SELECT distinct concat(p.first_name ,' ', p.last_name) as "Patient Name", d.disease_type
 FROM disease as d, patient as p
 where d.patient_id = p.patient_id
 and d.disease_type like "%infect%";
 
 -- the listing of all patients who satisfy certain selection criteria, such as who have been seen by a 
 -- certain doctor has first name contain "jack"
 CREATE OR REPLACE VIEW provider_patient_prescription
AS
 SELECT distinct concat(p.first_name ,' ', p.last_name) as "Patient Name", 
 concat(pro.first_name ,' ', pro.last_name) as "Doctor Name", pre.date	as "Date Diagnosis"
 FROM provider as pro, patient as p, prescription as pre
 where pro.provider_id = pre.provider_id and pre.patient_id = p.patient_id
 and pro.first_name like "%jack%";
 
 -- the listing of all patients who satisfy certain selection criteria, such as who visited on certain days    
 CREATE OR REPLACE VIEW patient_visit_certain_dayspatient_visit_certain_days
AS
SELECT distinct concat(p.first_name ,' ', p.last_name) as "Patient Name", 
 v.date_time_of_visit as "Visit Dates"
 FROM visit as v, patient as p
 where v.patient_id = p.patient_id
 and date_time_of_visit >= '2021-03-22' and date_time_of_visit <= '2021-03-25'
 order by v.date_time_of_visit;

