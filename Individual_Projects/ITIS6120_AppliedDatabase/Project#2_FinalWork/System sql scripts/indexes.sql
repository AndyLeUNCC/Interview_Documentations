-- DROP INDEX statement to remove existing indexes of a table.
-- drop index billing_detail_date on billing_detail;
-- create an index on the table named billing_detail
Create Index billing_detail_date_ix on billing_detail(date);


-- drop index rooms_patient_date on rooms_patient;
-- create an index on the table named rooms_patient
Create Index rooms_patient_date_ix on rooms_patient(date);

-- drop index laboratory_date on laboratory;
-- create an index on the table named laboratory
Create Index laboratory_date_ix on laboratory(date);

-- create an index on the table named contact_info
CREATE INDEX contact_info_zip_code_ix ON contact_info (zip_code);

-- create an index on the table named patient
CREATE INDEX patient_date_of_birth_ix ON patient (date_of_birth);

-- create an index on the table named provider
CREATE INDEX provider_date_of_birth_ix ON provider (date_of_birth);

-- create an index on the table named rooms
CREATE INDEX rooms_type_ix ON rooms (type);

-- create an index on the table named vital_sign
CREATE INDEX vital_sign_weight_ix ON vital_sign (weight);

-- create an index on the table named disease
CREATE INDEX disease_disease_type_ix ON disease (disease_type);