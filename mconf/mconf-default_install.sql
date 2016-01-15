-- MySQL dump 10.13  Distrib 5.5.44, for debian-linux-gnu (x86_64)
--
-- Host: mariadb    Database: mconf
-- ------------------------------------------------------
-- Server version	5.5.41-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `mconf`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `mconf` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;

USE `mconf`;

--
-- Table structure for table `activities`
--

DROP TABLE IF EXISTS `activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trackable_id` int(11) DEFAULT NULL,
  `trackable_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `owner_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `key` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parameters` text COLLATE utf8_unicode_ci,
  `recipient_id` int(11) DEFAULT NULL,
  `recipient_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `notified` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_activities_on_owner_id_and_owner_type` (`owner_id`,`owner_type`) USING BTREE,
  KEY `index_activities_on_recipient_id_and_recipient_type` (`recipient_id`,`recipient_type`) USING BTREE,
  KEY `index_activities_on_trackable_id_and_trackable_type` (`trackable_id`,`trackable_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activities`
--

LOCK TABLES `activities` WRITE;
/*!40000 ALTER TABLE `activities` DISABLE KEYS */;
INSERT INTO `activities` VALUES (1,1,'User',1,'User','user.created','--- {}\n',NULL,NULL,'2015-08-26 03:34:48','2015-08-26 03:34:48',1);
/*!40000 ALTER TABLE `activities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attachments`
--

DROP TABLE IF EXISTS `attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attachments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `space_id` int(11) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  `author_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `attachment` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attachments`
--

LOCK TABLES `attachments` WRITE;
/*!40000 ALTER TABLE `attachments` DISABLE KEYS */;
/*!40000 ALTER TABLE `attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bigbluebutton_meetings`
--

DROP TABLE IF EXISTS `bigbluebutton_meetings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bigbluebutton_meetings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server_id` int(11) DEFAULT NULL,
  `room_id` int(11) DEFAULT NULL,
  `meetingid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `running` tinyint(1) DEFAULT '0',
  `recorded` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `creator_id` int(11) DEFAULT NULL,
  `creator_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_bigbluebutton_meetings_on_meetingid_and_start_time` (`meetingid`,`start_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bigbluebutton_meetings`
--

LOCK TABLES `bigbluebutton_meetings` WRITE;
/*!40000 ALTER TABLE `bigbluebutton_meetings` DISABLE KEYS */;
/*!40000 ALTER TABLE `bigbluebutton_meetings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bigbluebutton_metadata`
--

DROP TABLE IF EXISTS `bigbluebutton_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bigbluebutton_metadata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) DEFAULT NULL,
  `owner_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bigbluebutton_metadata`
--

LOCK TABLES `bigbluebutton_metadata` WRITE;
/*!40000 ALTER TABLE `bigbluebutton_metadata` DISABLE KEYS */;
/*!40000 ALTER TABLE `bigbluebutton_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bigbluebutton_playback_formats`
--

DROP TABLE IF EXISTS `bigbluebutton_playback_formats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bigbluebutton_playback_formats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recording_id` int(11) DEFAULT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `length` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `playback_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bigbluebutton_playback_formats`
--

LOCK TABLES `bigbluebutton_playback_formats` WRITE;
/*!40000 ALTER TABLE `bigbluebutton_playback_formats` DISABLE KEYS */;
/*!40000 ALTER TABLE `bigbluebutton_playback_formats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bigbluebutton_playback_types`
--

DROP TABLE IF EXISTS `bigbluebutton_playback_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bigbluebutton_playback_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `visible` tinyint(1) DEFAULT '0',
  `default` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bigbluebutton_playback_types`
--

LOCK TABLES `bigbluebutton_playback_types` WRITE;
/*!40000 ALTER TABLE `bigbluebutton_playback_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `bigbluebutton_playback_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bigbluebutton_recordings`
--

DROP TABLE IF EXISTS `bigbluebutton_recordings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bigbluebutton_recordings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server_id` int(11) DEFAULT NULL,
  `room_id` int(11) DEFAULT NULL,
  `recordid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `meetingid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `published` tinyint(1) DEFAULT '0',
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `available` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `meeting_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_bigbluebutton_recordings_on_recordid` (`recordid`) USING BTREE,
  KEY `index_bigbluebutton_recordings_on_room_id` (`room_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bigbluebutton_recordings`
--

LOCK TABLES `bigbluebutton_recordings` WRITE;
/*!40000 ALTER TABLE `bigbluebutton_recordings` DISABLE KEYS */;
/*!40000 ALTER TABLE `bigbluebutton_recordings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bigbluebutton_room_options`
--

DROP TABLE IF EXISTS `bigbluebutton_room_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bigbluebutton_room_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `room_id` int(11) DEFAULT NULL,
  `default_layout` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `presenter_share_only` tinyint(1) DEFAULT NULL,
  `auto_start_video` tinyint(1) DEFAULT NULL,
  `auto_start_audio` tinyint(1) DEFAULT NULL,
  `background` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_bigbluebutton_room_options_on_room_id` (`room_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bigbluebutton_room_options`
--

LOCK TABLES `bigbluebutton_room_options` WRITE;
/*!40000 ALTER TABLE `bigbluebutton_room_options` DISABLE KEYS */;
INSERT INTO `bigbluebutton_room_options` VALUES (1,1,NULL,'2015-08-26 03:34:47','2015-08-26 03:34:47',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `bigbluebutton_room_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bigbluebutton_rooms`
--

DROP TABLE IF EXISTS `bigbluebutton_rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bigbluebutton_rooms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server_id` int(11) DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `owner_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `meetingid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `attendee_key` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `moderator_key` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `welcome_msg` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `logout_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `voice_bridge` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dial_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `max_participants` int(11) DEFAULT NULL,
  `private` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `external` tinyint(1) DEFAULT '0',
  `param` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `record_meeting` tinyint(1) DEFAULT '0',
  `duration` int(11) DEFAULT '0',
  `moderator_api_password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `attendee_api_password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `create_time` decimal(14,0) DEFAULT NULL,
  `moderator_only_message` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `auto_start_recording` tinyint(1) DEFAULT '0',
  `allow_start_stop_recording` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_bigbluebutton_rooms_on_meetingid` (`meetingid`) USING BTREE,
  KEY `index_bigbluebutton_rooms_on_server_id` (`server_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bigbluebutton_rooms`
--

LOCK TABLES `bigbluebutton_rooms` WRITE;
/*!40000 ALTER TABLE `bigbluebutton_rooms` DISABLE KEYS */;
INSERT INTO `bigbluebutton_rooms` VALUES (1,1,1,'User','3ede5de7-9ecd-4ef9-a75c-9f4d35f75919-1440560087','root','71c119b7','47e36cf4',NULL,'/feedback/webconf/',NULL,NULL,NULL,0,'2015-08-26 03:34:47','2015-08-26 03:34:47',0,'root',0,0,NULL,NULL,NULL,NULL,0,1);
/*!40000 ALTER TABLE `bigbluebutton_rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bigbluebutton_server_configs`
--

DROP TABLE IF EXISTS `bigbluebutton_server_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bigbluebutton_server_configs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server_id` int(11) DEFAULT NULL,
  `available_layouts` text COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bigbluebutton_server_configs`
--

LOCK TABLES `bigbluebutton_server_configs` WRITE;
/*!40000 ALTER TABLE `bigbluebutton_server_configs` DISABLE KEYS */;
INSERT INTO `bigbluebutton_server_configs` VALUES (1,1,'--- []\n','2015-08-26 03:34:46','2015-08-26 03:34:46');
/*!40000 ALTER TABLE `bigbluebutton_server_configs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bigbluebutton_servers`
--

DROP TABLE IF EXISTS `bigbluebutton_servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bigbluebutton_servers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `salt` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `version` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `param` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bigbluebutton_servers`
--

LOCK TABLES `bigbluebutton_servers` WRITE;
/*!40000 ALTER TABLE `bigbluebutton_servers` DISABLE KEYS */;
INSERT INTO `bigbluebutton_servers` VALUES (1,'Apukay bbb','http://meet.apukay.com/bigbluebutton/api','3d167370cc92657580ab7ccd632846b3','0.8','2015-08-26 03:34:46','2015-08-26 03:34:46','apukay-bbb');
/*!40000 ALTER TABLE `bigbluebutton_servers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `db_files`
--

DROP TABLE IF EXISTS `db_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `db_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data` blob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `db_files`
--

LOCK TABLES `db_files` WRITE;
/*!40000 ALTER TABLE `db_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `db_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invitations`
--

DROP TABLE IF EXISTS `invitations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invitations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `target_id` int(11) DEFAULT NULL,
  `target_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sender_id` int(11) DEFAULT NULL,
  `recipient_id` int(11) DEFAULT NULL,
  `recipient_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `starts_on` datetime DEFAULT NULL,
  `ends_on` datetime DEFAULT NULL,
  `ready` tinyint(1) DEFAULT '0',
  `sent` tinyint(1) DEFAULT '0',
  `result` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_invitations_on_target_id_and_target_type` (`target_id`,`target_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invitations`
--

LOCK TABLES `invitations` WRITE;
/*!40000 ALTER TABLE `invitations` DISABLE KEYS */;
/*!40000 ALTER TABLE `invitations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `join_requests`
--

DROP TABLE IF EXISTS `join_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `join_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `request_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `candidate_id` int(11) DEFAULT NULL,
  `introducer_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `group_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comment` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `accepted` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `processed_at` datetime DEFAULT NULL,
  `secret_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `join_requests`
--

LOCK TABLES `join_requests` WRITE;
/*!40000 ALTER TABLE `join_requests` DISABLE KEYS */;
/*!40000 ALTER TABLE `join_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ldap_tokens`
--

DROP TABLE IF EXISTS `ldap_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ldap_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `identifier` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_ldap_tokens_on_identifier` (`identifier`) USING BTREE,
  UNIQUE KEY `index_ldap_tokens_on_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ldap_tokens`
--

LOCK TABLES `ldap_tokens` WRITE;
/*!40000 ALTER TABLE `ldap_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `ldap_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mweb_events_events`
--

DROP TABLE IF EXISTS `mweb_events_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mweb_events_events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `summary` text COLLATE utf8_unicode_ci,
  `description` text COLLATE utf8_unicode_ci,
  `social_networks` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL,
  `owner_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `start_on` datetime DEFAULT NULL,
  `end_on` datetime DEFAULT NULL,
  `time_zone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `location` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `latitude` float DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  `permalink` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mweb_events_events_on_permalink` (`permalink`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mweb_events_events`
--

LOCK TABLES `mweb_events_events` WRITE;
/*!40000 ALTER TABLE `mweb_events_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `mweb_events_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mweb_events_participants`
--

DROP TABLE IF EXISTS `mweb_events_participants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mweb_events_participants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_id` int(11) DEFAULT NULL,
  `owner_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mweb_events_participants`
--

LOCK TABLES `mweb_events_participants` WRITE;
/*!40000 ALTER TABLE `mweb_events_participants` DISABLE KEYS */;
/*!40000 ALTER TABLE `mweb_events_participants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `text` text COLLATE utf8_unicode_ci,
  `space_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `participant_confirmations`
--

DROP TABLE IF EXISTS `participant_confirmations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `participant_confirmations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `participant_id` int(11) DEFAULT NULL,
  `confirmed_at` datetime DEFAULT NULL,
  `email_sent_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `participant_confirmations`
--

LOCK TABLES `participant_confirmations` WRITE;
/*!40000 ALTER TABLE `participant_confirmations` DISABLE KEYS */;
/*!40000 ALTER TABLE `participant_confirmations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `subject_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `role_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `text` text COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `reader_id` int(11) DEFAULT NULL,
  `space_id` int(11) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  `author_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `spam` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `private_messages`
--

DROP TABLE IF EXISTS `private_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `private_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender_id` int(11) DEFAULT NULL,
  `receiver_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `checked` tinyint(1) DEFAULT '0',
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `body` text COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_by_sender` tinyint(1) DEFAULT '0',
  `deleted_by_receiver` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `private_messages`
--

LOCK TABLES `private_messages` WRITE;
/*!40000 ALTER TABLE `private_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `private_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `organization` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fax` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zipcode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `province` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `prefix_key` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `description` text COLLATE utf8_unicode_ci,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `skype` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `im` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `visibility` int(11) DEFAULT '3',
  `full_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `logo_image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'',NULL,NULL,NULL,NULL,3,'root',NULL);
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `stage_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'User','Space'),(2,'Admin','Space'),(3,'Organizer','Event');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20090305140444'),('20090309113706'),('20090402133107'),('20090402141642'),('20090402154157'),('20090416104907'),('20090416135111'),('20090416140004'),('20090427101837'),('20090429105941'),('20090504144534'),('20090505144250'),('20090512110825'),('20090519094830'),('20090522150628'),('20090525142641'),('20090608105538'),('20090608143621'),('20090618085839'),('20090623101807'),('20090629152925'),('20090701105648'),('20090708181322'),('20090722102029'),('20090727091922'),('20090727104340'),('20090901112210'),('20090925174917'),('20091001111031'),('20091001134150'),('20091001134813'),('20091006141622'),('20091008131943'),('20091019113449'),('20091020015821'),('20091021153622'),('20091023213252'),('20091027160546'),('20091106085530'),('20091106104127'),('20091119151350'),('20091211135100'),('20091214104211'),('20100125144221'),('20100127110641'),('20100202091108'),('20100202112750'),('20100218144143'),('20100222144439'),('20100302134824'),('20100302150008'),('20100304121052'),('20100308104837'),('20100310150954'),('20100322180714'),('20100323113745'),('20100325095249'),('20100331091006'),('20100405132757'),('20100406081706'),('20100412112747'),('20100413075244'),('20100413110941'),('20100413130833'),('20100420152458'),('20100506103259'),('20100511141600'),('20100629123109'),('20100701125920'),('20100706080216'),('20100707140054'),('20100907080025'),('20100909080633'),('20100915102538'),('20100915144144'),('20100928121448'),('20101004113049'),('20101006103957'),('20101025140018'),('20101026103130'),('20101209161231'),('20101216141312'),('20110112120412'),('20110301144421'),('20110429184108'),('20110621154932'),('20110806233417'),('20110807143331'),('20110809195820'),('20110823180512'),('20110823181209'),('20111007150543'),('20111012041449'),('20111020165849'),('20111020174404'),('20120108030937'),('20120119155353'),('20120513055623'),('20120515001030'),('20120608080929'),('20120611114706'),('20120626180633'),('20120713195223'),('20120716185932'),('20120717183338'),('20120729031436'),('20120812235634'),('20120819013956'),('20120819022001'),('20120826215828'),('20120826223452'),('20120827011123'),('20120921002223'),('20121129143245'),('20121129160346'),('20130201132453'),('20130226215041'),('20130411020409'),('20130425154344'),('20130425154361'),('20130717195517'),('20130808192713'),('20130820174910'),('20130822174336'),('20130822175748'),('20130823182640'),('20130824002328'),('20130824014312'),('20130826135339'),('20130826174837'),('20130826185010'),('20130903171815'),('20130903173529'),('20131003192202'),('20131004124842'),('20131004125114'),('20131004150321'),('20131019000553'),('20131029184414'),('20131105183635'),('20131105194122'),('20131109002834'),('20131109180956'),('20131129175408'),('20140120160728'),('20140120194240'),('20140120194241'),('20140120194242'),('20140120194243'),('20140120194244'),('20140120194245'),('20140120194246'),('20140122135850'),('20140201192634'),('20140224191628'),('20140310170206'),('20140407192519'),('20140411200714'),('20140417185711'),('20140418185712'),('20140505162835'),('20140515205727'),('20140515205815'),('20140522155133'),('20140527173230'),('20140601190024'),('20140608203446'),('20140701194425'),('20140709161857'),('20140711164912'),('20140716180735'),('20140717053418'),('20140721131823'),('20140721191825'),('20140808173155'),('20140820214500'),('20140831235219'),('20141020195737'),('20141105192836'),('20141106162236'),('20141117164353'),('20141117182436'),('20141210192333'),('20141218130638'),('20141218184717'),('20150113164404'),('20150130190018'),('20150225170306'),('20150226192217'),('20150309160007'),('20150318203041'),('20150318204721'),('20150416210956'),('20150417192747'),('20150707182132'),('20150729141849'),('20150812180000'),('20150812180001'),('20150813144638');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shib_tokens`
--

DROP TABLE IF EXISTS `shib_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shib_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `identifier` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `new_account` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_shib_tokens_on_identifier` (`identifier`) USING BTREE,
  UNIQUE KEY `index_shib_tokens_on_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shib_tokens`
--

LOCK TABLES `shib_tokens` WRITE;
/*!40000 ALTER TABLE `shib_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `shib_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `domain` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `smtp_login` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `locale` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `ssl` tinyint(1) DEFAULT '0',
  `exception_notifications` tinyint(1) DEFAULT '0',
  `exception_notifications_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `signature` text COLLATE utf8_unicode_ci,
  `presence_domain` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `feedback_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shib_enabled` tinyint(1) DEFAULT '0',
  `shib_name_field` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shib_email_field` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `exception_notifications_prefix` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `smtp_password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `analytics_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `smtp_auto_tls` tinyint(1) DEFAULT NULL,
  `smtp_server` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `smtp_port` int(11) DEFAULT NULL,
  `smtp_use_tls` tinyint(1) DEFAULT NULL,
  `smtp_domain` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `smtp_auth_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `smtp_sender` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `chat_enabled` tinyint(1) DEFAULT '0',
  `xmpp_server` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shib_env_variables` text COLLATE utf8_unicode_ci,
  `shib_login_field` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `timezone` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'UTC',
  `external_help` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `webconf_auto_record` tinyint(1) DEFAULT '0',
  `ldap_enabled` tinyint(1) DEFAULT NULL,
  `ldap_host` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ldap_port` int(11) DEFAULT NULL,
  `ldap_user` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ldap_user_password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ldap_user_treebase` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ldap_username_field` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ldap_email_field` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ldap_name_field` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `require_registration_approval` tinyint(1) NOT NULL DEFAULT '0',
  `events_enabled` tinyint(1) DEFAULT '0',
  `registration_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `shib_principal_name_field` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ldap_filter` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shib_always_new_account` tinyint(1) DEFAULT '0',
  `local_auth_enabled` tinyint(1) DEFAULT '1',
  `visible_locales` varchar(255) COLLATE utf8_unicode_ci DEFAULT '---\n- en\n- pt-br\n',
  `room_dial_number_pattern` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shib_update_users` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
INSERT INTO `sites` VALUES (1,'Plataforma de Videoconferencias - Apukay','Mconf Website','mconf.apukay.com',NULL,'es-419','2015-08-26 03:34:46','2015-08-26 03:34:46',0,0,NULL,'Mconf',NULL,'',0,NULL,NULL,NULL,NULL,'',0,'postfix',25,0,'example.com','none','noreply@example.com',0,NULL,NULL,NULL,'UTC',NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,1,NULL,NULL,0,1,'---\n- en\n- pt-br\n',NULL,0);
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spaces`
--

DROP TABLE IF EXISTS `spaces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spaces` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  `public` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `permalink` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `disabled` tinyint(1) DEFAULT '0',
  `repository` tinyint(1) DEFAULT '0',
  `logo_image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spaces`
--

LOCK TABLES `spaces` WRITE;
/*!40000 ALTER TABLE `spaces` DISABLE KEYS */;
/*!40000 ALTER TABLE `spaces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `password_salt` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `superuser` tinyint(1) DEFAULT '0',
  `disabled` tinyint(1) DEFAULT '0',
  `confirmed_at` datetime DEFAULT NULL,
  `timezone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `expanded_post` tinyint(1) DEFAULT '0',
  `locale` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `receive_digest` int(11) DEFAULT '0',
  `reset_password_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `confirmation_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `confirmation_sent_at` datetime DEFAULT NULL,
  `unconfirmed_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `can_record` tinyint(1) DEFAULT NULL,
  `approved` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`) USING BTREE,
  UNIQUE KEY `index_users_on_confirmation_token` (`confirmation_token`) USING BTREE,
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'root','admin@apukay.com','a5ea5296f16fa4297a0364cd1fe30bd27085f5b6','xzxYfB57GUg_X2pUKPyz','2015-08-26 03:34:47','2015-08-26 03:34:47',1,0,'2015-08-26 03:34:47',NULL,0,NULL,0,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,'5463fc9ec5a3d14dc0dc5a013e5766760c5cf682b1bf5b25e39cc793527d60ca','2015-08-26 03:34:47','admin@apukay.com',NULL,1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-08-26  3:42:11
