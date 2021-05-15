-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: localhost    Database: outpatient_clinic_updated
-- ------------------------------------------------------
-- Server version	8.0.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
-- CREATE database outpatient_clinic if not exists
CREATE DATABASE IF NOT EXISTS `outpatient_clinic_updated`;
USE `outpatient_clinic_updated`;
--
-- Temporary view structure for view `all_list_room`
--

DROP TABLE IF EXISTS `all_list_room`;
/*!50001 DROP VIEW IF EXISTS `all_list_room`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `all_list_room` AS SELECT 
 1 AS `room_id`,
 1 AS `type`,
 1 AS `price_per_date`,
 1 AS `availability`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `all_patient`
--

DROP TABLE IF EXISTS `all_patient`;
/*!50001 DROP VIEW IF EXISTS `all_patient`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `all_patient` AS SELECT 
 1 AS `patient_id`,
 1 AS `first_name`,
 1 AS `middle_name`,
 1 AS `last_name`,
 1 AS `date_of_birth`,
 1 AS `age`,
 1 AS `language`,
 1 AS `marital_status`,
 1 AS `gender`,
 1 AS `provider_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `billing_detail`
--

DROP TABLE IF EXISTS `billing_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billing_detail` (
  `bill_id` int NOT NULL AUTO_INCREMENT,
  `patient_id` int NOT NULL,
  `consulting_fees` float NOT NULL,
  `test_fees` float NOT NULL,
  `medicine_price` float NOT NULL,
  `other_charges` float NOT NULL,
  `total_amount` double NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`bill_id`,`patient_id`),
  KEY `fk_billing_detail_patient1_idx` (`patient_id`),
  KEY `billing_detail_date_ix` (`date`),
  CONSTRAINT `fk_billing_detail_patient1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billing_detail`
--

LOCK TABLES `billing_detail` WRITE;
/*!40000 ALTER TABLE `billing_detail` DISABLE KEYS */;
INSERT INTO `billing_detail` VALUES (1,1,200,100,100,700,550,'2021-03-20'),(2,1,100,100,200,100,500,'2021-03-25'),(3,1,100,100,100,100,400,'2021-03-27'),(4,2,100,100,100,100,400,'2021-02-20'),(5,1,200,100,100,150,550,'2021-02-20'),(6,2,200,100,100,150,550,'2021-02-22'),(7,2,200,100,100,150,550,'2021-02-24'),(8,2,200,100,100,150,550,'2021-02-27'),(9,3,200,100,100,150,550,'2021-02-27'),(10,3,200,100,100,150,550,'2021-02-28'),(11,3,200,100,100,150,550,'2021-02-15'),(12,4,200,100,100,150,550,'2021-02-28'),(13,4,200,100,100,150,550,'2021-02-15'),(14,5,200,100,100,150,550,'2021-02-28'),(15,5,200,100,100,150,550,'2021-02-15');
/*!40000 ALTER TABLE `billing_detail` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `billing_detail_after_update` AFTER UPDATE ON `billing_detail` FOR EACH ROW BEGIN
    
    INSERT INTO billing_detail_history
	VALUES (old.bill_id, old.patient_id,old.consulting_fees,old.test_fees, old.medicine_price, old.other_charges, 
	old.total_amount, old.date, "Andy", now(), 0);

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `billing_detail_after_delete` AFTER DELETE ON `billing_detail` FOR EACH ROW BEGIN
    
    INSERT INTO billing_detail_history
	VALUES (old.bill_id, old.patient_id,old.consulting_fees,old.test_fees, old.medicine_price, old.other_charges, 
	old.total_amount, old.date, "Andy",now(), 1);

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `billing_detail_history`
--

DROP TABLE IF EXISTS `billing_detail_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billing_detail_history` (
  `bill_id` int NOT NULL,
  `patient_id` int NOT NULL,
  `consulting_fees` float NOT NULL,
  `test_fees` float NOT NULL,
  `medicine_price` float NOT NULL,
  `other_charges` float NOT NULL,
  `total_amount` double NOT NULL,
  `date` date NOT NULL,
  `changed_by` varchar(45) NOT NULL,
  `changed_on` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billing_detail_history`
--

LOCK TABLES `billing_detail_history` WRITE;
/*!40000 ALTER TABLE `billing_detail_history` DISABLE KEYS */;
INSERT INTO `billing_detail_history` VALUES (1,1,200,100,100,150,550,'2021-03-20','Andy','2021-05-12 17:52:54',0),(1,1,200,100,100,0,550,'2021-03-20','Andy','2021-05-12 17:52:55',0);
/*!40000 ALTER TABLE `billing_detail_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact_info`
--

DROP TABLE IF EXISTS `contact_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_info` (
  `patient_id` int NOT NULL,
  `address` varchar(45) NOT NULL,
  `state` varchar(45) NOT NULL,
  `zip_code` varchar(45) NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `phone_number` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`patient_id`),
  KEY `contact_info_zip_code_ix` (`zip_code`),
  CONSTRAINT `fk_contact_info_patient1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_info`
--

LOCK TABLES `contact_info` WRITE;
/*!40000 ALTER TABLE `contact_info` DISABLE KEYS */;
INSERT INTO `contact_info` VALUES (1,'110 Pangle Dr, Charlotte','NC','28207','b@b.com','123-777-199'),(2,'Mataderos 231','NC','28217','c@c.com','123-777-199'),(3,'Av. dos Lusíadas, 23','NC','28218','d@c.com','123-777-666'),(4,'Berkeley Gardens 12','NC','28219','a@c.com','123-777-111'),(5,'Walserweg 21','NC','28216','e@c.com','123-777-222'),(6,'35 King George','NC','28206','andy@c.com','123-777-333'),(7,'Kirchgasse 6','NC','28218','bb@c.com','123-777-454'),(8,'Jardim das rosas n. 32','NC','28218','bcb@c.com','123-777-333'),(9,'8 Johnstown Road','NC','28217','cbc@c.com','123-777-234'),(10,'1900 Oak St.','NC','28217','cab@c.com','123-777-134'),(11,'Magazinweg 7','NC','28217','cda@c.com','123-233-888'),(12,'12 Orchestra Terrace','NC','28217','acc@c.com','123-111-888'),(13,'Ave. 5 de Mayo Porlamar','NC','28217','lau@c.com','123-332-888'),(14,'89 Chiaroscuro Rd.','NC','28217','han@c.com','123-138-888'),(15,'Via Ludovico il Moro 22','NC','28217','morning@c.com','123-341-888');
/*!40000 ALTER TABLE `contact_info` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `contact_info_after_update` AFTER UPDATE ON `contact_info` FOR EACH ROW BEGIN
    
    INSERT INTO contact_info_history
		VALUES (old.patient_id, old.address,old.state,old.zip_code, old.email, old.phone_number, "Andy",now(), 0);


END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `contact_info_after_delete` AFTER DELETE ON `contact_info` FOR EACH ROW BEGIN
    
    INSERT INTO contact_info_history
	VALUES (old.patient_id, old.address,old.state,old.zip_code, old.email, old.phone_number, "Andy",now(), 1);

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `contact_info_history`
--

DROP TABLE IF EXISTS `contact_info_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_info_history` (
  `patient_id` int NOT NULL,
  `address` varchar(45) NOT NULL,
  `state` varchar(45) NOT NULL,
  `zip_code` varchar(45) NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `phone_number` varchar(45) DEFAULT NULL,
  `changed_by` varchar(45) NOT NULL,
  `changed_on` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_info_history`
--

LOCK TABLES `contact_info_history` WRITE;
/*!40000 ALTER TABLE `contact_info_history` DISABLE KEYS */;
INSERT INTO `contact_info_history` VALUES (1,'Pangle Dr, Charlotte','NC','28207','b@b.com','123-888-888','Andy','2021-05-12 18:02:57',0),(1,'110 Pangle Dr, Charlotte','NC','28207','b@b.com','123-888-888','Andy','2021-05-12 18:27:46',0),(1,'110 Pangle Dr, Charlotte','NC','28207','b@b.com','123-888-888','Andy','2021-05-12 18:30:59',0),(1,'110 Pangle Dr, Charlotte','NC','28207','b@b.com','123-888-888','Andy','2021-05-12 18:31:00',0),(1,'110 Pangle Dr, Charlotte','NC','28207','b@b.com','123-777-999','Andy','2021-05-12 18:31:16',0),(2,'Mataderos 231','NC','28217','c@c.com','123-777-999','Andy','2021-05-12 18:31:40',0),(1,'110 Pangle Dr, Charlotte','NC','28207','b@b.com','123-777-199','Andy','2021-05-12 18:58:20',0),(2,'Mataderos 231','NC','28217','c@c.com','123-777-199','Andy','2021-05-12 18:58:20',0),(2,'Mataderos 231','NC','28217','c@c.com','123-777-199','Andy','2021-05-12 18:58:21',0),(1,'110 Pangle Dr, Charlotte','NC','28207','b@b.com','123-777-199','Andy','2021-05-12 18:58:35',0),(2,'Mataderos 231','NC','28217','c@c.com','123-777-199','Andy','2021-05-12 18:58:36',0),(2,'Mataderos 231','NC','28217','c@c.com','123-777-199','Andy','2021-05-12 18:58:37',0),(1,'110 Pangle Dr, Charlotte','NC','28207','b@b.com','123-777-199','Andy','2021-05-12 19:01:36',0),(2,'Mataderos 231','NC','28217','c@c.com','123-777-199','Andy','2021-05-12 19:01:38',0),(2,'Mataderos 231','NC','28217','c@c.com','123-777-199','Andy','2021-05-12 19:01:38',0);
/*!40000 ALTER TABLE `contact_info_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `disease`
--

DROP TABLE IF EXISTS `disease`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `disease` (
  `patient_id` int NOT NULL,
  `icd10` varchar(45) NOT NULL,
  `disease_name` varchar(45) NOT NULL,
  `disease_type` varchar(45) NOT NULL,
  PRIMARY KEY (`patient_id`),
  KEY `disease_disease_type_ix` (`disease_type`),
  CONSTRAINT `fk_disease_laboratory1` FOREIGN KEY (`patient_id`) REFERENCES `laboratory` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disease`
--

LOCK TABLES `disease` WRITE;
/*!40000 ALTER TABLE `disease` DISABLE KEYS */;
INSERT INTO `disease` VALUES (1,'A00-B99','Certain infectious and parasitic diseases','infectious diseases'),(2,'C00-D49','Neoplasms','changed circulatory'),(3,'A00-B99','Certain infectious and parasitic diseases','infectious diseases'),(4,'A00-B99','Certain infectious and parasitic diseases','infectious diseases'),(5,'C00-D49','Neoplasms','circulatory'),(6,'A00-B99','Certain infectious and parasitic diseases','infectious diseases'),(7,'A00-B99','Certain infectious and parasitic diseases','infectious diseases');
/*!40000 ALTER TABLE `disease` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `disease_after_update` AFTER UPDATE ON `disease` FOR EACH ROW BEGIN
    
    INSERT INTO disease_history
	VALUES (old.patient_id, old.icd10,old.disease_name,old.disease_type, "Andy",now(), 0);

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `disease_after_delete` AFTER DELETE ON `disease` FOR EACH ROW BEGIN
    
    INSERT INTO disease_history
	VALUES (old.patient_id, old.icd10,old.disease_name,old.disease_type, "Andy",now(), 1);

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `disease_history`
--

DROP TABLE IF EXISTS `disease_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `disease_history` (
  `patient_id` int NOT NULL,
  `icd10` varchar(45) NOT NULL,
  `disease_name` varchar(45) NOT NULL,
  `disease_type` varchar(45) NOT NULL,
  `changed_by` varchar(45) NOT NULL,
  `changed_on` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disease_history`
--

LOCK TABLES `disease_history` WRITE;
/*!40000 ALTER TABLE `disease_history` DISABLE KEYS */;
INSERT INTO `disease_history` VALUES (2,'C00-D49','Neoplasms','circulatory','Andy','2021-05-12 18:58:21',0),(2,'C00-D49','Neoplasms','circulatory','Andy','2021-05-12 18:58:37',0),(2,'C00-D49','Neoplasms','changed circulatory','Andy','2021-05-12 19:01:39',0);
/*!40000 ALTER TABLE `disease_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `financial_info`
--

DROP TABLE IF EXISTS `financial_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `financial_info` (
  `patient_id` int NOT NULL,
  `insurrance_info` varchar(100) NOT NULL,
  `responsible_party` varchar(100) NOT NULL,
  PRIMARY KEY (`patient_id`),
  CONSTRAINT `fk_financial_info_patient1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `financial_info`
--

LOCK TABLES `financial_info` WRITE;
/*!40000 ALTER TABLE `financial_info` DISABLE KEYS */;
INSERT INTO `financial_info` VALUES (1,'changed insurrance','party_1'),(2,'insurrance_1','party_1'),(3,'insurrance_2','party_2'),(4,'insurrance_1','party_1'),(5,'insurrance_1','party_1'),(6,'insurrance_1','party_1'),(7,'insurrance_2','party_2'),(8,'insurrance_1','party_1'),(9,'insurrance_1','party_1'),(10,'insurrance_1','party_1');
/*!40000 ALTER TABLE `financial_info` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `financial_info_after_update` AFTER UPDATE ON `financial_info` FOR EACH ROW BEGIN
    
    INSERT INTO financial_info_history
	VALUES (old.patient_id, old.insurrance_info,old.responsible_party, "Andy",now(), 0);

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `financial_info_after_delete` AFTER DELETE ON `financial_info` FOR EACH ROW BEGIN
    
    INSERT INTO financial_info_history
	VALUES (old.patient_id, old.insurrance_info,old.responsible_party, "Andy",now(), 1);

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `financial_info_history`
--

DROP TABLE IF EXISTS `financial_info_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `financial_info_history` (
  `patient_id` int NOT NULL,
  `insurrance_info` varchar(100) NOT NULL,
  `responsible_party` varchar(100) NOT NULL,
  `changed_by` varchar(45) NOT NULL,
  `changed_on` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `financial_info_history`
--

LOCK TABLES `financial_info_history` WRITE;
/*!40000 ALTER TABLE `financial_info_history` DISABLE KEYS */;
INSERT INTO `financial_info_history` VALUES (1,'insurrance_correct','party_1','Andy','2021-05-12 18:27:46',0),(1,'changed insurrance','party_1','Andy','2021-05-12 18:31:00',0),(1,'changed insurrance','party_1','Andy','2021-05-12 18:58:20',0),(1,'changed insurrance','party_1','Andy','2021-05-12 18:58:36',0),(1,'changed insurrance','party_1','Andy','2021-05-12 19:01:37',0);
/*!40000 ALTER TABLE `financial_info_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `first_five_patient`
--

DROP TABLE IF EXISTS `first_five_patient`;
/*!50001 DROP VIEW IF EXISTS `first_five_patient`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `first_five_patient` AS SELECT 
 1 AS `patient_id`,
 1 AS `first_name`,
 1 AS `middle_name`,
 1 AS `last_name`,
 1 AS `date_of_birth`,
 1 AS `age`,
 1 AS `language`,
 1 AS `marital_status`,
 1 AS `gender`,
 1 AS `provider_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `laboratory`
--

DROP TABLE IF EXISTS `laboratory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `laboratory` (
  `patient_id` int NOT NULL,
  `type` varchar(45) NOT NULL,
  `results` varchar(100) NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`patient_id`),
  KEY `laboratory_date_ix` (`date`),
  CONSTRAINT `fk_laboratory_vital_sign1` FOREIGN KEY (`patient_id`) REFERENCES `vital_sign` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laboratory`
--

LOCK TABLES `laboratory` WRITE;
/*!40000 ALTER TABLE `laboratory` DISABLE KEYS */;
INSERT INTO `laboratory` VALUES (1,'changed type1','Positive','2021-03-22'),(2,'type2','Negative','2021-03-24'),(3,'type3','Positive','2021-03-22'),(4,'type4','Positive','2021-03-23'),(5,'type2','Negative','2021-03-24'),(6,'type3','Positive','2021-03-22'),(7,'type4','Positive','2021-03-23');
/*!40000 ALTER TABLE `laboratory` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `laboratory_after_update` AFTER UPDATE ON `laboratory` FOR EACH ROW BEGIN
    
    INSERT INTO laboratory_history
	VALUES (old.patient_id, old.type,old.results,old.date, "Andy",now(), 0);

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `laboratory_after_delete` AFTER DELETE ON `laboratory` FOR EACH ROW BEGIN
    
    INSERT INTO laboratory_history
	VALUES (old.patient_id, old.type,old.results,old.date, "Andy",now(), 1);

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `laboratory_history`
--

DROP TABLE IF EXISTS `laboratory_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `laboratory_history` (
  `patient_id` int NOT NULL,
  `type` varchar(45) NOT NULL,
  `results` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `changed_by` varchar(45) NOT NULL,
  `changed_on` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laboratory_history`
--

LOCK TABLES `laboratory_history` WRITE;
/*!40000 ALTER TABLE `laboratory_history` DISABLE KEYS */;
INSERT INTO `laboratory_history` VALUES (1,'type1','Positive','2021-03-22','Andy','2021-05-12 19:01:39',0);
/*!40000 ALTER TABLE `laboratory_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient` (
  `patient_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `middle_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `date_of_birth` date NOT NULL,
  `age` int DEFAULT NULL,
  `language` varchar(45) DEFAULT NULL,
  `marital_status` varchar(45) DEFAULT NULL,
  `gender` varchar(45) DEFAULT NULL,
  `provider_id` int NOT NULL,
  PRIMARY KEY (`patient_id`,`provider_id`),
  KEY `fk_patient_provider1_idx` (`provider_id`),
  KEY `patient_date_of_birth_ix` (`date_of_birth`),
  CONSTRAINT `fk_patient_provider1` FOREIGN KEY (`provider_id`) REFERENCES `provider` (`provider_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES (1,'Wilman ','Clover ','Markets','1985-10-24',36,'french','single','female',1),(2,'Alfreds ','Futter','Futterkiste','1985-10-10',36,'english','single','male',2),(3,'Easter ','Three','Fran','1993-10-10',28,'english','single','male',1),(4,'Antonio','Moreno','Taquería','1984-10-10',37,'english','single','male',2),(5,'Around','Futter','Horn','1984-11-10',37,'french','single','female',1),(6,'Alfreds','Futter','Futterkiste','1985-10-10',36,'english','single','male',3),(7,'Blondel','Futter','trump','1986-10-10',35,'english','single','male',4),(8,'Centro ','Michel','Handel','1985-10-15',36,'english','married','male',1),(9,'Chop ','Mineiro','Ann','1985-10-10',36,'french','single','male',1),(10,'Du ','Futter','Mendel','1985-10-10',36,'french','single','male',1),(11,'Centro ','Three','Devon','1985-10-10',36,'french','single','male',1),(12,'Bottom ','Six','Wang','1990-09-10',31,'chinese','single','male',1),(13,'Bon ','Five','Afonso','1991-10-10',30,'english','single','male',1),(14,'Ernst ','Sven','Holdings','1992-10-10',29,'english','single','male',1),(15,'Easter ','Two','Connection','1993-10-10',28,'english','single','male',1);
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `patient_after_update` AFTER UPDATE ON `patient` FOR EACH ROW BEGIN
    
    INSERT INTO patient_history
	VALUES (old.patient_id, old.first_name,old.middle_name,old.last_name,
    old.date_of_birth,old.age,old.language,old.marital_status,old.gender,old.provider_id, "Andy",now(), 0);

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `patient_after_delete` AFTER DELETE ON `patient` FOR EACH ROW BEGIN
    
    INSERT INTO patient_history
	VALUES (old.patient_id, old.first_name,old.middle_name,old.last_name,
    old.date_of_birth,old.age,old.language,old.marital_status,old.gender,old.provider_id, "Andy",now(), 1);

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary view structure for view `patient_disease`
--

DROP TABLE IF EXISTS `patient_disease`;
/*!50001 DROP VIEW IF EXISTS `patient_disease`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `patient_disease` AS SELECT 
 1 AS `Patient Name`,
 1 AS `disease_type`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `patient_first_name_contain_u_character`
--

DROP TABLE IF EXISTS `patient_first_name_contain_u_character`;
/*!50001 DROP VIEW IF EXISTS `patient_first_name_contain_u_character`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `patient_first_name_contain_u_character` AS SELECT 
 1 AS `patient_id`,
 1 AS `first_name`,
 1 AS `middle_name`,
 1 AS `last_name`,
 1 AS `date_of_birth`,
 1 AS `age`,
 1 AS `language`,
 1 AS `marital_status`,
 1 AS `gender`,
 1 AS `provider_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `patient_history`
--

DROP TABLE IF EXISTS `patient_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_history` (
  `patient_id` int NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `middle_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `date_of_birth` date NOT NULL,
  `age` int DEFAULT NULL,
  `language` varchar(45) DEFAULT NULL,
  `marital_status` varchar(45) DEFAULT NULL,
  `gender` varchar(45) DEFAULT NULL,
  `provider_id` int NOT NULL,
  `changed_by` varchar(45) NOT NULL,
  `changed_on` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_history`
--

LOCK TABLES `patient_history` WRITE;
/*!40000 ALTER TABLE `patient_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `patient_middle_name_contain_u_character`
--

DROP TABLE IF EXISTS `patient_middle_name_contain_u_character`;
/*!50001 DROP VIEW IF EXISTS `patient_middle_name_contain_u_character`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `patient_middle_name_contain_u_character` AS SELECT 
 1 AS `patient_id`,
 1 AS `first_name`,
 1 AS `middle_name`,
 1 AS `last_name`,
 1 AS `date_of_birth`,
 1 AS `age`,
 1 AS `language`,
 1 AS `marital_status`,
 1 AS `gender`,
 1 AS `provider_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `patient_visit_certain_days`
--

DROP TABLE IF EXISTS `patient_visit_certain_days`;
/*!50001 DROP VIEW IF EXISTS `patient_visit_certain_days`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `patient_visit_certain_days` AS SELECT 
 1 AS `Patient Name`,
 1 AS `Visit Dates`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `patient_visit_date`
--

DROP TABLE IF EXISTS `patient_visit_date`;
/*!50001 DROP VIEW IF EXISTS `patient_visit_date`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `patient_visit_date` AS SELECT 
 1 AS `Patient Name`,
 1 AS `Visit Dates`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `prescription`
--

DROP TABLE IF EXISTS `prescription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prescription` (
  `patient_id` int NOT NULL,
  `provider_id` int NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`patient_id`,`provider_id`),
  KEY `fk_prescription_provider1_idx` (`provider_id`),
  CONSTRAINT `fk_prescription_patient1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `fk_prescription_provider1` FOREIGN KEY (`provider_id`) REFERENCES `provider` (`provider_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prescription`
--

LOCK TABLES `prescription` WRITE;
/*!40000 ALTER TABLE `prescription` DISABLE KEYS */;
INSERT INTO `prescription` VALUES (1,1,'2021-03-20'),(1,2,'2021-03-22'),(1,3,'2021-03-25'),(1,4,'2021-03-25'),(2,1,'2021-03-20'),(2,2,'2021-03-22'),(3,1,'2021-03-20'),(3,3,'2021-03-25'),(4,1,'2021-03-22'),(4,2,'2021-03-25'),(5,1,'2021-03-20'),(5,2,'2021-03-22'),(5,3,'2021-03-25'),(6,1,'2021-03-25');
/*!40000 ALTER TABLE `prescription` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `prescription_after_update` AFTER UPDATE ON `prescription` FOR EACH ROW BEGIN
    
    INSERT INTO prescription_history
		VALUES (old.patient_id, old.provider_id,old.date, "Andy",now(), 0);


END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `prescription_after_delete` AFTER DELETE ON `prescription` FOR EACH ROW BEGIN
    
    INSERT INTO prescription_history
	VALUES (old.patient_id, old.provider_id,old.date, "Andy",now(), 1);

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `prescription_history`
--

DROP TABLE IF EXISTS `prescription_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prescription_history` (
  `patient_id` int NOT NULL,
  `provider_id` int NOT NULL,
  `date` date NOT NULL,
  `changed_by` varchar(45) NOT NULL,
  `changed_on` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prescription_history`
--

LOCK TABLES `prescription_history` WRITE;
/*!40000 ALTER TABLE `prescription_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `prescription_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provider`
--

DROP TABLE IF EXISTS `provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provider` (
  `provider_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `middle_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `date_of_birth` date NOT NULL,
  `age` int NOT NULL,
  `specialist` varchar(45) NOT NULL,
  `gender` varchar(45) NOT NULL,
  `language` varchar(45) NOT NULL,
  `date_of_hire` date DEFAULT NULL,
  `grad_date` date DEFAULT NULL,
  `year_of_practice` int NOT NULL,
  `school` varchar(45) NOT NULL,
  `federal_id` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`provider_id`),
  KEY `provider_date_of_birth_ix` (`date_of_birth`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider`
--

LOCK TABLES `provider` WRITE;
/*!40000 ALTER TABLE `provider` DISABLE KEYS */;
INSERT INTO `provider` VALUES (1,'jackson','m','michael','1970-04-20',51,'Infectious disease doctors','male','english','2010-10-19','2000-10-20',8,'Harvard','1'),(2,'nancy','m','michael','1980-04-20',41,'Cardiologists doctors','female','english','2010-10-19','2000-10-20',6,'Harvard','2'),(3,'Aaron','m','Hank','1970-04-11',51,'Anesthesiologists doctors','male','english','2010-10-19','2000-10-20',8,'Harvard','3'),(4,'Abagnale','k','Frank','1980-04-20',41,'Dermatologists doctors','male','english','2010-10-19','2000-10-20',4,'Harvard','4'),(5,'Abbey','m','Edward','1980-05-20',41,'Endocrinologists doctors','female','english','2010-10-19','2000-10-20',6,'Harvard','5'),(6,'White ','m','Markets','1980-04-11',41,'Family Physicians doctors','male','english','2010-10-19','2000-10-20',5,'Standford','6');
/*!40000 ALTER TABLE `provider` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `provider_after_update` AFTER UPDATE ON `provider` FOR EACH ROW BEGIN
    
    INSERT INTO provider_history
	VALUES (old.provider_id, old.first_name,old.middle_name,old.last_name,
    old.date_of_birth,old.age,old.specialist,old.gender,old.language,old.date_of_hire,
    old.grad_date,old.year_of_practice,old.school,old.federal_id, "Andy",now(), 0);


END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `provider_after_delete` AFTER DELETE ON `provider` FOR EACH ROW BEGIN
    
    INSERT INTO provider_history
	VALUES (old.provider_id, old.first_name,old.middle_name,old.last_name,
    old.date_of_birth,old.age,old.specialist,old.gender,old.language,old.date_of_hire,
    old.grad_date,old.year_of_practice,old.school,old.federal_id, "Andy",now(), 1);

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `provider_history`
--

DROP TABLE IF EXISTS `provider_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provider_history` (
  `provider_id` int NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `middle_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `date_of_birth` date NOT NULL,
  `age` int NOT NULL,
  `specialist` varchar(45) NOT NULL,
  `gender` varchar(45) NOT NULL,
  `language` varchar(45) NOT NULL,
  `date_of_hire` date DEFAULT NULL,
  `grad_date` date DEFAULT NULL,
  `year_of_practice` int NOT NULL,
  `school` varchar(45) NOT NULL,
  `federal_id` varchar(45) DEFAULT NULL,
  `changed_by` varchar(45) NOT NULL,
  `changed_on` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider_history`
--

LOCK TABLES `provider_history` WRITE;
/*!40000 ALTER TABLE `provider_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `provider_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `provider_male_practice`
--

DROP TABLE IF EXISTS `provider_male_practice`;
/*!50001 DROP VIEW IF EXISTS `provider_male_practice`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `provider_male_practice` AS SELECT 
 1 AS `provider_id`,
 1 AS `first_name`,
 1 AS `middle_name`,
 1 AS `last_name`,
 1 AS `date_of_birth`,
 1 AS `age`,
 1 AS `specialist`,
 1 AS `gender`,
 1 AS `language`,
 1 AS `date_of_hire`,
 1 AS `grad_date`,
 1 AS `year_of_practice`,
 1 AS `school`,
 1 AS `federal_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `provider_patient_prescription`
--

DROP TABLE IF EXISTS `provider_patient_prescription`;
/*!50001 DROP VIEW IF EXISTS `provider_patient_prescription`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `provider_patient_prescription` AS SELECT 
 1 AS `Patient Name`,
 1 AS `Doctor Name`,
 1 AS `Date Diagnosis`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `provider_practice`
--

DROP TABLE IF EXISTS `provider_practice`;
/*!50001 DROP VIEW IF EXISTS `provider_practice`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `provider_practice` AS SELECT 
 1 AS `provider_id`,
 1 AS `first_name`,
 1 AS `middle_name`,
 1 AS `last_name`,
 1 AS `date_of_birth`,
 1 AS `age`,
 1 AS `specialist`,
 1 AS `gender`,
 1 AS `language`,
 1 AS `date_of_hire`,
 1 AS `grad_date`,
 1 AS `year_of_practice`,
 1 AS `school`,
 1 AS `federal_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `provider_school`
--

DROP TABLE IF EXISTS `provider_school`;
/*!50001 DROP VIEW IF EXISTS `provider_school`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `provider_school` AS SELECT 
 1 AS `provider_id`,
 1 AS `first_name`,
 1 AS `middle_name`,
 1 AS `last_name`,
 1 AS `date_of_birth`,
 1 AS `age`,
 1 AS `specialist`,
 1 AS `gender`,
 1 AS `language`,
 1 AS `date_of_hire`,
 1 AS `grad_date`,
 1 AS `year_of_practice`,
 1 AS `school`,
 1 AS `federal_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rooms` (
  `room_id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(45) NOT NULL,
  `price_per_date` int NOT NULL,
  `availability` tinyint NOT NULL,
  PRIMARY KEY (`room_id`),
  KEY `rooms_type_ix` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms`
--

LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
INSERT INTO `rooms` VALUES (1,'separate',400,1),(2,'common',100,1),(3,'economy',100,1),(4,'common',200,1),(5,'seperate',100,1);
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `rooms_after_update` AFTER UPDATE ON `rooms` FOR EACH ROW BEGIN
    
    INSERT INTO rooms_history
		VALUES (old.room_id, old.type,old.price_per_date,old.availability,"Andy",now(), 0);



END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `rooms_after_delete` AFTER DELETE ON `rooms` FOR EACH ROW BEGIN
    
    INSERT INTO rooms_history
	VALUES (old.room_id, old.type,old.price_per_date,old.availability,"Andy",now(), 1);

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `rooms_history`
--

DROP TABLE IF EXISTS `rooms_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rooms_history` (
  `room_id` int NOT NULL,
  `type` varchar(45) NOT NULL,
  `price_per_date` int NOT NULL,
  `availability` tinyint NOT NULL,
  `changed_by` varchar(45) NOT NULL,
  `changed_on` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms_history`
--

LOCK TABLES `rooms_history` WRITE;
/*!40000 ALTER TABLE `rooms_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `rooms_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rooms_patient`
--

DROP TABLE IF EXISTS `rooms_patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rooms_patient` (
  `room_id` int NOT NULL,
  `patient_id` int NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`room_id`,`patient_id`),
  KEY `fk_rooms_patient_patient1_idx` (`patient_id`),
  KEY `rooms_patient_date_ix` (`date`),
  CONSTRAINT `fk_rooms_patient_patient1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `fk_rooms_patient_rooms1` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms_patient`
--

LOCK TABLES `rooms_patient` WRITE;
/*!40000 ALTER TABLE `rooms_patient` DISABLE KEYS */;
INSERT INTO `rooms_patient` VALUES (1,5,'2021-02-20'),(1,4,'2021-02-21'),(2,1,'2021-03-15'),(2,2,'2021-03-16'),(1,1,'2021-03-20'),(1,3,'2021-03-20'),(1,8,'2021-03-20'),(3,6,'2021-03-20'),(5,1,'2021-03-20'),(5,3,'2021-03-20'),(1,2,'2021-03-21'),(1,7,'2021-03-21'),(1,9,'2021-03-21'),(3,1,'2021-03-21'),(5,2,'2021-03-21'),(5,4,'2021-03-21'),(3,2,'2021-03-22'),(4,2,'2021-03-22'),(4,1,'2021-03-23'),(4,3,'2021-03-24'),(2,3,'2021-04-21'),(2,4,'2021-04-21');
/*!40000 ALTER TABLE `rooms_patient` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `rooms_patient_after_update` AFTER UPDATE ON `rooms_patient` FOR EACH ROW BEGIN
    
    INSERT INTO rooms_patient_history
	VALUES (old.room_id, old.patient_id,old.date,"Andy",now(), 0);



END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `rooms_patient_after_delete` AFTER DELETE ON `rooms_patient` FOR EACH ROW BEGIN
    
    INSERT INTO rooms_patient_history
	VALUES (old.room_id, old.patient_id,old.date,"Andy",now(), 1);

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `rooms_patient_history`
--

DROP TABLE IF EXISTS `rooms_patient_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rooms_patient_history` (
  `room_id` int NOT NULL,
  `patient_id` int NOT NULL,
  `date` date NOT NULL,
  `changed_by` varchar(45) NOT NULL,
  `changed_on` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms_patient_history`
--

LOCK TABLES `rooms_patient_history` WRITE;
/*!40000 ALTER TABLE `rooms_patient_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `rooms_patient_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `treatment_info`
--

DROP TABLE IF EXISTS `treatment_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `treatment_info` (
  `patient_id` int NOT NULL,
  `icd10` varchar(45) NOT NULL,
  `medication` varchar(45) NOT NULL,
  PRIMARY KEY (`patient_id`),
  CONSTRAINT `fk_treatment_info_vital_sign1` FOREIGN KEY (`patient_id`) REFERENCES `vital_sign` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `treatment_info`
--

LOCK TABLES `treatment_info` WRITE;
/*!40000 ALTER TABLE `treatment_info` DISABLE KEYS */;
INSERT INTO `treatment_info` VALUES (1,'A00-B99','Abacavir'),(2,'C00-D49','Acyclovir'),(3,'A00-B99','Abacavir'),(4,'A00-B99','Abacavir');
/*!40000 ALTER TABLE `treatment_info` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `treatment_info_after_update` AFTER UPDATE ON `treatment_info` FOR EACH ROW BEGIN
    
    INSERT INTO treatment_info_history
	VALUES (old.patient_id, old.icd10,old.medication,"Andy",now(), 0);

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `treatment_info_after_delete` AFTER DELETE ON `treatment_info` FOR EACH ROW BEGIN
    
    INSERT INTO treatment_info_history
	VALUES (old.patient_id, old.icd10,old.medication,"Andy",now(), 1);

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `treatment_info_history`
--

DROP TABLE IF EXISTS `treatment_info_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `treatment_info_history` (
  `patient_id` int NOT NULL,
  `icd10` varchar(45) NOT NULL,
  `medication` varchar(45) NOT NULL,
  `changed_by` varchar(45) NOT NULL,
  `changed_on` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `treatment_info_history`
--

LOCK TABLES `treatment_info_history` WRITE;
/*!40000 ALTER TABLE `treatment_info_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `treatment_info_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visit`
--

DROP TABLE IF EXISTS `visit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visit` (
  `encounter_id` int NOT NULL,
  `patient_id` int NOT NULL,
  `date_time_of_visit` date NOT NULL,
  PRIMARY KEY (`encounter_id`,`patient_id`),
  KEY `fk_visit_patient1_idx` (`patient_id`),
  CONSTRAINT `fk_visit_patient1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visit`
--

LOCK TABLES `visit` WRITE;
/*!40000 ALTER TABLE `visit` DISABLE KEYS */;
INSERT INTO `visit` VALUES (1,1,'2021-03-20'),(2,1,'2021-03-22'),(3,1,'2021-03-25'),(4,2,'2021-03-20'),(5,2,'2021-03-22'),(6,3,'2021-03-25'),(7,4,'2021-03-20'),(8,4,'2021-03-22'),(9,5,'2021-03-25'),(10,5,'2021-03-20'),(11,1,'2021-03-24'),(12,2,'2021-03-25');
/*!40000 ALTER TABLE `visit` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `visit_after_update` AFTER UPDATE ON `visit` FOR EACH ROW BEGIN
    
    INSERT INTO visit_history
	VALUES (old.encounter_id, old.patient_id,old.date_time_of_visit,"Andy",now(), 0);

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `visit_after_delete` AFTER DELETE ON `visit` FOR EACH ROW BEGIN
    
    INSERT INTO visit_history
	VALUES (old.encounter_id, old.patient_id,old.date_time_of_visit,"Andy",now(), 1);

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `visit_history`
--

DROP TABLE IF EXISTS `visit_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visit_history` (
  `encounter_id` int NOT NULL,
  `patient_id` int NOT NULL,
  `date_time_of_visit` date NOT NULL,
  `changed_by` varchar(45) NOT NULL,
  `changed_on` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visit_history`
--

LOCK TABLES `visit_history` WRITE;
/*!40000 ALTER TABLE `visit_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `visit_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vital_sign`
--

DROP TABLE IF EXISTS `vital_sign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vital_sign` (
  `patient_id` int NOT NULL,
  `temperature` float NOT NULL,
  `blood_pressure` varchar(45) NOT NULL,
  `height` float NOT NULL,
  `weight` float NOT NULL,
  `heart_beats` int NOT NULL,
  `oxygen_level` int NOT NULL,
  PRIMARY KEY (`patient_id`),
  KEY `vital_sign_weight_ix` (`weight`),
  CONSTRAINT `fk_vital_sign_patient1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vital_sign`
--

LOCK TABLES `vital_sign` WRITE;
/*!40000 ALTER TABLE `vital_sign` DISABLE KEYS */;
INSERT INTO `vital_sign` VALUES (1,35,'less than 120',160,70,72,85),(2,36,'less than 120',180,90,75,85),(3,35,'less than 120',160,70,72,85),(4,36,'less than 120',180,90,75,85),(5,36,'less than 120',180,90,75,85),(6,35,'less than 120',160,70,72,85),(7,36,'less than 120',180,90,75,85),(8,36,'less than 120',180,90,75,85),(9,36,'less than 120',180,90,75,85),(10,35,'less than 120',160,70,72,85),(11,36,'less than 120',180,90,75,85);
/*!40000 ALTER TABLE `vital_sign` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `vital_sign_after_update` AFTER UPDATE ON `vital_sign` FOR EACH ROW BEGIN
    
    INSERT INTO vital_sign_history
	VALUES (old.patient_id, old.temperature,old.blood_pressure,
    old.height,old.weight,old.heart_beats,old.oxygen_level,"Andy",now(), 0);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `vital_sign_after_delete` AFTER DELETE ON `vital_sign` FOR EACH ROW BEGIN
    
    INSERT INTO vital_sign_history
	VALUES (old.patient_id, old.temperature,old.blood_pressure,
    old.height,old.weight,old.heart_beats,old.oxygen_level,"Andy",now(), 1);

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `vital_sign_history`
--

DROP TABLE IF EXISTS `vital_sign_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vital_sign_history` (
  `patient_id` int NOT NULL,
  `temperature` float NOT NULL,
  `blood_pressure` varchar(45) NOT NULL,
  `height` float NOT NULL,
  `weight` float NOT NULL,
  `heart_beats` int NOT NULL,
  `oxygen_level` int NOT NULL,
  `changed_by` varchar(45) NOT NULL,
  `changed_on` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vital_sign_history`
--

LOCK TABLES `vital_sign_history` WRITE;
/*!40000 ALTER TABLE `vital_sign_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `vital_sign_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'outpatient_clinic_updated'
--

--
-- Dumping routines for database 'outpatient_clinic_updated'
--
/*!50003 DROP PROCEDURE IF EXISTS `change_laboratory_type` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `change_laboratory_type`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `change_patient_address` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `change_patient_address`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `change_patient_disease_type` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `change_patient_disease_type`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `change_patient_insurrance` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `change_patient_insurrance`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `change_patient_phone_number` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `change_patient_phone_number`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `count_number_of_patient_in_each_group_responsible_party` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `count_number_of_patient_in_each_group_responsible_party`()
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_list_of_patient_based_on_visit_dates` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_list_of_patient_based_on_visit_dates`()
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_list_of_patient_from_certain_date` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_list_of_patient_from_certain_date`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_list_of_patient_with_diagnosis` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_list_of_patient_with_diagnosis`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_list_of_patient_with_number_visiting` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_list_of_patient_with_number_visiting`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_list_of_patient_with_number_visiting_param` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_list_of_patient_with_number_visiting_param`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_list_of_patient_with_total_payment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_list_of_patient_with_total_payment`()
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_list_of_patient_with_total_payment_from_certain_date` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_list_of_patient_with_total_payment_from_certain_date`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_list_of_provider_have_number_of_patient_at_least_3` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_list_of_provider_have_number_of_patient_at_least_3`()
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_list_of_provider_include_number_of_patient` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_list_of_provider_include_number_of_patient`()
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_list_of_three_patient_pay_much` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_list_of_three_patient_pay_much`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_other_charges_billing_detail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_other_charges_billing_detail`(
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
    SET other_charges_param = CONCAT('The other charges is not null ');
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `all_list_room`
--

/*!50001 DROP VIEW IF EXISTS `all_list_room`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `all_list_room` AS select `rooms`.`room_id` AS `room_id`,`rooms`.`type` AS `type`,`rooms`.`price_per_date` AS `price_per_date`,`rooms`.`availability` AS `availability` from `rooms` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `all_patient`
--

/*!50001 DROP VIEW IF EXISTS `all_patient`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `all_patient` AS select `patient`.`patient_id` AS `patient_id`,`patient`.`first_name` AS `first_name`,`patient`.`middle_name` AS `middle_name`,`patient`.`last_name` AS `last_name`,`patient`.`date_of_birth` AS `date_of_birth`,`patient`.`age` AS `age`,`patient`.`language` AS `language`,`patient`.`marital_status` AS `marital_status`,`patient`.`gender` AS `gender`,`patient`.`provider_id` AS `provider_id` from `patient` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `first_five_patient`
--

/*!50001 DROP VIEW IF EXISTS `first_five_patient`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `first_five_patient` AS select `patient`.`patient_id` AS `patient_id`,`patient`.`first_name` AS `first_name`,`patient`.`middle_name` AS `middle_name`,`patient`.`last_name` AS `last_name`,`patient`.`date_of_birth` AS `date_of_birth`,`patient`.`age` AS `age`,`patient`.`language` AS `language`,`patient`.`marital_status` AS `marital_status`,`patient`.`gender` AS `gender`,`patient`.`provider_id` AS `provider_id` from `patient` limit 5 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `patient_disease`
--

/*!50001 DROP VIEW IF EXISTS `patient_disease`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `patient_disease` AS select distinct concat(`p`.`first_name`,' ',`p`.`last_name`) AS `Patient Name`,`d`.`disease_type` AS `disease_type` from (`disease` `d` join `patient` `p`) where ((`d`.`patient_id` = `p`.`patient_id`) and (`d`.`disease_type` like '%infect%')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `patient_first_name_contain_u_character`
--

/*!50001 DROP VIEW IF EXISTS `patient_first_name_contain_u_character`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `patient_first_name_contain_u_character` AS select `patient`.`patient_id` AS `patient_id`,`patient`.`first_name` AS `first_name`,`patient`.`middle_name` AS `middle_name`,`patient`.`last_name` AS `last_name`,`patient`.`date_of_birth` AS `date_of_birth`,`patient`.`age` AS `age`,`patient`.`language` AS `language`,`patient`.`marital_status` AS `marital_status`,`patient`.`gender` AS `gender`,`patient`.`provider_id` AS `provider_id` from `patient` where (`patient`.`first_name` like '%u%') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `patient_middle_name_contain_u_character`
--

/*!50001 DROP VIEW IF EXISTS `patient_middle_name_contain_u_character`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `patient_middle_name_contain_u_character` AS select `patient`.`patient_id` AS `patient_id`,`patient`.`first_name` AS `first_name`,`patient`.`middle_name` AS `middle_name`,`patient`.`last_name` AS `last_name`,`patient`.`date_of_birth` AS `date_of_birth`,`patient`.`age` AS `age`,`patient`.`language` AS `language`,`patient`.`marital_status` AS `marital_status`,`patient`.`gender` AS `gender`,`patient`.`provider_id` AS `provider_id` from `patient` where (`patient`.`middle_name` like '%ut%') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `patient_visit_certain_days`
--

/*!50001 DROP VIEW IF EXISTS `patient_visit_certain_days`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `patient_visit_certain_days` AS select distinct concat(`p`.`first_name`,' ',`p`.`last_name`) AS `Patient Name`,`v`.`date_time_of_visit` AS `Visit Dates` from (`visit` `v` join `patient` `p`) where ((`v`.`patient_id` = `p`.`patient_id`) and (`v`.`date_time_of_visit` >= '2021-03-22') and (`v`.`date_time_of_visit` <= '2021-03-25')) order by `v`.`date_time_of_visit` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `patient_visit_date`
--

/*!50001 DROP VIEW IF EXISTS `patient_visit_date`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `patient_visit_date` AS select concat(`p`.`first_name`,' ',`p`.`last_name`) AS `Patient Name`,`v`.`date_time_of_visit` AS `Visit Dates` from (`visit` `v` join `patient` `p`) where (`v`.`patient_id` = `p`.`patient_id`) order by `v`.`date_time_of_visit` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `provider_male_practice`
--

/*!50001 DROP VIEW IF EXISTS `provider_male_practice`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `provider_male_practice` AS select `provider`.`provider_id` AS `provider_id`,`provider`.`first_name` AS `first_name`,`provider`.`middle_name` AS `middle_name`,`provider`.`last_name` AS `last_name`,`provider`.`date_of_birth` AS `date_of_birth`,`provider`.`age` AS `age`,`provider`.`specialist` AS `specialist`,`provider`.`gender` AS `gender`,`provider`.`language` AS `language`,`provider`.`date_of_hire` AS `date_of_hire`,`provider`.`grad_date` AS `grad_date`,`provider`.`year_of_practice` AS `year_of_practice`,`provider`.`school` AS `school`,`provider`.`federal_id` AS `federal_id` from `provider` where ((`provider`.`gender` = 'male') and (`provider`.`year_of_practice` >= 6)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `provider_patient_prescription`
--

/*!50001 DROP VIEW IF EXISTS `provider_patient_prescription`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `provider_patient_prescription` AS select distinct concat(`p`.`first_name`,' ',`p`.`last_name`) AS `Patient Name`,concat(`pro`.`first_name`,' ',`pro`.`last_name`) AS `Doctor Name`,`pre`.`date` AS `Date Diagnosis` from ((`provider` `pro` join `patient` `p`) join `prescription` `pre`) where ((`pro`.`provider_id` = `pre`.`provider_id`) and (`pre`.`patient_id` = `p`.`patient_id`) and (`pro`.`first_name` like '%jack%')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `provider_practice`
--

/*!50001 DROP VIEW IF EXISTS `provider_practice`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `provider_practice` AS select `provider`.`provider_id` AS `provider_id`,`provider`.`first_name` AS `first_name`,`provider`.`middle_name` AS `middle_name`,`provider`.`last_name` AS `last_name`,`provider`.`date_of_birth` AS `date_of_birth`,`provider`.`age` AS `age`,`provider`.`specialist` AS `specialist`,`provider`.`gender` AS `gender`,`provider`.`language` AS `language`,`provider`.`date_of_hire` AS `date_of_hire`,`provider`.`grad_date` AS `grad_date`,`provider`.`year_of_practice` AS `year_of_practice`,`provider`.`school` AS `school`,`provider`.`federal_id` AS `federal_id` from `provider` where (`provider`.`year_of_practice` >= 6) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `provider_school`
--

/*!50001 DROP VIEW IF EXISTS `provider_school`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `provider_school` AS select `provider`.`provider_id` AS `provider_id`,`provider`.`first_name` AS `first_name`,`provider`.`middle_name` AS `middle_name`,`provider`.`last_name` AS `last_name`,`provider`.`date_of_birth` AS `date_of_birth`,`provider`.`age` AS `age`,`provider`.`specialist` AS `specialist`,`provider`.`gender` AS `gender`,`provider`.`language` AS `language`,`provider`.`date_of_hire` AS `date_of_hire`,`provider`.`grad_date` AS `grad_date`,`provider`.`year_of_practice` AS `year_of_practice`,`provider`.`school` AS `school`,`provider`.`federal_id` AS `federal_id` from `provider` where (`provider`.`school` = 'Harvard') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-05-12 21:33:29
