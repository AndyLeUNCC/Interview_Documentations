USE outpatient_clinic_updated;

DROP TRIGGER IF EXISTS billing_detail_after_delete;

DELIMITER //

CREATE TRIGGER billing_detail_after_delete
  AFTER DELETE ON billing_detail
  FOR EACH ROW
BEGIN
    
    INSERT INTO billing_detail_history
	VALUES (old.bill_id, old.patient_id,old.consulting_fees,old.test_fees, old.medicine_price, old.other_charges, 
	old.total_amount, old.date, "Andy",now(), 1);

END//

DELIMITER ;


DROP TRIGGER IF EXISTS billing_detail_after_update;

DELIMITER //

CREATE TRIGGER billing_detail_after_update
  AFTER UPDATE ON billing_detail
  FOR EACH ROW
BEGIN
    
    INSERT INTO billing_detail_history
	VALUES (old.bill_id, old.patient_id,old.consulting_fees,old.test_fees, old.medicine_price, old.other_charges, 
	old.total_amount, old.date, "Andy", now(), 0);

END//

DELIMITER ;


DROP TRIGGER IF EXISTS contact_info_after_delete;

DELIMITER //

CREATE TRIGGER contact_info_after_delete
  AFTER DELETE ON contact_info
  FOR EACH ROW
BEGIN
    
    INSERT INTO contact_info_history
	VALUES (old.patient_id, old.address,old.state,old.zip_code, old.email, old.phone_number, "Andy",now(), 1);

END//

DELIMITER ;


DROP TRIGGER IF EXISTS contact_info_after_update;

DELIMITER //

CREATE TRIGGER contact_info_after_update
  AFTER UPDATE ON contact_info
  FOR EACH ROW
BEGIN
    
    INSERT INTO contact_info_history
		VALUES (old.patient_id, old.address,old.state,old.zip_code, old.email, old.phone_number, "Andy",now(), 0);


END//

DELIMITER ;


DROP TRIGGER IF EXISTS disease_after_delete;

DELIMITER //

CREATE TRIGGER disease_after_delete
  AFTER DELETE ON disease
  FOR EACH ROW
BEGIN
    
    INSERT INTO disease_history
	VALUES (old.patient_id, old.icd10,old.disease_name,old.disease_type, "Andy",now(), 1);

END//

DELIMITER ;


DROP TRIGGER IF EXISTS disease_after_update;

DELIMITER //

CREATE TRIGGER disease_after_update
  AFTER UPDATE ON disease
  FOR EACH ROW
BEGIN
    
    INSERT INTO disease_history
	VALUES (old.patient_id, old.icd10,old.disease_name,old.disease_type, "Andy",now(), 0);

END//

DELIMITER ;

-- 
DROP TRIGGER IF EXISTS financial_info_after_delete;

DELIMITER //

CREATE TRIGGER financial_info_after_delete
  AFTER DELETE ON financial_info
  FOR EACH ROW
BEGIN
    
    INSERT INTO financial_info_history
	VALUES (old.patient_id, old.insurrance_info,old.responsible_party, "Andy",now(), 1);

END//

DELIMITER ;


DROP TRIGGER IF EXISTS financial_info_after_update;

DELIMITER //

CREATE TRIGGER financial_info_after_update
  AFTER UPDATE ON financial_info
  FOR EACH ROW
BEGIN
    
    INSERT INTO financial_info_history
	VALUES (old.patient_id, old.insurrance_info,old.responsible_party, "Andy",now(), 0);

END//

DELIMITER ;

-- 
DROP TRIGGER IF EXISTS laboratory_after_delete;

DELIMITER //

CREATE TRIGGER laboratory_after_delete
  AFTER DELETE ON laboratory
  FOR EACH ROW
BEGIN
    
    INSERT INTO laboratory_history
	VALUES (old.patient_id, old.type,old.results,old.date, "Andy",now(), 1);

END//

DELIMITER ;


DROP TRIGGER IF EXISTS laboratory_after_update;

DELIMITER //

CREATE TRIGGER laboratory_after_update
  AFTER UPDATE ON laboratory
  FOR EACH ROW
BEGIN
    
    INSERT INTO laboratory_history
	VALUES (old.patient_id, old.type,old.results,old.date, "Andy",now(), 0);

END//

DELIMITER ;

-- 
DROP TRIGGER IF EXISTS patient_after_delete;

DELIMITER //

CREATE TRIGGER patient_after_delete
  AFTER DELETE ON patient
  FOR EACH ROW
BEGIN
    
    INSERT INTO patient_history
	VALUES (old.patient_id, old.first_name,old.middle_name,old.last_name,
    old.date_of_birth,old.age,old.language,old.marital_status,old.gender,old.provider_id, "Andy",now(), 1);

END//

DELIMITER ;


DROP TRIGGER IF EXISTS patient_after_update;

DELIMITER //

CREATE TRIGGER patient_after_update
  AFTER UPDATE ON patient
  FOR EACH ROW
BEGIN
    
    INSERT INTO patient_history
	VALUES (old.patient_id, old.first_name,old.middle_name,old.last_name,
    old.date_of_birth,old.age,old.language,old.marital_status,old.gender,old.provider_id, "Andy",now(), 0);

END//

DELIMITER ;

-- 
DROP TRIGGER IF EXISTS prescription_after_delete;

DELIMITER //

CREATE TRIGGER prescription_after_delete
  AFTER DELETE ON prescription
  FOR EACH ROW
BEGIN
    
    INSERT INTO prescription_history
	VALUES (old.patient_id, old.provider_id,old.date, "Andy",now(), 1);

END//

DELIMITER ;


DROP TRIGGER IF EXISTS prescription_after_update;

DELIMITER //

CREATE TRIGGER prescription_after_update
  AFTER UPDATE ON prescription
  FOR EACH ROW
BEGIN
    
    INSERT INTO prescription_history
		VALUES (old.patient_id, old.provider_id,old.date, "Andy",now(), 0);


END//

DELIMITER ;


-- 
DROP TRIGGER IF EXISTS provider_after_delete;

DELIMITER //

CREATE TRIGGER provider_after_delete
  AFTER DELETE ON provider
  FOR EACH ROW
BEGIN
    
    INSERT INTO provider_history
	VALUES (old.provider_id, old.first_name,old.middle_name,old.last_name,
    old.date_of_birth,old.age,old.specialist,old.gender,old.language,old.date_of_hire,
    old.grad_date,old.year_of_practice,old.school,old.federal_id, "Andy",now(), 1);

END//

DELIMITER ;


DROP TRIGGER IF EXISTS provider_after_update;

DELIMITER //

CREATE TRIGGER provider_after_update
  AFTER UPDATE ON provider
  FOR EACH ROW
BEGIN
    
    INSERT INTO provider_history
	VALUES (old.provider_id, old.first_name,old.middle_name,old.last_name,
    old.date_of_birth,old.age,old.specialist,old.gender,old.language,old.date_of_hire,
    old.grad_date,old.year_of_practice,old.school,old.federal_id, "Andy",now(), 0);


END//

DELIMITER ;


-- 
DROP TRIGGER IF EXISTS rooms_after_delete;

DELIMITER //

CREATE TRIGGER rooms_after_delete
  AFTER DELETE ON rooms
  FOR EACH ROW
BEGIN
    
    INSERT INTO rooms_history
	VALUES (old.room_id, old.type,old.price_per_date,old.availability,"Andy",now(), 1);

END//

DELIMITER ;


DROP TRIGGER IF EXISTS rooms_after_update;

DELIMITER //

CREATE TRIGGER rooms_after_update
  AFTER UPDATE ON rooms
  FOR EACH ROW
BEGIN
    
    INSERT INTO rooms_history
		VALUES (old.room_id, old.type,old.price_per_date,old.availability,"Andy",now(), 0);



END//

DELIMITER ;

-- 
DROP TRIGGER IF EXISTS rooms_patient_after_delete;

DELIMITER //

CREATE TRIGGER rooms_patient_after_delete
  AFTER DELETE ON rooms_patient
  FOR EACH ROW
BEGIN
    
    INSERT INTO rooms_patient_history
	VALUES (old.room_id, old.patient_id,old.date,"Andy",now(), 1);

END//

DELIMITER ;


DROP TRIGGER IF EXISTS rooms_patient_after_update;

DELIMITER //

CREATE TRIGGER rooms_patient_after_update
  AFTER UPDATE ON rooms_patient
  FOR EACH ROW
BEGIN
    
    INSERT INTO rooms_patient_history
	VALUES (old.room_id, old.patient_id,old.date,"Andy",now(), 0);



END//

DELIMITER ;

-- 
DROP TRIGGER IF EXISTS treatment_info_after_delete;

DELIMITER //

CREATE TRIGGER treatment_info_after_delete
  AFTER DELETE ON treatment_info
  FOR EACH ROW
BEGIN
    
    INSERT INTO treatment_info_history
	VALUES (old.patient_id, old.icd10,old.medication,"Andy",now(), 1);

END//

DELIMITER ;


DROP TRIGGER IF EXISTS treatment_info_after_update;

DELIMITER //

CREATE TRIGGER treatment_info_after_update
  AFTER UPDATE ON treatment_info
  FOR EACH ROW
BEGIN
    
    INSERT INTO treatment_info_history
	VALUES (old.patient_id, old.icd10,old.medication,"Andy",now(), 0);

END//

DELIMITER ;

-- 
DROP TRIGGER IF EXISTS visit_after_delete;

DELIMITER //

CREATE TRIGGER visit_after_delete
  AFTER DELETE ON visit
  FOR EACH ROW
BEGIN
    
    INSERT INTO visit_history
	VALUES (old.encounter_id, old.patient_id,old.date_time_of_visit,"Andy",now(), 1);

END//

DELIMITER ;


DROP TRIGGER IF EXISTS visit_after_update;

DELIMITER //

CREATE TRIGGER visit_after_update
  AFTER UPDATE ON visit
  FOR EACH ROW
BEGIN
    
    INSERT INTO visit_history
	VALUES (old.encounter_id, old.patient_id,old.date_time_of_visit,"Andy",now(), 0);

END//

DELIMITER ;

-- 
DROP TRIGGER IF EXISTS vital_sign_after_delete;

DELIMITER //

CREATE TRIGGER vital_sign_after_delete
  AFTER DELETE ON vital_sign
  FOR EACH ROW
BEGIN
    
    INSERT INTO vital_sign_history
	VALUES (old.patient_id, old.temperature,old.blood_pressure,
    old.height,old.weight,old.heart_beats,old.oxygen_level,"Andy",now(), 1);

END//

DELIMITER ;


DROP TRIGGER IF EXISTS vital_sign_after_update;

DELIMITER //

CREATE TRIGGER vital_sign_after_update
  AFTER UPDATE ON vital_sign
  FOR EACH ROW
BEGIN
    
    INSERT INTO vital_sign_history
	VALUES (old.patient_id, old.temperature,old.blood_pressure,
    old.height,old.weight,old.heart_beats,old.oxygen_level,"Andy",now(), 0);
END//

DELIMITER ;