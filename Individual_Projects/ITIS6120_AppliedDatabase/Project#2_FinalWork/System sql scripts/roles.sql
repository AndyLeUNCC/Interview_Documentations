use outpatient_clinic_updated;

-- To create the roles, use the CREATE ROLE statement:
 DROP ROLE IF EXISTS 'app_read', 'app_write', 'app_developer';
CREATE ROLE 'app_developer', 'app_read', 'app_write';

DROP ROLE IF EXISTS 'admin', 'provider', 'patient', 'physician', 'receptionist';
CREATE ROLE 'admin', 'provider', 'patient', 'physician', 'receptionist';

-- To assign privileges to the roles, 
-- execute GRANT statements using the same syntax as for assigning privileges to user accounts:
GRANT ALL ON outpatient_clinic.* TO 'app_developer', 'admin';
GRANT SELECT ON outpatient_clinic.* TO 'app_read';
GRANT INSERT, UPDATE, DELETE ON outpatient_clinic.* TO 'app_write';
-- a physician could delete a prescription order, but not a receptionist.
GRANT SELECT ON outpatient_clinic.* TO 'receptionist', 'physician','patient', 'provider';
GRANT DELETE ON outpatient_clinic.prescription TO 'physician';


--  require one developer account, two user accounts that need read-only access, 
-- and one user account that needs read/write access
DROP USER IF EXISTS 'dev1'@'localhost','read_andy1'@'localhost','read_andy2'@'localhost','rw_andy1'@'localhost';
DROP USER IF EXISTS 'admin'@'localhost','receptionist1'@'localhost','physician1'@'localhost', 'patient1'@'localhost', 'provider1'@'localhost';
CREATE USER 'dev1'@'localhost' IDENTIFIED BY 'dev1pass';
CREATE USER 'read_andy1'@'localhost' IDENTIFIED BY 'read_andy1pass';
CREATE USER 'read_andy2'@'localhost' IDENTIFIED BY 'read_andy2pass';
CREATE USER 'rw_andy1'@'localhost' IDENTIFIED BY 'rw_andy1pass';

CREATE USER 'admin'@'localhost' IDENTIFIED BY 'adminpass';
CREATE USER 'receptionist1'@'localhost' IDENTIFIED BY 'receptionist1pass';
CREATE USER 'physician1'@'localhost' IDENTIFIED BY 'physician1pass';
CREATE USER 'patient1'@'localhost' IDENTIFIED BY 'patient1pass';
CREATE USER 'provider1'@'localhost' IDENTIFIED BY 'provider1pass';


-- assign each user account its required privileges
GRANT 'app_developer' TO 'dev1'@'localhost';
GRANT 'app_read' TO 'read_andy1'@'localhost', 'read_andy2'@'localhost';
GRANT 'app_read', 'app_write' TO 'rw_andy1'@'localhost';

GRANT 'admin' TO 'admin'@'localhost';
GRANT 'receptionist' TO 'receptionist1'@'localhost';
GRANT 'physician' TO 'physician1'@'localhost';
GRANT 'patient' TO 'patient1'@'localhost';
GRANT 'provider' TO 'provider1'@'localhost';



-- To verify the privileges assigned to an account, use SHOW GRANTS
SHOW GRANTS FOR 'dev1'@'localhost';
SHOW GRANTS FOR 'read_andy1'@'localhost';
SHOW GRANTS FOR 'read_andy2'@'localhost';
SHOW GRANTS FOR 'rw_andy1'@'localhost';

SHOW GRANTS FOR 'admin'@'localhost';
SHOW GRANTS FOR 'receptionist1'@'localhost';
SHOW GRANTS FOR 'physician1'@'localhost';
SHOW GRANTS FOR 'patient1'@'localhost';
SHOW GRANTS FOR 'provider1'@'localhost';