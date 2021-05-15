USE outpatient_clinic_updated;

DROP PROCEDURE IF EXISTS update_billing_detail;

DELIMITER //

CREATE PROCEDURE update_other_charges_billing_detail
(
  bill_id_param INT,
  patient_id_param INT,
  other_charges_param FLOAT 
)
BEGIN
  DECLARE sql_error TINYINT DEFAULT FALSE;
  
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET sql_error = TRUE;
    
  -- Set default values for NULL values
  IF other_charges_param IS NULL THEN
    SET other_charges_param = 10;
  END IF;

  START TRANSACTION;
  
  UPDATE  billing_detail 
  SET other_charges = other_charges_param
  WHERE bill_id = bill_id_param and patient_id=patient_id_param;
  
  IF sql_error = FALSE THEN
    COMMIT;
  ELSE
    ROLLBACK;
  END IF;
END//

DELIMITER ;

-- Test fail: 
CALL update_other_charges_billing_detail(1,1,null);

-- Test success: 
CALL update_other_charges_billing_detail(1,1,700);

select * from billing_detail where bill_id=1 and patient_id=1;

