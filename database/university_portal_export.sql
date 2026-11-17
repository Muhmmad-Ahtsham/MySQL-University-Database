/*M!999999\- enable the sandbox mode */ 

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `university_portal` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;

USE `university_portal`;
DROP TABLE IF EXISTS `attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `enrollment_id` int(11) NOT NULL,
  `class_date` date NOT NULL,
  `status` enum('Present','Absent','Late','Leave') NOT NULL DEFAULT 'Present',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_enrollment_date` (`enrollment_id`,`class_date`),
  CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`enrollment_id`) REFERENCES `enrollments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=256 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `attendance` WRITE;
/*!40000 ALTER TABLE `attendance` DISABLE KEYS */;
INSERT INTO `attendance` VALUES
(1,1,'2026-09-07','Late'),
(2,1,'2026-09-14','Present'),
(3,1,'2026-09-21','Present'),
(4,1,'2026-09-28','Present'),
(5,1,'2026-10-05','Absent'),
(6,1,'2026-10-12','Leave'),
(7,2,'2026-09-07','Present'),
(8,2,'2026-09-14','Present'),
(9,2,'2026-09-21','Present'),
(10,2,'2026-09-28','Absent'),
(11,2,'2026-10-05','Present'),
(12,2,'2026-10-12','Present'),
(13,3,'2026-09-07','Present'),
(14,3,'2026-09-14','Absent'),
(15,3,'2026-09-21','Present'),
(16,3,'2026-09-28','Present'),
(17,3,'2026-10-05','Present'),
(18,3,'2026-10-12','Present'),
(19,4,'2026-09-07','Present'),
(20,4,'2026-09-14','Present'),
(21,4,'2026-09-21','Present'),
(22,4,'2026-09-28','Present'),
(23,4,'2026-10-05','Late'),
(24,4,'2026-10-12','Present'),
(25,5,'2026-09-07','Late'),
(26,5,'2026-09-14','Present'),
(27,5,'2026-09-21','Absent'),
(28,5,'2026-09-28','Present'),
(29,5,'2026-10-05','Present'),
(30,5,'2026-10-12','Present'),
(31,6,'2026-09-07','Absent'),
(32,6,'2026-09-14','Present'),
(33,6,'2026-09-21','Present'),
(34,6,'2026-09-28','Present'),
(35,6,'2026-10-05','Present'),
(36,6,'2026-10-12','Late'),
(37,7,'2026-09-07','Absent'),
(38,7,'2026-09-14','Present'),
(39,7,'2026-09-21','Present'),
(40,7,'2026-09-28','Present'),
(41,7,'2026-10-05','Present'),
(42,7,'2026-10-12','Leave'),
(43,8,'2026-09-07','Late'),
(44,8,'2026-09-14','Present'),
(45,8,'2026-09-21','Present'),
(46,8,'2026-09-28','Absent'),
(47,8,'2026-10-05','Present'),
(48,8,'2026-10-12','Present'),
(49,9,'2026-09-07','Present'),
(50,9,'2026-09-14','Absent'),
(51,9,'2026-09-21','Present'),
(52,9,'2026-09-28','Present'),
(53,9,'2026-10-05','Absent'),
(54,9,'2026-10-12','Present'),
(55,10,'2026-09-07','Present'),
(56,10,'2026-09-14','Present'),
(57,10,'2026-09-21','Present'),
(58,10,'2026-09-28','Present'),
(59,10,'2026-10-05','Present'),
(60,10,'2026-10-12','Late'),
(61,11,'2026-09-07','Present'),
(62,11,'2026-09-14','Present'),
(63,11,'2026-09-21','Late'),
(64,11,'2026-09-28','Absent'),
(65,11,'2026-10-05','Present'),
(66,11,'2026-10-12','Present'),
(67,12,'2026-09-07','Late'),
(68,12,'2026-09-14','Absent'),
(69,12,'2026-09-21','Present'),
(70,12,'2026-09-28','Present'),
(71,12,'2026-10-05','Present'),
(72,12,'2026-10-12','Present'),
(73,15,'2026-09-07','Late'),
(74,15,'2026-09-14','Leave'),
(75,15,'2026-09-21','Present'),
(76,15,'2026-09-28','Present'),
(77,15,'2026-10-05','Present'),
(78,15,'2026-10-12','Present'),
(79,13,'2026-09-07','Absent'),
(80,13,'2026-09-14','Absent'),
(81,13,'2026-09-21','Late'),
(82,13,'2026-09-28','Leave'),
(83,13,'2026-10-05','Present'),
(84,13,'2026-10-12','Present'),
(85,14,'2026-09-07','Absent'),
(86,14,'2026-09-14','Absent'),
(87,14,'2026-09-21','Late'),
(88,14,'2026-09-28','Leave'),
(89,14,'2026-10-05','Present'),
(90,14,'2026-10-12','Present'),
(91,16,'2026-09-07','Present'),
(92,16,'2026-09-14','Present'),
(93,16,'2026-09-21','Absent'),
(94,16,'2026-09-28','Present'),
(95,16,'2026-10-05','Present'),
(96,16,'2026-10-12','Present'),
(97,17,'2026-09-07','Present'),
(98,17,'2026-09-14','Late'),
(99,17,'2026-09-21','Present'),
(100,17,'2026-09-28','Present'),
(101,17,'2026-10-05','Absent'),
(102,17,'2026-10-12','Present'),
(103,18,'2026-09-07','Present'),
(104,18,'2026-09-14','Present'),
(105,18,'2026-09-21','Absent'),
(106,18,'2026-09-28','Present'),
(107,18,'2026-10-05','Present'),
(108,18,'2026-10-12','Present'),
(109,20,'2026-09-07','Absent'),
(110,20,'2026-09-14','Present'),
(111,20,'2026-09-21','Absent'),
(112,20,'2026-09-28','Present'),
(113,20,'2026-10-05','Absent'),
(114,20,'2026-10-12','Present'),
(115,19,'2026-09-07','Late'),
(116,19,'2026-09-14','Present'),
(117,19,'2026-09-21','Late'),
(118,19,'2026-09-28','Present'),
(119,19,'2026-10-05','Late'),
(120,19,'2026-10-12','Present'),
(121,21,'2026-09-07','Absent'),
(122,21,'2026-09-14','Present'),
(123,21,'2026-09-21','Absent'),
(124,21,'2026-09-28','Present'),
(125,21,'2026-10-05','Absent'),
(126,21,'2026-10-12','Present'),
(127,24,'2026-09-07','Present'),
(128,24,'2026-09-14','Present'),
(129,24,'2026-09-21','Present'),
(130,24,'2026-09-28','Absent'),
(131,24,'2026-10-05','Present'),
(132,24,'2026-10-12','Present'),
(133,23,'2026-09-07','Present'),
(134,23,'2026-09-14','Late'),
(135,23,'2026-09-21','Present'),
(136,23,'2026-09-28','Present'),
(137,23,'2026-10-05','Present'),
(138,23,'2026-10-12','Absent'),
(139,22,'2026-09-07','Late'),
(140,22,'2026-09-14','Present'),
(141,22,'2026-09-21','Present'),
(142,22,'2026-09-28','Present'),
(143,22,'2026-10-05','Absent'),
(144,22,'2026-10-12','Present'),
(145,25,'2026-09-07','Present'),
(146,25,'2026-09-14','Present'),
(147,25,'2026-09-21','Present'),
(148,25,'2026-09-28','Leave'),
(149,25,'2026-10-05','Late'),
(150,25,'2026-10-12','Absent'),
(151,26,'2026-09-07','Late'),
(152,26,'2026-09-14','Absent'),
(153,26,'2026-09-21','Absent'),
(154,26,'2026-09-28','Present'),
(155,26,'2026-10-05','Present'),
(156,26,'2026-10-12','Present'),
(157,27,'2026-09-07','Absent'),
(158,27,'2026-09-14','Present'),
(159,27,'2026-09-21','Present'),
(160,27,'2026-09-28','Present'),
(161,27,'2026-10-05','Present'),
(162,27,'2026-10-12','Present'),
(163,30,'2026-09-07','Present'),
(164,30,'2026-09-14','Present'),
(165,30,'2026-09-21','Present'),
(166,30,'2026-09-28','Present'),
(167,30,'2026-10-05','Absent'),
(168,30,'2026-10-12','Late'),
(169,28,'2026-09-07','Absent'),
(170,28,'2026-09-14','Late'),
(171,28,'2026-09-21','Present'),
(172,28,'2026-09-28','Present'),
(173,28,'2026-10-05','Present'),
(174,28,'2026-10-12','Present'),
(175,29,'2026-09-07','Late'),
(176,29,'2026-09-14','Present'),
(177,29,'2026-09-21','Present'),
(178,29,'2026-09-28','Present'),
(179,29,'2026-10-05','Present'),
(180,29,'2026-10-12','Present'),
(181,33,'2026-09-07','Late'),
(182,33,'2026-09-14','Present'),
(183,33,'2026-09-21','Present'),
(184,33,'2026-09-28','Leave'),
(185,33,'2026-10-05','Present'),
(186,33,'2026-10-12','Present'),
(187,31,'2026-09-07','Present'),
(188,31,'2026-09-14','Leave'),
(189,31,'2026-09-21','Present'),
(190,31,'2026-09-28','Present'),
(191,31,'2026-10-05','Present'),
(192,31,'2026-10-12','Present'),
(193,32,'2026-09-07','Present'),
(194,32,'2026-09-14','Present'),
(195,32,'2026-09-21','Late'),
(196,32,'2026-09-28','Present'),
(197,32,'2026-10-05','Present'),
(198,32,'2026-10-12','Leave');
/*!40000 ALTER TABLE `attendance` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `courses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `department_id` int(11) NOT NULL,
  `teacher_id` int(11) DEFAULT NULL,
  `code` varchar(10) NOT NULL,
  `title` varchar(120) NOT NULL,
  `credit_hours` tinyint(4) NOT NULL DEFAULT 3,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `department_id` (`department_id`),
  KEY `teacher_id` (`teacher_id`),
  CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
  CONSTRAINT `courses_ibfk_2` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`id`) ON DELETE SET NULL,
  CONSTRAINT `chk_course_credits` CHECK (`credit_hours` between 1 and 6)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES
(1,1,1,'SE-101','Programming Fundamentals',4),
(2,1,2,'SE-310','Web Technologies',4),
(3,2,3,'IT-205','Database Systems',4),
(4,2,4,'IT-220','Computer Networks',3),
(5,3,5,'DS-201','Statistics for Data Science',3),
(6,3,5,'DS-310','Machine Learning',3),
(7,4,6,'CS-101','Introduction to Computing',3),
(8,4,6,'CS-230','Data Structures',4);
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `code` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES
(1,'Software Engineering','SE'),
(2,'Information Technology','IT'),
(3,'Data Science','DS'),
(4,'Computer Science','CS');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `enrollments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `enrollments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `enrolled_on` date NOT NULL,
  `marks` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_student_course` (`student_id`,`course_id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `enrollments_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE,
  CONSTRAINT `enrollments_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `chk_marks` CHECK (`marks` is null or `marks` between 0 and 100)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `enrollments` WRITE;
/*!40000 ALTER TABLE `enrollments` DISABLE KEYS */;
INSERT INTO `enrollments` VALUES
(1,1,1,'2026-09-01',68.00),
(2,1,2,'2026-09-01',81.00),
(3,1,3,'2026-09-01',94.00),
(4,2,1,'2026-09-01',67.00),
(5,2,2,'2026-09-01',80.00),
(6,2,3,'2026-09-02',93.00),
(7,3,1,'2026-09-02',66.00),
(8,3,2,'2026-09-02',79.00),
(9,3,7,'2026-09-02',92.00),
(10,4,1,'2026-09-02',65.00),
(11,4,3,'2026-09-02',78.00),
(12,4,4,'2026-09-03',91.00),
(13,5,3,'2026-09-03',64.00),
(14,5,4,'2026-09-03',77.00),
(15,5,2,'2026-09-03',90.00),
(16,6,3,'2026-09-03',63.00),
(17,6,4,'2026-09-03',76.00),
(18,6,7,'2026-09-04',89.00),
(19,7,4,'2026-09-04',62.00),
(20,7,3,'2026-09-04',75.00),
(21,7,5,'2026-09-04',88.00),
(22,8,4,'2026-09-04',61.00),
(23,8,3,'2026-09-04',74.00),
(24,8,1,'2026-09-05',87.00),
(25,9,5,'2026-09-05',60.00),
(26,9,6,'2026-09-05',73.00),
(27,9,7,'2026-09-05',86.00),
(28,10,5,'2026-09-05',NULL),
(29,10,6,'2026-09-06',NULL),
(30,10,2,'2026-09-06',NULL),
(31,11,5,'2026-09-06',NULL),
(32,11,6,'2026-09-06',NULL),
(33,11,3,'2026-09-06',NULL);
/*!40000 ALTER TABLE `enrollments` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `department_id` int(11) NOT NULL,
  `name` varchar(120) NOT NULL,
  `email` varchar(150) NOT NULL,
  `roll_no` varchar(30) DEFAULT NULL,
  `semester` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `roll_no` (`roll_no`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `students_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
  CONSTRAINT `chk_student_semester` CHECK (`semester` between 1 and 8)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES
(1,1,'Ali Ahmed','ali.ahmed@student.usindh.edu.pk','2k24-SE-01',3,'2026-11-17 10:36:10'),
(2,1,'Hina Memon','hina.memon@student.usindh.edu.pk','2k24-SE-02',3,'2026-11-17 10:36:10'),
(3,1,'Usman Chandio','usman.chandio@student.usindh.edu.pk','2k24-SE-03',3,'2026-11-17 10:36:10'),
(4,1,'Maria Shaikh','maria.shaikh@student.usindh.edu.pk','2k24-SE-04',5,'2026-11-17 10:36:10'),
(5,2,'Sana Lashari','sana.lashari@student.usindh.edu.pk','2k24-IT-01',3,'2026-11-17 10:36:10'),
(6,2,'Bilal Mirani','bilal.mirani@student.usindh.edu.pk','2k24-IT-02',5,'2026-11-17 10:36:10'),
(7,2,'Zoya Khan','zoya.khan@student.usindh.edu.pk','2k24-IT-03',3,'2026-11-17 10:36:10'),
(8,2,'Danish Rajput','danish.rajput@student.usindh.edu.pk','2k24-IT-04',5,'2026-11-17 10:36:10'),
(9,3,'Areeba Siddiqui','areeba.siddiqui@student.usindh.edu.pk','2k24-DS-01',3,'2026-11-17 10:36:10'),
(10,3,'Faisal Abbasi','faisal.abbasi@student.usindh.edu.pk','2k24-DS-02',5,'2026-11-17 10:36:10'),
(11,3,'Noor Fatima','noor.fatima@student.usindh.edu.pk','2k24-DS-03',3,'2026-11-17 10:36:10'),
(12,4,'Imran Panhwar','imran.panhwar@student.usindh.edu.pk','2k24-CS-01',1,'2026-11-17 10:36:10');
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `teachers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `teachers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `department_id` int(11) NOT NULL,
  `name` varchar(120) NOT NULL,
  `email` varchar(150) NOT NULL,
  `designation` varchar(60) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `teachers_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `teachers` WRITE;
/*!40000 ALTER TABLE `teachers` DISABLE KEYS */;
INSERT INTO `teachers` VALUES
(1,1,'Dr. Sara Khan','sara.khan@usindh.edu.pk','Associate Professor'),
(2,1,'Mr. Rafique Bhutto','rafique.bhutto@usindh.edu.pk','Lecturer'),
(3,2,'Ms. Farah Soomro','farah.soomro@usindh.edu.pk','Assistant Professor'),
(4,2,'Dr. Zahid Jatoi','zahid.jatoi@usindh.edu.pk','Professor'),
(5,3,'Dr. Nida Qureshi','nida.qureshi@usindh.edu.pk','Associate Professor'),
(6,4,'Mr. Kamran Rind','kamran.rind@usindh.edu.pk','Lecturer');
/*!40000 ALTER TABLE `teachers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

