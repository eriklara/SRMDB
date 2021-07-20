-- MySQL dump 10.13  Distrib 8.0.25, for Win64 (x86_64)
--
-- Host: localhost    Database: srmdbv3
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
  `create_id` int NOT NULL,
  `create_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_key_UNIQUE` (`customer_key`),
  KEY `crm_customer_store_id_index` (`store_id`),
  KEY `crm_customer_user_code_id_index` (`user_code_id`),
  KEY `crm_customer_user_create_uid_index` (`create_id`),
  KEY `crm_customer_card_id_index` (`card_id`),
  KEY `crm_customer_address_id_index` (`address_id`),
  CONSTRAINT `crm_customer_address_id_fkey` FOREIGN KEY (`address_id`) REFERENCES `res_address` (`id`),
  CONSTRAINT `crm_customer_card_id_fkey` FOREIGN KEY (`card_id`) REFERENCES `sale_card` (`id`),
  CONSTRAINT `crm_customer_store_id_fkey` FOREIGN KEY (`store_id`) REFERENCES `res_store` (`id`),
  CONSTRAINT `crm_customer_user_code_id_fkey` FOREIGN KEY (`user_code_id`) REFERENCES `res_user` (`id`),
  CONSTRAINT `crm_customer_user_creater_id_fkey` FOREIGN KEY (`create_id`) REFERENCES `res_user` (`id`)
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
  `id` int NOT NULL,
  `employee_id` int NOT NULL,
  `check_in` datetime DEFAULT NULL,
  `check_out` datetime DEFAULT NULL,
  `worked_hours` double DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `create_uid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `hr_attendance_creat_uid_index` (`create_uid`),
  KEY `hr_attendance_employee_id_index` (`employee_id`),
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
  `id` int NOT NULL,
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
  KEY `hr_department_manager_id_index` (`manager_id`),
  CONSTRAINT `hr_department_company_id_fkey` FOREIGN KEY (`company_id`) REFERENCES `res_company` (`id`),
  CONSTRAINT `hr_department_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `hr_department_manager_id_fkey` FOREIGN KEY (`manager_id`) REFERENCES `hr_employee` (`id`)
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
  `id` int NOT NULL,
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
  PRIMARY KEY (`id`),
  KEY `hr_departure_wizard_create_uid_index` (`create_uid`),
  KEY `hr_departure_wizard_employee_id_index` (`employee_id`),
  KEY `hr_departure_wizard_user_authorized_id_idx` (`user_authorizes_id`),
  CONSTRAINT `hr_departure_wizard_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `hr_departure_wizard_employee_id_fkey` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`),
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
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `employee_id` int NOT NULL,
  `documentation_type` int NOT NULL,
  `front_picture` int DEFAULT NULL,
  `rear_image` int DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `expiration_date` datetime DEFAULT NULL,
  `description` longtext,
  `update_date` datetime DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `create_uid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `hr_documentation_create_uid_key_idx` (`create_uid`),
  KEY `hr_documentation_documentation_type_key_idx` (`documentation_type`),
  KEY `hr_documentation_front_image_key_idx` (`front_picture`),
  KEY `hr_documentation_rear_image_key_idx` (`rear_image`),
  KEY `hr_documentation_employee_id_key` (`employee_id`),
  CONSTRAINT `hr_documentation_create_uid_key` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `hr_documentation_documentation_type_key` FOREIGN KEY (`documentation_type`) REFERENCES `hr_documentation_type` (`id`),
  CONSTRAINT `hr_documentation_employee_id_key` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `hr_documentation_front_image_key` FOREIGN KEY (`front_picture`) REFERENCES `res_image` (`id`),
  CONSTRAINT `hr_documentation_rear_image_key` FOREIGN KEY (`rear_image`) REFERENCES `res_image` (`id`)
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
  `id` int NOT NULL,
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
  `id` int NOT NULL,
  `full_name` varchar(250) CHARACTER SET latin1 DEFAULT NULL,
  `user_id` int NOT NULL,
  `status` varchar(3) CHARACTER SET latin1 NOT NULL,
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
  `sinid` varchar(100) CHARACTER SET latin1 DEFAULT NULL COMMENT 'Genera dudas está columna.',
  `permitNo` varchar(10) CHARACTER SET latin1 DEFAULT NULL,
  `visa_no` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `additional_note` text CHARACTER SET latin1,
  `certificate` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `study_field` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `study_school` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `emergency_contact` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `emergency_phone` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `km_home_work` int DEFAULT NULL,
  `color` int DEFAULT NULL,
  `barcode` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `pin` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `job_title` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `work_phone` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `mobile_phone` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `work_email` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `work_location` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `last_check_in` datetime DEFAULT NULL,
  `last_check_out` datetime DEFAULT NULL,
  `description` longtext CHARACTER SET latin1,
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
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `create_uid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `hr_employee_user_id_index` (`user_id`),
  KEY `hr_employee_company_id_index` (`company_id`),
  KEY `hr_employee_create_uid_index` (`create_uid`),
  KEY `hr_employee_department_id_index` (`department_id`),
  KEY `hr_employee_leave_manager_id_index` (`leave_manager_id`) /*!80000 INVISIBLE */,
  KEY `hr_employee_last_attendance_id_index` (`last_attendance_id`) /*!80000 INVISIBLE */,
  KEY `hr_employee_country_of_birth_id_index` (`country_of_birth`),
  KEY `hr_employee_job_id_fkey_idx` (`job_id`),
  CONSTRAINT `hr_employee_company_id_fkey` FOREIGN KEY (`company_id`) REFERENCES `res_company` (`id`),
  CONSTRAINT `hr_employee_country_of_birth_fkey` FOREIGN KEY (`country_of_birth`) REFERENCES `res_address` (`id`),
  CONSTRAINT `hr_employee_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `hr_employee_department_id_fkey` FOREIGN KEY (`department_id`) REFERENCES `hr_department` (`id`),
  CONSTRAINT `hr_employee_job_id_fkey` FOREIGN KEY (`job_id`) REFERENCES `hr_job` (`id`),
  CONSTRAINT `hr_employee_last_attendance_id_fkey` FOREIGN KEY (`last_attendance_id`) REFERENCES `hr_attendance` (`id`),
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
  `id` int NOT NULL,
  `full_name` varchar(250) NOT NULL,
  `type` varchar(100) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `employee_id` int NOT NULL,
  `update_Date` datetime NOT NULL,
  `create_Date` datetime NOT NULL,
  `create_uid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `hr_employeerelatives_create_uid_index` (`create_uid`),
  KEY `hr_employeerelatives_employee_id_fkey_idx` (`employee_id`),
  CONSTRAINT `hr_employeerelatives_employee_id_fkey` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
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
  `id` int NOT NULL,
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
  `holiday_status_id` int NOT NULL COMMENT 'Verificar si se crea estatus de holiday',
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
  KEY `hr_leave_employee_id_index` (`employee_id`),
  KEY `hr_leave_department_id_index` (`department_id`),
  KEY `hr_leave_manager_id_index` (`manager_id`),
  KEY `hr_leave_user_id_index` (`user_id`),
  KEY `hr_leave_category_id_index` (`category_id`),
  KEY `hr_leave_status_id_index` (`holiday_status_id`),
  KEY `hr_leave_create_uid_index` (`create_uid`),
  KEY `hr_leave_first_approver_id_index` (`first_approver_id`),
  KEY `hr_leave_mode_company_id_index` (`mode_company_id`),
  KEY `hr_leave_second_approver_id_index` (`second_approver_id`),
  CONSTRAINT `hr_leave_category_id_fkey` FOREIGN KEY (`category_id`) REFERENCES `hr_employee_category` (`id`),
  CONSTRAINT `hr_leave_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `hr_leave_department_id_fkey` FOREIGN KEY (`department_id`) REFERENCES `hr_department` (`id`),
  CONSTRAINT `hr_leave_employee_id_fkey` FOREIGN KEY (`employee_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `hr_leave_first_approver_id_fkey` FOREIGN KEY (`first_approver_id`) REFERENCES `hr_employee` (`id`),
  CONSTRAINT `hr_leave_holiday_status_id_fkey` FOREIGN KEY (`holiday_status_id`) REFERENCES `hr_leave_type` (`id`),
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
  `id` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `code` varchar(45) DEFAULT NULL,
  `sequence` int DEFAULT NULL,
  `create_calendar_meeting` tinyint DEFAULT NULL,
  `color_name` varchar(45) DEFAULT NULL,
  `active` tinyint DEFAULT NULL,
  `company_id` int DEFAULT NULL,
  `responsible_id` int DEFAULT NULL,
  `leave_validation_type` varchar(45) DEFAULT NULL,
  `allocation_validation_type` varchar(45) DEFAULT NULL,
  `allocation_type` varchar(45) DEFAULT NULL,
  `validity_start` date DEFAULT NULL,
  `validity_stop` date DEFAULT NULL,
  `time_type` varchar(45) DEFAULT NULL,
  `request_unit` varchar(45) DEFAULT NULL,
  `unpaid` tinyint DEFAULT NULL,
  `leave_notif_subtype_id` int DEFAULT NULL,
  `allocation_notif_subtype_id` int DEFAULT NULL,
  `create_uid` int DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `hr_leave_type_company_id_index` (`company_id`),
  KEY `hr_leave_type_create_uid_index` (`create_uid`),
  KEY `hr_leave_type_responsible_id_index` (`responsible_id`),
  CONSTRAINT `hr_leave_type_company_id_fkey` FOREIGN KEY (`company_id`) REFERENCES `res_company` (`id`),
  CONSTRAINT `hr_leave_type_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `hr_leave_type_responsible_id_fkey` FOREIGN KEY (`responsible_id`) REFERENCES `res_user` (`id`)
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
-- Table structure for table `purchase_account`
--

DROP TABLE IF EXISTS `purchase_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_account` (
  `id` int NOT NULL,
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
  `id` int NOT NULL,
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
  `id` int NOT NULL,
  `product_quantity` int NOT NULL,
  `total_amount` double NOT NULL,
  `discount_amount` double NOT NULL,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `create_date` datetime NOT NULL,
  `update_date` int NOT NULL,
  `create_uid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `purchase_order_product_order_id_index` (`order_id`),
  KEY `purchase_order_product_product_id_index` (`product_id`),
  KEY `purchase_order_product_create_uid_index` (`create_uid`),
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
  `id` int NOT NULL,
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
  `id` int NOT NULL,
  `key` varchar(45) NOT NULL COMMENT 'Clave de compras y gastos',
  `type_id` int NOT NULL,
  `status` varchar(3) NOT NULL,
  `deadline` datetime NOT NULL,
  `reception_date` datetime DEFAULT NULL,
  `company_id` int NOT NULL,
  `total` double NOT NULL,
  `image_id` int DEFAULT NULL,
  `account_id` int NOT NULL,
  `update_date` datetime NOT NULL,
  `create_uid` int NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Key_UNIQUE` (`key`),
  KEY `purchase_purchase_company_id_index` (`company_id`),
  KEY `purchase_purchase_type_id_index` (`type_id`),
  KEY `purchase_purchase_image_id_index` (`image_id`),
  KEY `purchase_purchase_account_id_index` (`account_id`),
  KEY `purchase_purchase_create_uid_index` (`create_uid`),
  CONSTRAINT `purchase_purchase_account_id_fkey` FOREIGN KEY (`account_id`) REFERENCES `purchase_account` (`id`),
  CONSTRAINT `purchase_purchase_company_id_fkey` FOREIGN KEY (`company_id`) REFERENCES `res_company` (`id`),
  CONSTRAINT `purchase_purchase_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`),
  CONSTRAINT `purchase_purchase_image_id_fkey` FOREIGN KEY (`image_id`) REFERENCES `res_image` (`id`),
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
  KEY `purchase_purchase_order_order_id_index` (`order_id`),
  KEY `purchase_purchase_order_purchase_id_index` (`purchase_id`),
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
  `id` int NOT NULL,
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
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `address_format` longtext,
  `address_view_id` int DEFAULT NULL,
  `phone_code` int DEFAULT NULL,
  `name_position` varchar(100) DEFAULT NULL,
  `state_required` tinyint DEFAULT NULL,
  `region` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `description` longtext,
  `update_date` datetime DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `create_uid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `res_address_create_uid_index` (`create_uid`),
  CONSTRAINT `res_address_create_uid_fkey` FOREIGN KEY (`create_uid`) REFERENCES `res_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `res_address`
--

LOCK TABLES `res_address` WRITE;
/*!40000 ALTER TABLE `res_address` DISABLE KEYS */;
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
/*!40000 ALTER TABLE `res_company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `res_currency`
--

DROP TABLE IF EXISTS `res_currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `res_currency` (
  `id` int NOT NULL,
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
-- Table structure for table `res_image`
--

DROP TABLE IF EXISTS `res_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `res_image` (
  `id` int NOT NULL,
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
-- Table structure for table `res_store`
--

DROP TABLE IF EXISTS `res_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `res_store` (
  `id` int NOT NULL,
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
  `create_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `res_store_address_id_index` (`address_id`),
  KEY `res_store_create_uid_index` (`create_id`),
  CONSTRAINT `res_store_address_id_fkey` FOREIGN KEY (`address_id`) REFERENCES `res_address` (`id`),
  CONSTRAINT `res_store_create_uid_fkey` FOREIGN KEY (`create_id`) REFERENCES `res_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `res_store`
--

LOCK TABLES `res_store` WRITE;
/*!40000 ALTER TABLE `res_store` DISABLE KEYS */;
/*!40000 ALTER TABLE `res_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `res_user`
--

DROP TABLE IF EXISTS `res_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `res_user` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `profile` varchar(2) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `sur_name` varchar(100) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `position` varchar(50) NOT NULL,
  `seller_number` varchar(50) DEFAULT NULL,
  `status` varchar(10) NOT NULL,
  `update_date` datetime NOT NULL,
  `create_date` datetime NOT NULL,
  `store_id` int DEFAULT NULL,
  `address_id` int DEFAULT NULL,
  `create_uid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `res_user_store_id_index` (`store_id`),
  KEY `res_user_address_id_index` (`address_id`),
  KEY `res_user_create_uid_index` (`create_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `res_user`
--

LOCK TABLES `res_user` WRITE;
/*!40000 ALTER TABLE `res_user` DISABLE KEYS */;
INSERT INTO `res_user` VALUES (1,'Shandy arely','AM','Salazar','chan','asalazar','Test007','vendedor','00001','activo','2021-07-12 00:00:00','2021-07-12 00:00:00',NULL,NULL,NULL);
/*!40000 ALTER TABLE `res_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_card`
--

DROP TABLE IF EXISTS `sale_card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sale_card` (
  `id` int NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
-- Table structure for table `sale_payment`
--

DROP TABLE IF EXISTS `sale_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sale_payment` (
  `id` int NOT NULL,
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
  KEY `sale_payment_transaction_id_index` (`transaction_id`),
  KEY `sale_payment_create_uid_index` (`create_uid`),
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
  KEY `sale_payment_sale_sale_id_index` (`sale_id`),
  KEY `sale_payment_sale_create_uid_index` (`create_uid`),
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
  `id` int NOT NULL,
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
  `id` int NOT NULL,
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
  `id` int NOT NULL,
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
  KEY `sale_sale_sale_id_index` (`sale_id`),
  KEY `sale_sale_create_uid_index` (`create_uid`),
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
  `id` int NOT NULL,
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
  `id` int NOT NULL,
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
  KEY `sale_transaction_sale_sale_id_index` (`sale_id`),
  KEY `sale_transaction_sale_transaction_id_index` (`transaction_id`),
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-07-19 23:30:07
