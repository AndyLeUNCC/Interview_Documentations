/**************************************************************
Insight information obtained queries on the tables
***************************************************************/
use outpatient_clinic;

-- count how many patient are there in each group responsible_part
SELECT count(*) as "Number of patient", responsible_party as " Responsible Party" 
FROM patient as p, financial_info as f
where p.patient_id = f.patient_id
group by responsible_party
order by count(*) ASC;

-- search the list of provider include number of patient
 SELECT  concat(pro.first_name ,' ', pro.last_name) as "Provider Name" ,count(*) as "Number of patient"
FROM patient as pa, provider as pro, prescription as pre
where pro.provider_id = pre.provider_id and pre.patient_id = pa.patient_id
group by pro.provider_id
order by count(*) ASC;

-- search the list of provider have number of patient at least 3
 SELECT  concat(pro.first_name ,' ', pro.last_name) as "Provider Name" ,count(*) as "Number of patient"
FROM patient as pa, provider as pro, prescription as pre
where pro.provider_id = pre.provider_id and pre.patient_id = pa.patient_id
group by pro.provider_id
having count(*) >=3
order by count(*) ASC;

-- list of patient with the total payment of each patient that paid for clinic
select concat(p.first_name ,' ', p.last_name) as "Patient Name", sum(total_amount) as "Total payment"
from patient as p, billing_detail as b
where p.patient_id = b.patient_id
group by p.patient_id;

-- list of patient with the total payment of each patient that paid for clinic from the certain date to the certain date
select concat(p.first_name ,' ', p.last_name) as "Patient Name", sum(total_amount) as "Total payment"
from patient as p, billing_detail as b
where p.patient_id = b.patient_id and b.date >= "2021-02-20" and b.date <= "2021-03-20"
group by b.patient_id;

-- list  three of patient has pay much in clinic
select concat(p.first_name ,' ', p.last_name) as "Patient Name", sum(total_amount) as "Total payment"
from patient as p, billing_detail as b
where p.patient_id = b.patient_id
group by b.patient_id
order by sum(total_amount) DESC
limit 3;

-- list of patient with number of visiting the clinic
SELECT distinct concat(p.first_name ,' ', p.last_name) as "Patient Name", count(encounter_id) as "Number Visited"
 FROM visit as v, patient as p
 where v.patient_id = p.patient_id
 group by p.patient_id
 order by v.date_time_of_visit;
 
 -- list of patient with number of visiting the clinic twice 
SELECT distinct concat(p.first_name ,' ', p.last_name) as "Patient Name", count(encounter_id) as "Number Visited"
 FROM visit as v, patient as p
 where v.patient_id = p.patient_id
 group by p.patient_id
 having count(encounter_id) = 2
 order by v.date_time_of_visit;
 
 -- within the shortest time interval mysql
 SELECT
    T1.*,
    (SELECT MIN(T2.date_time_of_visit)
     FROM visit T2
     WHERE T2.date_time_of_visit > T1.date_time_of_visit)-T1.date_time_of_visit as "list of interval"
FROM
    visit T1

ORDER BY
    T1.date_time_of_visit
