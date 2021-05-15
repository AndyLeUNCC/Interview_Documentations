
/**************************************************************
complex queries on the tables
***************************************************************/
use outpatient_clinic;

-- searching of patient records based on visit dates
 SELECT concat(p.first_name ,' ', p.last_name) as "Patient Name", 
 v.date_time_of_visit as "Visit Dates"
 FROM visit as v, patient as p
 where v.patient_id = p.patient_id
 order by v.date_time_of_visit;
 
 
 -- the listing of all patients who satisfy certain selection criteria, such as those who have been given a certain diagnosis
 SELECT distinct concat(p.first_name ,' ', p.last_name) as "Patient Name", d.disease_type
 FROM disease as d, patient as p
 where d.patient_id = p.patient_id
 and d.disease_type like "%infect%";
 
 -- the listing of all patients who satisfy certain selection criteria, such as who have been seen by a 
 -- certain doctor has first name contain "jack"
 SELECT distinct concat(p.first_name ,' ', p.last_name) as "Patient Name", 
 concat(pro.first_name ,' ', pro.last_name) as "Doctor Name", pre.date	as "Date Diagnosis"
 FROM provider as pro, patient as p, prescription as pre
 where pro.provider_id = pre.provider_id and pre.patient_id = p.patient_id
 and pro.first_name like "%jack%";
 
 -- the listing of all patients who satisfy certain selection criteria, such as who visited on certain days    
SELECT distinct concat(p.first_name ,' ', p.last_name) as "Patient Name", 
 v.date_time_of_visit as "Visit Dates"
 FROM visit as v, patient as p
 where v.patient_id = p.patient_id
 and date_time_of_visit >= '2021-03-22' and date_time_of_visit <= '2021-03-25'
 order by v.date_time_of_visit;

