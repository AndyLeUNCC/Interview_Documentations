USE outpatient_clinic_updated;

-- change of patient address by update statement

DROP PROCEDURE IF EXISTS change_patient_address;

DELIMITER //

CREATE PROCEDURE change_patient_address
(
  patient_id_param INT,
  patient_address_param varchar(100)
)
BEGIN
  DECLARE sql_error TINYINT DEFAULT FALSE;
  
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
    
  -- Set default values for NULL values
  IF patient_address_param IS NULL THEN
    SET patient_address_param = '';
  END IF;

  START TRANSACTION;
  
  UPDATE  contact_info 
  SET address = patient_address_param
  WHERE patient_id=patient_id_param;
  
  IF sql_error = FALSE THEN
    COMMIT;
  ELSE
    ROLLBACK;
  END IF;
END//

DELIMITER ;


-- Test success: 
CALL change_patient_address(1,'110 Pangle Dr, Charlotte');

select * from contact_info where patient_id=1;


-- change of patient insurrance by update statement
DROP PROCEDURE IF EXISTS change_patient_insurrance;

DELIMITER //

CREATE PROCEDURE change_patient_insurrance
(
  patient_id_param INT,
  patient_insurrance_param varchar(100)
)
BEGIN
  DECLARE sql_error TINYINT DEFAULT FALSE;
  
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
    
  -- Set default values for NULL values
  IF patient_insurrance_param IS NULL THEN
    SET patient_insurrance_param = '';
  END IF;

  START TRANSACTION;
  
  UPDATE  financial_info 
  SET insurrance_info = patient_insurrance_param
  WHERE patient_id=patient_id_param;
  
  IF sql_error = FALSE THEN
    COMMIT;
  ELSE
    ROLLBACK;
  END IF;
END//

DELIMITER ;


-- Test success: 
CALL change_patient_insurrance(1,'changed insurrance');

select * from financial_info where patient_id=1;

-- change the phone number of patient
DROP PROCEDURE IF EXISTS change_patient_phone_number;

DELIMITER //

CREATE PROCEDURE change_patient_phone_number
(
  patient_id_param INT,
  patient_phone_number_param varchar(100)
)
BEGIN
  DECLARE sql_error TINYINT DEFAULT FALSE;
  
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
    
  -- Set default values for NULL values
  IF patient_phone_number_param IS NULL THEN
    SET patient_phone_number_param = '';
  END IF;

  START TRANSACTION;
  
  UPDATE  contact_info 
  SET phone_number = patient_phone_number_param
  WHERE patient_id=patient_id_param;
  
  IF sql_error = FALSE THEN
    COMMIT;
  ELSE
    ROLLBACK;
  END IF;
END//

DELIMITER ;


-- Test success: 
CALL change_patient_phone_number(2, '123-777-199');

select * from contact_info where patient_id=2;


-- change the phone number of patient
DROP PROCEDURE IF EXISTS change_patient_phone_number;

DELIMITER //

CREATE PROCEDURE change_patient_phone_number
(
  patient_id_param INT,
  patient_phone_number_param varchar(100)
)
BEGIN
  DECLARE sql_error TINYINT DEFAULT FALSE;
  
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
    
  -- Set default values for NULL values
  IF patient_phone_number_param IS NULL THEN
    SET patient_phone_number_param = '';
  END IF;

  START TRANSACTION;
  
  UPDATE  contact_info 
  SET phone_number = patient_phone_number_param
  WHERE patient_id=patient_id_param;
  
  IF sql_error = FALSE THEN
    COMMIT;
  ELSE
    ROLLBACK;
  END IF;
END//

DELIMITER ;


-- Test success: 
CALL change_patient_phone_number(2, '123-777-199');

select * from contact_info where patient_id=2;


-- change the disease type of patient 
DROP PROCEDURE IF EXISTS change_patient_disease_type;

DELIMITER //

CREATE PROCEDURE change_patient_disease_type
(
  patient_id_param INT,
  patient_disease_type_param varchar(100)
)
BEGIN
  DECLARE sql_error TINYINT DEFAULT FALSE;
  
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
    
  -- Set default values for NULL values
  IF patient_disease_type_param IS NULL THEN
    SET patient_disease_type_param = '';
  END IF;

  START TRANSACTION;
  
  UPDATE  disease 
  SET disease_type = patient_disease_type_param
  WHERE patient_id=patient_id_param;
  
  IF sql_error = FALSE THEN
    COMMIT;
  ELSE
    ROLLBACK;
  END IF;
END//

DELIMITER ;


-- Test success: 
CALL change_patient_disease_type(2, 'changed circulatory' );

select * from disease where patient_id=2;


-- change the type of laboratory based on the patient id
DROP PROCEDURE IF EXISTS change_laboratory_type;

DELIMITER //

CREATE PROCEDURE change_laboratory_type
(
  patient_id_param INT,
  laboratory_type_param varchar(100)
)
BEGIN
  DECLARE sql_error TINYINT DEFAULT FALSE;
  
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
    
  -- Set default values for NULL values
  IF laboratory_type_param IS NULL THEN
    SET laboratory_type_param = '';
  END IF;

  START TRANSACTION;
  
  UPDATE  laboratory 
  SET type = laboratory_type_param
  WHERE patient_id=patient_id_param;
  
  IF sql_error = FALSE THEN
    COMMIT;
  ELSE
    ROLLBACK;
  END IF;
END//

DELIMITER ;


-- Test success: 
CALL change_laboratory_type(1, 'changed type1' );

select * from laboratory where patient_id=1;
