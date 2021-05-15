-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: localhost    Database: patient_clinic_management
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
CREATE DATABASE IF NOT EXISTS `outpatient_clinic`;
USE `outpatient_clinic`;

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
  CONSTRAINT `fk_billing_detail_patient1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billing_detail`
--

LOCK TABLES `billing_detail` WRITE;
/*!40000 ALTER TABLE `billing_detail` DISABLE KEYS */;
INSERT INTO `billing_detail` VALUES (1,1,200,100,100,150,550,'2021-03-20'),(2,1,100,100,200,100,500,'2021-03-25'),(3,1,100,100,100,100,400,'2021-03-27'),(4,2,100,100,100,100,400,'2021-02-20'),(5,1,200,100,100,150,550,'2021-02-20'),(6,2,200,100,100,150,550,'2021-02-22'),(7,2,200,100,100,150,550,'2021-02-24'),(8,2,200,100,100,150,550,'2021-02-27'),(9,3,200,100,100,150,550,'2021-02-27'),(10,3,200,100,100,150,550,'2021-02-28'),(11,3,200,100,100,150,550,'2021-02-15'),(12,4,200,100,100,150,550,'2021-02-28'),(13,4,200,100,100,150,550,'2021-02-15'),(14,5,200,100,100,150,550,'2021-02-28'),(15,5,200,100,100,150,550,'2021-02-15');
/*!40000 ALTER TABLE `billing_detail` ENABLE KEYS */;
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
  CONSTRAINT `fk_contact_info_patient1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact_info`
--

LOCK TABLES `contact_info` WRITE;
/*!40000 ALTER TABLE `contact_info` DISABLE KEYS */;
INSERT INTO `contact_info` VALUES (1,'Pangle Dr, Charlotte','NC','28207','b@b.com','123-888-888'),(2,'Mataderos 231','NC','28217','c@c.com','123-777-999'),(3,'Av. dos Lusíadas, 23','NC','28218','d@c.com','123-777-666'),(4,'Berkeley Gardens 12','NC','28219','a@c.com','123-777-111'),(5,'Walserweg 21','NC','28216','e@c.com','123-777-222'),(6,'35 King George','NC','28206','andy@c.com','123-777-333'),(7,'Kirchgasse 6','NC','28218','bb@c.com','123-777-454'),(8,'Jardim das rosas n. 32','NC','28218','bcb@c.com','123-777-333'),(9,'8 Johnstown Road','NC','28217','cbc@c.com','123-777-234'),(10,'1900 Oak St.','NC','28217','cab@c.com','123-777-134'),(11,'Magazinweg 7','NC','28217','cda@c.com','123-233-888'),(12,'12 Orchestra Terrace','NC','28217','acc@c.com','123-111-888'),(13,'Ave. 5 de Mayo Porlamar','NC','28217','lau@c.com','123-332-888'),(14,'89 Chiaroscuro Rd.','NC','28217','han@c.com','123-138-888'),(15,'Via Ludovico il Moro 22','NC','28217','morning@c.com','123-341-888');
/*!40000 ALTER TABLE `contact_info` ENABLE KEYS */;
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
  CONSTRAINT `fk_disease_laboratory1` FOREIGN KEY (`patient_id`) REFERENCES `laboratory` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disease`
--

LOCK TABLES `disease` WRITE;
/*!40000 ALTER TABLE `disease` DISABLE KEYS */;
INSERT INTO `disease` VALUES (1,'A00-B99','Certain infectious and parasitic diseases','infectious diseases'),(2,'C00-D49','Neoplasms','circulatory'),(3,'A00-B99','Certain infectious and parasitic diseases','infectious diseases'),(4,'A00-B99','Certain infectious and parasitic diseases','infectious diseases'),(5,'C00-D49','Neoplasms','circulatory'),(6,'A00-B99','Certain infectious and parasitic diseases','infectious diseases'),(7,'A00-B99','Certain infectious and parasitic diseases','infectious diseases');
/*!40000 ALTER TABLE `disease` ENABLE KEYS */;
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
INSERT INTO `financial_info` VALUES (1,'insurrance_correct','party_1'),(2,'insurrance_1','party_1'),(3,'insurrance_2','party_2'),(4,'insurrance_1','party_1'),(5,'insurrance_1','party_1'),(6,'insurrance_1','party_1'),(7,'insurrance_2','party_2'),(8,'insurrance_1','party_1'),(9,'insurrance_1','party_1'),(10,'insurrance_1','party_1');
/*!40000 ALTER TABLE `financial_info` ENABLE KEYS */;
UNLOCK TABLES;

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
  CONSTRAINT `fk_laboratory_vital_sign1` FOREIGN KEY (`patient_id`) REFERENCES `vital_sign` (`patient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laboratory`
--

LOCK TABLES `laboratory` WRITE;
/*!40000 ALTER TABLE `laboratory` DISABLE KEYS */;
INSERT INTO `laboratory` VALUES (1,'type1','Positive','2021-03-22'),(2,'type2','Negative','2021-03-24'),(3,'type3','Positive','2021-03-22'),(4,'type4','Positive','2021-03-23'),(5,'type2','Negative','2021-03-24'),(6,'type3','Positive','2021-03-22'),(7,'type4','Positive','2021-03-23');
/*!40000 ALTER TABLE `laboratory` ENABLE KEYS */;
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
  PRIMARY KEY (`provider_id`)
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
  PRIMARY KEY (`room_id`)
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
  CONSTRAINT `fk_rooms_patient_patient1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  CONSTRAINT `fk_rooms_patient_rooms1` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms_patient`
--

LOCK TABLES `rooms_patient` WRITE;
/*!40000 ALTER TABLE `rooms_patient` DISABLE KEYS */;
INSERT INTO `rooms_patient` VALUES (1,1,'2021-03-20'),(1,2,'2021-03-21'),(1,3,'2021-03-20'),(1,4,'2021-02-21'),(1,5,'2021-02-20'),(1,7,'2021-03-21'),(1,8,'2021-03-20'),(1,9,'2021-03-21'),(2,1,'2021-03-15'),(2,2,'2021-03-16'),(2,3,'2021-04-21'),(2,4,'2021-04-21'),(3,1,'2021-03-21'),(3,2,'2021-03-22'),(3,6,'2021-03-20'),(4,1,'2021-03-23'),(4,2,'2021-03-22'),(4,3,'2021-03-24'),(5,1,'2021-03-20'),(5,2,'2021-03-21'),(5,3,'2021-03-20'),(5,4,'2021-03-21');
/*!40000 ALTER TABLE `rooms_patient` ENABLE KEYS */;
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-09 18:56:55
