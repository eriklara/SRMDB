-- MySQL dump 10.13  Distrib 8.0.25, for Win64 (x86_64)
--
-- Host: localhost    Database: srmdb
-- ------------------------------------------------------
-- Server version	8.0.25

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

--
-- Table structure for table `crm_customer`
--

DROP TABLE IF EXISTS `crm_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `crm_customer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_key` varchar(45) NOT NULL,
  `name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `sur_name` varchar(100) DEFAULT NULL,
  `customer_number` varchar(20) NOT NULL,
  `type` varchar(50) NOT NULL COMMENT '(P)rivilegio: Cliente que tiene privilegio con el negocio.\n(C)ontacto: Contacto de un futuro cliente.\n(E)standar: Cliente sin privilegios.',
  `status` varchar(3) NOT NULL COMMENT '(A)ctivo, (B)aja, (BL)oquedo.',
  `date_birth` datetime NOT NULL,
  `gender` varchar(3) NOT NULL COMMENT '(F)emenino, (M)asculino, (P)okemón etc.',
  `RFC` varchar(20) DEFAULT NULL,
  `business_name` varchar(100) DEFAULT NULL,
  `profession` varchar(250) DEFAULT NULL,
  `phone_number` varchar(20) NOT NULL,
  `mail` varchar(100) DEFAULT NULL,
  `description` longtext,
  `update_date` datetime DEFAULT NULL,
  `address_id` int NOT NULL,
  `user_code_id` int DEFAULT NULL,
  `card_id` int NOT NULL,
  `store_id` int NOT NULL,
  `create_uid` int NOT NULL,
  `create_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_key_UNIQUE` (`customer_key`),
  KEY `crm_customer_store_id_index` (`store_id`),
  KEY `crm_customer_user_code_id_index` (`user_code_id`),
  KEY `crm_customer_user_create_uid_index` (`create_uid`),
  KEY `crm_customer_card_id_index` (`card_id`),
  KEY `crm_customer_address_id_index` (`address_id`),
  CONSTRAINT `crm_customer_address_id_fkey` FOREIGN KEY (`address_id`) REFERENCES `res_address` (`id`),
  CONSTRAINT `crm_customer_card_id_fkey` FOREIGN KEY (`card_id`) REFERENCES `sale_card` (`id`),
  CONSTRAINT `crm_customer_store_id_fkey` FOREIGN KEY (`store_id`) REFERENCES `res_store` (`id`),
  CONSTRAINT `crm_customer_user_code_id_fkey` FOREIGN KEY (`user_code_id`) REFERENCES `res_user` (`id`),
  CONSTRAINT `crm_customer_user_creater_id_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crm_customer`
--

LOCK TABLES `crm_customer` WRITE;
/*!40000 ALTER TABLE `crm_customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `crm_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_attendance`
--

DROP TABLE IF EXISTS `hr_attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hr_attendance` (
  `id` int NOT NULL AUTO_INCREMENT,
  `employee_id` int NOT NULL,
  `check_in` datetime DEFAULT NULL,
  `check_out` datetime DEFAULT NULL,
  `worked_hours` double DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `create_uid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `hr_attendance_creat_uid_index` (`create_uid`),
  KEY `hr_attendance_employee_id_fkey` (`employee_id`),
  CONSTRAINT `hr_attendance_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `hr_attendance_employee_id_fkey` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_attendance`
--

LOCK TABLES `hr_attendance` WRITE;
/*!40000 ALTER TABLE `hr_attendance` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_department`
--

DROP TABLE IF EXISTS `hr_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hr_department` (
  `id` int NOT NULL AUTO_INCREMENT,
  `department_key` varchar(45) NOT NULL,
  `name` varchar(100) NOT NULL,
  `complete_name` varchar(250) NOT NULL,
  `status` varchar(3) NOT NULL COMMENT '(A)ctivo, (B)aja, (BL)oquedo.',
  `company_id` int NOT NULL,
  `manager_id` int NOT NULL,
  `color` int DEFAULT NULL COMMENT 'Revisar la tabla de colores.',
  `description` longtext,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime NOT NULL,
  `create_uid` int NOT NULL COMMENT 'Usuario que crea el departamento.',
  PRIMARY KEY (`id`),
  KEY `hr_department_company_id_index` (`company_id`),
  KEY `hr_department_create_uid_index` (`create_uid`),
  KEY `hr_department_employee_id_fkey` (`manager_id`),
  CONSTRAINT `hr_department_company_id_fkey` FOREIGN KEY (`company_id`) REFERENCES `res_company` (`id`),
  CONSTRAINT `hr_department_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `hr_department_employee_id_fkey` FOREIGN KEY (`manager_id`) REFERENCES `hr_employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_department`
--

LOCK TABLES `hr_department` WRITE;
/*!40000 ALTER TABLE `hr_department` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_departure_wizard`
--

DROP TABLE IF EXISTS `hr_departure_wizard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hr_departure_wizard` (
  `id` int NOT NULL AUTO_INCREMENT,
  `departure_reason` varchar(200) NOT NULL,
  `departure_description` longtext NOT NULL,
  `departure_date` date NOT NULL,
  `employee_id` int NOT NULL,
  `archive_private_address` tinyint(1) DEFAULT NULL,
  `cancel_leaves` tinyint(1) DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_uid` int DEFAULT NULL,
  `user_authorizes_id` int DEFAULT NULL COMMENT 'Usuario que autoriza la salida.',
  `check_in` datetime DEFAULT NULL,
  `check_out` datetime DEFAULT NULL,
  `worked_hours` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `hr_departure_wizard_create_uid_index` (`create_uid`),
  KEY `hr_departure_wizard_user_authorized_id_idx` (`user_authorizes_id`),
  KEY `hhr_departurewizard_employee_id_fkey` (`employee_id`),
  CONSTRAINT `hhr_departurewizard_employee_id_fkey` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `hr_departure_wizard_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `hr_departure_wizard_user_authorizes_id` FOREIGN KEY (`user_authorizes_id`) REFERENCES `res_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_departure_wizard`
--

LOCK TABLES `hr_departure_wizard` WRITE;
/*!40000 ALTER TABLE `hr_departure_wizard` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_departure_wizard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_documentation`
--

DROP TABLE IF EXISTS `hr_documentation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hr_documentation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `employee_id` int NOT NULL,
  `documentation_type` int NOT NULL,
  `front_picture` int NOT NULL,
  `rear_image` int NOT NULL,
  `country` varchar(100) DEFAULT NULL,
  `expiration_date` datetime DEFAULT NULL,
  `description` longtext,
  `update_date` datetime DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `create_uid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `hr_documentation_create_uid_key_idx` (`create_uid`),
  KEY `hr_documentation_front_image_key_idx` (`front_picture`),
  KEY `hr_documentation_rear_image_key_idx` (`rear_image`),
  KEY `hr_documentation_documentation_type_fkey_idx` (`documentation_type`),
  KEY `hr_documentation_employee_id_fkey` (`employee_id`),
  CONSTRAINT `hr_documentation_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `hr_documentation_documentation_type_fkey` FOREIGN KEY (`documentation_type`) REFERENCES `hr_documentation_type` (`id`),
  CONSTRAINT `hr_documentation_employee_id_fkey` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `hr_documentation_front_image_fkey` FOREIGN KEY (`front_picture`) REFERENCES `res_image` (`id`),
  CONSTRAINT `hr_documentation_rear_image_fkey` FOREIGN KEY (`rear_image`) REFERENCES `res_image` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_documentation`
--

LOCK TABLES `hr_documentation` WRITE;
/*!40000 ALTER TABLE `hr_documentation` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_documentation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_documentation_type`
--

DROP TABLE IF EXISTS `hr_documentation_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hr_documentation_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `description` longtext,
  `create_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_documentation_type`
--

LOCK TABLES `hr_documentation_type` WRITE;
/*!40000 ALTER TABLE `hr_documentation_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_documentation_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_employee`
--

DROP TABLE IF EXISTS `hr_employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hr_employee` (
  `id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `number_employee` varchar(45) DEFAULT NULL,
  `seller_number` varchar(50) NOT NULL,
  `user_id` int NOT NULL,
  `status` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `company_id` int NOT NULL,
  `address_id` int NOT NULL,
  `gender` varchar(3) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `marital` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `RFC` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `NSS` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `business_name` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `place_of_birth` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `country_of_birth` int NOT NULL,
  `birthday` date NOT NULL,
  `sinid` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL COMMENT 'Genera dudas está columna.',
  `permitNo` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `visa_no` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `additional_note` text CHARACTER SET latin1 COLLATE latin1_swedish_ci,
  `certificate` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `study_field` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `study_school` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `emergency_contact` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `emergency_phone` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `km_home_work` int DEFAULT NULL,
  `color` int DEFAULT NULL,
  `barcode` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `pin` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `job_title` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `work_phone` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `mobile_phone` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `work_email` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `work_location` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `last_check_in` datetime DEFAULT NULL,
  `last_check_out` datetime DEFAULT NULL,
  `description` longtext CHARACTER SET latin1 COLLATE latin1_swedish_ci,
  `bank_account_id` int DEFAULT NULL COMMENT 'Cuenta bancaria.',
  `job_id` int NOT NULL,
  `parent_id` int DEFAULT NULL,
  `coach_id` int DEFAULT NULL,
  `employee_relatives_id` int DEFAULT NULL,
  `resource_calendar_id` int DEFAULT NULL,
  `resource_id` int NOT NULL,
  `last_attendance_id` int DEFAULT NULL,
  `leave_manager_id` int DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  `create_uid` int DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `number_employee_UNIQUE` (`number_employee`),
  KEY `hr_employee_user_id_index` (`user_id`),
  KEY `hr_employee_company_id_index` (`company_id`),
  KEY `hr_employee_create_uid_index` (`create_uid`),
  KEY `hr_employee_leave_manager_id_index` (`leave_manager_id`) /*!80000 INVISIBLE */,
  KEY `hr_employee_country_of_birth_id_index` (`country_of_birth`),
  KEY `hr_employee_attendance_id_fkey_idx` (`last_attendance_id`),
  KEY `hr_employee_department_id_fkey_idx` (`department_id`),
  KEY `hr_employee_job_id_fkey._idx` (`job_id`),
  CONSTRAINT `hr_employee_attendance_id_fkey` FOREIGN KEY (`last_attendance_id`) REFERENCES `hr_attendance` (`id`),
  CONSTRAINT `hr_employee_company_id_fkey` FOREIGN KEY (`company_id`) REFERENCES `res_company` (`id`),
  CONSTRAINT `hr_employee_country_of_birth_fkey` FOREIGN KEY (`country_of_birth`) REFERENCES `res_address` (`id`),
  CONSTRAINT `hr_employee_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `hr_employee_department_id_fkey` FOREIGN KEY (`department_id`) REFERENCES `hr_department` (`id`),
  CONSTRAINT `hr_employee_job_id_fkey.` FOREIGN KEY (`job_id`) REFERENCES `hr_job` (`id`),
  CONSTRAINT `hr_employee_leave_manager_id_fkey` FOREIGN KEY (`leave_manager_id`) REFERENCES `res_user` (`id`),
  CONSTRAINT `hr_employee_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `res_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_employee`
--

LOCK TABLES `hr_employee` WRITE;
/*!40000 ALTER TABLE `hr_employee` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_employee_category`
--

DROP TABLE IF EXISTS `hr_employee_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hr_employee_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `color` int DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `create_uid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  KEY `hr_employee_category_create_uid_index` (`create_uid`),
  CONSTRAINT `hr_employee_category_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_employee_category`
--

LOCK TABLES `hr_employee_category` WRITE;
/*!40000 ALTER TABLE `hr_employee_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_employee_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_employee_relatives`
--

DROP TABLE IF EXISTS `hr_employee_relatives`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hr_employee_relatives` (
  `id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(250) NOT NULL,
  `type` varchar(100) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `employee_id` int NOT NULL,
  `update_Date` datetime NOT NULL,
  `create_Date` datetime NOT NULL,
  `create_uid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `hr_employeerelatives_create_uid_index` (`create_uid`),
  KEY `hr_employeerelatives_employee_id_fkey` (`employee_id`),
  CONSTRAINT `hr_employeerelatives_employee_id_fkey` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `hr_employeerelatives_user_id_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_employee_relatives`
--

LOCK TABLES `hr_employee_relatives` WRITE;
/*!40000 ALTER TABLE `hr_employee_relatives` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_employee_relatives` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_holidays_summary_employee`
--

DROP TABLE IF EXISTS `hr_holidays_summary_employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hr_holidays_summary_employee` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date_from` date NOT NULL,
  `holiday_type` varchar(100) DEFAULT NULL,
  `date_to` date DEFAULT NULL,
  `duration_display` varchar(45) DEFAULT NULL,
  `create_uid` int DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `user_authorizes_id` varchar(45) DEFAULT NULL,
  `description` longtext,
  PRIMARY KEY (`id`),
  KEY `hr_holidays_summary_employee_create_uid_index` (`create_uid`),
  CONSTRAINT `hr_holidays_summary_employee_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_holidays_summary_employee`
--

LOCK TABLES `hr_holidays_summary_employee` WRITE;
/*!40000 ALTER TABLE `hr_holidays_summary_employee` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_holidays_summary_employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_job`
--

DROP TABLE IF EXISTS `hr_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hr_job` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(250) DEFAULT NULL,
  `expected_employees` int DEFAULT NULL,
  `no_of_employee` int DEFAULT NULL,
  `no_of_recruitment` int DEFAULT NULL,
  `no_of_hired_employee` int DEFAULT NULL,
  `requirements` text,
  `department_id` int NOT NULL,
  `company_id` int DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `description` longtext,
  `create_uid` int DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Unique_name_company_id_department_id` (`name`,`company_id`,`department_id`),
  KEY `hr_job_company_id_index` (`company_id`),
  KEY `hr_job_create_uid_index` (`create_uid`),
  KEY `hr_job_department_id_index` (`department_id`),
  CONSTRAINT `hr_job_company_id_fkey` FOREIGN KEY (`company_id`) REFERENCES `res_company` (`id`),
  CONSTRAINT `hr_job_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `hr_job_department_id_fkey` FOREIGN KEY (`department_id`) REFERENCES `hr_department` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_job`
--

LOCK TABLES `hr_job` WRITE;
/*!40000 ALTER TABLE `hr_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_leave`
--

DROP TABLE IF EXISTS `hr_leave`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hr_leave` (
  `id` int NOT NULL AUTO_INCREMENT,
  `private_name` varchar(100) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `payslip_status` varchar(3) DEFAULT NULL,
  `report_note` longtext,
  `date_from` datetime DEFAULT NULL,
  `date_to` datetime DEFAULT NULL,
  `number_of_days` double DEFAULT NULL,
  `duration_display` varchar(100) DEFAULT NULL,
  `employee_id` int DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  `meeting_id` int DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  `holiday_type` varchar(100) DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `leave_type_id` int NOT NULL COMMENT 'Verificar si se crea estatus de holiday',
  `mode_company_id` int DEFAULT NULL,
  `second_approver_id` int DEFAULT NULL,
  `request_date_from` date DEFAULT NULL,
  `request_date_to` date DEFAULT NULL,
  `request_hour_from` char(1) DEFAULT NULL,
  `request_hour_to` varchar(100) DEFAULT NULL,
  `request_date_from_period` varchar(100) DEFAULT NULL,
  `request_unit_half` tinyint(1) DEFAULT NULL,
  `request_unit_hours` tinyint(1) DEFAULT NULL,
  `request_unit_custom` tinyint(1) DEFAULT NULL,
  `manager_id` int DEFAULT NULL,
  `first_approver_id` int DEFAULT NULL,
  `description` longtext,
  `user_id` int DEFAULT NULL,
  `create_uid` int DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `hr_leave_user_id_index` (`user_id`),
  KEY `hr_leave_category_id_index` (`category_id`),
  KEY `hr_leave_create_uid_index` (`create_uid`),
  KEY `hr_leave_mode_company_id_index` (`mode_company_id`),
  KEY `hr_leave_department_id_fkey_idx` (`department_id`),
  KEY `hr_leave_employee_id_fkey` (`employee_id`),
  KEY `hr_leave_first_approver_id_fkey` (`first_approver_id`),
  KEY `hr_leave_manager_id_fkey` (`manager_id`),
  KEY `hr_leave_second_approver_id_fkey` (`second_approver_id`),
  KEY `hr_leave_leave_type_idx` (`leave_type_id`),
  CONSTRAINT `hr_leave_category_id_fkey` FOREIGN KEY (`category_id`) REFERENCES `hr_employee_category` (`id`),
  CONSTRAINT `hr_leave_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `hr_leave_department_id_fkey` FOREIGN KEY (`department_id`) REFERENCES `hr_department` (`id`),
  CONSTRAINT `hr_leave_employee_id_fkey` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `hr_leave_first_approver_id_fkey` FOREIGN KEY (`first_approver_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `hr_leave_leave_type` FOREIGN KEY (`leave_type_id`) REFERENCES `hr_leave_type` (`id`),
  CONSTRAINT `hr_leave_manager_id_fkey` FOREIGN KEY (`manager_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `hr_leave_mode_company_id_fkey` FOREIGN KEY (`mode_company_id`) REFERENCES `res_company` (`id`),
  CONSTRAINT `hr_leave_second_approver_id_fkey` FOREIGN KEY (`second_approver_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `hr_leave_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `res_user` (`id`),
  CONSTRAINT `hr_leave_duration_check` CHECK ((`number_of_days` >= 0)),
  CONSTRAINT `hr_leave_type_value` CHECK ((((`holiday_type` = _utf8mb4'employee') and (`employee_id` is not null)) or ((`holiday_type` = _utf8mb4'company') and (`mode_company_id` is not null)) or ((`holiday_type` = _utf8mb4'category') and (`category_id` is not null)) or ((`holiday_type` = _utf8mb4'department') and (`department_id` is not null))))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_leave`
--

LOCK TABLES `hr_leave` WRITE;
/*!40000 ALTER TABLE `hr_leave` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_leave` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hr_leave_type`
--

DROP TABLE IF EXISTS `hr_leave_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hr_leave_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `code` varchar(45) NOT NULL,
  `sequence` int NOT NULL,
  `create_calendar_meeting` tinyint NOT NULL,
  `color_name` varchar(45) NOT NULL,
  `active` tinyint NOT NULL,
  `company_id` int NOT NULL,
  `responsible_id` int NOT NULL,
  `leave_validation_type` varchar(45) NOT NULL,
  `allocation_validation_type` varchar(45) NOT NULL,
  `allocation_type` varchar(45) NOT NULL,
  `validity_start` date NOT NULL,
  `validity_stop` date NOT NULL,
  `time_type` varchar(45) NOT NULL,
  `request_unit` varchar(45) NOT NULL,
  `unpaid` tinyint NOT NULL,
  `leave_notif_subtype_id` int NOT NULL,
  `allocation_notif_subtype_id` int NOT NULL,
  `create_uid` int NOT NULL,
  `create_date` datetime NOT NULL,
  `update_date` datetime NOT NULL,
  `description` longtext,
  PRIMARY KEY (`id`),
  KEY `hr_leave_type_company_id_index` (`company_id`),
  KEY `hr_leave_type_create_uid_index` (`create_uid`),
  KEY `hr_leave_type_responsible_id_index` (`responsible_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hr_leave_type`
--

LOCK TABLES `hr_leave_type` WRITE;
/*!40000 ALTER TABLE `hr_leave_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `hr_leave_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice_invoice`
--

DROP TABLE IF EXISTS `invoice_invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice_invoice` (
  `id` int NOT NULL AUTO_INCREMENT,
  `number` varchar(45) DEFAULT NULL,
  `total amount` decimal(10,0) DEFAULT NULL,
  `type_invoice` varchar(45) DEFAULT NULL,
  `invoice_date` datetime DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `status` varchar(3) DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `company_id` int DEFAULT NULL,
  `create_uid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoice_invoice_customer_id_idx` (`customer_id`),
  KEY `invoice_invoice_company_id_idx` (`company_id`),
  KEY `invoice_invoice_create_uid_idx` (`create_uid`),
  CONSTRAINT `invoice_invoice_company_id` FOREIGN KEY (`company_id`) REFERENCES `res_company` (`id`),
  CONSTRAINT `invoice_invoice_create_uid` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `invoice_invoice_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `crm_customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_invoice`
--

LOCK TABLES `invoice_invoice` WRITE;
/*!40000 ALTER TABLE `invoice_invoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice_invoice_details`
--

DROP TABLE IF EXISTS `invoice_invoice_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice_invoice_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `invoice_id` int DEFAULT NULL,
  `fiscal_folio` varchar(100) NOT NULL,
  `sat_certificate` varchar(200) NOT NULL,
  `certification_date` datetime NOT NULL,
  `issuing_certificate` varchar(200) NOT NULL,
  `date_ issue` datetime NOT NULL,
  `sale_id` int NOT NULL,
  `subtotal` decimal(10,0) NOT NULL,
  `total` decimal(10,0) NOT NULL,
  `IVA` decimal(10,0) NOT NULL,
  `ISH` decimal(10,0) NOT NULL,
  `SAT_digital_seal` varchar(2500) NOT NULL,
  `CFDI_digital_seal` varchar(45) NOT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `create_uid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoice_details_create_uid_idx` (`create_uid`),
  KEY `invoice_details_invoice_id_idx` (`invoice_id`),
  KEY `invoice_details_sale_id_fkey_idx` (`sale_id`),
  CONSTRAINT `invoice_details_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `invoice_details_invoice_id_fkey` FOREIGN KEY (`invoice_id`) REFERENCES `invoice_invoice` (`id`),
  CONSTRAINT `invoice_details_sale_id_fkey` FOREIGN KEY (`sale_id`) REFERENCES `sale_sale` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_invoice_details`
--

LOCK TABLES `invoice_invoice_details` WRITE;
/*!40000 ALTER TABLE `invoice_invoice_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_invoice_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice_invoice_product`
--

DROP TABLE IF EXISTS `invoice_invoice_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice_invoice_product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `invoice_id` int DEFAULT NULL,
  `total` decimal(10,0) DEFAULT NULL,
  `subtotal` decimal(10,0) DEFAULT NULL,
  `product_quantity` int DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `create_uid` int DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoice_product_product_id_idx` (`product_id`),
  KEY `invoice_product_create_uid_idx` (`create_uid`),
  KEY `invoice_product_invoice_id_fkey_idx` (`invoice_id`),
  CONSTRAINT `invoice_product_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `invoice_product_invoice_id_fkey` FOREIGN KEY (`invoice_id`) REFERENCES `invoice_invoice` (`id`),
  CONSTRAINT `invoice_product_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `sale_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_invoice_product`
--

LOCK TABLES `invoice_invoice_product` WRITE;
/*!40000 ALTER TABLE `invoice_invoice_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_invoice_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_account`
--

DROP TABLE IF EXISTS `purchase_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_account` (
  `id` int NOT NULL AUTO_INCREMENT,
  `key` varchar(45) NOT NULL,
  `name` varchar(100) NOT NULL,
  `number` varchar(45) NOT NULL,
  `description` longtext,
  `create_date` datetime NOT NULL,
  `company_id` int NOT NULL,
  `update_date` datetime NOT NULL,
  `create_uid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `purchase_account_company_id_index` (`company_id`),
  KEY `purchase_account_create_id_index` (`create_uid`),
  CONSTRAINT `purchase_account_company_id_fkey` FOREIGN KEY (`company_id`) REFERENCES `res_company` (`id`),
  CONSTRAINT `purchase_account_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_account`
--

LOCK TABLES `purchase_account` WRITE;
/*!40000 ALTER TABLE `purchase_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_order`
--

DROP TABLE IF EXISTS `purchase_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `store_id` int NOT NULL,
  `user_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `user_ip` varchar(50) DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `update_date` datetime NOT NULL,
  `create_uid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `purchase_order_store_id_index` (`store_id`),
  KEY `purchase_order_user_id_index` (`user_id`),
  KEY `purchase_order_customer_id_index` (`customer_id`),
  KEY `purchase_order_create_uid_index` (`create_uid`),
  CONSTRAINT `purchase_order_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `purchase_order_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `crm_customer` (`id`),
  CONSTRAINT `purchase_order_store_id_fkey` FOREIGN KEY (`store_id`) REFERENCES `res_store` (`id`),
  CONSTRAINT `purchase_order_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `res_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_order`
--

LOCK TABLES `purchase_order` WRITE;
/*!40000 ALTER TABLE `purchase_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_order_product`
--

DROP TABLE IF EXISTS `purchase_order_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_order_product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_quantity` int NOT NULL,
  `total_amount` double NOT NULL,
  `discount_amount` double NOT NULL,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `create_date` datetime NOT NULL,
  `update_date` int NOT NULL,
  `create_uid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `purchase_order_product_product_id_index` (`product_id`),
  KEY `purchase_order_product_create_uid_index` (`create_uid`),
  KEY `purchase_order_product_order_id_fkey_idx` (`order_id`),
  CONSTRAINT `purchase_order_product_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `purchase_order_product_order_id_fkey` FOREIGN KEY (`order_id`) REFERENCES `purchase_order` (`id`),
  CONSTRAINT `purchase_order_product_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `sale_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_order_product`
--

LOCK TABLES `purchase_order_product` WRITE;
/*!40000 ALTER TABLE `purchase_order_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_order_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_provider`
--

DROP TABLE IF EXISTS `purchase_provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_provider` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `sur_name` varchar(100) NOT NULL,
  `status` varchar(3) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `type` varchar(50) NOT NULL,
  `type_register` varchar(3) NOT NULL COMMENT '(F)isico, (M)oral.',
  `RFC` varchar(50) NOT NULL,
  `address_id` int NOT NULL,
  `category` varchar(50) NOT NULL,
  `description` varchar(500) NOT NULL,
  `create_date` date NOT NULL,
  `update_date` date NOT NULL,
  `business_name` varchar(250) NOT NULL,
  `create_uid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `purchase_provider_address_id_index` (`address_id`),
  KEY `purchase_provider_create_uid_index` (`create_uid`),
  CONSTRAINT `purchase_provider_address_id_fkey` FOREIGN KEY (`address_id`) REFERENCES `res_address` (`id`),
  CONSTRAINT `purchase_provider_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_provider`
--

LOCK TABLES `purchase_provider` WRITE;
/*!40000 ALTER TABLE `purchase_provider` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_provider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_purchase`
--

DROP TABLE IF EXISTS `purchase_purchase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_purchase` (
  `id` int NOT NULL AUTO_INCREMENT,
  `key` varchar(45) NOT NULL COMMENT 'Clave de compras y gastos',
  `type_id` int NOT NULL,
  `status` varchar(3) NOT NULL,
  `deadline` datetime NOT NULL,
  `reception_date` datetime DEFAULT NULL,
  `company_id` int NOT NULL,
  `total` double NOT NULL,
  `image_id` int NOT NULL,
  `account_id` int NOT NULL,
  `update_date` datetime NOT NULL,
  `create_uid` int NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Key_UNIQUE` (`key`),
  KEY `purchase_purchase_company_id_index` (`company_id`),
  KEY `purchase_purchase_type_id_index` (`type_id`),
  KEY `purchase_purchase_create_uid_index` (`create_uid`),
  KEY `purcharse_purchase_image_id_fkey_idx` (`image_id`),
  KEY `purchase_purchase_account_id_fkey_idx` (`account_id`),
  CONSTRAINT `purcharse_purchase_image_id_fkey` FOREIGN KEY (`image_id`) REFERENCES `res_image` (`id`),
  CONSTRAINT `purchase_purchase_account_id_fkey` FOREIGN KEY (`account_id`) REFERENCES `purchase_account` (`id`),
  CONSTRAINT `purchase_purchase_company_id_fkey` FOREIGN KEY (`company_id`) REFERENCES `res_company` (`id`),
  CONSTRAINT `purchase_purchase_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `purchase_purchase_type_id_fkey` FOREIGN KEY (`type_id`) REFERENCES `purchase_type_purchase` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_purchase`
--

LOCK TABLES `purchase_purchase` WRITE;
/*!40000 ALTER TABLE `purchase_purchase` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_purchase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_purchase_order`
--

DROP TABLE IF EXISTS `purchase_purchase_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_purchase_order` (
  `order_id` int NOT NULL,
  `purchase_id` int NOT NULL,
  KEY `purchase_purchase_order_purchase_id_index` (`purchase_id`),
  KEY `purchase_order_order_id_fkey_idx` (`order_id`),
  CONSTRAINT `purchase_order_order_id_fkey` FOREIGN KEY (`order_id`) REFERENCES `purchase_order` (`id`),
  CONSTRAINT `purchase_order_purchase_id_fkey` FOREIGN KEY (`purchase_id`) REFERENCES `purchase_purchase` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_purchase_order`
--

LOCK TABLES `purchase_purchase_order` WRITE;
/*!40000 ALTER TABLE `purchase_purchase_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_purchase_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_type_purchase`
--

DROP TABLE IF EXISTS `purchase_type_purchase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_type_purchase` (
  `id` int NOT NULL AUTO_INCREMENT,
  `key` varchar(45) NOT NULL,
  `description` longtext,
  `create_date` datetime NOT NULL,
  `update_date` datetime NOT NULL,
  `create_uid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `purchase_type_purchase_create_uid_index` (`create_uid`),
  CONSTRAINT `purchase_type_purchase_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_type_purchase`
--

LOCK TABLES `purchase_type_purchase` WRITE;
/*!40000 ALTER TABLE `purchase_type_purchase` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchase_type_purchase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `res_address`
--

DROP TABLE IF EXISTS `res_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `res_address` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `latitude` varchar(20) DEFAULT NULL,
  `longitude` varchar(20) DEFAULT NULL,
  `phone_number` varchar(10) DEFAULT NULL,
  `region` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `description` longtext,
  `update_date` datetime DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_uid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `res_address_create_uid_index` (`create_uid`),
  CONSTRAINT `res_address_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `res_address`
--

LOCK TABLES `res_address` WRITE;
/*!40000 ALTER TABLE `res_address` DISABLE KEYS */;
INSERT INTO `res_address` VALUES (1,'Oficinas OokinSoft','77506','010101,1000','010101,1000','9983226937','Benito Juarez','Cancún','SM 253, MZ 12 LT 21','2021-08-13 00:00:00','2021-08-13 00:00:00',1);
/*!40000 ALTER TABLE `res_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `res_company`
--

DROP TABLE IF EXISTS `res_company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `res_company` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(3) DEFAULT NULL,
  `name` varchar(200) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `mail` varchar(100) NOT NULL,
  `type_registre` varchar(3) DEFAULT NULL,
  `business_name` varchar(100) NOT NULL,
  `address_id` int NOT NULL,
  `company_registry` varchar(200) DEFAULT NULL,
  `description` longtext,
  `update_date` datetime DEFAULT NULL,
  `create_uid` int NOT NULL,
  `create_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `res_company_create_uid_index` (`create_uid`),
  KEY `res_company_address_id_index` (`address_id`),
  CONSTRAINT `res_company_address_id_fkey` FOREIGN KEY (`address_id`) REFERENCES `res_address` (`id`),
  CONSTRAINT `res_company_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `res_company`
--

LOCK TABLES `res_company` WRITE;
/*!40000 ALTER TABLE `res_company` DISABLE KEYS */;
INSERT INTO `res_company` VALUES (1,'AC','OokinSoft','9983226937','OokinSoft@gmail.com','EMP','OokinSoft CV A SV.',1,'OokinSoft CV A SV.','ES una empresa de prueba','2021-08-13 00:00:00',1,'2021-08-13');
/*!40000 ALTER TABLE `res_company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `res_currency`
--

DROP TABLE IF EXISTS `res_currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `res_currency` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `symbol` varchar(10) NOT NULL,
  `rounding` int DEFAULT NULL,
  `decimal_places` int DEFAULT NULL,
  `status` varchar(3) NOT NULL,
  `position` varchar(100) DEFAULT NULL,
  `currency_unit_label` varchar(100) DEFAULT NULL,
  `currency_subunit_label` varchar(100) DEFAULT NULL,
  `description` longtext,
  `create_uid` int NOT NULL,
  `create_date` datetime NOT NULL,
  `update_date` datetime NOT NULL,
  `country` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  KEY `res_currency_create_uid_index` (`create_uid`),
  CONSTRAINT `res_currency_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `res_currency`
--

LOCK TABLES `res_currency` WRITE;
/*!40000 ALTER TABLE `res_currency` DISABLE KEYS */;
/*!40000 ALTER TABLE `res_currency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `res_error_log`
--

DROP TABLE IF EXISTS `res_error_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `res_error_log` (
  `id` int NOT NULL,
  `key` varchar(45) DEFAULT NULL,
  `json` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `res_error_log`
--

LOCK TABLES `res_error_log` WRITE;
/*!40000 ALTER TABLE `res_error_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `res_error_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `res_image`
--

DROP TABLE IF EXISTS `res_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `res_image` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `url` varchar(200) NOT NULL,
  `image_type` varchar(50) NOT NULL,
  `description` longtext,
  `create_date` datetime NOT NULL,
  `update_date` datetime NOT NULL,
  `create_uid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `res_image_create_uid_index` (`create_uid`),
  CONSTRAINT `res_image_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `res_image`
--

LOCK TABLES `res_image` WRITE;
/*!40000 ALTER TABLE `res_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `res_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `res_information_log`
--

DROP TABLE IF EXISTS `res_information_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `res_information_log` (
  `id` int NOT NULL,
  `key` varchar(45) DEFAULT NULL,
  `json` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `res_information_log`
--

LOCK TABLES `res_information_log` WRITE;
/*!40000 ALTER TABLE `res_information_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `res_information_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `res_session`
--

DROP TABLE IF EXISTS `res_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `res_session` (
  `id` int NOT NULL AUTO_INCREMENT,
  `key_session` varchar(20) DEFAULT NULL,
  `create_uid` int DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `company_id` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_session_UNIQUE` (`key_session`),
  KEY `res_session_company_id_fkey_idx` (`company_id`),
  KEY `res_session_create_uid_fkey_idx` (`create_uid`),
  CONSTRAINT `res_session_company_id_fkey` FOREIGN KEY (`company_id`) REFERENCES `res_company` (`id`),
  CONSTRAINT `res_session_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `res_session`
--

LOCK TABLES `res_session` WRITE;
/*!40000 ALTER TABLE `res_session` DISABLE KEYS */;
INSERT INTO `res_session` VALUES (1,NULL,3,'2021-08-17 17:15:36',1,NULL),(2,'SES3170821171735',3,'2021-08-17 17:17:35',1,NULL),(3,'SES3170821172716',3,'2021-08-17 17:27:16',1,NULL),(4,'SES3170821174514',3,'2021-08-17 17:45:14',1,NULL),(5,'SES3170821230113',3,'2021-08-17 23:01:13',1,NULL),(6,NULL,NULL,'2021-08-18 13:06:15',NULL,NULL),(7,NULL,NULL,'2021-08-18 13:11:42',NULL,NULL),(8,'SES3180821131225',3,'2021-08-18 13:12:25',1,NULL),(9,NULL,NULL,'2021-08-18 16:18:08',NULL,NULL),(10,NULL,NULL,'2021-08-18 16:44:52',NULL,NULL),(11,'SES3180821164520',3,'2021-08-18 16:45:20',1,NULL),(12,'SES3180821164623',3,'2021-08-18 16:46:23',1,NULL),(13,'SES3180821164805',3,'2021-08-18 16:48:05',1,NULL),(14,'SES3180821165600',3,'2021-08-18 16:56:00',1,NULL),(15,'SES3180821165803',3,'2021-08-18 16:58:03',1,NULL),(16,'SES3180821165914',3,'2021-08-18 16:59:14',1,NULL),(17,'SES3180821170923',3,'2021-08-18 17:09:23',1,NULL),(18,'SES3180821171224',3,'2021-08-18 17:12:24',1,NULL),(19,'SES3180821171541',3,'2021-08-18 17:15:41',1,NULL),(20,'SES3180821171551',3,'2021-08-18 17:15:51',1,NULL),(21,'SES3180821171600',3,'2021-08-18 17:16:00',1,NULL),(22,'SES3180821171605',3,'2021-08-18 17:16:05',1,NULL),(23,'SES3180821171612',3,'2021-08-18 17:16:12',1,NULL),(24,'SES3180821171903',3,'2021-08-18 17:19:03',NULL,NULL),(25,'SES1200821230521',1,'2021-08-20 23:05:21',1,NULL),(26,'SES1200821230619',1,'2021-08-20 23:06:19',1,NULL),(27,'SES3200821232423',3,'2021-08-20 23:24:23',NULL,NULL),(28,'SES3200821232445',3,'2021-08-20 23:24:45',NULL,NULL);
/*!40000 ALTER TABLE `res_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `res_store`
--

DROP TABLE IF EXISTS `res_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `res_store` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `status` varchar(3) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `mail` varchar(100) NOT NULL,
  `opening_time` time NOT NULL,
  `closing_time` time NOT NULL,
  `coordinates` varchar(100) NOT NULL,
  `description` longtext,
  `address_id` int NOT NULL,
  `create_date` datetime NOT NULL,
  `update_date` datetime DEFAULT NULL,
  `create_uid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `res_store_address_id_index` (`address_id`),
  KEY `res_store_create_uid_index` (`create_uid`),
  CONSTRAINT `res_store_address_id_fkey` FOREIGN KEY (`address_id`) REFERENCES `res_address` (`id`),
  CONSTRAINT `res_store_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `res_store`
--

LOCK TABLES `res_store` WRITE;
/*!40000 ALTER TABLE `res_store` DISABLE KEYS */;
INSERT INTO `res_store` VALUES (1,'OokinSoft Oficina 1','AC','9983226937','OokingSoft@gmail.com','12:15:55','12:15:55','10101010101101011, 10101010101','Tienda de pruebas.',1,'2021-08-13 00:00:00','2021-08-13 00:00:00',1);
/*!40000 ALTER TABLE `res_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `res_success_log`
--

DROP TABLE IF EXISTS `res_success_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `res_success_log` (
  `id` int NOT NULL,
  `key` varchar(45) NOT NULL,
  `json` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `res_success_log`
--

LOCK TABLES `res_success_log` WRITE;
/*!40000 ALTER TABLE `res_success_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `res_success_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `res_user`
--

DROP TABLE IF EXISTS `res_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `res_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `profile` varchar(2) NOT NULL DEFAULT 'ES' COMMENT '(AD)MIN usuario perfil administrador.\n(ES)TANDAR usuario perfil estandar.',
  `last_name` varchar(100) NOT NULL,
  `sur_name` varchar(100) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `position` varchar(50) NOT NULL,
  `status` varchar(10) NOT NULL,
  `update_date` datetime NOT NULL,
  `create_date` datetime NOT NULL,
  `store_id` int DEFAULT NULL,
  `address_id` int DEFAULT NULL,
  `create_uid` int DEFAULT NULL,
  `company_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `res_user_store_id_index` (`store_id`),
  KEY `res_user_address_id_index` (`address_id`),
  KEY `res_user_create_uid_index` (`create_uid`) /*!80000 INVISIBLE */,
  KEY `res_user_company_id_fkey_idx` (`company_id`),
  CONSTRAINT `res_user_company_id_fkey` FOREIGN KEY (`company_id`) REFERENCES `res_company` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `res_user`
--

LOCK TABLES `res_user` WRITE;
/*!40000 ALTER TABLE `res_user` DISABLE KEYS */;
INSERT INTO `res_user` VALUES (1,'Test5','AD','Test5','Test4','Test4','SRM','Test4','BJ','2021-08-16 00:00:00','2021-07-12 00:00:00',NULL,NULL,NULL,NULL),(3,'Test7','AD','Test7','Test7','Test7','Test7','Test7','AC','2021-08-13 00:00:00','2021-08-13 00:00:00',1,1,1,1),(4,'Test8','AD','Test8','Test8','Test8','Test8','Test8','AC','2021-08-16 00:00:00','2021-08-16 00:00:00',1,1,1,1);
/*!40000 ALTER TABLE `res_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_card`
--

DROP TABLE IF EXISTS `sale_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sale_card` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `number` varchar(20) NOT NULL,
  `expiration_year` varchar(100) NOT NULL,
  `expiration_month` varchar(100) NOT NULL,
  `CVC` varchar(100) NOT NULL,
  `update_date` datetime DEFAULT NULL,
  `creates_date` datetime NOT NULL,
  `create_uid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sale_card_create_uid_index` (`create_uid`),
  CONSTRAINT `sale_card_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_card`
--

LOCK TABLES `sale_card` WRITE;
/*!40000 ALTER TABLE `sale_card` DISABLE KEYS */;
INSERT INTO `sale_card` VALUES (1,'Arely Salazar','4545 4545 4545 4545','25','07','102','2021-07-12 00:00:00','2021-07-12 00:00:00',1);
/*!40000 ALTER TABLE `sale_card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_category`
--

DROP TABLE IF EXISTS `sale_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sale_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(3) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `complete_name` varchar(100) DEFAULT NULL,
  `parent_path` varchar(50) DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `company_id` int DEFAULT NULL,
  `description` longtext,
  `update_date` datetime DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_uid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sale_category_category_id_idx` (`category_id`),
  KEY `sale_category_company_id_fkey_idx` (`company_id`),
  KEY `sale_category_create_uid_fkey_idx` (`create_uid`),
  CONSTRAINT `sale_category_category_id_fkey` FOREIGN KEY (`category_id`) REFERENCES `sale_category` (`id`),
  CONSTRAINT `sale_category_company_id_fkey` FOREIGN KEY (`company_id`) REFERENCES `res_company` (`id`),
  CONSTRAINT `sale_category_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_category`
--

LOCK TABLES `sale_category` WRITE;
/*!40000 ALTER TABLE `sale_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `sale_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_packaging`
--

DROP TABLE IF EXISTS `sale_packaging`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sale_packaging` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(3) NOT NULL,
  `name` varchar(100) NOT NULL,
  `sequence` int NOT NULL,
  `qty` double NOT NULL,
  `barcode` varchar(50) NOT NULL,
  `product_id` int DEFAULT NULL,
  `company_id` int DEFAULT NULL,
  `description` longtext,
  `create_uid` int DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sale_packaging_product_id_idx` (`product_id`),
  KEY `sale_packaging_company_id_fkey_idx` (`company_id`),
  KEY `sale_packaging_create_uid_fkey_idx` (`create_uid`),
  CONSTRAINT `sale_packaging_company_id_fkey` FOREIGN KEY (`company_id`) REFERENCES `res_company` (`id`),
  CONSTRAINT `sale_packaging_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `sale_packaging_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `sale_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_packaging`
--

LOCK TABLES `sale_packaging` WRITE;
/*!40000 ALTER TABLE `sale_packaging` DISABLE KEYS */;
/*!40000 ALTER TABLE `sale_packaging` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_payment`
--

DROP TABLE IF EXISTS `sale_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sale_payment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `payment_key` varchar(100) NOT NULL,
  `payment_amount` double NOT NULL,
  `payment_type` varchar(100) NOT NULL,
  `status` varchar(3) NOT NULL,
  `description` longtext NOT NULL,
  `currency_id` varchar(11) NOT NULL,
  `sale_id` int NOT NULL,
  `store_Id` int NOT NULL,
  `transaction_id` int NOT NULL,
  `update_date` date NOT NULL,
  `create_date` date NOT NULL,
  `create_uid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `PaymentKey` (`payment_key`),
  KEY `sale_payment_store_id_index` (`store_Id`),
  KEY `sale_payment_create_uid_index` (`create_uid`),
  KEY `sale_payment_transaction_id_fkey_idx` (`transaction_id`),
  CONSTRAINT `sale_payment_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `sale_payment_store_id_fkey` FOREIGN KEY (`store_Id`) REFERENCES `res_store` (`id`),
  CONSTRAINT `sale_payment_transaction_id_fkey` FOREIGN KEY (`transaction_id`) REFERENCES `sale_transaction` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_payment`
--

LOCK TABLES `sale_payment` WRITE;
/*!40000 ALTER TABLE `sale_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `sale_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_payment_sale`
--

DROP TABLE IF EXISTS `sale_payment_sale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sale_payment_sale` (
  `sale_id` int NOT NULL,
  `payment_id` int NOT NULL,
  `total_amount` double NOT NULL,
  `refund_amount` double NOT NULL,
  `return_currency` varchar(11) NOT NULL,
  `store_id` int NOT NULL,
  `update_date` datetime DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `create_uid` int NOT NULL,
  KEY `sale_payment_sale_store_id_index` (`store_id`),
  KEY `sale_payment_sale_payment_id_index` (`payment_id`),
  KEY `sale_payment_sale_create_uid_index` (`create_uid`),
  KEY `sale_payment_sale_sale_id_fkey_idx` (`sale_id`),
  CONSTRAINT `sale_payment_sale_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `sale_payment_sale_payment_id_fkey` FOREIGN KEY (`payment_id`) REFERENCES `sale_payment` (`id`),
  CONSTRAINT `sale_payment_sale_sale_id_fkey` FOREIGN KEY (`sale_id`) REFERENCES `sale_sale` (`id`),
  CONSTRAINT `sale_payment_sale_store_id_fkey` FOREIGN KEY (`store_id`) REFERENCES `res_store` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_payment_sale`
--

LOCK TABLES `sale_payment_sale` WRITE;
/*!40000 ALTER TABLE `sale_payment_sale` DISABLE KEYS */;
/*!40000 ALTER TABLE `sale_payment_sale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_payment_type`
--

DROP TABLE IF EXISTS `sale_payment_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sale_payment_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `description` longtext NOT NULL,
  `update_date` datetime DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `create_uid` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `PaymentType` (`type`),
  KEY `sale_payment_type_create_uid_fkey_index` (`create_uid`),
  CONSTRAINT `sale_payment_type_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_payment_type`
--

LOCK TABLES `sale_payment_type` WRITE;
/*!40000 ALTER TABLE `sale_payment_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `sale_payment_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_product`
--

DROP TABLE IF EXISTS `sale_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sale_product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `key` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `price` int NOT NULL,
  `model` varchar(100) DEFAULT NULL,
  `stock` int NOT NULL,
  `type` varchar(10) NOT NULL,
  `status` varchar(10) NOT NULL,
  `QR_code` longtext,
  `discount_percent` int DEFAULT NULL,
  `expiry_date` datetime DEFAULT NULL,
  `store_id` int NOT NULL,
  `provider_id` int NOT NULL,
  `image_id` int NOT NULL,
  `update_date` datetime DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `create_uid` int NOT NULL,
  `description` longtext,
  PRIMARY KEY (`id`),
  KEY `sale_product_store_id_index` (`store_id`),
  KEY `sale_product_create_uid_index` (`create_uid`),
  KEY `sale_product_image_id_index` (`image_id`),
  KEY `sale_product_provider_id_index` (`provider_id`),
  CONSTRAINT `sale_product_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `sale_product_image_id_fkey` FOREIGN KEY (`image_id`) REFERENCES `res_image` (`create_uid`),
  CONSTRAINT `sale_product_provider_id_fkey` FOREIGN KEY (`provider_id`) REFERENCES `purchase_provider` (`id`),
  CONSTRAINT `sale_product_store_id_fkey` FOREIGN KEY (`store_id`) REFERENCES `res_store` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_product`
--

LOCK TABLES `sale_product` WRITE;
/*!40000 ALTER TABLE `sale_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `sale_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_product_price_list`
--

DROP TABLE IF EXISTS `sale_product_price_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sale_product_price_list` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `price` double NOT NULL,
  `currency_id` varchar(11) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `description` longtext NOT NULL,
  `update_date` datetime DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `create_uid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sale_product_price_list_product_id_index` (`product_id`),
  KEY `sale_product_price_list_create_uid_index` (`create_uid`),
  CONSTRAINT `sale_product_price_list_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `sale_product_price_list_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `sale_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_product_price_list`
--

LOCK TABLES `sale_product_price_list` WRITE;
/*!40000 ALTER TABLE `sale_product_price_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `sale_product_price_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_product_sale`
--

DROP TABLE IF EXISTS `sale_product_sale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sale_product_sale` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `sale_id` int NOT NULL,
  `product_uantity` int NOT NULL,
  `total_amount` double NOT NULL,
  `discount_total` double NOT NULL,
  `update_date` datetime DEFAULT NULL,
  `create _date` datetime NOT NULL,
  `create_uid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sale_sale_product:_id_index` (`product_id`),
  KEY `sale_sale_create_uid_index` (`create_uid`),
  KEY `sale_sale_sale_id_fkey_idx` (`sale_id`),
  CONSTRAINT `sale_sale_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `sale_sale_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `sale_product` (`id`),
  CONSTRAINT `sale_sale_sale_id_fkey` FOREIGN KEY (`sale_id`) REFERENCES `sale_sale` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_product_sale`
--

LOCK TABLES `sale_product_sale` WRITE;
/*!40000 ALTER TABLE `sale_product_sale` DISABLE KEYS */;
/*!40000 ALTER TABLE `sale_product_sale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_sale`
--

DROP TABLE IF EXISTS `sale_sale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sale_sale` (
  `id` int NOT NULL AUTO_INCREMENT,
  `key` varchar(20) NOT NULL,
  `type` varchar(50) NOT NULL,
  `total` double NOT NULL,
  `currency_id` varchar(11) NOT NULL,
  `status` varchar(3) DEFAULT NULL,
  `invoice_number` varchar(11) DEFAULT NULL,
  `discount_amount` double DEFAULT NULL,
  `description` longtext,
  `update_date` datetime NOT NULL,
  `create_date` datetime NOT NULL,
  `customer_id` int NOT NULL,
  `store_Id` int NOT NULL,
  `create_uid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `SaleKey` (`key`),
  KEY `sale_sale_store_id_index` (`store_Id`),
  KEY `sale_sale_customer_id_index` (`customer_id`),
  KEY `sale_sale_create_uid_index` (`create_uid`),
  CONSTRAINT `sale_sale_customer_id_fkey` FOREIGN KEY (`customer_id`) REFERENCES `crm_customer` (`id`),
  CONSTRAINT `sale_sale_store_id_fkey` FOREIGN KEY (`store_Id`) REFERENCES `res_store` (`id`),
  CONSTRAINT `sale_sale_user_id_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_sale`
--

LOCK TABLES `sale_sale` WRITE;
/*!40000 ALTER TABLE `sale_sale` DISABLE KEYS */;
/*!40000 ALTER TABLE `sale_sale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_transaction`
--

DROP TABLE IF EXISTS `sale_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sale_transaction` (
  `id` int NOT NULL AUTO_INCREMENT,
  `key` varchar(50) NOT NULL,
  `status` varchar(3) NOT NULL,
  `transaction_type` varchar(50) NOT NULL,
  `total_quantity` double NOT NULL,
  `total_discount` double NOT NULL,
  `reference_output` varchar(100) NOT NULL,
  `reference_Input` varchar(100) NOT NULL,
  `payment_type_id` int NOT NULL,
  `payment_id` int NOT NULL,
  `card_id` int NOT NULL,
  `currency_id` varchar(11) NOT NULL,
  `store_id` int NOT NULL,
  `transaction_id` int NOT NULL,
  `description` longtext,
  `update_date` date NOT NULL,
  `create_date` date NOT NULL,
  `create_uid` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `TransactionKey` (`key`),
  KEY `sale_transaction_payment_type_id_index` (`payment_type_id`),
  KEY `sale_transaction_store_id_index` (`store_id`),
  KEY `sale_transaction_transaction_id_index` (`transaction_id`),
  KEY `sale_transaction_create_uid_index` (`create_uid`),
  KEY `sale_transaction_card_id_index` (`card_id`),
  CONSTRAINT `sale_transaction_card_id_fkey` FOREIGN KEY (`card_id`) REFERENCES `sale_card` (`id`),
  CONSTRAINT `sale_transaction_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `sale_transaction_payment_type_id_fkey` FOREIGN KEY (`payment_type_id`) REFERENCES `sale_payment_type` (`id`),
  CONSTRAINT `sale_transaction_store_id_fkey` FOREIGN KEY (`store_id`) REFERENCES `res_store` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_transaction`
--

LOCK TABLES `sale_transaction` WRITE;
/*!40000 ALTER TABLE `sale_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `sale_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_transaction_sale`
--

DROP TABLE IF EXISTS `sale_transaction_sale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sale_transaction_sale` (
  `sale_id` int NOT NULL,
  `transaction_id` int NOT NULL,
  KEY `sale_transaction_sale_transaction_id_fkey_idx` (`transaction_id`),
  KEY `sale_transaction_sale_sale_id_fkey_idx` (`sale_id`),
  CONSTRAINT `sale_transaction_sale_sale_id_fkey` FOREIGN KEY (`sale_id`) REFERENCES `sale_sale` (`id`),
  CONSTRAINT `sale_transaction_sale_transaction_id_fkey` FOREIGN KEY (`transaction_id`) REFERENCES `sale_transaction` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_transaction_sale`
--

LOCK TABLES `sale_transaction_sale` WRITE;
/*!40000 ALTER TABLE `sale_transaction_sale` DISABLE KEYS */;
/*!40000 ALTER TABLE `sale_transaction_sale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_assign_serial`
--

DROP TABLE IF EXISTS `stock_assign_serial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_assign_serial` (
  `id` int NOT NULL AUTO_INCREMENT,
  `next_serial_number` varchar(45) NOT NULL,
  `next_serial_count` int DEFAULT NULL,
  `create_date` date NOT NULL,
  `update_date` date DEFAULT NULL,
  `move_id` int NOT NULL,
  `create_uid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `stock_assign_serial_create_uid_idx` (`create_uid`),
  KEY `stock_assign_serial_move_id_fkey_idx` (`move_id`),
  CONSTRAINT `stock_assign_serial_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `stock_assign_serial_move_id_fkey` FOREIGN KEY (`move_id`) REFERENCES `stock_move` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_assign_serial`
--

LOCK TABLES `stock_assign_serial` WRITE;
/*!40000 ALTER TABLE `stock_assign_serial` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_assign_serial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_backorder_confirmation`
--

DROP TABLE IF EXISTS `stock_backorder_confirmation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_backorder_confirmation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(3) NOT NULL,
  `show_transfers` tinyint DEFAULT NULL,
  `description` longtext,
  `picking_id` int DEFAULT NULL,
  `create_uid` int NOT NULL,
  `company_id` int NOT NULL,
  `update_date` date DEFAULT NULL,
  `create_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `stock_backorder_confirmation_create_uid_idx` (`create_uid`),
  KEY `stock_backorder_confirmation_company_id_idx` (`company_id`),
  KEY `stock_backorder_confirmation_picking_id_fkey_idx` (`picking_id`),
  CONSTRAINT `stock_backorder_confirmation_company_id_fkey` FOREIGN KEY (`company_id`) REFERENCES `res_company` (`id`),
  CONSTRAINT `stock_backorder_confirmation_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `stock_backorder_confirmation_picking_id_fkey` FOREIGN KEY (`picking_id`) REFERENCES `stock_picking` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_backorder_confirmation`
--

LOCK TABLES `stock_backorder_confirmation` WRITE;
/*!40000 ALTER TABLE `stock_backorder_confirmation` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_backorder_confirmation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_immediate_transfer`
--

DROP TABLE IF EXISTS `stock_immediate_transfer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_immediate_transfer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(3) NOT NULL,
  `show_transfers` tinyint NOT NULL,
  `description` longtext,
  `update_date` date DEFAULT NULL,
  `create_date` date NOT NULL,
  `picking_id` int NOT NULL,
  `create_uid` int NOT NULL,
  `company_id` int NOT NULL,
  `stock_immediate_transfercol` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `stock_immediate_transfer_create_uid_idx` (`create_uid`),
  KEY `stock_inmediate_transfer_company_id_fkey_idx` (`company_id`),
  KEY `stock_inmediate_transfer_picking_id_fkey_idx` (`picking_id`),
  CONSTRAINT `stock_immediate_transfer_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `stock_inmediate_transfer_company_id_fkey` FOREIGN KEY (`company_id`) REFERENCES `res_company` (`id`),
  CONSTRAINT `stock_inmediate_transfer_picking_id_fkey` FOREIGN KEY (`picking_id`) REFERENCES `stock_picking` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_immediate_transfer`
--

LOCK TABLES `stock_immediate_transfer` WRITE;
/*!40000 ALTER TABLE `stock_immediate_transfer` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_immediate_transfer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_inventory`
--

DROP TABLE IF EXISTS `stock_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_inventory` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `inventory_date` date DEFAULT NULL,
  `status` varchar(3) DEFAULT NULL,
  `company_id` int DEFAULT NULL,
  `start_empty` tinyint DEFAULT NULL,
  `prefill_counted_quantity` varchar(45) DEFAULT NULL,
  `exhausted` tinyint DEFAULT NULL,
  `accounting_date` date DEFAULT NULL,
  `description` longtext,
  `create_date` date NOT NULL,
  `update_date` date DEFAULT NULL,
  `create_uid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `stock_inventory_company_id_idx` (`company_id`),
  KEY `stock_inventory_create_uid_idx` (`create_uid`),
  CONSTRAINT `stock_inventory_company_id_fkey` FOREIGN KEY (`company_id`) REFERENCES `res_company` (`id`),
  CONSTRAINT `stock_inventory_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_inventory`
--

LOCK TABLES `stock_inventory` WRITE;
/*!40000 ALTER TABLE `stock_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_inventory_details`
--

DROP TABLE IF EXISTS `stock_inventory_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_inventory_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_editable` tinyint DEFAULT NULL,
  `inventory_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `location_id` int DEFAULT NULL,
  `package_id` int DEFAULT NULL,
  `prod_lot_id` int DEFAULT NULL,
  `company_id` int DEFAULT NULL,
  `theorical_qty` int DEFAULT NULL,
  `inventory_date` date DEFAULT NULL,
  `description` longtext,
  `update_date` date DEFAULT NULL,
  `create_date` date DEFAULT NULL,
  `create_uid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `stock_inventory_line_inventory_id_idx` (`inventory_id`),
  KEY `stock_inventory_line_product_id_idx` (`product_id`),
  KEY `stock_inventory_line_loaction_id_idx` (`location_id`),
  KEY `stock_inventory_line_company_id_idx` (`company_id`),
  KEY `stock_inventory_line_create_uid_idx` (`create_uid`),
  KEY `stock_inventory_details_category_id_fkey_idx` (`category_id`),
  KEY `stock_inventory_details_prod_lot_id_fkey_idx` (`prod_lot_id`),
  KEY `stock_inventory_details_package_id_fkey_idx` (`package_id`),
  CONSTRAINT `stock_inventory_details_category_id_fkey` FOREIGN KEY (`category_id`) REFERENCES `sale_category` (`id`),
  CONSTRAINT `stock_inventory_details_company_id_fkey` FOREIGN KEY (`company_id`) REFERENCES `res_company` (`id`),
  CONSTRAINT `stock_inventory_details_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `stock_inventory_details_inventory_id_fkey` FOREIGN KEY (`inventory_id`) REFERENCES `stock_inventory` (`id`),
  CONSTRAINT `stock_inventory_details_loaction_id_fkey` FOREIGN KEY (`location_id`) REFERENCES `stock_location` (`id`),
  CONSTRAINT `stock_inventory_details_package_id_fkey` FOREIGN KEY (`package_id`) REFERENCES `stock_quant_package` (`id`),
  CONSTRAINT `stock_inventory_details_prod_lot_id_fkey` FOREIGN KEY (`prod_lot_id`) REFERENCES `stock_production_lot` (`id`),
  CONSTRAINT `stock_inventory_details_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `sale_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_inventory_details`
--

LOCK TABLES `stock_inventory_details` WRITE;
/*!40000 ALTER TABLE `stock_inventory_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_inventory_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_inventory_location`
--

DROP TABLE IF EXISTS `stock_inventory_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_inventory_location` (
  `inventory_id` int DEFAULT NULL,
  `location_id` int DEFAULT NULL,
  KEY `stock_inventory_location_location_fkey_idx` (`inventory_id`),
  KEY `stock_inventory_location_location_fkey_idx1` (`location_id`),
  CONSTRAINT `stock_inventory_location_inventory_fkey` FOREIGN KEY (`inventory_id`) REFERENCES `stock_inventory` (`id`),
  CONSTRAINT `stock_inventory_location_location_fkey` FOREIGN KEY (`location_id`) REFERENCES `stock_location` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_inventory_location`
--

LOCK TABLES `stock_inventory_location` WRITE;
/*!40000 ALTER TABLE `stock_inventory_location` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_inventory_location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_location`
--

DROP TABLE IF EXISTS `stock_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_location` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `complete_name` varchar(100) NOT NULL,
  `status` varchar(3) NOT NULL,
  `usage` varchar(100) NOT NULL,
  `posx` int NOT NULL,
  `posy` int NOT NULL,
  `posz` int NOT NULL,
  `parent_path` varchar(45) NOT NULL,
  `scrap_location` tinyint NOT NULL,
  `return_location` tinyint NOT NULL,
  `barcode` varchar(45) NOT NULL,
  `valuation_out_account` int NOT NULL,
  `valuation_in_account` int NOT NULL,
  `description` longtext,
  `removal_strategy_id` int NOT NULL,
  `company_id` int NOT NULL,
  `location_id` int NOT NULL,
  `create_date` date NOT NULL,
  `update_date` date DEFAULT NULL,
  `create_uid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `stock_location_company_id_idx` (`company_id`),
  KEY `stock_location_location_id_idx` (`location_id`),
  KEY `stock_location_create_uid_idx` (`create_uid`),
  CONSTRAINT `stock_location_company_id` FOREIGN KEY (`company_id`) REFERENCES `res_company` (`id`),
  CONSTRAINT `stock_location_create_uid` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `stock_location_location_id` FOREIGN KEY (`location_id`) REFERENCES `stock_location` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_location`
--

LOCK TABLES `stock_location` WRITE;
/*!40000 ALTER TABLE `stock_location` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_location_route`
--

DROP TABLE IF EXISTS `stock_location_route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_location_route` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `status` varchar(3) NOT NULL,
  `sequence` varchar(45) NOT NULL,
  `product_selectable` tinyint NOT NULL,
  `product_category_selectable` tinyint NOT NULL,
  `warehouse_selectable` tinyint NOT NULL,
  `sale_selectable` tinyint NOT NULL,
  `description` longtext,
  `create_date` date NOT NULL,
  `update_date` date DEFAULT NULL,
  `company_id` int NOT NULL,
  `create_uid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `stock_location_route_company_id_idx` (`company_id`),
  KEY `stock_location_route_create_uid_idx` (`create_uid`),
  CONSTRAINT `stock_location_route_company_id` FOREIGN KEY (`company_id`) REFERENCES `res_company` (`id`),
  CONSTRAINT `stock_location_route_create_uid` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_location_route`
--

LOCK TABLES `stock_location_route` WRITE;
/*!40000 ALTER TABLE `stock_location_route` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_location_route` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_location_route_categ`
--

DROP TABLE IF EXISTS `stock_location_route_categ`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_location_route_categ` (
  `location_route_id` int NOT NULL,
  `category_id` int NOT NULL,
  KEY `stock_route_categ_location_route_id_idx` (`location_route_id`),
  KEY `stock_route_categ_location_category_id_fkey_idx` (`category_id`),
  CONSTRAINT `stock_route_categ_location_category_id_fkey` FOREIGN KEY (`category_id`) REFERENCES `sale_category` (`id`),
  CONSTRAINT `stock_route_categ_location_route_id_fkey` FOREIGN KEY (`location_route_id`) REFERENCES `stock_location_route` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_location_route_categ`
--

LOCK TABLES `stock_location_route_categ` WRITE;
/*!40000 ALTER TABLE `stock_location_route_categ` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_location_route_categ` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_location_route_move`
--

DROP TABLE IF EXISTS `stock_location_route_move`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_location_route_move` (
  `move_id` int NOT NULL,
  `route_id` int NOT NULL,
  KEY `location_route_move_route_id_idx` (`route_id`),
  KEY `location_route_move_move_id_fkey_idx` (`move_id`),
  CONSTRAINT `location_route_move_move_id_fkey` FOREIGN KEY (`move_id`) REFERENCES `stock_move` (`id`),
  CONSTRAINT `location_route_move_route_id_fkey` FOREIGN KEY (`route_id`) REFERENCES `stock_location_route` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_location_route_move`
--

LOCK TABLES `stock_location_route_move` WRITE;
/*!40000 ALTER TABLE `stock_location_route_move` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_location_route_move` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_move`
--

DROP TABLE IF EXISTS `stock_move`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_move` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `priority` varchar(10) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `date_deadline` datetime DEFAULT NULL,
  `company_id` int NOT NULL,
  `product_id` int NOT NULL,
  `description_picking` longtext,
  `product_qty` double DEFAULT NULL,
  `product_uom_qty` double NOT NULL,
  `product_uom` int NOT NULL,
  `location_id` int NOT NULL,
  `location_dest_id` int NOT NULL,
  `move_id` int DEFAULT NULL,
  `picking_id` int DEFAULT NULL,
  `description` longtext,
  `status` varchar(3) DEFAULT NULL,
  `price_unit` double DEFAULT NULL,
  `origin` varchar(50) DEFAULT NULL,
  `procure_method` varchar(50) NOT NULL,
  `scrapped` tinyint(1) DEFAULT NULL,
  `group_id` int DEFAULT NULL,
  `rule_id` int DEFAULT NULL,
  `propagate_cancel` tinyint(1) DEFAULT NULL,
  `delay_alert_date` timestamp NULL DEFAULT NULL,
  `picking_type_id` int DEFAULT NULL,
  `inventory_id` int DEFAULT NULL,
  `origin_returned_move_id` int DEFAULT NULL,
  `restrict_partner_id` int DEFAULT NULL,
  `warehouse_id` int DEFAULT NULL,
  `additional` tinyint(1) DEFAULT NULL,
  `reference` varchar(50) DEFAULT NULL,
  `package_level_id` int DEFAULT NULL,
  `next_serial` varchar(50) DEFAULT NULL,
  `next_serial_count` int DEFAULT NULL,
  `orderpoint_id` int DEFAULT NULL,
  `to_refund` tinyint(1) DEFAULT NULL,
  `purchase_line_id` int DEFAULT NULL,
  `created_purchase_line_id` int DEFAULT NULL,
  `sale_line_id` int DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `create_uid` int DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stock_move_company_id_fkey_idx` (`company_id`),
  KEY `stock_move_product_id_fkey_idx` (`product_id`),
  KEY `stock_move_location_id_fkey_idx` (`location_id`),
  KEY `stock_move_move_id_fkey_idx` (`move_id`),
  KEY `stock_move_picking_id_fkey_idx` (`picking_id`),
  KEY `stock_move_rule_id_fkey_idx` (`rule_id`),
  KEY `stock_move_picking_type_id_fkey_idx` (`picking_type_id`),
  KEY `stock_move_inventory_id_fkey_idx` (`inventory_id`),
  KEY `stock_move_warehouse_id_fkey_idx` (`warehouse_id`),
  KEY `stock_move_create_uid_fkey_idx` (`create_uid`),
  KEY `stock_move_location_dest_id_fkey_idx` (`location_dest_id`),
  CONSTRAINT `stock_move_company_id_fkey` FOREIGN KEY (`company_id`) REFERENCES `res_company` (`id`),
  CONSTRAINT `stock_move_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `stock_move_inventory_id_fkey` FOREIGN KEY (`inventory_id`) REFERENCES `stock_inventory` (`id`),
  CONSTRAINT `stock_move_location_dest_id_fkey` FOREIGN KEY (`location_dest_id`) REFERENCES `stock_location` (`id`),
  CONSTRAINT `stock_move_location_id_fkey` FOREIGN KEY (`location_id`) REFERENCES `stock_location` (`id`),
  CONSTRAINT `stock_move_move_id_fkey` FOREIGN KEY (`move_id`) REFERENCES `stock_move` (`id`),
  CONSTRAINT `stock_move_picking_id_fkey` FOREIGN KEY (`picking_id`) REFERENCES `stock_picking` (`id`),
  CONSTRAINT `stock_move_picking_type_id_fkey` FOREIGN KEY (`picking_type_id`) REFERENCES `stock_picking_type` (`id`),
  CONSTRAINT `stock_move_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `sale_product` (`id`),
  CONSTRAINT `stock_move_rule_id_fkey` FOREIGN KEY (`rule_id`) REFERENCES `stock_rule` (`id`),
  CONSTRAINT `stock_move_warehouse_id_fkey` FOREIGN KEY (`warehouse_id`) REFERENCES `stock_warehouse` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_move`
--

LOCK TABLES `stock_move` WRITE;
/*!40000 ALTER TABLE `stock_move` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_move` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_picking`
--

DROP TABLE IF EXISTS `stock_picking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_picking` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `status` varchar(3) NOT NULL,
  `origin` varchar(45) NOT NULL,
  `move_type` varchar(50) NOT NULL,
  `priority` varchar(50) NOT NULL,
  `scheduled_date` timestamp NOT NULL,
  `date_deadline` timestamp NOT NULL,
  `has_deadline_issue` tinyint(1) NOT NULL,
  `date` timestamp NOT NULL,
  `date_done` timestamp NOT NULL,
  `location_id` int NOT NULL,
  `location_dest_id` int NOT NULL,
  `description` longtext NOT NULL,
  `printed` tinyint(1) NOT NULL,
  `is_locked` tinyint(1) NOT NULL,
  `immediate_transfer` tinyint(1) NOT NULL,
  `picking_type_id` int NOT NULL,
  `backorder_id` int NOT NULL,
  `company_id` int NOT NULL,
  `user_id` int NOT NULL,
  `sale_id` int NOT NULL,
  `update_date` datetime DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `create_uid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `stock_picking_location_id_fkey_idx` (`location_id`),
  KEY `stock_picking_location_dest_id_fkey_idx` (`location_dest_id`),
  KEY `stock_picking_picking_type_id_fkey_idx` (`picking_type_id`),
  KEY `stock_picking_backorder_id_fkey_idx` (`backorder_id`),
  KEY `stock_picking_company_id_fkey_idx` (`company_id`),
  KEY `stock_picking_user_id_fkey_idx` (`user_id`),
  KEY `stock_picking_sale_id_fkey_idx` (`sale_id`),
  KEY `stock_picking_create_uid_fkey_idx` (`create_uid`),
  CONSTRAINT `stock_picking_backorder_id_fkey` FOREIGN KEY (`backorder_id`) REFERENCES `stock_picking` (`id`),
  CONSTRAINT `stock_picking_company_id_fkey` FOREIGN KEY (`company_id`) REFERENCES `res_company` (`id`),
  CONSTRAINT `stock_picking_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `stock_picking_location_dest_id_fkey` FOREIGN KEY (`location_dest_id`) REFERENCES `stock_location` (`id`),
  CONSTRAINT `stock_picking_location_id_fkey` FOREIGN KEY (`location_id`) REFERENCES `stock_location` (`id`),
  CONSTRAINT `stock_picking_picking_type_id_fkey` FOREIGN KEY (`picking_type_id`) REFERENCES `stock_picking_type` (`id`),
  CONSTRAINT `stock_picking_sale_id_fkey` FOREIGN KEY (`sale_id`) REFERENCES `sale_sale` (`id`),
  CONSTRAINT `stock_picking_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `res_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_picking`
--

LOCK TABLES `stock_picking` WRITE;
/*!40000 ALTER TABLE `stock_picking` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_picking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_picking_type`
--

DROP TABLE IF EXISTS `stock_picking_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_picking_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `status` varchar(3) NOT NULL,
  `location_src_id` int NOT NULL,
  `location_dest_id` int NOT NULL,
  `code` varchar(50) NOT NULL,
  `return_picking_type_id` int NOT NULL,
  `show_entire_packs` tinyint(1) NOT NULL,
  `warehouse_id` int NOT NULL,
  `use_create_lots` tinyint(1) NOT NULL,
  `use_existing_lots` tinyint(1) NOT NULL,
  `show_operations` tinyint(1) NOT NULL,
  `show_reserved` tinyint(1) NOT NULL,
  `barcode` varchar(50) NOT NULL,
  `description` longtext,
  `company_id` int NOT NULL,
  `create_uid` int NOT NULL,
  `create_date` datetime NOT NULL,
  `update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stock_picking_type_location_src_id_fkey_idx` (`location_src_id`),
  KEY `stock_picking_type_location_dest_id_fkey_idx` (`location_dest_id`),
  KEY `stock_picking_type_picking_type_id_fkey_idx` (`return_picking_type_id`),
  KEY `stock_picking_type_warehouse_id_fkey_idx` (`warehouse_id`),
  KEY `stock_picking_type_company_id_fkey_idx` (`company_id`),
  KEY `stock_picking_type_cretae_uid_fkey_idx` (`create_uid`),
  CONSTRAINT `stock_picking_type_company_id_fkey` FOREIGN KEY (`company_id`) REFERENCES `res_company` (`id`),
  CONSTRAINT `stock_picking_type_cretae_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `stock_picking_type_location_dest_id_fkey` FOREIGN KEY (`location_dest_id`) REFERENCES `stock_location` (`id`),
  CONSTRAINT `stock_picking_type_location_src_id_fkey` FOREIGN KEY (`location_src_id`) REFERENCES `stock_location` (`id`),
  CONSTRAINT `stock_picking_type_picking_type_id_fkey` FOREIGN KEY (`return_picking_type_id`) REFERENCES `stock_picking_type` (`id`),
  CONSTRAINT `stock_picking_type_warehouse_id_fkey` FOREIGN KEY (`warehouse_id`) REFERENCES `stock_warehouse` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_picking_type`
--

LOCK TABLES `stock_picking_type` WRITE;
/*!40000 ALTER TABLE `stock_picking_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_picking_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_production_lot`
--

DROP TABLE IF EXISTS `stock_production_lot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_production_lot` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `reference` varchar(50) NOT NULL,
  `product_id` int NOT NULL,
  `description` longtext,
  `company_id` int NOT NULL,
  `update_date` datetime DEFAULT NULL,
  `create_uid` int DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sale_production_lot_product_id_idx` (`product_id`),
  KEY `stock_production_lot_company_id_fkey_idx` (`company_id`),
  KEY `stock_production_lot_create_uid_fkey_idx` (`create_uid`),
  CONSTRAINT `stock_production_lot_company_id_fkey` FOREIGN KEY (`company_id`) REFERENCES `res_company` (`id`),
  CONSTRAINT `stock_production_lot_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `stock_production_lot_product_id_fkey` FOREIGN KEY (`product_id`) REFERENCES `sale_product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_production_lot`
--

LOCK TABLES `stock_production_lot` WRITE;
/*!40000 ALTER TABLE `stock_production_lot` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_production_lot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_quant_package`
--

DROP TABLE IF EXISTS `stock_quant_package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_quant_package` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(3) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `packaging_id` int DEFAULT NULL,
  `location_id` int DEFAULT NULL,
  `company_id` int DEFAULT NULL,
  `create_uid` int DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stock_quant_package_location_id _fkey_idx` (`location_id`),
  KEY `stock_quant_package_packaging_id _fkey_idx` (`packaging_id`),
  KEY `stock_quant_package_company_id _fkey_idx` (`company_id`),
  KEY `stock_quant_package_create_uid _fkey_idx` (`create_uid`),
  CONSTRAINT `stock_quant_package_company_id _fkey` FOREIGN KEY (`company_id`) REFERENCES `res_company` (`id`),
  CONSTRAINT `stock_quant_package_create_uid _fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `stock_quant_package_location_id _fkey` FOREIGN KEY (`location_id`) REFERENCES `stock_location` (`id`),
  CONSTRAINT `stock_quant_package_packaging_id _fkey` FOREIGN KEY (`packaging_id`) REFERENCES `sale_packaging` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_quant_package`
--

LOCK TABLES `stock_quant_package` WRITE;
/*!40000 ALTER TABLE `stock_quant_package` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_quant_package` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_rule`
--

DROP TABLE IF EXISTS `stock_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_rule` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `status` varchar(3) DEFAULT NULL,
  `procure_method` varchar(45) DEFAULT NULL,
  `delay` int DEFAULT NULL,
  `company_id` int DEFAULT NULL,
  `warehouse_id` int DEFAULT NULL,
  `description` longtext,
  `update_date` datetime DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_uid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stock_rule_company_id_fkey_idx` (`company_id`),
  KEY `stock_rule_warehouse_id_fkey_idx` (`warehouse_id`),
  KEY `stock_rule_create_uid_fkey_idx` (`create_uid`),
  CONSTRAINT `stock_rule_company_id_fkey` FOREIGN KEY (`company_id`) REFERENCES `res_company` (`id`),
  CONSTRAINT `stock_rule_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `stock_rule_warehouse_id_fkey` FOREIGN KEY (`warehouse_id`) REFERENCES `stock_warehouse` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_rule`
--

LOCK TABLES `stock_rule` WRITE;
/*!40000 ALTER TABLE `stock_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_scrap`
--

DROP TABLE IF EXISTS `stock_scrap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_scrap` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `company_id` int NOT NULL,
  `staus` varchar(3) NOT NULL,
  `product_id` int NOT NULL,
  `lot_id` int NOT NULL,
  `package_id` int NOT NULL,
  `move_id` int NOT NULL,
  `picking_id` int NOT NULL,
  `location_id` int NOT NULL,
  `scrap_location_id` int NOT NULL,
  `scrap_qty` double NOT NULL,
  `date_done` datetime NOT NULL,
  `deacription` longtext,
  `create_uid` int NOT NULL,
  `update_date` datetime DEFAULT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `stock_scrap_company_id_fkey_idx` (`company_id`),
  KEY `stock_scrap_lot_id_fkey_idx` (`lot_id`),
  KEY `stock_scrap_package_id_fkey_idx` (`package_id`),
  KEY `stock_scrap_move_id_fkey_idx` (`move_id`),
  KEY `stock_scrap_picking_id_fkey_idx` (`picking_id`),
  KEY `stock_scrap_location_id_fkey_idx` (`location_id`),
  KEY `stock_scrap_scrap_location_id_fkey_idx` (`scrap_location_id`),
  KEY `stock_scrap_create_uid_fkey_idx` (`create_uid`),
  CONSTRAINT `stock_scrap_company_id_fkey` FOREIGN KEY (`company_id`) REFERENCES `res_company` (`id`),
  CONSTRAINT `stock_scrap_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `stock_scrap_location_id_fkey` FOREIGN KEY (`location_id`) REFERENCES `stock_location` (`id`),
  CONSTRAINT `stock_scrap_lot_id_fkey` FOREIGN KEY (`lot_id`) REFERENCES `stock_production_lot` (`id`),
  CONSTRAINT `stock_scrap_move_id_fkey` FOREIGN KEY (`move_id`) REFERENCES `stock_move` (`id`),
  CONSTRAINT `stock_scrap_package_id_fkey` FOREIGN KEY (`package_id`) REFERENCES `stock_quant_package` (`id`),
  CONSTRAINT `stock_scrap_picking_id_fkey` FOREIGN KEY (`picking_id`) REFERENCES `stock_picking` (`id`),
  CONSTRAINT `stock_scrap_scrap_location_id_fkey` FOREIGN KEY (`scrap_location_id`) REFERENCES `stock_location` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_scrap`
--

LOCK TABLES `stock_scrap` WRITE;
/*!40000 ALTER TABLE `stock_scrap` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_scrap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_warehouse`
--

DROP TABLE IF EXISTS `stock_warehouse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_warehouse` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `status` varchar(3) NOT NULL,
  `company_id` int NOT NULL,
  `warehouse_key` varchar(45) NOT NULL,
  `create_date` datetime NOT NULL,
  `create_uid` int NOT NULL,
  `update_date` datetime DEFAULT NULL,
  `description` longtext,
  PRIMARY KEY (`id`),
  KEY `stock_warehouse_company_id_fkey_idx` (`company_id`),
  KEY `stock_warehouse_create_uid_fkey_idx` (`create_uid`),
  CONSTRAINT `stock_warehouse_company_id_fkey` FOREIGN KEY (`company_id`) REFERENCES `res_company` (`id`),
  CONSTRAINT `stock_warehouse_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_warehouse`
--

LOCK TABLES `stock_warehouse` WRITE;
/*!40000 ALTER TABLE `stock_warehouse` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_warehouse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'srmdb'
--
/*!50003 DROP PROCEDURE IF EXISTS `SPCREATECUSTOMER` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SPCREATECUSTOMER`(
    IN pcustomer_id     int,
    IN    pcustomer_key    varchar(45),
    IN    pname            varchar(100),
    IN    plast_name       varchar(100),
	IN    psur_name        varchar(100),
	IN    pcustomer_number varchar(20),
	IN    ptype            varchar(50),
	IN    pdate_birth      datetime,
	IN    pgender          varchar(3),
	IN    pRFC             varchar(20),
	IN    pbusiness_name   varchar(100),
	IN    pprofession      varchar(250),
	IN    pphone_number    varchar(20),   
	IN    pmail            varchar(100),
    IN    pdescription     varchar(1000),
	IN    paddress_id      int,
	IN    puser_code_id     int,
    IN    pcard_id          int,
	IN    pstore_id        int, 
	IN    pcreate_uid      int,
    IN    pcompany_id      int
)
BEGIN

	INSERT INTO `srmdb`.`crm_customer`
	(
		`id`,
		`customer_key`,
		`name`,
		`last_name`,
		`sur_name`,
		`customer_number`,
		`type`,
		`status`,
		`date_birth`,
		`gender`,
		`RFC`,
		`business_name`,
		`profession`,
		`phone_number`,
		`mail`,
		`description`,
		`update_date`,
		`address_id`,
		`user_code_id`,
		`card_id`,
		`store_id`,
		`create_uid`,
		`create_date`
    )
	VALUES
	(
		pcustomer_id,
		pcustomer_key,
		pname,
		plast_name,
		psur_name,
		pcustomer_number,
		ptype,
		'AC',
		pdate_birth,
		pgender,
		pRFC,
		pbusiness_name,
		pprofession,
		pphone_number,
		pmail,
		pdescription,
		curdate(),
		paddress_id,
		puser_code_id,
		pcard_id,
		pstore_id,
		pcreate_uid,
		curdate()
    );
    SELECT pcustomer_id = LAST_INSERT_ID();
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SPCREATEUSER` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SPCREATEUSER`(
    INOUT puser_id    int,
    IN    pname       varchar(100), 
	IN    pprofile    varchar(2), 
	IN    plast_name  varchar(100), 
	IN    psur_name   varchar(100), 
	IN    puser_name  varchar(50), 
	IN    ppassword   varchar(50),
    IN    pposition   varchar(50),
	IN    pstatus     varchar(10), 
	IN    pstore_id   int, 
	IN    paddress_id int, 
	IN    pcreate_uid int,
    IN    pcompany_id int
)
BEGIN

	INSERT INTO `srmdb`.`res_user`
	(
		`name`,
		`profile`,
		`last_name`,
		`sur_name`,
		`user_name`,
		`password`,
		`position`,
		`status`,
		`update_date`,
		`create_date`,
		`store_id`,
		`address_id`,
		`create_uid`,
        `company_id`
    )
	VALUES
	(
		pname,
		pprofile,
		plast_name,
		psur_name,
		puser_name,
		ppassword,
		pposition,
		pstatus,
		curdate(),
		curdate(),
		pstore_id,
		paddress_id,
		pcreate_uid,
        pcompany_id
    );
    SELECT puser_id = LAST_INSERT_ID();
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SPDELETECUSTOMER` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SPDELETECUSTOMER`(IN pcustomer_id INT)
BEGIN
	UPDATE `srmdb`.`crm_customer`
	SET  STATUS = 'B'
    WHERE id = pcustomer_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SPDELETEUSER` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SPDELETEUSER`(
	IN puser_id INT
)
BEGIN

	UPDATE `srmdb`.`res_user`
	   SET STATUS  = 'BJ',
       UPDATE_DATE = CURDATE()
	WHERE id = puser_id;
	
    SELECT "1" AS Result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SPGETCUSTOMERBYID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SPGETCUSTOMERBYID`( 
  IN pcustomer_id  INT,
  IN pstatus       varchar(3),
  IN pendingdate   date,
  IN pstartdate    date,
  IN pcustomer_key varchar(45),
  IN pname         varchar(50),
  IN plast_name    varchar(50)
)
BEGIN

   -- Creation:   24-07-2021   --
   -- Developer:  Erik Reynoso --
   -- Date:       24-07-2021   --
   -- Descriptio: Obtiene los datos de un cliente por el id --

	SELECT CUS.id,
           CUS.customer_key, 
		   CUS.name, 
           CUS.last_name, 
           CUS.sur_name, 
           CUS.customer_number, 
           CUS.type,
           CUS.status,
           CUS.date_birth, 
           CUS.gender,
           CUS.RFC,
		   CUS.business_name,
		   CUS.profession, 
	       CUS.phone_number,
	       CUS.mail,
	       CUS.description, 
	       CUS.update_date, 
	       CUS.user_code_id,
	       CUS.create_uid, 
	       CUS.create_date,
           ADS.id              address_id,
           ADS.name            address_name,
           ADS.postal_code     address_postal_Code,
           ADS.address_format  address_format,
           ADS.addres_view_id  address_view_id,
           ADS.phone_code      address_phone_code,
           ADS.name_position   address_name_position,
           ADS.state_required  address_state_required,
           ADS.region          address_region,
           ADS.city            address_city,
           ADS.description     address_description,
           ADS.create_date     address_create_date,
           CAR.id              card_id,
           CAR.name            card_name,
           CAR.number          card_number,
           STO.id              store_id,
           STO.name            store_name,
           USR.id              create_uid,
           USR.name            user_name,
           USR.status          user_status,
           USR.profile         user_profile,
           USC.id              user_code_id,
           USC.user_name       customer_user_name
	 FROM `srmdb`.`crm_customer` CUS
	INNER JOIN  `srmdb`.`res_address` ADS ON CUS.address_id   = ADS.id
    INNER JOIN  `srmdb`.`sale_card`   CAR ON CUS.card_id      = CAR.id 
    INNER JOIN  `srmdb`.`res_store`   STO ON CUS.store_id     = STO.id
    INNER JOIN  `srmdb`.`res_user`    USR ON CUS.create_uid   = USR.id
    INNER JOIN  `srmdb`.`res_user`    USC ON CUS.user_code_id = USC.id
	WHERE CUS.id = pcustomer_id
      AND CUS.status = pstatus;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SPGETUSER` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SPGETUSER`(
  IN puser_id      INT,
  IN pname         varchar(50),
  IN plast_name    varchar(100),
  IN psur_name     varchar(100),
  IN puser_name    varchar(45),
  IN pposition     varchar(50),
  IN pstatus       varchar(3),
  IN pending_date  date,
  IN pstart_date   date,
  IN pdate_type    varchar(2),
  IN pcompany_id   INT 
)
BEGIN
   
   DECLARE ValidateCero INT DEFAULT 0;

   -- Creation:   06-08-2021   --
   -- Developer:  Erik Reynoso --
   -- Date:       06-08-2021   --
   -- Descriptio: Obtiene los datos de un usuario filtrado por todos los datos --

	SELECT USR.id, 
		   USR.name, 
           USR.profile, 
           USR.last_name, 
           USR.sur_name, 
           USR.user_name,
           USR.position, 
           USR.status,
		   USR.update_date,
		   USR.create_date,
           ADS.id              address_id,
           ADS.name            address_name,
           ADS.postal_code     address_postal_Code,
           ADS.latitude        address_latitude,
           ADS.longitude       address_longitude,
           ADS.phone_number    address_phone_number,
           ADS.region          address_region,
           ADS.city            address_city,
           ADS.description     address_description,
           ADS.create_date     address_create_date,
           STO.id              store_id,
           STO.name            store_name,
           CUS.id              create_uid,
           CUS.name            user_name,
           CUS.status          user_status,
           CUS.profile         user_profile,
           COM.id              company_id,
           COM.status          company_status,
           COM.name            company_name,
           COM.phone_number    company_phone_number,
           COM.mail            company_mail,
           COM.business_name   company_business_name
	 FROM `srmdb`.`res_user` USR
	LEFT JOIN `srmdb`.`res_address` ADS ON USR.address_id = ADS.id
    LEFT JOIN `srmdb`.`res_store`   STO ON USR.store_id   = STO.id
    LEFT JOIN `srmdb`.`res_user`    CUS ON USR.create_uid = CUS.id
    LEFT JOIN `srmdb`.`res_company` COM ON USR.company_id = COM.id
	WHERE (
			puser_id = ValidateCero Or
			USR.id = puser_id
		  ) 
      AND (
            plast_name IS NULL Or
			USR.last_name LIKE concat('%', plast_name, '%')
		  )
	  AND (	
            psur_name IS NULL Or
		    USR.sur_name LIKE concat('%', psur_name, '%')
          )
	  AND (
            puser_name IS NULL Or
            USR.user_name = puser_name
          )
	  AND (
            pposition IS NULL Or
            USR.position = pposition
          )
	  AND (
            pstatus IS NULL Or
            USR.status = pstatus
          )
	  AND (
			pname IS NULL Or
            USR.name LIKE concat('%', pname, '%')
          )
	  AND ( pdate_type IS NULL Or
			(
 	         (
               pdate_type = 'C'                           And
			   DATE(USR.create_date) >= DATE(pstart_date) And
               DATE(USR.create_date) <= DATE(pending_date)
		     )
             Or
 	         ( 
				pdate_type = 'U'                           And
				DATE(USR.update_date) >= DATE(pstart_date) And
				DATE(USR.update_date) <= DATE(pending_date)
			)
		  )
          )
	  AND (
            pcompany_id = ValidateCero Or 
            USR.company_id = pcompany_id
          );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SPLOGINUSER` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SPLOGINUSER`(
	IN p_user_name varchar(50),
	IN p_password  varchar(50)
)
BEGIN

	DECLARE v_user_id INT DEFAULT 0;
	DECLARE v_company_id INT DEFAULT 0;
    DECLARE v_key_session VARCHAR(50);
    DECLARE id int;
    
    SELECT  USR.id INTO @v_user_id
	  FROM `srmdb`.`res_user` USR
	 WHERE upper(USR.user_name) = upper(p_user_name)
       AND USR.password         = p_password;
	
	SELECT  USR.company_id INTO @v_company_id
	  FROM `srmdb`.`res_user` USR
	 WHERE USR.id = @v_user_id;
    
    SET @v_key_session = concat('SES', @v_user_id, DATE_FORMAT(NOW( ), "%d%m%y%H%i%S" ));
  
	INSERT INTO `srmdb`.`res_session`
    (
		`id`,
		`key_session`,
		`create_uid`,
		`create_date`,
		`company_id`
	)
	VALUES
	(
		@id,
		@v_key_session,
		@v_user_id,
		current_timestamp(),
		@v_company_id
	);

    SELECT USR.id          id,
           USR.name        name,
           USR.last_name   last_name,
           USR.sur_name    sur_name,
           USR.status      status,
           USR.company_id  company_id,
           USR.address_id  address_id,
           USR.store_id    store_id,
           SES.id          session_id,
           SES.key_session key_session
	  FROM `srmdb`.`res_user` USR
      LEFT JOIN `srmdb`.`res_session` SES ON USR.id = SES.create_uid
	 WHERE USR.id          = @v_user_id
       AND SES.key_session = @v_key_session;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SPUPDATECUSTOMER` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SPUPDATECUSTOMER`(   
    IN pcustomer_id INT,
    IN pname varchar(100), 
	IN plast_name varchar(100), 
	IN psur_name varchar(100), 
	IN pcustomer_number varchar(20), 
	IN ptype varchar(50), 
	IN pstatus varchar(3), 
	IN pdate_birth datetime, 
	IN pgender varchar(3), 
	IN pRFC varchar(20), 
	IN pbusiness_name varchar(100), 
	IN pprofession varchar(250), 
	IN pphone_number varchar(20), 
	IN pmail varchar(100), 
	IN pdescription longtext,
    OUT pResult INT
)
BEGIN

	UPDATE `srmdb`.`crm_customer`
	SET
		name            = pname,
		last_name       = plast_name,
		sur_name        = psur_name,
		customer_number = pcustomer_number,
		type            = ptype,
		status          = pstatus,
		date_birth      = pdate_birth,
		gender          = pgender,
		RFC             = pRFC,
		business_name   = pbusiness_name,
		profession      = pprofession,
		phone_number    = pphone_number,
		mail            = pmail,
		description     = pdescription,
		update_date     = current_date()
  WHERE id = pcustomer_id;
	
    SET pResult = 1;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SPUPDATEUSER` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SPUPDATEUSER`(
    IN puser_id INT,
    IN pname varchar(100), 
	IN pprofile varchar(2), 
	IN plast_name varchar(100), 
	IN psur_name varchar(100), 
	IN puser_name varchar(50), 
    IN pposition varchar(50), 
	IN pstatus varchar(10)
)
BEGIN

    UPDATE `srmdb`.`res_user`
	SET
	`name`          = pname,
	`profile`       = pprofile,
	`last_name`     = plast_name,
	`sur_name`      = psur_name,
	`user_name`     = puser_name,
	`position`      = pposition,
	`status`        = pstatus,
	`update_date`   = CURDATE()
	WHERE `id` = puser_id;
    
    SELECT "1" as Result;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-10-14  3:52:49
