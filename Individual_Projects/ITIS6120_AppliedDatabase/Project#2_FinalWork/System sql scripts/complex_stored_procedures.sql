USE outpatient_clinic_updated;

  -- searching of patient records based on visit dates
DROP PROCEDURE IF EXISTS get_list_of_patient_based_on_visit_dates;

DELIMITER //

CREATE PROCEDURE get_list_of_patient_based_on_visit_dates
()
BEGIN
  DECLARE sql_error TINYINT DEFAULT FALSE;
  
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;

  START TRANSACTION;
  
  -- searching of patient records based on visit dates
	 SELECT concat(p.first_name ,' ', p.last_name) as "Patient Name", 
	 v.date_time_of_visit as "Visit Dates"
	 FROM visit as v, patient as p
	 where v.patient_id = p.patient_id
	 order by v.date_time_of_visit;
  
  IF sql_error = FALSE THEN
    COMMIT;
  ELSE
    ROLLBACK;
  END IF;
END//

DELIMITER ;


-- Test success: 
CALL get_list_of_patient_based_on_visit_dates();

-- the listing of all patients who satisfy certain selection criteria, such as those who have been given a certain diagnosis
DROP PROCEDURE IF EXISTS get_list_of_patient_with_diagnosis;

DELIMITER //

CREATE PROCEDURE get_list_of_patient_with_diagnosis
(
	diagnosis_param varchar(100)
)
BEGIN
  DECLARE sql_error TINYINT DEFAULT FALSE;
  
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;

  START TRANSACTION;
  
   -- the listing of all patients who satisfy certain selection criteria, such as those who have been given a certain diagnosis
 SELECT distinct concat(p.first_name ,' ', p.last_name) as "Patient Name", d.disease_type
 FROM disease as d, patient as p
 where d.patient_id = p.patient_id
 and d.disease_type like concat('%' , diagnosis_param ,'%');
  
  IF sql_error = FALSE THEN
    COMMIT;
  ELSE
    ROLLBACK;
  END IF;
END//

DELIMITER ;


-- Test success: 
CALL get_list_of_patient_with_diagnosis('infect');

   -- the listing of all patients who satisfy certain selection criteria, such as who visited on certain days    
DROP PROCEDURE IF EXISTS get_list_of_patient_from_certain_date;

DELIMITER //

CREATE PROCEDURE get_list_of_patient_from_certain_date
(
 from_date_param varchar(100),
 to_date_param varchar(100)

)
BEGIN
  DECLARE sql_error TINYINT DEFAULT FALSE;
  
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;

  START TRANSACTION;
  
   -- the listing of all patients who satisfy certain selection criteria, such as who visited on certain days    
	SELECT distinct concat(p.first_name ,' ', p.last_name) as "Patient Name", 
	 v.date_time_of_visit as "Visit Dates"
	 FROM visit as v, patient as p
	 where v.patient_id = p.patient_id
	 and date_time_of_visit >= from_date_param and date_time_of_visit <= to_date_param
	 order by v.date_time_of_visit;
  
  IF sql_error = FALSE THEN
    COMMIT;
  ELSE
    ROLLBACK;
  END IF;
END//

DELIMITER ;


-- Test success: 
CALL get_list_of_patient_from_certain_date("2021-03-22", "2021-03-25");



-- count how many patient are there in each group responsible_part
DROP PROCEDURE IF EXISTS count_number_of_patient_in_each_group_responsible_party;

DELIMITER //

CREATE PROCEDURE count_number_of_patient_in_each_group_responsible_party
()
BEGIN
  DECLARE sql_error TINYINT DEFAULT FALSE;
  
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;

  START TRANSACTION;
  
  -- count how many patient are there in each group responsible_part
	SELECT count(*) as "Number of patient", responsible_party as " Responsible Party" 
	FROM patient as p, financial_info as f
	where p.patient_id = f.patient_id
	group by responsible_party
	order by count(*) ASC;
  
  IF sql_error = FALSE THEN
    COMMIT;
  ELSE
    ROLLBACK;
  END IF;
END//

DELIMITER ;


-- Test success: 
CALL count_number_of_patient_in_each_group_responsible_party();



-- search the list of provider include number of patient
DROP PROCEDURE IF EXISTS get_list_of_provider_include_number_of_patient;

DELIMITER //

CREATE PROCEDURE get_list_of_provider_include_number_of_patient
()
BEGIN
  DECLARE sql_error TINYINT DEFAULT FALSE;
  
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;

  START TRANSACTION;
  
  -- search the list of provider include number of patient
	SELECT  concat(pro.first_name ,' ', pro.last_name) as "Provider Name" ,count(*) as "Number of patient"
	FROM patient as pa, provider as pro, prescription as pre
	where pro.provider_id = pre.provider_id and pre.patient_id = pa.patient_id
	group by pro.provider_id
	order by count(*) ASC;
  
  IF sql_error = FALSE THEN
    COMMIT;
  ELSE
    ROLLBACK;
  END IF;
END//

DELIMITER ;


-- Test success: 
CALL get_list_of_provider_include_number_of_patient();


-- get the list of provider have number of patient at least 3
DROP PROCEDURE IF EXISTS get_list_of_provider_have_number_of_patient_at_least_3;

DELIMITER //

CREATE PROCEDURE get_list_of_provider_have_number_of_patient_at_least_3
()
BEGIN
  DECLARE sql_error TINYINT DEFAULT FALSE;
  
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;

  START TRANSACTION;
  
  -- search the list of provider have number of patient at least 3
 SELECT  concat(pro.first_name ,' ', pro.last_name) as "Provider Name" ,count(*) as "Number of patient"
	FROM patient as pa, provider as pro, prescription as pre
	where pro.provider_id = pre.provider_id and pre.patient_id = pa.patient_id
	group by pro.provider_id
	having count(*) >=3
	order by count(*) ASC;
  
  IF sql_error = FALSE THEN
    COMMIT;
  ELSE
    ROLLBACK;
  END IF;
END//

DELIMITER ;


-- Test success: 
CALL get_list_of_provider_have_number_of_patient_at_least_3();


-- list of patient with the total payment of each patient that paid for clinic
DROP PROCEDURE IF EXISTS get_list_of_patient_with_total_payment;

DELIMITER //

CREATE PROCEDURE get_list_of_patient_with_total_payment
()
BEGIN
  DECLARE sql_error TINYINT DEFAULT FALSE;
  
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;

  START TRANSACTION;
  
  -- list of patient with the total payment of each patient that paid for clinic
	select concat(p.first_name ,' ', p.last_name) as "Patient Name", sum(total_amount) as "Total payment"
	from patient as p, billing_detail as b
	where p.patient_id = b.patient_id
	group by p.patient_id;
  
  IF sql_error = FALSE THEN
    COMMIT;
  ELSE
    ROLLBACK;
  END IF;
END//

DELIMITER ;


-- Test success: 
CALL get_list_of_patient_with_total_payment();

-- list of patient with the total payment of each patient that paid for clinic from the certain date to the certain date
DROP PROCEDURE IF EXISTS get_list_of_patient_with_total_payment_from_certain_date;

DELIMITER //

CREATE PROCEDURE get_list_of_patient_with_total_payment_from_certain_date
(
 from_date_param varchar(100),
 to_date_param varchar(100)

)
BEGIN
  DECLARE sql_error TINYINT DEFAULT FALSE;
  
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;

  START TRANSACTION;
  
  -- list of patient with the total payment of each patient that paid for clinic from the certain date to the certain date
	select concat(p.first_name ,' ', p.last_name) as "Patient Name", sum(total_amount) as "Total payment"
	from patient as p, billing_detail as b
	where p.patient_id = b.patient_id and b.date >= from_date_param  and b.date <= from_date_param
	group by b.patient_id;
  
  IF sql_error = FALSE THEN
    COMMIT;
  ELSE
    ROLLBACK;
  END IF;
END//

DELIMITER ;


-- Test success: 
CALL get_list_of_patient_with_total_payment_from_certain_date("2021-02-20", "2021-03-20");


 -- list  number of patient has pay much in clinic with number is parameter
DROP PROCEDURE IF EXISTS get_list_of_three_patient_pay_much;

DELIMITER //

CREATE PROCEDURE get_list_of_three_patient_pay_much
(
 number_patient_param INT
)
BEGIN
  DECLARE sql_error TINYINT DEFAULT FALSE;
  
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;

  START TRANSACTION;
  
 -- list  number of patient has pay much in clinic
	select concat(p.first_name ,' ', p.last_name) as "Patient Name", sum(total_amount) as "Total payment"
	from patient as p, billing_detail as b
	where p.patient_id = b.patient_id
	group by b.patient_id
	order by sum(total_amount) DESC
	limit number_patient_param;
  
  IF sql_error = FALSE THEN
    COMMIT;
  ELSE
    ROLLBACK;
  END IF;
END//

DELIMITER ;


-- Test success: 
CALL get_list_of_three_patient_pay_much(4);


 -- list of patient with number of visiting the clinic
DROP PROCEDURE IF EXISTS get_list_of_patient_with_number_visiting;

DELIMITER //

CREATE PROCEDURE get_list_of_patient_with_number_visiting
(
)
BEGIN
  DECLARE sql_error TINYINT DEFAULT FALSE;
  
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;

  START TRANSACTION;
  
 -- list of patient with number of visiting the clinic
SELECT distinct concat(p.first_name ,' ', p.last_name) as "Patient Name", count(encounter_id) as "Number Visited"
 FROM visit as v, patient as p
 where v.patient_id = p.patient_id
 group by p.patient_id
 order by v.date_time_of_visit;
 
  
  IF sql_error = FALSE THEN
    COMMIT;
  ELSE
    ROLLBACK;
  END IF;
END//

DELIMITER ;


-- Test success: 
CALL get_list_of_patient_with_number_visiting();


-- list of patient with number of visiting the at least number of visiting is parameter
DROP PROCEDURE IF EXISTS get_list_of_patient_with_number_visiting_param;

DELIMITER //

CREATE PROCEDURE get_list_of_patient_with_number_visiting_param
(
number_visiting_param INT
)
BEGIN
  DECLARE sql_error TINYINT DEFAULT FALSE;
  
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;

  START TRANSACTION;
  
-- list of patient with number of visiting the clinic twice 
SELECT distinct concat(p.first_name ,' ', p.last_name) as "Patient Name", count(encounter_id) as "Number Visited"
 FROM visit as v, patient as p
 where v.patient_id = p.patient_id
 group by p.patient_id
 having count(encounter_id) >= number_visiting_param
 order by v.date_time_of_visit;
 
  
  IF sql_error = FALSE THEN
    COMMIT;
  ELSE
    ROLLBACK;
  END IF;
END//

DELIMITER ;


-- Test success: 
CALL get_list_of_patient_with_number_visiting_param(2);