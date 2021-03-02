-- MySQL dump 10.13  Distrib 8.0.13, for Win64 (x86_64)
--
-- Host: localhost    Database: pttk_garaman
-- ------------------------------------------------------
-- Server version	8.0.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `car`
--

DROP TABLE IF EXISTS `car`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `car` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `info` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_customer_id_idx` (`customer_id`),
  CONSTRAINT `fk_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `car`
--

LOCK TABLES `car` WRITE;
/*!40000 ALTER TABLE `car` DISABLE KEYS */;
INSERT INTO `car` VALUES (13,NULL,'CotKet',1),(14,NULL,'cotket',1),(15,NULL,'cotket',1),(16,NULL,'cotket',1),(17,NULL,'cotket',1),(18,NULL,'cotket',3);
/*!40000 ALTER TABLE `car` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `car_reception`
--

DROP TABLE IF EXISTS `car_reception`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `car_reception` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `car_id` int(11) NOT NULL,
  `sale_staff_id` int(11) NOT NULL,
  `technical_staff_id` int(11) NOT NULL,
  `created_date` datetime DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`),
  KEY `car_reception_fk_2_idx` (`car_id`),
  KEY `car_reception_fk_sale_staff_idx` (`sale_staff_id`),
  KEY `car_reception_fk_technical_staff_idx` (`technical_staff_id`),
  CONSTRAINT `car_reception_fk_2` FOREIGN KEY (`car_id`) REFERENCES `car` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `car_reception_fk_3` FOREIGN KEY (`sale_staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `car_reception_fk_4` FOREIGN KEY (`technical_staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `car_reception_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `car_reception`
--

LOCK TABLES `car_reception` WRITE;
/*!40000 ALTER TABLE `car_reception` DISABLE KEYS */;
INSERT INTO `car_reception` VALUES (13,1,13,6,7,'2020-12-09 00:00:00','2020-12-09 00:00:00'),(14,1,14,5,7,'2020-12-09 00:00:00','2020-12-09 00:00:00'),(15,1,15,5,39,'2020-12-10 00:00:00','2020-12-10 00:00:00'),(16,1,16,5,7,'2020-12-10 00:00:00','2020-12-10 00:00:00'),(17,1,17,5,7,'2020-12-10 00:00:00','2020-12-10 00:00:00'),(18,3,18,5,43,'2020-12-10 00:00:00','2020-12-10 00:00:00');
/*!40000 ALTER TABLE `car_reception` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `car_reception_bill`
--

DROP TABLE IF EXISTS `car_reception_bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `car_reception_bill` (
  `id` int(11) NOT NULL,
  `created_date` datetime DEFAULT NULL,
  `payment_staff_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_payment_staff_idx` (`payment_staff_id`),
  CONSTRAINT `car_reception_bill_ibfk_1` FOREIGN KEY (`id`) REFERENCES `car_reception` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `payment_staff` FOREIGN KEY (`payment_staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `car_reception_bill`
--

LOCK TABLES `car_reception_bill` WRITE;
/*!40000 ALTER TABLE `car_reception_bill` DISABLE KEYS */;
INSERT INTO `car_reception_bill` VALUES (13,'2020-12-09 00:00:00',5),(15,'2020-12-10 00:00:00',5),(16,'2020-12-10 00:00:00',5);
/*!40000 ALTER TABLE `car_reception_bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `car_reception_part`
--

DROP TABLE IF EXISTS `car_reception_part`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `car_reception_part` (
  `car_reception_id` int(11) NOT NULL,
  `part_id` int(11) NOT NULL,
  `quantity` tinyint(4) NOT NULL,
  KEY `part_id` (`part_id`),
  KEY `car_reception_id` (`car_reception_id`),
  CONSTRAINT `car_reception_part_ibfk_1` FOREIGN KEY (`part_id`) REFERENCES `part` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `car_reception_part_ibfk_2` FOREIGN KEY (`car_reception_id`) REFERENCES `car_reception` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `car_reception_part`
--

LOCK TABLES `car_reception_part` WRITE;
/*!40000 ALTER TABLE `car_reception_part` DISABLE KEYS */;
INSERT INTO `car_reception_part` VALUES (13,3,1),(17,9,1),(15,1,1),(18,3,3),(16,9,3);
/*!40000 ALTER TABLE `car_reception_part` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `car_reception_service`
--

DROP TABLE IF EXISTS `car_reception_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `car_reception_service` (
  `car_reception_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `quantity` tinyint(4) NOT NULL,
  KEY `car_reception_id` (`car_reception_id`),
  KEY `service_id` (`service_id`),
  CONSTRAINT `car_reception_service_ibfk_1` FOREIGN KEY (`car_reception_id`) REFERENCES `car_reception` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `car_reception_service_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `car_reception_service`
--

LOCK TABLES `car_reception_service` WRITE;
/*!40000 ALTER TABLE `car_reception_service` DISABLE KEYS */;
INSERT INTO `car_reception_service` VALUES (13,1,2),(13,2,1),(14,4,12),(14,2,1),(17,8,1),(15,1,3),(18,2,1),(16,8,1);
/*!40000 ALTER TABLE `car_reception_service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `car_reception_staff`
--

DROP TABLE IF EXISTS `car_reception_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `car_reception_staff` (
  `car_reception_id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL,
  KEY `car_reception_id` (`car_reception_id`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `car_reception_staff_ibfk_1` FOREIGN KEY (`car_reception_id`) REFERENCES `car_reception` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `car_reception_staff_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `car_reception_staff`
--

LOCK TABLES `car_reception_staff` WRITE;
/*!40000 ALTER TABLE `car_reception_staff` DISABLE KEYS */;
/*!40000 ALTER TABLE `car_reception_staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `customer` (
  `id` int(11) NOT NULL,
  `vip` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`id`) REFERENCES `member` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,1),(2,0),(3,0),(4,0),(9,0),(11,0),(12,0),(13,0),(14,0),(15,0),(16,0),(17,0),(18,0),(20,0),(21,0),(22,0),(32,0),(34,0),(35,0),(38,0);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gara`
--

DROP TABLE IF EXISTS `gara`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `gara` (
  `gara_name` varchar(30) NOT NULL,
  `address` varchar(255) NOT NULL,
  `open_hour` time DEFAULT NULL,
  `close_hour` time DEFAULT NULL,
  PRIMARY KEY (`gara_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gara`
--

LOCK TABLES `gara` WRITE;
/*!40000 ALTER TABLE `gara` DISABLE KEYS */;
/*!40000 ALTER TABLE `gara` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `member` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `phone` varchar(15) NOT NULL,
  `dob` date DEFAULT NULL,
  `card_number` varchar(15) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone_UNIQUE` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (1,'Dương Văn Linh','linhduonghy@gmail.com','Vĩnh Phúc','0396156993','1999-06-15','026099001378'),(2,'Hoàng Hà Linh','linhhahoang1999','Long Biên - Hà Nội','0312345921','1999-08-22','026099001234'),(3,'Thu Nguyễn','tu@gmail.com','Sóc Sơn - Hà Nội','03961910993','1999-10-10','02012312421'),(4,'Thu Hà','iu@gmail.com','Hà Nội','0134982123','1999-10-11','010100101011'),(5,'Lương Thu Hà','lth99@gmail.com','Hà Nội','0912342146','1999-09-11','026099001102'),(6,'Hoàng Hà Lam','hhl@gmail.com','Long Biên-Hà Nội','0987789119','1999-01-12','026099001020'),(7,'Nguyễn Giang Xu','daxua@gmail.com','Lâm Thao-Phú Thọ','012334312','1999-02-22','026099012321'),(9,'Nguyễn Trung Thông','trungthong@gmail.com','Hòa Bình','0396156992','1980-02-08','233259790'),(11,'Phạm Thị Mền','menpt@gmail.comm','Gia Lai','12328383','1997-11-11','233259793'),(12,'Trần Quỳnh Nhi','nhitq@gmail.com','Ha Noi','012030102','1999-05-14','233259794'),(13,'Vũ Ngọc Thiết','thietvn@gmail.com','Hà Nội','0120200302','1989-02-12','233259795'),(14,'Trần Thị Huệ','huett@gmail.com','Hà Nội','124123123','1972-07-18','233259796'),(15,'Bùi Công Hậu','lam@gmail.com','hn','012312312','1999-12-12','12321321321'),(16,'Nguyễn Nhật Duy','xoan@gmail.com','LB-HN','0982527982','1999-08-22','1232312'),(17,'Y Nga','tholan@gmail.com','Hn','0973776072','1999-06-11','12312312'),(18,'Trần Thị Thảo','xego@gmail.com','hn','0917749254','1999-12-02','123123122'),(20,'Nguyễn Hùng Dũng','xoanxe@gmailc.om','hn','0904770053','1999-12-03','12341'),(21,'Nguyễn Thị Mỹ PHúc','lan@gmail.com','hn','0974880788','1999-12-04','123123'),(22,'Nguyễn Phùng Thọ','xoanxegoa@gmail.com','hn','0983888611','1999-12-05','1202'),(32,'Nguyễn Văn Đông','huy@gmail.com','pt','0984603663','1999-12-06','12221'),(34,'A Plenh','abc@gmail.com','abc','0986375176','1992-02-02','12002'),(35,'Lưu  Thị Diễn','linha@gmail.com','vp','0914770545','1993-03-03','12021'),(38,'Nguyễn Thị Trường An','ut@gmail.com','4','0986253482','1999-12-11','123'),(39,'Nguyễn Thị Huyền','hai@gmail.com','Vinh Phuc','0944545232','1999-02-01','1231221'),(40,'Nguyễn Văn Cường','cuongnv@gmail.com','Hà nội','0912644784','1992-12-12','233259814'),(41,'Trần Thị Thu Hà','hattt@gmail.com','Hải phòng','01668890843','1992-12-03','233259815'),(42,'Nguyễn Thị Kim Anh','anhntk@gmail.com','Thanh hóa','0966219941','1995-10-10','233259816'),(43,'Nguyễn Thị Thắm','thamnt@gmail.com','Vĩnh phúc','01634229954','1999-12-10','233259817'),(44,'Đặng Thị Thanh Lộc','locdtt@gmail.com','Bắc Giang','01672377922','1999-10-19','233259818'),(45,'Phùng Thị Ánh Tuyết','tuyetpta@gmail.com','Thái Bình','01674269375','1999-06-15','233259819'),(46,'Quàng Văn Năm','namqv@gmail.com','Ninh Bình','0962089926','1999-12-14','233259820'),(47,'Lê Trung Phi','philt@gmail.com','Phú Thọ','01695084768','1999-11-02','233259821'),(48,'Võ Văn Hùng','hungvv@gmail.com','Hà Nội','0987214082','1999-02-11','233259822'),(49,'Cao Thị Minh','minhct@gmail.com','Hà Nội','0978366465','1999-01-12','233259823'),(50,'Đặng Văn Phúc','phucdv@gmail.com','Hà Nội','0914162689','1999-02-09','233259824');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `part`
--

DROP TABLE IF EXISTS `part`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `part` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `years_warranty` tinyint(4) DEFAULT NULL,
  `price` float NOT NULL,
  `provider_id` int(11) DEFAULT NULL,
  `quantity_in_stock` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `part_ibfk_1` (`provider_id`),
  CONSTRAINT `part_ibfk_1` FOREIGN KEY (`provider_id`) REFERENCES `provider` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `part`
--

LOCK TABLES `part` WRITE;
/*!40000 ALTER TABLE `part` DISABLE KEYS */;
INSERT INTO `part` VALUES (1,'Bạc đạn bánh xe','Bạc đạn bánh xe',2,50000,1,97),(2,'Cần gặt nước mưa','	Bạc đạn bánh xe',3,200000,1,100),(3,'Dầu nhớt','Dầu nhớt',1,100000,2,96),(4,'Bình điện ','Bình điện ',2,300000,1,100),(5,'Bộ Massage','Bộ Massage',1,1000000,2,100),(6,'Bơm dầu trợ lực lại','Bơm dầu trợ lực lại',1,400000,3,99),(7,'Bơm hơi bánh xe','Bơm hơi bánh xe',1,300000,1,100),(8,'Cần lái','Cần lái',2,400000,2,100),(9,'Cảm biến nhiệp đồ nước','Cảm biến nhiệp đồ nước',1,200000,3,98),(10,'Máy phát điện','Máy phát điện',2,2000000,1,100);
/*!40000 ALTER TABLE `part` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `part_import`
--

DROP TABLE IF EXISTS `part_import`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `part_import` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  `created_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `staff_id` (`staff_id`),
  KEY `provider_id` (`provider_id`),
  CONSTRAINT `part_import_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `part_import_ibfk_2` FOREIGN KEY (`provider_id`) REFERENCES `provider` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `part_import`
--

LOCK TABLES `part_import` WRITE;
/*!40000 ALTER TABLE `part_import` DISABLE KEYS */;
/*!40000 ALTER TABLE `part_import` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `part_import_bill`
--

DROP TABLE IF EXISTS `part_import_bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `part_import_bill` (
  `id` int(11) NOT NULL,
  `created_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `part_import_bill_ibfk_1` FOREIGN KEY (`id`) REFERENCES `part_import` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `part_import_bill`
--

LOCK TABLES `part_import_bill` WRITE;
/*!40000 ALTER TABLE `part_import_bill` DISABLE KEYS */;
/*!40000 ALTER TABLE `part_import_bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `part_import_part`
--

DROP TABLE IF EXISTS `part_import_part`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `part_import_part` (
  `part_id` int(11) NOT NULL,
  `part_import_id` int(11) NOT NULL,
  `quantity` int(5) NOT NULL,
  KEY `part_id` (`part_id`),
  KEY `part_import_id` (`part_import_id`),
  CONSTRAINT `part_import_part_ibfk_1` FOREIGN KEY (`part_id`) REFERENCES `part` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `part_import_part_ibfk_2` FOREIGN KEY (`part_import_id`) REFERENCES `part_import` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `part_import_part`
--

LOCK TABLES `part_import_part` WRITE;
/*!40000 ALTER TABLE `part_import_part` DISABLE KEYS */;
/*!40000 ALTER TABLE `part_import_part` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provider`
--

DROP TABLE IF EXISTS `provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `provider` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `address` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider`
--

LOCK TABLES `provider` WRITE;
/*!40000 ALTER TABLE `provider` DISABLE KEYS */;
INSERT INTO `provider` VALUES (1,'Lâm Thao','Phú Thọ','desc'),(2,'Wood','Long Biên - Hà Nội','desc'),(3,'Sầm Sơn','Thanh Hóa','desc');
/*!40000 ALTER TABLE `provider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(45) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title_UNIQUE` (`title`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'Nhân viên quản lý','Quản lý thông tin dịch vụ, phụ tùng, quản lý thống kê'),(2,'Nhân viên bán hàng','nhân viên nhận khách hàng, nhận yêu cầu dịch vụ, phụ tùng từ khách hàng, nhận thanh toán từ khách hàng'),(3,'Nhân viên kho','Nhân viên nhập phụ tùng từ nhà cung cấp, quản lý thông tin nhà cung cấp'),(4,'Nhân viên kỹ thuật','Nhân viên sửa chữa, thay thế dịch vụ, phụ tùng xe cho khách hàng');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `service` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `years_warranty` tinyint(4) DEFAULT NULL,
  `price` float NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES (1,'Bảo hành','Bảo hành',2,500000),(2,'Sửa điều hòa','Sửa điều hòa',3,300000),(3,'Rửa xe ô tô','Rửa xe ô tô',1,100000),(4,'Kiểm tra định kỳ','Kiểm tra định kỳ',1,200000),(5,'Rửa chữa bảo dưỡng khoang máy ô tô','Rửa chữa bảo dưỡng khoang máy ô tô',1,200000),(6,'Đánh bóng sơn xe','Đánh bóng sơn xe',1,400000),(7,'Dọn nội thất ô ô','Dọn nội thất ô tô',1,200000),(8,'Sửa chữa khung gầm ô tô','Sửa chữa khung gầm ô tô',1,100000),(9,'Sửa chữa hộp số tự động','Sửa chữa hộp số tự động',1,300000),(10,'Thay thế phụ tung','Thay thế phụ tùng',1,300000);
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `staff` (
  `id` int(11) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) DEFAULT NULL,
  `level` varchar(255) DEFAULT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`id`) REFERENCES `member` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `staff_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (5,'tu','c437cc6bd58bad835dacffb081be4882','1',2),(6,'xoan','c437cc6bd58bad835dacffb081be4882','2',1),(7,'huy','c437cc6bd58bad835dacffb081be4882','3',4),(39,'hai','c437cc6bd58bad835dacffb081be4882','4',4),(40,'hue','c437cc6bd58bad835dacffb081be4882','1',1),(41,'khoa','c437cc6bd58bad835dacffb081be4882','2',2),(42,'hang','c437cc6bd58bad835dacffb081be4882','3',3),(43,'uyen','c437cc6bd58bad835dacffb081be4882','4',4),(44,'thu','c437cc6bd58bad835dacffb081be4882','1',1),(45,'luong','c437cc6bd58bad835dacffb081be4882','2',2),(46,'ngoc','c437cc6bd58bad835dacffb081be4882','3',3),(47,'anh','c437cc6bd58bad835dacffb081be4882','4',4),(48,'nguyen','c437cc6bd58bad835dacffb081be4882','1',1),(49,'thuy','c437cc6bd58bad835dacffb081be4882','2',2),(50,'linh','c437cc6bd58bad835dacffb081be4882','3',3);
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'pttk_garaman'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-27 19:36:58
