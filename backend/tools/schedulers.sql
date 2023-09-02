-- MySQL dump 10.19  Distrib 10.3.38-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: suite
-- ------------------------------------------------------
-- Server version	10.3.38-MariaDB-0ubuntu0.20.04.1

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

--
-- Table structure for table `schedulers`
--

DROP TABLE IF EXISTS `schedulers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedulers` (
  `id` varchar(36) NOT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `date_entered` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `created_by` char(36) DEFAULT NULL,
  `modified_user_id` char(36) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `date_time_start` datetime DEFAULT NULL,
  `date_time_end` datetime DEFAULT NULL,
  `job_interval` varchar(100) DEFAULT NULL,
  `time_from` time DEFAULT NULL,
  `time_to` time DEFAULT NULL,
  `last_run` datetime DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `catch_up` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `idx_schedule` (`date_time_start`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedulers`
--

LOCK TABLES `schedulers` WRITE;
/*!40000 ALTER TABLE `schedulers` DISABLE KEYS */;
INSERT INTO `schedulers` VALUES ('b5c74a15-f3eb-8b25-3538-64f298e949a1',0,'2023-09-02 02:06:22','2023-09-02 02:06:22','1','1','Process Workflow Tasks','function::processAOW_Workflow','2015-01-01 07:15:01',NULL,'*::*::*::*::*',NULL,NULL,NULL,'Active',1),('b64ba639-fff8-a8dc-7741-64f2982b37c2',0,'2023-09-02 02:06:22','2023-09-02 02:06:22','1','1','Run Report Generation Scheduled Tasks','function::aorRunScheduledReports','2015-01-01 14:30:01',NULL,'*::*::*::*::*',NULL,NULL,NULL,'Active',1),('b6aa0d06-f1f3-85a0-84dc-64f298587e34',0,'2023-09-02 02:06:22','2023-09-02 02:06:22','1','1','Prune Tracker Tables','function::trimTracker','2015-01-01 18:45:01',NULL,'0::2::1::*::*',NULL,NULL,NULL,'Active',1),('b7118c59-5b92-eb57-27d5-64f298ab30ae',0,'2023-09-02 02:06:22','2023-09-02 02:06:22','1','1','Check Inbound Mailboxes','function::pollMonitoredInboxesAOP','2015-01-01 07:15:01',NULL,'*::*::*::*::*',NULL,NULL,NULL,'Active',0),('b7a6569c-054f-0a8a-7d15-64f29881260d',0,'2023-09-02 02:06:22','2023-09-02 02:06:22','1','1','Run Nightly Process Bounced Campaign Emails','function::pollMonitoredInboxesForBouncedCampaignEmails','2015-01-01 11:30:01',NULL,'0::2-6::*::*::*',NULL,NULL,NULL,'Active',1),('b81dceef-3cc5-b37e-b95d-64f298bfb071',0,'2023-09-02 02:06:22','2023-09-02 02:06:22','1','1','Run Nightly Mass Email Campaigns','function::runMassEmailCampaign','2015-01-01 14:45:01',NULL,'0::2-6::*::*::*',NULL,NULL,NULL,'Active',1),('b86a00d9-56c1-2a2b-a7ab-64f298d67d12',0,'2023-09-02 02:06:22','2023-09-02 02:06:22','1','1','Prune Database on 1st of Month','function::pruneDatabase','2015-01-01 15:00:01',NULL,'0::4::1::*::*',NULL,NULL,NULL,'Inactive',0),('b8df8d9b-8af3-48ba-6e40-64f2982eab5c',0,'2023-09-02 02:06:22','2023-09-02 02:06:22','1','1','Run Email Reminder Notifications','function::sendEmailReminders','2015-01-01 11:45:01',NULL,'*::*::*::*::*',NULL,NULL,NULL,'Active',0),('b92aac2f-8f8e-82ea-b6ec-64f298ecb17e',0,'2023-09-02 02:06:22','2023-09-02 02:06:22','1','1','Clean Jobs Queue','function::cleanJobQueue','2015-01-01 16:00:01',NULL,'0::5::*::*::*',NULL,NULL,NULL,'Active',0),('b975fc9a-51ca-61f7-7917-64f298596cd3',0,'2023-09-02 02:06:22','2023-09-02 02:06:22','1','1','Removal of documents from filesystem','function::removeDocumentsFromFS','2015-01-01 14:30:01',NULL,'0::3::1::*::*',NULL,NULL,NULL,'Active',0),('b9e9765d-f8f0-7aaa-3597-64f298d33910',0,'2023-09-02 02:06:22','2023-09-02 02:06:22','1','1','Prune SuiteCRM Feed Tables','function::trimSugarFeeds','2015-01-01 16:45:01',NULL,'0::2::1::*::*',NULL,NULL,NULL,'Active',1),('ba375025-059f-7560-c0e6-64f298d29489',0,'2023-09-02 02:06:22','2023-09-02 02:06:22','1','1','Google Calendar Sync','function::syncGoogleCalendar','2015-01-01 08:00:01',NULL,'*/15::*::*::*::*',NULL,NULL,NULL,'Active',0);
/*!40000 ALTER TABLE `schedulers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-09-02  7:41:32
