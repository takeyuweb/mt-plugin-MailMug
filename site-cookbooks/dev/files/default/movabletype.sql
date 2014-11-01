-- MySQL dump 10.13  Distrib 5.1.73, for redhat-linux-gnu (x86_64)
--
-- Host: localhost    Database: movabletype
-- ------------------------------------------------------
-- Server version	5.1.73

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
-- Table structure for table `mt_accesstoken`
--

DROP TABLE IF EXISTS `mt_accesstoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_accesstoken` (
  `accesstoken_id` varchar(80) NOT NULL,
  `accesstoken_session_id` varchar(80) NOT NULL,
  `accesstoken_start` int(11) NOT NULL,
  PRIMARY KEY (`accesstoken_id`),
  KEY `mt_accesstoken_session_id` (`accesstoken_session_id`),
  KEY `mt_accesstoken_start` (`accesstoken_start`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_accesstoken`
--

LOCK TABLES `mt_accesstoken` WRITE;
/*!40000 ALTER TABLE `mt_accesstoken` DISABLE KEYS */;
/*!40000 ALTER TABLE `mt_accesstoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_asset`
--

DROP TABLE IF EXISTS `mt_asset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_asset` (
  `asset_id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_blog_id` int(11) NOT NULL,
  `asset_class` varchar(255) DEFAULT 'file',
  `asset_created_by` int(11) DEFAULT NULL,
  `asset_created_on` datetime DEFAULT NULL,
  `asset_description` mediumtext,
  `asset_file_ext` varchar(20) DEFAULT NULL,
  `asset_file_name` varchar(255) DEFAULT NULL,
  `asset_file_path` varchar(255) DEFAULT NULL,
  `asset_label` varchar(255) DEFAULT NULL,
  `asset_mime_type` varchar(255) DEFAULT NULL,
  `asset_modified_by` int(11) DEFAULT NULL,
  `asset_modified_on` datetime DEFAULT NULL,
  `asset_parent` int(11) DEFAULT NULL,
  `asset_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`asset_id`),
  KEY `mt_asset_blog_class_date` (`asset_blog_id`,`asset_class`,`asset_created_on`),
  KEY `mt_asset_parent` (`asset_parent`),
  KEY `mt_asset_file_ext` (`asset_file_ext`),
  KEY `mt_asset_created_on` (`asset_created_on`),
  KEY `mt_asset_class` (`asset_class`),
  KEY `mt_asset_label` (`asset_label`),
  KEY `mt_asset_created_by` (`asset_created_by`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_asset`
--

LOCK TABLES `mt_asset` WRITE;
/*!40000 ALTER TABLE `mt_asset` DISABLE KEYS */;
/*!40000 ALTER TABLE `mt_asset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_asset_meta`
--

DROP TABLE IF EXISTS `mt_asset_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_asset_meta` (
  `asset_meta_asset_id` int(11) NOT NULL,
  `asset_meta_type` varchar(75) NOT NULL,
  `asset_meta_vchar` varchar(255) DEFAULT NULL,
  `asset_meta_vchar_idx` varchar(255) DEFAULT NULL,
  `asset_meta_vdatetime` datetime DEFAULT NULL,
  `asset_meta_vdatetime_idx` datetime DEFAULT NULL,
  `asset_meta_vinteger` int(11) DEFAULT NULL,
  `asset_meta_vinteger_idx` int(11) DEFAULT NULL,
  `asset_meta_vfloat` float DEFAULT NULL,
  `asset_meta_vfloat_idx` float DEFAULT NULL,
  `asset_meta_vblob` mediumblob,
  `asset_meta_vclob` mediumtext,
  PRIMARY KEY (`asset_meta_asset_id`,`asset_meta_type`),
  KEY `mt_asset_meta_type_vint` (`asset_meta_type`,`asset_meta_vinteger_idx`),
  KEY `mt_asset_meta_type_vflt` (`asset_meta_type`,`asset_meta_vfloat_idx`),
  KEY `mt_asset_meta_type_vdt` (`asset_meta_type`,`asset_meta_vdatetime_idx`),
  KEY `mt_asset_meta_type_vchar` (`asset_meta_type`,`asset_meta_vchar_idx`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_asset_meta`
--

LOCK TABLES `mt_asset_meta` WRITE;
/*!40000 ALTER TABLE `mt_asset_meta` DISABLE KEYS */;
/*!40000 ALTER TABLE `mt_asset_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_association`
--

DROP TABLE IF EXISTS `mt_association`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_association` (
  `association_id` int(11) NOT NULL AUTO_INCREMENT,
  `association_author_id` int(11) DEFAULT '0',
  `association_blog_id` int(11) DEFAULT '0',
  `association_created_by` int(11) DEFAULT NULL,
  `association_created_on` datetime DEFAULT NULL,
  `association_group_id` int(11) DEFAULT '0',
  `association_modified_by` int(11) DEFAULT NULL,
  `association_modified_on` datetime DEFAULT NULL,
  `association_role_id` int(11) DEFAULT '0',
  `association_type` int(11) NOT NULL,
  PRIMARY KEY (`association_id`),
  KEY `mt_association_author_id` (`association_author_id`),
  KEY `mt_association_group_id` (`association_group_id`),
  KEY `mt_association_created_on` (`association_created_on`),
  KEY `mt_association_type` (`association_type`),
  KEY `mt_association_blog_id` (`association_blog_id`),
  KEY `mt_association_role_id` (`association_role_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_association`
--

LOCK TABLES `mt_association` WRITE;
/*!40000 ALTER TABLE `mt_association` DISABLE KEYS */;
INSERT INTO `mt_association` VALUES (1,1,1,1,'2014-11-02 00:12:59',0,NULL,'2014-11-02 00:12:59',1,1);
/*!40000 ALTER TABLE `mt_association` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_author`
--

DROP TABLE IF EXISTS `mt_author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_author` (
  `author_id` int(11) NOT NULL AUTO_INCREMENT,
  `author_api_password` varchar(60) DEFAULT NULL,
  `author_auth_type` varchar(50) DEFAULT NULL,
  `author_basename` varchar(255) DEFAULT NULL,
  `author_can_create_blog` tinyint(4) DEFAULT NULL,
  `author_can_view_log` tinyint(4) DEFAULT NULL,
  `author_created_by` int(11) DEFAULT NULL,
  `author_created_on` datetime DEFAULT NULL,
  `author_date_format` varchar(30) DEFAULT 'relative',
  `author_email` varchar(127) DEFAULT NULL,
  `author_entry_prefs` varchar(255) DEFAULT NULL,
  `author_external_id` varchar(255) DEFAULT NULL,
  `author_hint` varchar(75) DEFAULT NULL,
  `author_is_superuser` tinyint(4) DEFAULT NULL,
  `author_locked_out_time` int(11) NOT NULL DEFAULT '0',
  `author_modified_by` int(11) DEFAULT NULL,
  `author_modified_on` datetime DEFAULT NULL,
  `author_name` varchar(255) NOT NULL,
  `author_nickname` varchar(255) DEFAULT NULL,
  `author_password` varchar(124) NOT NULL,
  `author_preferred_language` varchar(50) DEFAULT NULL,
  `author_public_key` mediumtext,
  `author_remote_auth_token` varchar(50) DEFAULT NULL,
  `author_remote_auth_username` varchar(50) DEFAULT NULL,
  `author_status` int(11) DEFAULT '1',
  `author_text_format` varchar(30) DEFAULT NULL,
  `author_type` smallint(6) NOT NULL DEFAULT '1',
  `author_url` varchar(255) DEFAULT NULL,
  `author_userpic_asset_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`author_id`),
  KEY `mt_author_auth_type_name` (`author_auth_type`,`author_name`,`author_type`),
  KEY `mt_author_locked_out_time` (`author_locked_out_time`),
  KEY `mt_author_status` (`author_status`),
  KEY `mt_author_name` (`author_name`),
  KEY `mt_author_basename` (`author_basename`),
  KEY `mt_author_email` (`author_email`),
  KEY `mt_author_external_id` (`author_external_id`),
  KEY `mt_author_created_on` (`author_created_on`),
  KEY `mt_author_type` (`author_type`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_author`
--

LOCK TABLES `mt_author` WRITE;
/*!40000 ALTER TABLE `mt_author` DISABLE KEYS */;
INSERT INTO `mt_author` VALUES (1,'rat5tkhm','MT','admin',NULL,NULL,1,'2014-11-02 00:12:58','relative','admin@localhost.localdomain',NULL,'',NULL,NULL,0,NULL,'2014-11-02 00:12:58','admin','admin','$6$NtYaTojMigWSzPNd$4EB3rEBttvEdlhHKk0VOtlCs5FgMCLSEtpUOr4piW+HLbvW+CYmVtrN00/JvGpDEQbc/UInYMSC49yKPCMAffQ','ja',NULL,NULL,NULL,1,NULL,1,NULL,NULL);
/*!40000 ALTER TABLE `mt_author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_author_meta`
--

DROP TABLE IF EXISTS `mt_author_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_author_meta` (
  `author_meta_author_id` int(11) NOT NULL,
  `author_meta_type` varchar(75) NOT NULL,
  `author_meta_vchar` varchar(255) DEFAULT NULL,
  `author_meta_vchar_idx` varchar(255) DEFAULT NULL,
  `author_meta_vdatetime` datetime DEFAULT NULL,
  `author_meta_vdatetime_idx` datetime DEFAULT NULL,
  `author_meta_vinteger` int(11) DEFAULT NULL,
  `author_meta_vinteger_idx` int(11) DEFAULT NULL,
  `author_meta_vfloat` float DEFAULT NULL,
  `author_meta_vfloat_idx` float DEFAULT NULL,
  `author_meta_vblob` mediumblob,
  `author_meta_vclob` mediumtext,
  PRIMARY KEY (`author_meta_author_id`,`author_meta_type`),
  KEY `mt_author_meta_type_vint` (`author_meta_type`,`author_meta_vinteger_idx`),
  KEY `mt_author_meta_type_vflt` (`author_meta_type`,`author_meta_vfloat_idx`),
  KEY `mt_author_meta_type_vdt` (`author_meta_type`,`author_meta_vdatetime_idx`),
  KEY `mt_author_meta_type_vchar` (`author_meta_type`,`author_meta_vchar_idx`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_author_meta`
--

LOCK TABLES `mt_author_meta` WRITE;
/*!40000 ALTER TABLE `mt_author_meta` DISABLE KEYS */;
INSERT INTO `mt_author_meta` VALUES (1,'widgets',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'BIN:SERG\0\0\0\0\0\0\0H\0\0\0\0\0\0dashboard:user:1H\0\0\0\0\0\0favorite_blogsH\0\0\0\0\0\0order-\0\0\0300\0\0\0paramH\0\0\0\0\0\0tab-\0\0\0website\0\0\0set-\0\0\0main\0\0\0personal_statsH\0\0\0\0\0\0order-\0\0\0400\0\0\0set-\0\0\0sidebar\0\0\0notification_dashboardH\0\0\0\0\0\0order-\0\0\0100\0\0\0set-\0\0\0main\0\0\0mt_newsH\0\0\0\0\0\0order-\0\0\0500\0\0\0set-\0\0\0sidebar\0\0\0\nsite_statsH\0\0\0\0\0\0order-\0\0\0200\0\0\0set-\0\0\0main',NULL);
/*!40000 ALTER TABLE `mt_author_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_author_summary`
--

DROP TABLE IF EXISTS `mt_author_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_author_summary` (
  `author_summary_author_id` int(11) NOT NULL,
  `author_summary_type` varchar(75) NOT NULL,
  `author_summary_class` varchar(75) NOT NULL,
  `author_summary_vchar_idx` varchar(255) DEFAULT NULL,
  `author_summary_vinteger_idx` int(11) DEFAULT NULL,
  `author_summary_vblob` mediumblob,
  `author_summary_vclob` mediumtext,
  `author_summary_expired` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`author_summary_author_id`,`author_summary_type`),
  KEY `mt_author_summary_class_vint` (`author_summary_class`,`author_summary_vinteger_idx`),
  KEY `mt_author_summary_id_class` (`author_summary_author_id`,`author_summary_class`),
  KEY `mt_author_summary_class_vchar` (`author_summary_class`,`author_summary_vchar_idx`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_author_summary`
--

LOCK TABLES `mt_author_summary` WRITE;
/*!40000 ALTER TABLE `mt_author_summary` DISABLE KEYS */;
/*!40000 ALTER TABLE `mt_author_summary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_blog`
--

DROP TABLE IF EXISTS `mt_blog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_blog` (
  `blog_id` int(11) NOT NULL AUTO_INCREMENT,
  `blog_allow_anon_comments` tinyint(4) DEFAULT NULL,
  `blog_allow_comment_html` tinyint(4) DEFAULT NULL,
  `blog_allow_commenter_regist` tinyint(4) DEFAULT NULL,
  `blog_allow_comments_default` tinyint(4) DEFAULT NULL,
  `blog_allow_pings` tinyint(4) DEFAULT NULL,
  `blog_allow_pings_default` tinyint(4) DEFAULT NULL,
  `blog_allow_reg_comments` tinyint(4) DEFAULT NULL,
  `blog_allow_unreg_comments` tinyint(4) DEFAULT NULL,
  `blog_archive_path` varchar(255) DEFAULT NULL,
  `blog_archive_tmpl_category` varchar(255) DEFAULT NULL,
  `blog_archive_tmpl_daily` varchar(255) DEFAULT NULL,
  `blog_archive_tmpl_individual` varchar(255) DEFAULT NULL,
  `blog_archive_tmpl_monthly` varchar(255) DEFAULT NULL,
  `blog_archive_tmpl_weekly` varchar(255) DEFAULT NULL,
  `blog_archive_type` varchar(255) DEFAULT NULL,
  `blog_archive_type_preferred` varchar(25) DEFAULT NULL,
  `blog_archive_url` varchar(255) DEFAULT NULL,
  `blog_autodiscover_links` tinyint(4) DEFAULT NULL,
  `blog_autolink_urls` tinyint(4) DEFAULT NULL,
  `blog_basename_limit` smallint(6) DEFAULT NULL,
  `blog_cc_license` varchar(255) DEFAULT NULL,
  `blog_children_modified_on` datetime DEFAULT NULL,
  `blog_class` varchar(255) DEFAULT 'blog',
  `blog_content_css` varchar(255) DEFAULT NULL,
  `blog_convert_paras` varchar(30) DEFAULT NULL,
  `blog_convert_paras_comments` varchar(30) DEFAULT NULL,
  `blog_created_by` int(11) DEFAULT NULL,
  `blog_created_on` datetime DEFAULT NULL,
  `blog_custom_dynamic_templates` varchar(25) DEFAULT 'none',
  `blog_date_language` varchar(5) DEFAULT NULL,
  `blog_days_on_index` int(11) DEFAULT NULL,
  `blog_description` mediumtext,
  `blog_email_new_comments` tinyint(4) DEFAULT NULL,
  `blog_email_new_pings` tinyint(4) DEFAULT NULL,
  `blog_entries_on_index` int(11) DEFAULT NULL,
  `blog_file_extension` varchar(10) DEFAULT NULL,
  `blog_google_api_key` varchar(32) DEFAULT NULL,
  `blog_internal_autodiscovery` tinyint(4) DEFAULT NULL,
  `blog_is_dynamic` tinyint(4) DEFAULT NULL,
  `blog_junk_folder_expiry` int(11) DEFAULT NULL,
  `blog_junk_score_threshold` float DEFAULT NULL,
  `blog_language` varchar(5) DEFAULT NULL,
  `blog_manual_approve_commenters` tinyint(4) DEFAULT NULL,
  `blog_moderate_pings` tinyint(4) DEFAULT NULL,
  `blog_moderate_unreg_comments` tinyint(4) DEFAULT NULL,
  `blog_modified_by` int(11) DEFAULT NULL,
  `blog_modified_on` datetime DEFAULT NULL,
  `blog_mt_update_key` varchar(30) DEFAULT NULL,
  `blog_name` varchar(255) NOT NULL,
  `blog_old_style_archive_links` tinyint(4) DEFAULT NULL,
  `blog_parent_id` int(11) DEFAULT NULL,
  `blog_ping_blogs` tinyint(4) DEFAULT NULL,
  `blog_ping_google` tinyint(4) DEFAULT NULL,
  `blog_ping_others` mediumtext,
  `blog_ping_technorati` tinyint(4) DEFAULT NULL,
  `blog_ping_weblogs` tinyint(4) DEFAULT NULL,
  `blog_remote_auth_token` varchar(50) DEFAULT NULL,
  `blog_require_comment_emails` tinyint(4) DEFAULT NULL,
  `blog_sanitize_spec` varchar(255) DEFAULT NULL,
  `blog_server_offset` float DEFAULT NULL,
  `blog_site_path` varchar(255) DEFAULT NULL,
  `blog_site_url` varchar(255) DEFAULT NULL,
  `blog_sort_order_comments` varchar(8) DEFAULT NULL,
  `blog_sort_order_posts` varchar(8) DEFAULT NULL,
  `blog_status_default` smallint(6) DEFAULT NULL,
  `blog_theme_id` varchar(255) DEFAULT NULL,
  `blog_use_comment_confirmation` tinyint(4) DEFAULT NULL,
  `blog_use_revision` tinyint(4) DEFAULT NULL,
  `blog_welcome_msg` mediumtext,
  `blog_words_in_excerpt` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`blog_id`),
  KEY `mt_blog_name` (`blog_name`),
  KEY `mt_blog_class` (`blog_class`),
  KEY `mt_blog_parent_id` (`blog_parent_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_blog`
--

LOCK TABLES `mt_blog` WRITE;
/*!40000 ALTER TABLE `mt_blog` DISABLE KEYS */;
INSERT INTO `mt_blog` VALUES (1,NULL,1,1,1,1,1,1,0,NULL,NULL,NULL,NULL,NULL,NULL,'Monthly,Individual,Category,Page','Individual',NULL,NULL,1,100,NULL,'2014-11-01 15:12:59','website',NULL,'richtext','1',1,'2014-11-02 00:12:58','none','ja',0,NULL,1,1,10,'html',NULL,0,NULL,14,0,'ja',NULL,1,2,NULL,'2014-11-02 00:12:58',NULL,'First Website',NULL,NULL,0,0,NULL,0,0,NULL,0,'0',9,'/var/www/html','http://127.0.0.1:8080/','ascend','descend',2,'classic_website',1,1,NULL,40);
/*!40000 ALTER TABLE `mt_blog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_blog_meta`
--

DROP TABLE IF EXISTS `mt_blog_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_blog_meta` (
  `blog_meta_blog_id` int(11) NOT NULL,
  `blog_meta_type` varchar(75) NOT NULL,
  `blog_meta_vchar` varchar(255) DEFAULT NULL,
  `blog_meta_vchar_idx` varchar(255) DEFAULT NULL,
  `blog_meta_vdatetime` datetime DEFAULT NULL,
  `blog_meta_vdatetime_idx` datetime DEFAULT NULL,
  `blog_meta_vinteger` int(11) DEFAULT NULL,
  `blog_meta_vinteger_idx` int(11) DEFAULT NULL,
  `blog_meta_vfloat` float DEFAULT NULL,
  `blog_meta_vfloat_idx` float DEFAULT NULL,
  `blog_meta_vblob` mediumblob,
  `blog_meta_vclob` mediumtext,
  PRIMARY KEY (`blog_meta_blog_id`,`blog_meta_type`),
  KEY `mt_blog_meta_type_vint` (`blog_meta_type`,`blog_meta_vinteger_idx`),
  KEY `mt_blog_meta_type_vflt` (`blog_meta_type`,`blog_meta_vfloat_idx`),
  KEY `mt_blog_meta_type_vdt` (`blog_meta_type`,`blog_meta_vdatetime_idx`),
  KEY `mt_blog_meta_type_vchar` (`blog_meta_type`,`blog_meta_vchar_idx`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_blog_meta`
--

LOCK TABLES `mt_blog_meta` WRITE;
/*!40000 ALTER TABLE `mt_blog_meta` DISABLE KEYS */;
INSERT INTO `mt_blog_meta` VALUES (1,'commenter_authenticators','MovableType',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1,'nofollow_urls',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL),(1,'page_layout','layout-wtt',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(1,'follow_auth_links',NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `mt_blog_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_category`
--

DROP TABLE IF EXISTS `mt_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_allow_pings` tinyint(4) DEFAULT '0',
  `category_author_id` int(11) DEFAULT NULL,
  `category_basename` varchar(255) DEFAULT NULL,
  `category_blog_id` int(11) NOT NULL,
  `category_class` varchar(255) DEFAULT 'category',
  `category_created_by` int(11) DEFAULT NULL,
  `category_created_on` datetime DEFAULT NULL,
  `category_description` mediumtext,
  `category_label` varchar(100) NOT NULL,
  `category_modified_by` int(11) DEFAULT NULL,
  `category_modified_on` datetime DEFAULT NULL,
  `category_parent` int(11) DEFAULT '0',
  `category_ping_urls` mediumtext,
  PRIMARY KEY (`category_id`),
  KEY `mt_category_blog_basename` (`category_blog_id`,`category_basename`),
  KEY `mt_category_parent` (`category_parent`),
  KEY `mt_category_class` (`category_class`),
  KEY `mt_category_blog_class` (`category_blog_id`,`category_class`),
  KEY `mt_category_label` (`category_label`),
  KEY `mt_category_blog_id` (`category_blog_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_category`
--

LOCK TABLES `mt_category` WRITE;
/*!40000 ALTER TABLE `mt_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `mt_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_category_meta`
--

DROP TABLE IF EXISTS `mt_category_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_category_meta` (
  `category_meta_category_id` int(11) NOT NULL,
  `category_meta_type` varchar(75) NOT NULL,
  `category_meta_vchar` varchar(255) DEFAULT NULL,
  `category_meta_vchar_idx` varchar(255) DEFAULT NULL,
  `category_meta_vdatetime` datetime DEFAULT NULL,
  `category_meta_vdatetime_idx` datetime DEFAULT NULL,
  `category_meta_vinteger` int(11) DEFAULT NULL,
  `category_meta_vinteger_idx` int(11) DEFAULT NULL,
  `category_meta_vfloat` float DEFAULT NULL,
  `category_meta_vfloat_idx` float DEFAULT NULL,
  `category_meta_vblob` mediumblob,
  `category_meta_vclob` mediumtext,
  PRIMARY KEY (`category_meta_category_id`,`category_meta_type`),
  KEY `mt_category_meta_type_vint` (`category_meta_type`,`category_meta_vinteger_idx`),
  KEY `mt_category_meta_type_vflt` (`category_meta_type`,`category_meta_vfloat_idx`),
  KEY `mt_category_meta_type_vdt` (`category_meta_type`,`category_meta_vdatetime_idx`),
  KEY `mt_category_meta_type_vchar` (`category_meta_type`,`category_meta_vchar_idx`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_category_meta`
--

LOCK TABLES `mt_category_meta` WRITE;
/*!40000 ALTER TABLE `mt_category_meta` DISABLE KEYS */;
/*!40000 ALTER TABLE `mt_category_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_comment`
--

DROP TABLE IF EXISTS `mt_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_comment` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_author` varchar(100) DEFAULT NULL,
  `comment_blog_id` int(11) NOT NULL,
  `comment_commenter_id` int(11) DEFAULT NULL,
  `comment_created_by` int(11) DEFAULT NULL,
  `comment_created_on` datetime DEFAULT NULL,
  `comment_email` varchar(127) DEFAULT NULL,
  `comment_entry_id` int(11) NOT NULL,
  `comment_ip` varchar(50) DEFAULT NULL,
  `comment_junk_log` mediumtext,
  `comment_junk_score` float DEFAULT NULL,
  `comment_junk_status` smallint(6) DEFAULT '1',
  `comment_last_moved_on` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `comment_modified_by` int(11) DEFAULT NULL,
  `comment_modified_on` datetime DEFAULT NULL,
  `comment_parent_id` int(11) DEFAULT NULL,
  `comment_text` mediumtext,
  `comment_url` varchar(255) DEFAULT NULL,
  `comment_visible` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `mt_comment_blog_stat` (`comment_blog_id`,`comment_junk_status`,`comment_created_on`),
  KEY `mt_comment_commenter_id` (`comment_commenter_id`),
  KEY `mt_comment_dd_coment_vis_mod` (`comment_visible`,`comment_modified_on`),
  KEY `mt_comment_visible_date` (`comment_visible`,`comment_created_on`),
  KEY `mt_comment_author` (`comment_author`),
  KEY `mt_comment_entry_visible` (`comment_entry_id`,`comment_visible`,`comment_created_on`),
  KEY `mt_comment_email` (`comment_email`),
  KEY `mt_comment_blog_junk_stat` (`comment_blog_id`,`comment_junk_status`,`comment_last_moved_on`),
  KEY `mt_comment_blog_visible` (`comment_blog_id`,`comment_visible`,`comment_created_on`,`comment_id`),
  KEY `mt_comment_last_moved_on` (`comment_last_moved_on`),
  KEY `mt_comment_blog_ip_date` (`comment_blog_id`,`comment_ip`,`comment_created_on`),
  KEY `mt_comment_blog_visible_entry` (`comment_blog_id`,`comment_visible`,`comment_entry_id`),
  KEY `mt_comment_blog_url` (`comment_blog_id`,`comment_visible`,`comment_url`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_comment`
--

LOCK TABLES `mt_comment` WRITE;
/*!40000 ALTER TABLE `mt_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `mt_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_comment_meta`
--

DROP TABLE IF EXISTS `mt_comment_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_comment_meta` (
  `comment_meta_comment_id` int(11) NOT NULL,
  `comment_meta_type` varchar(75) NOT NULL,
  `comment_meta_vchar` varchar(255) DEFAULT NULL,
  `comment_meta_vchar_idx` varchar(255) DEFAULT NULL,
  `comment_meta_vdatetime` datetime DEFAULT NULL,
  `comment_meta_vdatetime_idx` datetime DEFAULT NULL,
  `comment_meta_vinteger` int(11) DEFAULT NULL,
  `comment_meta_vinteger_idx` int(11) DEFAULT NULL,
  `comment_meta_vfloat` float DEFAULT NULL,
  `comment_meta_vfloat_idx` float DEFAULT NULL,
  `comment_meta_vblob` mediumblob,
  `comment_meta_vclob` mediumtext,
  PRIMARY KEY (`comment_meta_comment_id`,`comment_meta_type`),
  KEY `mt_comment_meta_type_vint` (`comment_meta_type`,`comment_meta_vinteger_idx`),
  KEY `mt_comment_meta_type_vflt` (`comment_meta_type`,`comment_meta_vfloat_idx`),
  KEY `mt_comment_meta_type_vdt` (`comment_meta_type`,`comment_meta_vdatetime_idx`),
  KEY `mt_comment_meta_type_vchar` (`comment_meta_type`,`comment_meta_vchar_idx`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_comment_meta`
--

LOCK TABLES `mt_comment_meta` WRITE;
/*!40000 ALTER TABLE `mt_comment_meta` DISABLE KEYS */;
/*!40000 ALTER TABLE `mt_comment_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_config`
--

DROP TABLE IF EXISTS `mt_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_config` (
  `config_id` int(11) NOT NULL AUTO_INCREMENT,
  `config_data` mediumtext,
  PRIMARY KEY (`config_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_config`
--

LOCK TABLES `mt_config` WRITE;
/*!40000 ALTER TABLE `mt_config` DISABLE KEYS */;
INSERT INTO `mt_config` VALUES (1,'MTReleaseNumber 5\nMTVersion 6.0\nPluginSchemaVersion multiblog=2.42\nPluginSchemaVersion stylecatcher=1.0\nPluginSchemaVersion WidgetManager=1.1\nPluginSchemaVersion formattedtext=1.00\nSchemaVersion 6.0009\n');
/*!40000 ALTER TABLE `mt_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_entry`
--

DROP TABLE IF EXISTS `mt_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_entry` (
  `entry_id` int(11) NOT NULL AUTO_INCREMENT,
  `entry_allow_comments` tinyint(4) DEFAULT NULL,
  `entry_allow_pings` tinyint(4) DEFAULT NULL,
  `entry_atom_id` varchar(255) DEFAULT NULL,
  `entry_author_id` int(11) NOT NULL,
  `entry_authored_on` datetime DEFAULT NULL,
  `entry_basename` varchar(255) DEFAULT NULL,
  `entry_blog_id` int(11) NOT NULL,
  `entry_category_id` int(11) DEFAULT NULL,
  `entry_class` varchar(255) DEFAULT 'entry',
  `entry_comment_count` int(11) DEFAULT '0',
  `entry_convert_breaks` varchar(60) DEFAULT NULL,
  `entry_created_by` int(11) DEFAULT NULL,
  `entry_created_on` datetime DEFAULT NULL,
  `entry_excerpt` mediumtext,
  `entry_keywords` mediumtext,
  `entry_modified_by` int(11) DEFAULT NULL,
  `entry_modified_on` datetime DEFAULT NULL,
  `entry_ping_count` int(11) DEFAULT '0',
  `entry_pinged_urls` mediumtext,
  `entry_status` smallint(6) NOT NULL,
  `entry_tangent_cache` mediumtext,
  `entry_template_id` int(11) DEFAULT NULL,
  `entry_text` mediumtext,
  `entry_text_more` mediumtext,
  `entry_title` varchar(255) DEFAULT NULL,
  `entry_to_ping_urls` mediumtext,
  `entry_unpublished_on` datetime DEFAULT NULL,
  `entry_week_number` int(11) DEFAULT NULL,
  `entry_current_revision` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry_id`),
  KEY `mt_entry_author_id` (`entry_author_id`),
  KEY `mt_entry_tag_count` (`entry_status`,`entry_class`,`entry_blog_id`,`entry_id`),
  KEY `mt_entry_status` (`entry_status`),
  KEY `mt_entry_blog_stat_date` (`entry_blog_id`,`entry_class`,`entry_status`,`entry_authored_on`,`entry_id`),
  KEY `mt_entry_blog_author` (`entry_blog_id`,`entry_class`,`entry_author_id`,`entry_authored_on`),
  KEY `mt_entry_blog_basename` (`entry_blog_id`,`entry_basename`),
  KEY `mt_entry_class_unpublished` (`entry_class`,`entry_unpublished_on`),
  KEY `mt_entry_comment_count` (`entry_comment_count`),
  KEY `mt_entry_created_on` (`entry_created_on`),
  KEY `mt_entry_blog_unpublished` (`entry_blog_id`,`entry_class`,`entry_unpublished_on`),
  KEY `mt_entry_dd_entry_tag_count` (`entry_blog_id`,`entry_status`,`entry_class`,`entry_id`),
  KEY `mt_entry_auth_stat_class` (`entry_author_id`,`entry_status`,`entry_class`),
  KEY `mt_entry_blog_authored` (`entry_blog_id`,`entry_class`,`entry_authored_on`),
  KEY `mt_entry_blog_week` (`entry_blog_id`,`entry_class`,`entry_status`,`entry_week_number`),
  KEY `mt_entry_modified_on` (`entry_modified_on`),
  KEY `mt_entry_class` (`entry_class`),
  KEY `mt_entry_title` (`entry_title`),
  KEY `mt_entry_class_authored` (`entry_class`,`entry_authored_on`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_entry`
--

LOCK TABLES `mt_entry` WRITE;
/*!40000 ALTER TABLE `mt_entry` DISABLE KEYS */;
/*!40000 ALTER TABLE `mt_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_entry_meta`
--

DROP TABLE IF EXISTS `mt_entry_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_entry_meta` (
  `entry_meta_entry_id` int(11) NOT NULL,
  `entry_meta_type` varchar(75) NOT NULL,
  `entry_meta_vchar` varchar(255) DEFAULT NULL,
  `entry_meta_vchar_idx` varchar(255) DEFAULT NULL,
  `entry_meta_vdatetime` datetime DEFAULT NULL,
  `entry_meta_vdatetime_idx` datetime DEFAULT NULL,
  `entry_meta_vinteger` int(11) DEFAULT NULL,
  `entry_meta_vinteger_idx` int(11) DEFAULT NULL,
  `entry_meta_vfloat` float DEFAULT NULL,
  `entry_meta_vfloat_idx` float DEFAULT NULL,
  `entry_meta_vblob` mediumblob,
  `entry_meta_vclob` mediumtext,
  PRIMARY KEY (`entry_meta_entry_id`,`entry_meta_type`),
  KEY `mt_entry_meta_type_vint` (`entry_meta_type`,`entry_meta_vinteger_idx`),
  KEY `mt_entry_meta_type_vflt` (`entry_meta_type`,`entry_meta_vfloat_idx`),
  KEY `mt_entry_meta_type_vdt` (`entry_meta_type`,`entry_meta_vdatetime_idx`),
  KEY `mt_entry_meta_type_vchar` (`entry_meta_type`,`entry_meta_vchar_idx`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_entry_meta`
--

LOCK TABLES `mt_entry_meta` WRITE;
/*!40000 ALTER TABLE `mt_entry_meta` DISABLE KEYS */;
/*!40000 ALTER TABLE `mt_entry_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_entry_rev`
--

DROP TABLE IF EXISTS `mt_entry_rev`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_entry_rev` (
  `entry_rev_id` int(11) NOT NULL AUTO_INCREMENT,
  `entry_rev_changed` varchar(255) NOT NULL,
  `entry_rev_created_by` int(11) DEFAULT NULL,
  `entry_rev_created_on` datetime DEFAULT NULL,
  `entry_rev_description` varchar(255) DEFAULT NULL,
  `entry_rev_entry` mediumblob NOT NULL,
  `entry_rev_entry_id` int(11) NOT NULL,
  `entry_rev_label` varchar(255) DEFAULT NULL,
  `entry_rev_modified_by` int(11) DEFAULT NULL,
  `entry_rev_modified_on` datetime DEFAULT NULL,
  `entry_rev_rev_number` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`entry_rev_id`),
  KEY `mt_entry_rev_entry_id` (`entry_rev_entry_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_entry_rev`
--

LOCK TABLES `mt_entry_rev` WRITE;
/*!40000 ALTER TABLE `mt_entry_rev` DISABLE KEYS */;
/*!40000 ALTER TABLE `mt_entry_rev` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_entry_summary`
--

DROP TABLE IF EXISTS `mt_entry_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_entry_summary` (
  `entry_summary_entry_id` int(11) NOT NULL,
  `entry_summary_type` varchar(75) NOT NULL,
  `entry_summary_class` varchar(75) NOT NULL,
  `entry_summary_vchar_idx` varchar(255) DEFAULT NULL,
  `entry_summary_vinteger_idx` int(11) DEFAULT NULL,
  `entry_summary_vblob` mediumblob,
  `entry_summary_vclob` mediumtext,
  `entry_summary_expired` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`entry_summary_entry_id`,`entry_summary_type`),
  KEY `mt_entry_summary_class_vint` (`entry_summary_class`,`entry_summary_vinteger_idx`),
  KEY `mt_entry_summary_id_class` (`entry_summary_entry_id`,`entry_summary_class`),
  KEY `mt_entry_summary_class_vchar` (`entry_summary_class`,`entry_summary_vchar_idx`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_entry_summary`
--

LOCK TABLES `mt_entry_summary` WRITE;
/*!40000 ALTER TABLE `mt_entry_summary` DISABLE KEYS */;
/*!40000 ALTER TABLE `mt_entry_summary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_failedlogin`
--

DROP TABLE IF EXISTS `mt_failedlogin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_failedlogin` (
  `failedlogin_id` int(11) NOT NULL AUTO_INCREMENT,
  `failedlogin_author_id` int(11) DEFAULT NULL,
  `failedlogin_ip_locked` tinyint(4) DEFAULT '0',
  `failedlogin_remote_ip` varchar(60) DEFAULT NULL,
  `failedlogin_start` int(11) NOT NULL,
  PRIMARY KEY (`failedlogin_id`),
  KEY `mt_failedlogin_author_id` (`failedlogin_author_id`),
  KEY `mt_failedlogin_remote_ip` (`failedlogin_remote_ip`),
  KEY `mt_failedlogin_ip_start` (`failedlogin_remote_ip`,`failedlogin_start`),
  KEY `mt_failedlogin_ip_locked` (`failedlogin_ip_locked`),
  KEY `mt_failedlogin_author_start` (`failedlogin_author_id`,`failedlogin_start`),
  KEY `mt_failedlogin_start` (`failedlogin_start`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_failedlogin`
--

LOCK TABLES `mt_failedlogin` WRITE;
/*!40000 ALTER TABLE `mt_failedlogin` DISABLE KEYS */;
/*!40000 ALTER TABLE `mt_failedlogin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_fileinfo`
--

DROP TABLE IF EXISTS `mt_fileinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_fileinfo` (
  `fileinfo_id` int(11) NOT NULL AUTO_INCREMENT,
  `fileinfo_archive_type` varchar(255) DEFAULT NULL,
  `fileinfo_author_id` int(11) DEFAULT NULL,
  `fileinfo_blog_id` int(11) NOT NULL,
  `fileinfo_category_id` int(11) DEFAULT NULL,
  `fileinfo_entry_id` int(11) DEFAULT NULL,
  `fileinfo_file_path` mediumtext,
  `fileinfo_startdate` varchar(80) DEFAULT NULL,
  `fileinfo_template_id` int(11) DEFAULT NULL,
  `fileinfo_templatemap_id` int(11) DEFAULT NULL,
  `fileinfo_url` varchar(255) DEFAULT NULL,
  `fileinfo_virtual` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`fileinfo_id`),
  KEY `mt_fileinfo_author_id` (`fileinfo_author_id`),
  KEY `mt_fileinfo_archive_type` (`fileinfo_archive_type`),
  KEY `mt_fileinfo_template_id` (`fileinfo_template_id`),
  KEY `mt_fileinfo_startdate` (`fileinfo_startdate`),
  KEY `mt_fileinfo_entry_id` (`fileinfo_entry_id`),
  KEY `mt_fileinfo_category_id` (`fileinfo_category_id`),
  KEY `mt_fileinfo_url` (`fileinfo_url`),
  KEY `mt_fileinfo_blog_id` (`fileinfo_blog_id`),
  KEY `mt_fileinfo_templatemap_id` (`fileinfo_templatemap_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_fileinfo`
--

LOCK TABLES `mt_fileinfo` WRITE;
/*!40000 ALTER TABLE `mt_fileinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `mt_fileinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_filter`
--

DROP TABLE IF EXISTS `mt_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_filter` (
  `filter_id` int(11) NOT NULL AUTO_INCREMENT,
  `filter_author_id` int(11) NOT NULL,
  `filter_blog_id` int(11) NOT NULL,
  `filter_created_by` int(11) DEFAULT NULL,
  `filter_created_on` datetime DEFAULT NULL,
  `filter_items` mediumblob,
  `filter_label` varchar(255) DEFAULT NULL,
  `filter_modified_by` int(11) DEFAULT NULL,
  `filter_modified_on` datetime DEFAULT NULL,
  `filter_object_ds` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`filter_id`),
  KEY `mt_filter_author_id` (`filter_author_id`),
  KEY `mt_filter_modified_on` (`filter_modified_on`),
  KEY `mt_filter_created_on` (`filter_created_on`),
  KEY `mt_filter_author_ds` (`filter_author_id`,`filter_object_ds`),
  KEY `mt_filter_label` (`filter_label`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_filter`
--

LOCK TABLES `mt_filter` WRITE;
/*!40000 ALTER TABLE `mt_filter` DISABLE KEYS */;
/*!40000 ALTER TABLE `mt_filter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_formatted_text`
--

DROP TABLE IF EXISTS `mt_formatted_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_formatted_text` (
  `formatted_text_id` int(11) NOT NULL AUTO_INCREMENT,
  `formatted_text_blog_id` int(11) NOT NULL,
  `formatted_text_created_by` int(11) DEFAULT NULL,
  `formatted_text_created_on` datetime DEFAULT NULL,
  `formatted_text_description` varchar(255) DEFAULT NULL,
  `formatted_text_label` varchar(255) DEFAULT NULL,
  `formatted_text_modified_by` int(11) DEFAULT NULL,
  `formatted_text_modified_on` datetime DEFAULT NULL,
  `formatted_text_text` mediumtext,
  PRIMARY KEY (`formatted_text_id`),
  KEY `mt_formatted_text_blog_c_by` (`formatted_text_blog_id`,`formatted_text_created_by`),
  KEY `mt_formatted_text_modified_on` (`formatted_text_modified_on`),
  KEY `mt_formatted_text_created_on` (`formatted_text_created_on`),
  KEY `mt_formatted_text_label` (`formatted_text_label`),
  KEY `mt_formatted_text_blog_id` (`formatted_text_blog_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_formatted_text`
--

LOCK TABLES `mt_formatted_text` WRITE;
/*!40000 ALTER TABLE `mt_formatted_text` DISABLE KEYS */;
/*!40000 ALTER TABLE `mt_formatted_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_ipbanlist`
--

DROP TABLE IF EXISTS `mt_ipbanlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_ipbanlist` (
  `ipbanlist_id` int(11) NOT NULL AUTO_INCREMENT,
  `ipbanlist_blog_id` int(11) NOT NULL,
  `ipbanlist_created_by` int(11) DEFAULT NULL,
  `ipbanlist_created_on` datetime DEFAULT NULL,
  `ipbanlist_ip` varchar(50) NOT NULL,
  `ipbanlist_modified_by` int(11) DEFAULT NULL,
  `ipbanlist_modified_on` datetime DEFAULT NULL,
  PRIMARY KEY (`ipbanlist_id`),
  KEY `mt_ipbanlist_ip` (`ipbanlist_ip`),
  KEY `mt_ipbanlist_blog_id` (`ipbanlist_blog_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_ipbanlist`
--

LOCK TABLES `mt_ipbanlist` WRITE;
/*!40000 ALTER TABLE `mt_ipbanlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `mt_ipbanlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_log`
--

DROP TABLE IF EXISTS `mt_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_log` (
  `log_id` int(11) NOT NULL AUTO_INCREMENT,
  `log_author_id` int(11) DEFAULT '0',
  `log_blog_id` int(11) DEFAULT '0',
  `log_category` varchar(255) DEFAULT NULL,
  `log_class` varchar(255) DEFAULT 'system',
  `log_created_by` int(11) DEFAULT NULL,
  `log_created_on` datetime DEFAULT NULL,
  `log_ip` varchar(50) DEFAULT NULL,
  `log_level` int(11) DEFAULT '1',
  `log_message` mediumtext,
  `log_metadata` mediumtext,
  `log_modified_by` int(11) DEFAULT NULL,
  `log_modified_on` datetime DEFAULT NULL,
  PRIMARY KEY (`log_id`),
  KEY `mt_log_level` (`log_level`),
  KEY `mt_log_created_on` (`log_created_on`),
  KEY `mt_log_blog_id` (`log_blog_id`),
  KEY `mt_log_class` (`log_class`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_log`
--

LOCK TABLES `mt_log` WRITE;
/*!40000 ALTER TABLE `mt_log` DISABLE KEYS */;
INSERT INTO `mt_log` VALUES (1,0,0,'upgrade','system',NULL,'2014-11-01 15:12:59',NULL,1,'\'admin\'がデータベースをバージョン6.0009にアップグレードしました。',NULL,NULL,'2014-11-01 15:12:59'),(2,0,0,'install','plugin',NULL,'2014-11-01 15:12:59',NULL,1,'\'admin\'がプラグイン(FormattedText、バージョン1.11、スキーマバージョン1.00)をインストールしました。',NULL,NULL,'2014-11-01 15:12:59'),(3,0,0,'install','plugin',NULL,'2014-11-01 15:12:59',NULL,1,'\'admin\'がプラグイン(Widget Manager Upgrade Assistant、バージョン1.1、スキーマバージョン1.1)をインストールしました。',NULL,NULL,'2014-11-01 15:12:59'),(4,0,0,'install','plugin',NULL,'2014-11-01 15:12:59',NULL,1,'\'admin\'がプラグイン(StyleCatcher、バージョン2.5、スキーマバージョン1.0)をインストールしました。',NULL,NULL,'2014-11-01 15:12:59'),(5,0,0,'install','plugin',NULL,'2014-11-01 15:12:59',NULL,1,'\'admin\'がプラグイン(MultiBlog、バージョン2.42、スキーマバージョン2.42)をインストールしました。',NULL,NULL,'2014-11-01 15:12:59'),(6,1,0,'logout_user','author',NULL,'2014-11-01 15:13:05','192.168.42.2',1,'ユーザー\'admin\'(ID1)がサインアウトしました。',NULL,NULL,'2014-11-01 15:13:05');
/*!40000 ALTER TABLE `mt_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_notification`
--

DROP TABLE IF EXISTS `mt_notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_notification` (
  `notification_id` int(11) NOT NULL AUTO_INCREMENT,
  `notification_blog_id` int(11) NOT NULL,
  `notification_created_by` int(11) DEFAULT NULL,
  `notification_created_on` datetime DEFAULT NULL,
  `notification_email` varchar(75) DEFAULT NULL,
  `notification_modified_by` int(11) DEFAULT NULL,
  `notification_modified_on` datetime DEFAULT NULL,
  `notification_name` varchar(50) DEFAULT NULL,
  `notification_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`notification_id`),
  KEY `mt_notification_email` (`notification_email`),
  KEY `mt_notification_blog_id` (`notification_blog_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_notification`
--

LOCK TABLES `mt_notification` WRITE;
/*!40000 ALTER TABLE `mt_notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `mt_notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_objectasset`
--

DROP TABLE IF EXISTS `mt_objectasset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_objectasset` (
  `objectasset_id` int(11) NOT NULL AUTO_INCREMENT,
  `objectasset_asset_id` int(11) NOT NULL,
  `objectasset_blog_id` int(11) DEFAULT NULL,
  `objectasset_embedded` tinyint(4) DEFAULT '0',
  `objectasset_object_ds` varchar(50) NOT NULL,
  `objectasset_object_id` int(11) NOT NULL,
  PRIMARY KEY (`objectasset_id`),
  KEY `mt_objectasset_blog_obj` (`objectasset_blog_id`,`objectasset_object_ds`,`objectasset_object_id`),
  KEY `mt_objectasset_asset_id` (`objectasset_asset_id`),
  KEY `mt_objectasset_id_ds` (`objectasset_object_id`,`objectasset_object_ds`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_objectasset`
--

LOCK TABLES `mt_objectasset` WRITE;
/*!40000 ALTER TABLE `mt_objectasset` DISABLE KEYS */;
/*!40000 ALTER TABLE `mt_objectasset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_objectscore`
--

DROP TABLE IF EXISTS `mt_objectscore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_objectscore` (
  `objectscore_id` int(11) NOT NULL AUTO_INCREMENT,
  `objectscore_author_id` int(11) DEFAULT '0',
  `objectscore_created_by` int(11) DEFAULT NULL,
  `objectscore_created_on` datetime DEFAULT NULL,
  `objectscore_ip` varchar(50) DEFAULT NULL,
  `objectscore_modified_by` int(11) DEFAULT NULL,
  `objectscore_modified_on` datetime DEFAULT NULL,
  `objectscore_namespace` varchar(100) NOT NULL,
  `objectscore_object_ds` varchar(50) NOT NULL,
  `objectscore_object_id` int(11) DEFAULT '0',
  `objectscore_score` float DEFAULT NULL,
  PRIMARY KEY (`objectscore_id`),
  KEY `mt_objectscore_ns_ip_ds_obj` (`objectscore_namespace`,`objectscore_ip`,`objectscore_object_ds`,`objectscore_object_id`),
  KEY `mt_objectscore_ds_obj` (`objectscore_object_ds`,`objectscore_object_id`),
  KEY `mt_objectscore_ns_user_ds_obj` (`objectscore_namespace`,`objectscore_author_id`,`objectscore_object_ds`,`objectscore_object_id`),
  KEY `mt_objectscore_user_ns` (`objectscore_author_id`,`objectscore_namespace`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_objectscore`
--

LOCK TABLES `mt_objectscore` WRITE;
/*!40000 ALTER TABLE `mt_objectscore` DISABLE KEYS */;
/*!40000 ALTER TABLE `mt_objectscore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_objecttag`
--

DROP TABLE IF EXISTS `mt_objecttag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_objecttag` (
  `objecttag_id` int(11) NOT NULL AUTO_INCREMENT,
  `objecttag_blog_id` int(11) DEFAULT NULL,
  `objecttag_object_datasource` varchar(50) NOT NULL,
  `objecttag_object_id` int(11) NOT NULL,
  `objecttag_tag_id` int(11) NOT NULL,
  PRIMARY KEY (`objecttag_id`),
  KEY `mt_objecttag_blog_ds_tag` (`objecttag_blog_id`,`objecttag_object_datasource`,`objecttag_tag_id`),
  KEY `mt_objecttag_object_id` (`objecttag_object_id`),
  KEY `mt_objecttag_tag_id` (`objecttag_tag_id`),
  KEY `mt_objecttag_blog_ds_obj_tag` (`objecttag_blog_id`,`objecttag_object_datasource`,`objecttag_object_id`,`objecttag_tag_id`),
  KEY `mt_objecttag_object_datasource` (`objecttag_object_datasource`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_objecttag`
--

LOCK TABLES `mt_objecttag` WRITE;
/*!40000 ALTER TABLE `mt_objecttag` DISABLE KEYS */;
/*!40000 ALTER TABLE `mt_objecttag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_permission`
--

DROP TABLE IF EXISTS `mt_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_permission` (
  `permission_id` int(11) NOT NULL AUTO_INCREMENT,
  `permission_author_id` int(11) NOT NULL DEFAULT '0',
  `permission_blog_id` int(11) NOT NULL DEFAULT '0',
  `permission_blog_prefs` varchar(255) DEFAULT NULL,
  `permission_created_by` int(11) DEFAULT NULL,
  `permission_created_on` datetime DEFAULT NULL,
  `permission_entry_prefs` mediumtext,
  `permission_modified_by` int(11) DEFAULT NULL,
  `permission_modified_on` datetime DEFAULT NULL,
  `permission_page_prefs` mediumtext,
  `permission_permissions` mediumtext,
  `permission_restrictions` mediumtext,
  `permission_role_mask` int(11) DEFAULT '0',
  `permission_template_prefs` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`permission_id`),
  KEY `mt_permission_author_id` (`permission_author_id`),
  KEY `mt_permission_role_mask` (`permission_role_mask`),
  KEY `mt_permission_blog_id` (`permission_blog_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_permission`
--

LOCK TABLES `mt_permission` WRITE;
/*!40000 ALTER TABLE `mt_permission` DISABLE KEYS */;
INSERT INTO `mt_permission` VALUES (1,1,0,NULL,NULL,'2014-11-02 00:12:58',NULL,NULL,'2014-11-02 00:12:58',NULL,'\'administer\',\'create_blog\',\'create_website\',\'edit_templates\',\'manage_plugins\',\'view_log\'',NULL,0,NULL),(2,1,1,NULL,1,'2014-11-02 00:12:59',NULL,NULL,'2014-11-02 00:12:59',NULL,'\'edit_categories\',\'save_image_defaults\',\'view_blog_log\',\'manage_pages\',\'set_publish_paths\',\'edit_tags\',\'manage_member_blogs\',\'manage_themes\',\'manage_feedback\',\'publish_post\',\'edit_all_posts\',\'edit_assets\',\'edit_config\',\'administer_blog\',\'send_notifications\',\'create_post\',\'rebuild\',\'edit_notifications\',\'comment\',\'administer_website\',\'edit_templates\',\'manage_users\',\'upload\'',NULL,0,NULL);
/*!40000 ALTER TABLE `mt_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_placement`
--

DROP TABLE IF EXISTS `mt_placement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_placement` (
  `placement_id` int(11) NOT NULL AUTO_INCREMENT,
  `placement_blog_id` int(11) NOT NULL,
  `placement_category_id` int(11) NOT NULL,
  `placement_entry_id` int(11) NOT NULL,
  `placement_is_primary` tinyint(4) NOT NULL,
  PRIMARY KEY (`placement_id`),
  KEY `mt_placement_category_id` (`placement_category_id`),
  KEY `mt_placement_blog_cat` (`placement_blog_id`,`placement_category_id`),
  KEY `mt_placement_blog_id` (`placement_blog_id`),
  KEY `mt_placement_is_primary` (`placement_is_primary`),
  KEY `mt_placement_entry_id` (`placement_entry_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_placement`
--

LOCK TABLES `mt_placement` WRITE;
/*!40000 ALTER TABLE `mt_placement` DISABLE KEYS */;
/*!40000 ALTER TABLE `mt_placement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_plugindata`
--

DROP TABLE IF EXISTS `mt_plugindata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_plugindata` (
  `plugindata_id` int(11) NOT NULL AUTO_INCREMENT,
  `plugindata_data` mediumblob,
  `plugindata_key` varchar(255) NOT NULL,
  `plugindata_plugin` varchar(50) NOT NULL,
  PRIMARY KEY (`plugindata_id`),
  KEY `mt_plugindata_plugin` (`plugindata_plugin`),
  KEY `mt_plugindata_key` (`plugindata_key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_plugindata`
--

LOCK TABLES `mt_plugindata` WRITE;
/*!40000 ALTER TABLE `mt_plugindata` DISABLE KEYS */;
/*!40000 ALTER TABLE `mt_plugindata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_role`
--

DROP TABLE IF EXISTS `mt_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_created_by` int(11) DEFAULT NULL,
  `role_created_on` datetime DEFAULT NULL,
  `role_description` mediumtext,
  `role_is_system` tinyint(4) DEFAULT '0',
  `role_modified_by` int(11) DEFAULT NULL,
  `role_modified_on` datetime DEFAULT NULL,
  `role_name` varchar(255) NOT NULL,
  `role_permissions` mediumtext,
  `role_role_mask` int(11) DEFAULT NULL,
  `role_role_mask2` int(11) DEFAULT NULL,
  `role_role_mask3` int(11) DEFAULT NULL,
  `role_role_mask4` int(11) DEFAULT NULL,
  PRIMARY KEY (`role_id`),
  KEY `mt_role_created_on` (`role_created_on`),
  KEY `mt_role_is_system` (`role_is_system`),
  KEY `mt_role_name` (`role_name`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_role`
--

LOCK TABLES `mt_role` WRITE;
/*!40000 ALTER TABLE `mt_role` DISABLE KEYS */;
INSERT INTO `mt_role` VALUES (1,1,'2014-11-02 00:12:58','ウェブサイトを管理できます。',0,NULL,'2014-11-02 00:12:58','ウェブサイト管理者','\'administer_website\',\'manage_member_blogs\'',NULL,NULL,NULL,NULL),(2,1,'2014-11-02 00:12:58','ブログの管理者です。',0,NULL,'2014-11-02 00:12:58','ブログ管理者','\'administer_blog\'',4096,NULL,NULL,NULL),(3,1,'2014-11-02 00:12:58','ファイルをアップロードし、記事(カテゴリ)、ウェブページ(フォルダ)、タグを編集して公開できます。',0,NULL,'2014-11-02 00:12:58','編集者','\'comment\',\'create_post\',\'publish_post\',\'edit_all_posts\',\'edit_categories\',\'edit_tags\',\'manage_pages\',\'rebuild\',\'upload\',\'send_notifications\',\'manage_feedback\',\'edit_assets\'',NULL,NULL,NULL,NULL),(4,1,'2014-11-02 00:12:58','記事を作成し、各自の記事の編集とファイルのアップロード、およびそれらを公開できます。',0,NULL,'2014-11-02 00:12:58','ユーザー','\'comment\',\'create_post\',\'publish_post\',\'upload\',\'send_notifications\'',NULL,NULL,NULL,NULL),(5,1,'2014-11-02 00:12:58','テンプレートとテーマの編集と管理、及びそれらの公開ができます。',0,NULL,'2014-11-02 00:12:58','デザイナ','\'manage_themes\',\'edit_templates\',\'rebuild\'',144,NULL,NULL,NULL),(6,1,'2014-11-02 00:12:58','ページの管理、ファイルのアップロード、ブログテンプレートを公開できます。',0,NULL,'2014-11-02 00:12:58','ウェブマスター','\'manage_pages\',\'rebuild\',\'upload\'',NULL,NULL,NULL,NULL),(7,1,'2014-11-02 00:12:58','記事の作成、各自の記事とコメントを編集できます。',0,NULL,'2014-11-02 00:12:58','ライター','\'comment\',\'create_post\'',NULL,NULL,NULL,NULL),(8,1,'2014-11-02 00:12:58','コメントを投稿し、コメントやトラックバックを管理できます。',0,NULL,'2014-11-02 00:12:58','モデレータ','\'comment\',\'manage_feedback\'',NULL,NULL,NULL,NULL),(9,1,'2014-11-02 00:12:58','コメントを投稿できます。',0,NULL,'2014-11-02 00:12:58','コメント投稿者','\'comment\'',1,NULL,NULL,NULL);
/*!40000 ALTER TABLE `mt_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_session`
--

DROP TABLE IF EXISTS `mt_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_session` (
  `session_id` varchar(80) NOT NULL,
  `session_data` mediumblob,
  `session_duration` int(11) DEFAULT NULL,
  `session_email` varchar(255) DEFAULT NULL,
  `session_kind` varchar(2) DEFAULT NULL,
  `session_name` varchar(255) DEFAULT NULL,
  `session_start` int(11) NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `mt_session_kind` (`session_kind`),
  KEY `mt_session_name` (`session_name`),
  KEY `mt_session_duration` (`session_duration`),
  KEY `mt_session_start` (`session_start`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_session`
--

LOCK TABLES `mt_session` WRITE;
/*!40000 ALTER TABLE `mt_session` DISABLE KEYS */;
INSERT INTO `mt_session` VALUES ('NW','<ul>\n\n<li>2014.10.16 <a href=\"http://www.sixapart.jp/movabletype/news/2014/10/16-1100.html\">POODLE: SSLv3.0 脆弱性への対応について</a></li>\n\n<li>2014.10.02 <a href=\"http://www.sixapart.jp/movabletype/news/2014/10/02-1400.html\">Movable Type クラウド版でマルチドメインでの利用とアクセス制限が可能に</a></li>\n\n<li>2014.10.02 <a href=\"http://www.sixapart.jp/movabletype/news/2014/10/02-1100.html\">Movable Type 6.0.5 の提供を開始</a></li>\n\n<li>2014.09.19 <a href=\"http://www.sixapart.jp/movabletype/news/2014/09/19-1300.html\">11月29日（土）MTDDC Meetup TOKYO 2014 開催のお知らせ</a></li>\n\n<li>2014.09.16 <a href=\"http://www.sixapart.jp/movabletype/news/2014/09/16-1100.html\">Movable Type for AWS バージョン 6.0.4-0 がリリースされました</a></li>\n\n</ul>\n<span style=\"display: block; text-align: center; margin-top: 10px;\"><a href=\"http://www.sixapart.jp/movabletype/feedback.html\" class=\"button\">Movable Type へのフィードバック</a></span>',NULL,NULL,'NW',NULL,1414854781);
/*!40000 ALTER TABLE `mt_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_tag`
--

DROP TABLE IF EXISTS `mt_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_tag` (
  `tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_is_private` tinyint(4) DEFAULT '0',
  `tag_n8d_id` int(11) DEFAULT '0',
  `tag_name` varchar(255) NOT NULL,
  PRIMARY KEY (`tag_id`),
  KEY `mt_tag_n8d_id` (`tag_n8d_id`),
  KEY `mt_tag_name_id` (`tag_name`,`tag_id`),
  KEY `mt_tag_name` (`tag_name`),
  KEY `mt_tag_private_id_name` (`tag_is_private`,`tag_id`,`tag_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_tag`
--

LOCK TABLES `mt_tag` WRITE;
/*!40000 ALTER TABLE `mt_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `mt_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_tbping`
--

DROP TABLE IF EXISTS `mt_tbping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_tbping` (
  `tbping_id` int(11) NOT NULL AUTO_INCREMENT,
  `tbping_blog_id` int(11) NOT NULL,
  `tbping_blog_name` varchar(255) DEFAULT NULL,
  `tbping_created_by` int(11) DEFAULT NULL,
  `tbping_created_on` datetime DEFAULT NULL,
  `tbping_excerpt` mediumtext,
  `tbping_ip` varchar(50) NOT NULL,
  `tbping_junk_log` mediumtext,
  `tbping_junk_score` float DEFAULT NULL,
  `tbping_junk_status` smallint(6) NOT NULL DEFAULT '1',
  `tbping_last_moved_on` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
  `tbping_modified_by` int(11) DEFAULT NULL,
  `tbping_modified_on` datetime DEFAULT NULL,
  `tbping_source_url` varchar(255) DEFAULT NULL,
  `tbping_tb_id` int(11) NOT NULL,
  `tbping_title` varchar(255) DEFAULT NULL,
  `tbping_visible` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`tbping_id`),
  KEY `mt_tbping_blog_stat` (`tbping_blog_id`,`tbping_junk_status`,`tbping_created_on`),
  KEY `mt_tbping_ip` (`tbping_ip`),
  KEY `mt_tbping_visible_date` (`tbping_visible`,`tbping_created_on`),
  KEY `mt_tbping_blog_junk_stat` (`tbping_blog_id`,`tbping_junk_status`,`tbping_last_moved_on`),
  KEY `mt_tbping_last_moved_on` (`tbping_last_moved_on`),
  KEY `mt_tbping_blog_visible` (`tbping_blog_id`,`tbping_visible`,`tbping_created_on`,`tbping_id`),
  KEY `mt_tbping_tb_visible` (`tbping_tb_id`,`tbping_visible`,`tbping_created_on`),
  KEY `mt_tbping_created_on` (`tbping_created_on`),
  KEY `mt_tbping_junk_date` (`tbping_junk_status`,`tbping_created_on`),
  KEY `mt_tbping_blog_url` (`tbping_blog_id`,`tbping_visible`,`tbping_source_url`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_tbping`
--

LOCK TABLES `mt_tbping` WRITE;
/*!40000 ALTER TABLE `mt_tbping` DISABLE KEYS */;
/*!40000 ALTER TABLE `mt_tbping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_tbping_meta`
--

DROP TABLE IF EXISTS `mt_tbping_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_tbping_meta` (
  `tbping_meta_tbping_id` int(11) NOT NULL,
  `tbping_meta_type` varchar(75) NOT NULL,
  `tbping_meta_vchar` varchar(255) DEFAULT NULL,
  `tbping_meta_vchar_idx` varchar(255) DEFAULT NULL,
  `tbping_meta_vdatetime` datetime DEFAULT NULL,
  `tbping_meta_vdatetime_idx` datetime DEFAULT NULL,
  `tbping_meta_vinteger` int(11) DEFAULT NULL,
  `tbping_meta_vinteger_idx` int(11) DEFAULT NULL,
  `tbping_meta_vfloat` float DEFAULT NULL,
  `tbping_meta_vfloat_idx` float DEFAULT NULL,
  `tbping_meta_vblob` mediumblob,
  `tbping_meta_vclob` mediumtext,
  PRIMARY KEY (`tbping_meta_tbping_id`,`tbping_meta_type`),
  KEY `mt_tbping_meta_type_vint` (`tbping_meta_type`,`tbping_meta_vinteger_idx`),
  KEY `mt_tbping_meta_type_vflt` (`tbping_meta_type`,`tbping_meta_vfloat_idx`),
  KEY `mt_tbping_meta_type_vdt` (`tbping_meta_type`,`tbping_meta_vdatetime_idx`),
  KEY `mt_tbping_meta_type_vchar` (`tbping_meta_type`,`tbping_meta_vchar_idx`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_tbping_meta`
--

LOCK TABLES `mt_tbping_meta` WRITE;
/*!40000 ALTER TABLE `mt_tbping_meta` DISABLE KEYS */;
/*!40000 ALTER TABLE `mt_tbping_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_template`
--

DROP TABLE IF EXISTS `mt_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_template` (
  `template_id` int(11) NOT NULL AUTO_INCREMENT,
  `template_blog_id` int(11) NOT NULL,
  `template_build_dynamic` tinyint(4) DEFAULT NULL,
  `template_build_interval` int(11) DEFAULT NULL,
  `template_build_type` smallint(6) DEFAULT NULL,
  `template_created_by` int(11) DEFAULT NULL,
  `template_created_on` datetime DEFAULT NULL,
  `template_identifier` varchar(50) DEFAULT NULL,
  `template_linked_file` varchar(255) DEFAULT NULL,
  `template_linked_file_mtime` varchar(10) DEFAULT NULL,
  `template_linked_file_size` int(11) DEFAULT NULL,
  `template_modified_by` int(11) DEFAULT NULL,
  `template_modified_on` datetime DEFAULT NULL,
  `template_name` varchar(255) NOT NULL,
  `template_outfile` varchar(255) DEFAULT NULL,
  `template_rebuild_me` tinyint(4) DEFAULT NULL,
  `template_text` mediumtext,
  `template_type` varchar(25) NOT NULL,
  `template_current_revision` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`template_id`),
  KEY `mt_template_identifier` (`template_identifier`),
  KEY `mt_template_outfile` (`template_outfile`),
  KEY `mt_template_name` (`template_name`),
  KEY `mt_template_type` (`template_type`),
  KEY `mt_template_blog_id` (`template_blog_id`)
) ENGINE=MyISAM AUTO_INCREMENT=63 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_template`
--

LOCK TABLES `mt_template` WRITE;
/*!40000 ALTER TABLE `mt_template` DISABLE KEYS */;
INSERT INTO `mt_template` VALUES (1,1,0,0,1,1,'2014-11-02 00:12:58','trackbacks',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','トラックバック',NULL,1,'<mt:Ignore><!-- Display TrackBacks for the entry/page or TrackBack details if TrackBacks are being accepted --></mt:Ignore>\n<mt:IfPingsActive>\n<div id=\"trackbacks\" class=\"trackbacks\">\n    <h2 class=\"trackbacks-header\"><$mt:EntryTrackbackCount singular=\"トラックバック(1)\" plural=\"トラックバック(#)\" none=\"トラックバック(0)\"$></h2>\n\n    <mt:Ignore><!-- Display TrackBack details if TrackBacks are being accepted --></mt:Ignore>\n    <mt:IfPingsAccepted>\n    <div class=\"trackbacks-info\">\n        <p>トラックバックURL: <$mt:EntryTrackbackLink$></p>\n    </div>\n    </mt:IfPingsAccepted>\n\n\n    <mt:Ignore><!-- Display TrackBacks --></mt:Ignore>\n    <mt:Pings>\n        <mt:PingsHeader>\n    <div class=\"trackbacks-content\">\n        </mt:PingsHeader>\n        <div class=\"trackback\" id=\"ping-<$mt:PingID$>\">\n            <div class=\"inner\">\n                <div class=\"trackback-header\">\n                    <div class=\"asset-meta\">\n                        <$mt:PingBlogName$> - <a href=\"<$mt:PingURL$>\"><$mt:PingTitle$></a> (<a href=\"#ping-<$mt:PingID$>\"><$mt:PingDate$></a>)\n                    </div>\n                </div>\n                <div class=\"trackback-content\">\n                    <p>\n                        <$mt:PingExcerpt$> <a href=\"<$mt:PingURL$>\">続きを読む</a>\n                    </p>\n                </div>\n            </div>\n        </div>\n        <mt:PingsFooter>\n    </div>\n        </mt:PingsFooter>\n    </mt:Pings>\n</div>\n</mt:IfPingsActive>\n','custom',0),(2,1,0,0,1,1,'2014-11-02 00:12:58','entry_summary',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','記事の概要',NULL,1,'<$mt:EntryTrackbackData$>\n<div id=\"entry-<$mt:EntryID$>\" class=\"entry-asset asset hentry\">\n    <div class=\"asset-header\">\n        <h2 class=\"asset-name entry-title\"><a href=\"<$mt:EntryPermalink$>\" rel=\"bookmark\"><$mt:EntryTitle$></a><mt:If name=\"display_blog_name\"> - <a href=\"<$mt:EntryBlogURL$>\"><$mt:EntryBlogName$></a></mt:If></h2>\n        <div class=\"asset-meta\">\n            <span class=\"byline\">\n    <mt:If tag=\"EntryAuthorDisplayName\">\n                <span class=\"vcard author\"><$mt:EntryAuthorLink show_hcard=\"1\"$></span> (<abbr class=\"published\" title=\"<$mt:EntryDate format_name=\"iso8601\"$>\"><$mt:EntryDate format=\"%x %X\"$></abbr>)\n    <mt:Else>\n                <abbr class=\"published\" title=\"<$mt:EntryDate format_name=\"iso8601\"$>\"><$mt:EntryDate format=\"%x %X\"$></abbr>\n    </mt:If>\n            </span>\n<mt:Unless name=\"hide_counts\" eq=\"1\">\n            <mt:IfCommentsActive><span class=\"separator\">|</span> <a href=\"<$mt:EntryPermalink$>#comments\"><$mt:EntryCommentCount singular=\"コメント(1)\" plural=\"コメント(#)\" none=\"コメント(0)\"$></a></mt:IfCommentsActive>\n            <mt:IfPingsActive><span class=\"separator\">|</span> <a href=\"<$mt:EntryPermalink$>#trackbacks\"><$mt:EntryTrackbackCount singular=\"トラックバック(1)\" plural=\"トラックバック(#)\" none=\"トラックバック(0)\"$></a></mt:IfPingsActive>\n</mt:Unless>\n        </div>\n    </div>\n    <div class=\"asset-content entry-content\">\n<mt:If tag=\"EntryBody\">\n        <div class=\"asset-body\">\n            <$mt:EntryBody$>\n        </div>\n</mt:If>\n<mt:If name=\"entry_archive\">\n    <mt:EntryIfTagged>\n        <div class=\"entry-tags\">\n            <h4>タグ<span class=\"delimiter\">:</span></h4>\n            <ul>\n                <li><mt:EntryTags glue=\'<span class=\"delimiter\">,</span></li> <li>\'><a href=\"javascript:void(0)\" onclick=\"location.href=\'<$mt:TagSearchLink encode_js=\"1\"$>\';return false;\" rel=\"tag\"><$mt:TagName$></a></mt:EntryTags></li>\n            </ul>\n        </div>\n    </mt:EntryIfTagged>\n</mt:If>\n<mt:If tag=\"EntryMore\" convert_breaks=\"0\">\n        <div class=\"asset-more-link\">\n            続きを読む: <a href=\"<$mt:EntryPermalink$>#more\" rel=\"bookmark\"><$mt:EntryTitle$></a>\n        </div>\n</mt:If>\n    </div>\n    <div class=\"asset-footer\"></div>\n</div>\n','custom',0),(3,1,0,0,1,1,'2014-11-02 00:12:58','comment_preview',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','コメントプレビュー',NULL,1,'<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\"\n    \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\" id=\"sixapart-standard\">\n<head>\n    <script type=\"text/javascript\">\n    /* <![CDATA[ */\n    var user = <$mt:UserSessionState$>;\n    var is_preview = true;\n    /* ]]> */\n    </script>\n    <$mt:Include module=\"HTMLヘッダー\"$>\n    <title><$mt:BlogName encode_html=\"1\"$>: コメントのプレビュー</title>\n</head>\n<body id=\"<$mt:WebsiteThemeID$>\" class=\"mt-comment-preview <$mt:Var name=\"page_layout\"$>\" onload=\"mtEntryOnLoad()\" onunload=\"mtEntryOnUnload()\">\n    <div id=\"container\">\n        <div id=\"container-inner\">\n\n\n            <$mt:Include module=\"バナーヘッダー\"$>\n\n\n            <div id=\"content\">\n                <div id=\"content-inner\">\n\n\n                    <div id=\"alpha\">\n                        <div id=\"alpha-inner\">\n\n\n                            <h1 id=\"page-title\"><$mt:Var name=\"page_title\"$></h1>\n\n\n<mt:Ignore><!-- Comment Preview --></mt:Ignore>\n                            <div class=\"comment\" id=\"comment-<$mt:CommentID$>\">\n                                <div class=\"inner\">\n                                    <div class=\"comment-header\">\n                                        <div class=\"asset-meta\">\n                                            <span class=\"byline\">\n                                                <$mt:CommentAuthorIdentity$>\n    <mt:IfCommentParent>\n                                                <span class=\"vcard author\"><$mt:CommentAuthorLink$></span>から<a href=\"<mt:CommentParent><$mt:CommentLink$></mt:CommentParent>\"><mt:CommentParent><$mt:CommentAuthor$></mt:CommentParent></a>への返信\n    <mt:Else>\n                                                <span class=\"vcard author\"><$mt:CommentAuthorLink$></span>\n    </mt:IfCommentParent>\n                                                | <a href=\"<$mt:CommentLink$>\"><abbr class=\"published\" title=\"<$mt:CommentDate format_name=\"iso8601\"$>\"><$mt:CommentDate$></abbr></a>\n                                            </span>\n                                        </div>\n                                    </div>\n                                    <div class=\"comment-content\">\n                                        <$mt:CommentBody$>\n                                    </div>\n                                </div>\n                            </div>\n\n\n<mt:Ignore><!-- Comment Form --></mt:Ignore>\n                            <div class=\"comments-open\" id=\"comments-open\">\n                                <h2 class=\"comments-open-header\">コメントする</h2>\n                                <div class=\"comments-open-content\">\n                                    <div id=\"comment-greeting\"></div>\n                                    <form method=\"post\" action=\"<$mt:CGIPath$><$mt:CommentScript$>\" name=\"comments_form\" id=\"comments-form\" onsubmit=\"return mtCommentOnSubmit(this)\">\n                                        <input type=\"hidden\" name=\"static\" value=\"1\" />\n                                        <input type=\"hidden\" name=\"armor\" value=\"1\" />\n                                        <input type=\"hidden\" name=\"preview\" value=\"\" />\n                                        <input type=\"hidden\" name=\"entry_id\" value=\"<$mt:EntryID$>\" />\n                                        <input type=\"hidden\" name=\"__lang\" value=\"<$mt:BlogLanguage$>\" />\n                                        <input type=\"hidden\" name=\"sid\" value=\"\" />\n<mt:IfCommentParent>\n                                            <input type=\"hidden\" name=\"parent_id\" value=\"<$mt:CommentParentID escape=\"html\"$>\" id=\"comment-parent-id\">\n</mt:IfCommentParent>\n                                        <div id=\"comments-open-data\">\n                                            <div id=\"comment-form-name\">\n                                                <label for=\"comment-author\">名前</label>\n                                                <input id=\"comment-author\" name=\"author\" size=\"30\" value=\"<$mt:CommentAuthor encode_html=\"1\"$>\" onfocus=\"mtShowCaptcha()\" />\n                                            </div>\n                                            <div id=\"comment-form-email\">\n                                                <label for=\"comment-email\">電子メール</label>\n                                                <input id=\"comment-email\" name=\"email\" size=\"30\" value=\"<$mt:CommentEmail encode_html=\"1\"$>\" onfocus=\"mtShowCaptcha()\" />\n                                            </div>\n                                            <div id=\"comment-form-url\">\n                                                <label for=\"comment-url\">URL</label>\n                                                <input id=\"comment-url\" name=\"url\" size=\"30\" value=\"<$mt:CommentURL encode_html=\"1\"$>\" onfocus=\"mtShowCaptcha()\" />\n                                            </div>\n                                        </div>\n<mt:IfCommentParent>\n                                        <div id=\"comment-form-reply\">\n                                            <input type=\"checkbox\" id=\"comment-reply\" name=\"comment_reply\" value=\"<$mt:CommentParentID escape=\"html\"$>\" checked=\"checked\" onclick=\"mtSetCommentParentID()\" />\n                                            <label for=\"comment-reply\" id=\"comment-reply-label\"><mt:CommentParent><$mt:CommentAuthor$></mt:CommentParent>からのコメントに返信</label>\n                                        </div>\n</mt:IfCommentParent>\n                                        <div id=\"comments-open-text\">\n                                            <label for=\"comment-text\">コメント <mt:IfAllowCommentHTML>(スタイル用のHTMLタグを使えます)</mt:IfAllowCommentHTML></label>\n                                            <textarea id=\"comment-text\" name=\"text\" rows=\"15\" cols=\"50\" onfocus=\"mtShowCaptcha()\"><$mt:CommentBody autolink=\"0\" sanitize=\"0\" convert_breaks=\"0\" encode_html=\"1\"$></textarea>\n                                        </div>\n                                        <div id=\"comments-open-captcha\"></div>\n                                        <div id=\"comments-open-footer\">\n                                            <input type=\"submit\" accesskey=\"v\" name=\"preview_button\" id=\"comment-preview\" value=\"プレビュー\" onclick=\"this.form.preview.value=\'1\';\" />\n                                            <input type=\"submit\" accesskey=\"s\" name=\"post\" id=\"comment-submit\" value=\"投稿\" />\n                                            <input type=\"button\" name=\"cancel\" id=\"comment-cancel\" value=\"キャンセル\" onclick=\"window.location=\'<$mt:EntryPermalink$>\'\" />\n                                        </div>\n                                    </form>\n                                </div>\n                            </div>\n                        </div>\n                    </div>\n\n\n                    <$mt:Include module=\"サイドバー\"$>\n\n\n                </div>\n            </div>\n\n\n            <$mt:Include module=\"バナーフッター\"$>\n\n\n        </div>\n    </div>\n</body>\n</html>\n','comment_preview',0),(4,1,0,0,1,1,'2014-11-02 00:12:58','monthly_entry_listing',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','月別記事リスト',NULL,1,'<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\"\n    \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\" id=\"sixapart-standard\">\n<head>\n    <$mt:Include module=\"HTMLヘッダー\"$>\n    <title><$mt:BlogName encode_html=\"1\"$>: <$mt:ArchiveTitle$>アーカイブ</title>\n<mt:Ignore>\n    <!-- Include Next and Previous links if publishing a date-based archive -->\n</mt:Ignore>\n<mt:If name=\"datebased_archive\">\n    <mt:ArchivePrevious><link rel=\"prev\" href=\"<$mt:ArchiveLink$>\" title=\"<$mt:ArchiveTitle encode_html=\"1\"$>\" /></mt:ArchivePrevious>\n    <mt:ArchiveNext><link rel=\"next\" href=\"<$mt:ArchiveLink$>\" title=\"<$mt:ArchiveTitle encode_html=\"1\"$>\" /></mt:ArchiveNext>\n</mt:If>\n</head>\n<body id=\"<$mt:BlogThemeID$>\" class=\"mt-archive-listing mt-<$mt:Var name=\"archive_class\"$> <$mt:Var name=\"page_layout\"$>\">\n    <div id=\"container\">\n        <div id=\"container-inner\">\n\n\n            <$mt:Include module=\"バナーヘッダー\"$>\n\n\n            <div id=\"content\">\n                <div id=\"content-inner\">\n\n\n                    <div id=\"alpha\">\n                        <div id=\"alpha-inner\">\n\n\n                            <h1 id=\"page-title\" class=\"archive-title\"><$mt:ArchiveTitle$>アーカイブ</h1>\n\n\n<mt:Ignore><!-- Limit number of entries to the number set in Blog Entry Settings --></mt:Ignore>\n<mt:Unless name=\"datebased_archive\"><$mt:Var name=\"limit\" value=\"auto\"$></mt:Unless>\n<mt:Entries limit=\"$limit\">\n                            <mt:Ignore><!-- Use the Entry Summary module for each entry published on this page --></mt:Ignore>\n                            <$mt:Include module=\"記事の概要\"$>\n</mt:Entries>\n\n\n                            <div class=\"content-nav\">\n                                <mt:ArchivePrevious><a href=\"<$mt:ArchiveLink$>\">&laquo; <$mt:ArchiveTitle$></a> |</mt:ArchivePrevious>\n                                <a href=\"<$mt:Link template=\"main_index\"$>\">メインページ</a> |\n                                <a href=\"<$mt:Link template=\"archive_index\"$>\">アーカイブ</a>\n                                <mt:ArchiveNext>| <a href=\"<$mt:ArchiveLink$>\"><$mt:ArchiveTitle$> &raquo;</a></mt:ArchiveNext>\n                            </div>\n\n\n                        </div>\n                    </div>\n\n\n                    <$mt:Include module=\"サイドバー\"$>\n\n\n                </div>\n            </div>\n\n\n            <$mt:Include module=\"バナーフッター\"$>\n\n\n        </div>\n    </div>\n</body>\n</html>\n','archive',0),(5,1,0,0,1,1,'2014-11-02 00:12:58','search_results',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','検索結果',NULL,1,'<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\"\n    \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\" id=\"sixapart-standard\">\n<head>\n    <script type=\"text/javascript\">\n    /* <![CDATA[ */\n    var user = <$mt:UserSessionState$>;\n    /* ]]> */\n    </script>\n    <$mt:Include module=\"HTMLヘッダー\"$>\n    <title><$mt:BlogName encode_html=\"1\"$>: 検索結果</title>\n    <mt:Ignore>Below Javascript adds ajax search capability</mt:Ignore>\n    <script type=\"text/javascript\">\n    /* <![CDATA[ */\n    <mt:IfMoreResults>\n    function getResults(page) {\n        page = parseInt(page);\n        if (timer) window.clearTimeout(timer);\n        var xh = mtGetXmlHttp();\n        if (!xh) return false;\n        var res = results[page];\n        if (!res) return;\n        var url = res[\'next_url\'];\n        if (!url) return;\n\n        xh.open(\'GET\', url + \'&format=js\', true);\n        xh.onreadystatechange = function() {\n            if ( xh.readyState == 4 ) {\n                if ( xh.status && ( xh.status != 200 ) ) {\n                    // error - ignore\n                } else {\n                    try {\n                        var page_results = eval(\"(\" + xh.responseText + \")\");\n                        if ( page_results[\'error\'] == null )\n                            results[page + 1] = page_results[\'result\'];\n                    } catch (e) {\n                    }\n                }\n            }\n        };\n        xh.send(null);\n    }\n\n    function swapContent(direction) {\n        if ( direction == undefined ) direction = 1;\n        var page_span = document.getElementById(\'current-page\');\n        if (!page_span) return true;\n        var next_page = direction + parseInt(page_span.innerHTML);\n        var res = results[next_page];\n        if (!res) return true;\n        var content = res[\'content\'];\n        if (!content) return true;\n        var div = document.getElementById(\'search-results\');\n        if (!div) return true;\n        div.innerHTML = content;\n        timer = window.setTimeout(\"getResults(\" + next_page + \")\", 1*1000);\n        window.scroll(0, 0);\n        return false;\n    }\n    <mt:Else><mt:IfPreviousResults>\n    function swapContent(direction) {\n        return true;\n    }</mt:IfPreviousResults>\n    </mt:IfMoreResults>\n    /* ]]> */\n    </script>\n</head>\n<body id=\"<$mt:WebsiteThemeID$>\" class=\"mt-search-results <$mt:Var name=\"page_layout\"$>\">\n    <div id=\"container\">\n        <div id=\"container-inner\">\n\n\n            <$mt:Include module=\"バナーヘッダー\"$>\n\n\n            <div id=\"content\">\n                <div id=\"content-inner\">\n\n\n                    <div id=\"alpha\">\n                        <div id=\"alpha-inner\">\n\n<mt:Ignore><!--\n    Below is the block to show search results.\n    This makes an independent block to support\n    Ajax-based background retrieval of the next search results.\n--></mt:Ignore>\n<mt:SetVarTemplate id=\"search_results\" name=\"search_results\">  \n<mt:SearchResults>\n    <mt:SearchResultsHeader>\n                            <div id=\"search-results\">\n                                <span id=\"current-page\" class=\"hidden\"><$mt:CurrentPage$></span>\n                                <h1 id=\"page-title\" class=\"search-results-header\">\n        <mt:IfStraightSearch>\n                                    「<$mt:SearchString$>」と一致するもの\n        </mt:IfStraightSearch>\n        <mt:IfTagSearch>\n                                    タグ「<$mt:SearchString$>」が付けられているもの\n        </mt:IfTagSearch>\n                                </h1>\n                                <div class=\"search-results-container autopagerize_page_element\">\n    </mt:SearchResultsHeader>\n                                    <$mt:Include module=\"記事の概要\" hide_counts=\"1\" display_blog_name=\"1\" local=\"1\"$>\n    <mt:SearchResultsFooter>\n                                </div><div class=\"autopagerize_insert_before\"></div>\n\n    <mt:Ignore><!-- Used with the ajax search capability of the new search class --></mt:Ignore>\n                                <div class=\"content-nav\">\n                                    <mt:IfPreviousResults><a href=\"<$mt:PreviousLink$>\" rel=\"prev\" onclick=\"return swapContent(-1);\">&lt; 前</a>&nbsp;&nbsp;</mt:IfPreviousResults><mt:PagerBlock><mt:IfCurrentPage><$mt:Var name=\"__value__\"$><mt:Else><a href=\"<$mt:PagerLink$>\"><$mt:Var name=\"__value__\"$></a></mt:IfCurrentPage><mt:Unless name=\"__last__\">&nbsp;</mt:Unless></mt:PagerBlock><mt:IfMoreResults>&nbsp;&nbsp;<a href=\"<$mt:NextLink$>\" rel=\"next\" onclick=\"return swapContent();\">次 &gt;</a></mt:IfMoreResults>\n                                </div>\n                            </div>\n    </mt:SearchResultsFooter>\n</mt:SearchResults>\n</mt:SetVarTemplate>\n<mt:Ignore><!-- Display search results constructed in the block above --></mt:Ignore>\n<$mt:Var name=\"search_results\"$>\n\n\n<mt:Ignore><!-- Display no results message --></mt:Ignore>\n<mt:NoSearchResults>\n                            <h1 id=\"page-title\" class=\"search-results-header\">\n    <mt:IfStraightSearch>\n                                「<$mt:SearchString$>」と一致するもの\n    </mt:IfStraightSearch>\n    <mt:IfTagSearch>\n                                タグ「<$mt:SearchString$>」が付けられているもの\n    </mt:IfTagSearch>\n                            </h1>\n                            <p>「<$mt:SearchString$>」と一致する結果は見つかりませんでした。</p>\n</mt:NoSearchResults>\n\n\n<mt:Ignore><!-- Display instructions for searching if search script was accessed without a query --></mt:Ignore>\n<mt:NoSearch>\n                            <h1 id=\"page-title\" class=\"search-results-header\">例</h1>\n                            <p>すべての単語が順序に関係なく検索されます。フレーズで検索したいときは引用符で囲んでください。</p>\n                            <blockquote>\n                                <p><code>\"movable type\"</code></p>\n                            </blockquote>\n                            <p>AND、OR、NOTを入れることで論理検索を行うこともできます。</p>\n                            <blockquote>\n                                <p><code>個人 OR 出版</code></p>\n                                <p><code>個人 NOT 出版</code></p>\n                            </blockquote>\n</mt:NoSearch>\n\n<mt:Ignore><!-- Used with the ajax search capability of the new search class --></mt:Ignore>\n<mt:IfMoreResults>\n<script type=\"text/javascript\">\n<!--\nvar div = document.getElementById(\'search-results\');\nvar results = {\n    \'<$mt:CurrentPage$>\': {\n        \'content\': div.innerHTML,\n        \'next_url\': \'<$mt:NextLink$>\'\n    }\n};\nvar timer = window.setTimeout(\"getResults(\" + <$mt:CurrentPage$> + \")\", 1*1000);\n//-->\n</script>\n</mt:IfMoreResults>\n\n\n                        </div>\n                    </div>\n\n                    <$mt:Include module=\"サイドバー\"$>\n\n\n                </div>\n            </div>\n\n\n            <$mt:Include module=\"バナーフッター\"$>\n\n\n        </div>\n    </div>\n</body>\n</html>\n','search_results',0),(6,1,0,0,1,1,'2014-11-02 00:12:58','recent_assets',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','アイテム',NULL,1,'<mt:If tag=\"AssetCount\" include_blogs=\"children\" include_with_website=\"1\">\n    <mt:Assets type=\"image\" lastn=\"10\" include_blogs=\"children\" include_with_website=\"1\">\n        <mt:AssetsHeader>\n<div class=\"widget-recent-assets widget\">\n    <h3 class=\"widget-header\">アイテム</h3>\n    <div class=\"widget-content\">\n        <ul>\n        </mt:AssetsHeader>\n        <li class=\"item\"><a class=\"asset-image\" href=\"<$mt:AssetURL$>\"><img src=\"<$mt:AssetThumbnailURL height=\"70\"$>\" class=\"asset-img-thumb\" alt=\"<$mt:AssetLabel$>\" title=\"<$mt:AssetLabel$>\" /></a></li>\n        <mt:AssetsFooter>\n        </ul>\n    </div>\n</div>\n        </mt:AssetsFooter>\n    </mt:Assets>\n</mt:If>\n','widget',0),(7,1,0,0,1,1,'2014-11-02 00:12:58','rsd',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','RSD','rsd.xml',1,'<$mt:HTTPContentType type=\"application/rsd+xml\"$><?xml version=\"1.0\"?>\n<rsd version=\"1.0\" xmlns=\"http://archipelago.phrasewise.com/rsd\">\n<service>\n<engineName><$mt:ProductName version=\"1\"$></engineName>\n<engineLink>http://www.sixapart.com/movabletype/</engineLink>\n<homePageLink><$mt:BlogURL$></homePageLink>\n<apis>\n<api name=\"MetaWeblog\" preferred=\"true\" apiLink=\"<$mt:CGIPath$><$mt:XMLRPCScript$>\" blogID=\"<$mt:BlogID$>\" />\n<api name=\"MovableType\" preferred=\"false\" apiLink=\"<$mt:CGIPath$><$mt:XMLRPCScript$>\" blogID=\"<$mt:BlogID$>\" />\n<api name=\"Blogger\" preferred=\"false\" apiLink=\"<$mt:CGIPath$><$mt:XMLRPCScript$>\" blogID=\"<$mt:BlogID$>\" />\n<api name=\"Atom\" preferred=\"false\" apiLink=\"<$mt:CGIPath$><$mt:AtomScript$>/weblog\" blogID=\"<$mt:BlogID$>\" />\n</apis>\n</service>\n</rsd>\n','index',0),(8,1,0,0,1,1,'2014-11-02 00:12:58','monthly_archive_dropdown',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','月別アーカイブ(ドロップダウン)',NULL,1,'<mt:IfArchiveTypeEnabled archive_type=\"Monthly\">\n    <mt:ArchiveList archive_type=\"Monthly\">\n        <mt:ArchiveListHeader>\n<div class=\"widget-archive-monthly-dropdown widget-archive widget\">\n   <h3 class=\"widget-header\"><a href=\"<$mt:BlogURL$>archives.html\">アーカイブ</a></h3>\n   <div class=\"widget-content\">\n      <select onchange=\"nav(this)\">\n         <option>月を選択...</option>\n         </mt:ArchiveListHeader>\n         <option value=\"<$mt:ArchiveLink$>\"><$mt:ArchiveTitle$></option>\n         <mt:ArchiveListFooter>\n      </select>\n   </div>\n</div>\n<script type=\"text/javascript\" charset=\"utf-8\">\n/* <![CDATA[ */\nfunction nav(sel) {\n   if (sel.selectedIndex == -1) return;\n   var opt = sel.options[sel.selectedIndex];\n   if (opt && opt.value)\n      location.href = opt.value;\n}\n/* ]]> */\n</script>\n        </mt:ArchiveListFooter>\n    </mt:ArchiveList>\n</mt:IfArchiveTypeEnabled>\n','widget',0),(9,1,0,0,1,1,'2014-11-02 00:12:58','styles',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','スタイルシート','styles.css',1,'@import url(<$mt:StaticWebPath$>themes-base/blog.css);\n@import url(<$mt:StaticWebPath$>themes/minimalist-red/screen.css);\n','index',0),(10,1,0,0,1,1,'2014-11-02 00:12:58','feed_recent',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','最新記事のフィード','atom.xml',1,'<$mt:HTTPContentType type=\"application/atom+xml\"$><?xml version=\"1.0\" encoding=\"<$mt:PublishCharset$>\"?>\n<feed xmlns=\"http://www.w3.org/2005/Atom\">\n    <title><$mt:BlogName remove_html=\"1\" encode_xml=\"1\"$></title>\n    <link rel=\"alternate\" type=\"text/html\" href=\"<$mt:BlogURL encode_xml=\"1\"$>\" />\n    <link rel=\"self\" type=\"application/atom+xml\" href=\"<$mt:Link template=\"feed_recent\"$>\" />\n    <id>tag:<$mt:BlogHost exclude_port=\"1\" encode_xml=\"1\"$>,<$mt:TemplateCreatedOn format=\"%Y-%m-%d\"$>:<$mt:BlogRelativeURL encode_xml=\"1\"$>/<$mt:BlogID$></id>\n    <updated><mt:Entries blog_ids=\"children\" include_with_website=\"1\" lastn=\"1\"><$mt:EntryModifiedDate utc=\"1\" format=\"%Y-%m-%dT%H:%M:%SZ\"$></mt:Entries></updated>\n    <mt:If tag=\"BlogDescription\"><subtitle><$mt:BlogDescription remove_html=\"1\" encode_xml=\"1\"$></subtitle></mt:If>\n    <generator uri=\"http://www.sixapart.com/movabletype/\"><$mt:ProductName version=\"1\"$></generator>\n<mt:Entries blog_ids=\"children\" include_with_website=\"1\" lastn=\"15\">\n<entry>\n    <title><$mt:EntryTitle remove_html=\"1\" encode_xml=\"1\"$> - <$mt:EntryBlogName$></title>\n    <link rel=\"alternate\" type=\"text/html\" href=\"<$mt:EntryPermalink encode_xml=\"1\"$>\" />\n    <id><$mt:EntryAtomID$></id>\n\n    <published><$mt:EntryDate utc=\"1\" format=\"%Y-%m-%dT%H:%M:%SZ\"$></published>\n    <updated><$mt:EntryModifiedDate utc=\"1\" format=\"%Y-%m-%dT%H:%M:%SZ\"$></updated>\n\n    <summary><$mt:EntryExcerpt remove_html=\"1\" encode_xml=\"1\"$></summary>\n    <author>\n        <name><$mt:EntryAuthorDisplayName encode_xml=\"1\"$></name>\n        <mt:If tag=\"EntryAuthorURL\"><uri><$mt:EntryAuthorURL encode_xml=\"1\"$></uri></mt:If>\n    </author>\n    <mt:EntryCategories>\n        <category term=\"<$mt:CategoryLabel encode_xml=\"1\"$>\" scheme=\"http://www.sixapart.com/ns/types#category\" />\n    </mt:EntryCategories>\n    <mt:EntryIfTagged><mt:EntryTags><category term=\"<$mt:TagName normalize=\"1\" encode_xml=\"1\"$>\" label=\"<$mt:TagName encode_xml=\"1\"$>\" scheme=\"http://www.sixapart.com/ns/types#tag\" />\n    </mt:EntryTags></mt:EntryIfTagged>\n    <content type=\"html\" xml:lang=\"<$mt:BlogLanguage ietf=\"1\"$>\" xml:base=\"<$mt:BlogURL encode_xml=\"1\"$>\">\n        <$mt:EntryBody encode_xml=\"1\"$>\n        <$mt:EntryMore encode_xml=\"1\"$>\n    </content>\n</entry>\n</mt:Entries>\n</feed>\n','index',0),(11,1,0,0,1,1,'2014-11-02 00:12:58','entry',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','記事',NULL,1,'<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\"\n    \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\" id=\"sixapart-standard\">\n<head>\n    <$mt:Include module=\"HTMLヘッダー\"$>\n    <$mt:Var name=\"comments_per_page\" value=\"50\"$>\n    <mt:EntryPrevious><link rel=\"prev bookmark\" href=\"<$mt:EntryPermalink$>\" title=\"<$mt:EntryTitle encode_html=\"1\"$>\" /></mt:EntryPrevious>\n    <mt:EntryNext><link rel=\"next bookmark\" href=\"<$mt:EntryPermalink$>\" title=\"<$mt:EntryTitle encode_html=\"1\"$>\" /></mt:EntryNext>\n    <$mt:EntryTrackbackData$>\n    <mt:If tag=\"EntryCommentCount\" gt=\"$comments_per_page\">\n    <script type=\"text/javascript\">\n        MT.entryID = <$mt:EntryID$>;\n        MT.commentsPerPage = <$mt:Var name=\"comments_per_page\"$>;\n        MT.entryCommentCount = <$mt:EntryCommentCount$>;\n        MT.commentIds = [<mt:Comments sort_order=\"ascend\" glue=\",\"><mt:CommentID></mt:Comments>];\n    </script>\n    </mt:If>\n    <title><$mt:EntryTitle encode_html=\"1\"$> - <$mt:BlogName encode_html=\"1\"$></title>\n</head>\n<body id=\"<$mt:WebsiteThemeID$>\" class=\"mt-entry-archive <$mt:Var name=\"page_layout\"$>\">\n    <div id=\"container\">\n        <div id=\"container-inner\">\n\n\n            <$mt:Include module=\"バナーヘッダー\"$>\n\n\n            <div id=\"content\">\n                <div id=\"content-inner\">\n\n\n                    <div id=\"alpha\">\n                        <div id=\"alpha-inner\">\n\n\n                            <div id=\"entry-<$mt:EntryID$>\" class=\"entry-asset asset hentry\">\n                                <div class=\"asset-header\">\n                                    <h1 id=\"page-title\" class=\"asset-name entry-title\"><$mt:EntryTitle$></h1>\n                                    <div class=\"asset-meta\">\n                                        <span class=\"byline\">\n<mt:If tag=\"EntryAuthorDisplayName\">\n                                            <span class=\"vcard author\"><$mt:EntryAuthorLink show_hcard=\"1\"$></span> (<abbr class=\"published\" title=\"<$mt:EntryDate format_name=\"iso8601\"$>\"><$mt:EntryDate format=\"%x %X\"$></abbr>)\n<mt:Else>\n                                            <abbr class=\"published\" title=\"<$mt:EntryDate format_name=\"iso8601\"$>\"><$mt:EntryDate format=\"%x %X\"$></abbr>\n</mt:If>\n                                        </span>\n<mt:IfCommentsActive>\n                                        <span class=\"separator\">|</span> <a href=\"<$mt:EntryPermalink$>#comments\"><$mt:EntryCommentCount singular=\"コメント(1)\" plural=\"コメント(#)\" none=\"コメント(0)\"$></a>\n</mt:IfCommentsActive>\n<mt:IfPingsActive>\n                                        <span class=\"separator\">|</span> <a href=\"<$mt:EntryPermalink$>#trackbacks\"><$mt:EntryTrackbackCount singular=\"トラックバック(1)\" plural=\"トラックバック(#)\" none=\"トラックバック(0)\"$></a>\n</mt:IfPingsActive>\n                                    </div>\n                                </div>\n                                <div class=\"asset-content entry-content\">\n<mt:If tag=\"EntryBody\">\n                                    <div class=\"asset-body\">\n                                        <$mt:EntryBody$>\n                                    </div>\n</mt:If>\n<mt:If tag=\"EntryMore\" convert_breaks=\"0\">\n                                    <div id=\"more\" class=\"asset-more\">\n                                        <$mt:EntryMore$>\n                                    </div>\n</mt:If>\n                                </div>\n                                <div class=\"asset-footer\">\n<mt:IfArchiveTypeEnabled archive_type=\"Category\">\n    <mt:If tag=\"EntryCategories\">\n                                    <div class=\"entry-categories\">\n                                        <h4>カテゴリ<span class=\"delimiter\">:</span></h4>\n                                        <ul>\n                                            <li class=\"entry-category\"><mt:EntryCategories glue=\'<span class=\"delimiter\">,</span></li> <li class=\"entry-category\">\'><a href=\"<$mt:CategoryArchiveLink$>\" rel=\"tag\"><$mt:CategoryLabel$></a></mt:EntryCategories></li>\n                                        </ul>\n                                    </div>\n    </mt:If>\n</mt:IfArchiveTypeEnabled>\n<mt:EntryIfTagged>\n                                    <div class=\"entry-tags\">\n                                        <h4>タグ<span class=\"delimiter\">:</span></h4>\n                                        <ul>\n                                            <li><mt:EntryTags glue=\'<span class=\"delimiter\">,</span></li> <li>\'><a href=\"javascript:void(0)\" onclick=\"location.href=\'<$mt:TagSearchLink encode_js=\"1\"$>\';return false;\" rel=\"tag\"><$mt:TagName$></a></mt:EntryTags></li>\n                                        </ul>\n                                    </div>\n</mt:EntryIfTagged>\n                                </div>\n                            </div>\n\n\n                    <$mt:Include module=\"トラックバック\"$>\n                    <$mt:Include module=\"コメント\"$>\n\n\n                        </div>\n                    </div>\n\n\n                    <$mt:Include module=\"サイドバー\"$>\n\n\n                </div>\n            </div>\n\n\n            <$mt:Include module=\"バナーフッター\"$>\n\n\n        </div>\n    </div>\n</body>\n</html>\n','individual',0),(12,1,0,0,1,1,'2014-11-02 00:12:58','category_archive_list',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','カテゴリアーカイブ',NULL,1,'<mt:IfArchiveTypeEnabled archive_type=\"Category\">\n<div class=\"widget-archive widget-archive-category widget\">\n    <h3 class=\"widget-header\">カテゴリ</h3>\n    <div class=\"widget-content\">\n    <mt:TopLevelCategories>\n        <mt:SubCatIsFirst>\n        <ul>\n        </mt:SubCatIsFirst>\n        <mt:If tag=\"CategoryCount\">\n            <li><a href=\"<$mt:CategoryArchiveLink$>\"<mt:If tag=\"CategoryDescription\"> title=\"<$mt:CategoryDescription remove_html=\"1\" encode_html=\"1\"$>\"</mt:If>><$mt:CategoryLabel$> (<$mt:CategoryCount$>)</a>\n        <mt:Else>\n            <li><$mt:CategoryLabel$>\n        </mt:If>\n        <$mt:SubCatsRecurse$>\n            </li>\n        <mt:SubCatIsLast>\n        </ul>\n        </mt:SubCatIsLast>\n    </mt:TopLevelCategories>\n    </div>\n</div>\n</mt:IfArchiveTypeEnabled>\n','widget',0),(13,1,0,0,1,1,'2014-11-02 00:12:58','monthly_archive_list',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','月別アーカイブ',NULL,1,'<mt:IfArchiveTypeEnabled archive_type=\"Monthly\">\n    <mt:ArchiveList archive_type=\"Monthly\">\n        <mt:ArchiveListHeader>\n<div class=\"widget-archive-monthly widget-archive widget\">\n    <h3 class=\"widget-header\"><$mt:ArchiveTypeLabel$> <a href=\"<$mt:Link template=\"archive_index\"$>\">アーカイブ</a></h3>\n    <div class=\"widget-content\">\n        <ul>\n        </mt:ArchiveListHeader>\n            <li><a href=\"<$mt:ArchiveLink$>\"><$mt:ArchiveTitle$> (<$mt:ArchiveCount$>)</a></li>\n        <mt:ArchiveListFooter>\n        </ul>\n    </div>\n</div>\n        </mt:ArchiveListFooter>\n    </mt:ArchiveList>\n</mt:IfArchiveTypeEnabled>\n','widget',0),(14,1,0,0,1,1,'2014-11-02 00:12:58','popup_image',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','ポップアップ画像',NULL,1,'<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\" id=\"sixapart-standard\">\n<head><title><$mt:ImageURL$></title></head>\n<body id=\"uploaded-image-popup\" class=\"popup\" style=\"margin: 0;padding: 0;\">\n    <img src=\"<$mt:ImageURL$>\" width=\"<$mt:ImageWidth$>\" height=\"<$mt:ImageHeight$>\" alt=\"<$mt:ImageURL$>\" style=\"margin: 0;padding: 0;border: 0;\" />\n</body>\n</html>\n','popup_image',0),(15,1,0,0,1,1,'2014-11-02 00:12:58','tag_cloud',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','タグクラウド',NULL,1,'<mt:Tags top=\"20\" include_blogs=\"children\" include_with_website=\"1\">\n<mt:If name=\"__first__\">\n<div class=\"widget-tag-cloud widget\">\n    <h3 class=\"widget-header\">タグクラウド</h3>\n    <div class=\"widget-content\">\n        <ul>\n</mt:If>\n            <li class=\"rank-<$mt:TagRank max=\"10\"$>\"><a href=\"javascript:void(0)\" onclick=\"location.href=\'<$mt:TagSearchLink encode_js=\"1\"$>\';return false;\" rel=\"tag\"><$mt:TagName$></a></li>\n<mt:If name=\"__last__\">\n        </ul>\n    </div>\n</div>\n</mt:If>\n</mt:Tags>\n','widget',0),(16,1,0,0,1,1,'2014-11-02 00:12:58','banner_header',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','バナーヘッダー',NULL,1,'<div id=\"header\">\n    <div id=\"header-inner\">\n        <div id=\"header-content\">\n<mt:Ignore><!-- Use h1 and h2 html tags on the main index of the blog as the title, use divs on all other pages where there are page titles. --></mt:Ignore>\n<mt:If name=\"main_index\">\n            <h1 id=\"header-name\"><a href=\"<$mt:BlogURL$>\" accesskey=\"1\"><$mt:BlogName encode_html=\"1\"$></a></h1>\n            <h2 id=\"header-description\"><$mt:BlogDescription$></h2>\n<mt:Else>\n            <div id=\"header-name\"><a href=\"<$mt:BlogURL$>\" accesskey=\"1\"><$mt:BlogName encode_html=\"1\"$></a></div>\n            <div id=\"header-description\"><$mt:BlogDescription$></div>\n</mt:If>\n        </div>\n    </div>\n</div>\n','custom',0),(17,1,0,0,1,1,'2014-11-02 00:12:58','technorati_search',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','Technorati Search',NULL,1,'<div class=\"widget-technorati widget\">\n    <h3 class=\"widget-header\">Techonrati</h3>\n    <div class=\"widget-content\">\n        <div id=\"technorati\">\n            <form id=\"ts_s\" method=\"post\" action=\"http://technorati.com/search.php\">\n                <fieldset>\n                    <legend><a href=\'http://www.technorati.com/\'>Technorati</a> search</legend>\n                    <input type=\"hidden\" name=\"sub\" value=\"searchlet\" />\n                    <input type=\"text\" id=\"ts_search\" name=\"s\" size=\"12\" maxlength=\"255\" value=\"\" /><br />\n                    <input type=\"radio\" checked=\"checked\" name=\"from\" id=\"ts_yb\" value=\"<$mt:BlogURL$>\" />\n                    <label for=\"ts_yb\" title=\"<$mt:BlogName$>\">このブログ</label>\n                    <input type=\"radio\" name=\"from\" id=\"ts_www\" value=\"\" /> <label for=\"ts_www\">すべてのブログ</label>\n                    <input type=\"submit\" class=\"btn\" value=\"検索\" />\n                </fieldset>\n            </form>\n            <p id=\"ts_l\" class=\"ts_l\"><a href=\"http://technorati.com/search/<$mt:BlogURL$>\" id=\"ts_lh\">&#187; リンクしているブログ</a></p>\n        </div>\n    </div>\n</div>\n','widget',0),(18,1,0,0,1,1,'2014-11-02 00:12:58','recent_entries',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','最近の記事',NULL,1,'<mt:If tag=\"BlogEntryCount\" include_blogs=\"children\" include_with_website=\"1\">\n    <mt:Entries lastn=\"10\" include_blogs=\"children\" include_with_website=\"1\">\n        <mt:EntriesHeader>\n<div class=\"widget-recent-entries widget-archives widget\">\n    <h3 class=\"widget-header\">最近の記事</h3>\n    <div class=\"widget-content\">\n        <ul>\n        </mt:EntriesHeader>\n            <li><a href=\"<$mt:EntryPermalink$>\"><$mt:EntryTitle$></a> - <a href=\"<$mt:EntryBlogURL$>\"><$mt:EntryBlogName$></a></li>\n        <mt:EntriesFooter>\n        </ul>\n    </div>\n</div>\n        </mt:EntriesFooter>\n    </mt:Entries>\n</mt:If>\n','widget',0),(19,1,0,0,1,1,'2014-11-02 00:12:58','author_archive_list',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','ユーザーアーカイブ',NULL,1,'<mt:IfArchiveTypeEnabled archive_type=\"Author\">\n    <mt:ArchiveList archive_type=\"Author\">\n        <mt:ArchiveListHeader>\n<div class=\"widget-archive widget-archive-author widget\">\n    <h3 class=\"widget-header\">ユーザー</h3>\n    <div class=\"widget-content\">\n        <ul>\n        </mt:ArchiveListHeader>\n            <li><a href=\"<$mt:ArchiveLink$>\"><$mt:ArchiveTitle$> (<$mt:ArchiveCount$>)</a></li>\n        <mt:ArchiveListFooter>\n        </ul>\n    </div>\n</div>\n        </mt:ArchiveListFooter>\n    </mt:ArchiveList>\n</mt:IfArchiveTypeEnabled>\n','widget',0),(20,1,0,0,1,1,'2014-11-02 00:12:58','powered_by',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','Powered By',NULL,1,'<div class=\"widget-powered widget\">\n    <div class=\"widget-content\">\n        <a href=\"http://www.sixapart.jp/movabletype/\"><img src=\"<$mt:StaticWebPath$>images/bug-pbmt-white.png\" alt=\"Powered by Movable Type <$mt:Version$>\" width=\"80\" height=\"61\" /></a>\n    </div>\n</div>\n','widget',0),(21,1,0,0,1,1,'2014-11-02 00:12:58','date_based_author_archives',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','日付ベースのユーザーアーカイブ',NULL,1,'<mt:IfArchiveTypeEnabled archive_type=\"Author-Yearly\">\n    <mt:ArchiveList archive_type=\"Author-Yearly\">\n        <mt:ArchiveListHeader>\n<div class=\"widget-archive-author-yearly widget-archive widget\">\n    <h3 class=\"widget-header\">年別ユーザーアーカイブ</h3>\n    <div class=\"widget-content\">\n        <ul>\n        </mt:ArchiveListHeader>\n            <li><a href=\"<$mt:ArchiveLink$>\"><$mt:ArchiveTitle$> (<$mt:ArchiveCount$>)</a></li>\n        <mt:ArchiveListFooter>\n        </ul>\n    </div>\n</div>\n        </mt:ArchiveListFooter>\n    </mt:ArchiveList>\n</mt:IfArchiveTypeEnabled>\n\n<mt:IfArchiveTypeEnabled archive_type=\"Author-Monthly\">\n    <mt:ArchiveList archive_type=\"Author-Monthly\">\n        <mt:ArchiveListHeader>\n<div class=\"widget-archive-author-monthly widget-archive widget\">\n    <h3 class=\"widget-header\">月別ユーザーアーカイブ</h3>\n    <div class=\"widget-content\">\n        <ul>\n        </mt:ArchiveListHeader>\n            <li><a href=\"<$mt:ArchiveLink$>\"><$mt:ArchiveTitle$> (<$mt:ArchiveCount$>)</a></li>\n        <mt:ArchiveListFooter>\n        </ul>\n    </div>\n</div>\n        </mt:ArchiveListFooter>\n    </mt:ArchiveList>\n</mt:IfArchiveTypeEnabled>\n\n<mt:IfArchiveTypeEnabled archive_type=\"Author-Weekly\">\n    <mt:ArchiveList archive_type=\"Author-Weekly\">\n        <mt:ArchiveListHeader>\n<div class=\"widget-archive-author-weekly widget-archive widget\">\n    <h3 class=\"widget-header\">週別ユーザーアーカイブ</h3>\n    <div class=\"widget-content\">\n        <ul>\n        </mt:ArchiveListHeader>\n            <li><a href=\"<$mt:ArchiveLink$>\"><$mt:ArchiveTitle$> (<$mt:ArchiveCount$>)</a></li>\n        <mt:ArchiveListFooter>\n        </ul>\n    </div>\n</div>\n        </mt:ArchiveListFooter>\n    </mt:ArchiveList>\n</mt:IfArchiveTypeEnabled>\n\n<mt:IfArchiveTypeEnabled archive_type=\"Author-Daily\">\n    <mt:ArchiveList archive_type=\"Author-Daily\">\n        <mt:ArchiveListHeader>\n<div class=\"widget-archive-author-daily widget-archive widget\">\n    <h3 class=\"widget-header\">日別ユーザーアーカイブ</h3>\n    <div class=\"widget-content\">\n        <ul>\n        </mt:ArchiveListHeader>\n            <li><a href=\"<$mt:ArchiveLink$>\"><$mt:ArchiveTitle$> (<$mt:ArchiveCount$>)</a></li>\n        <mt:ArchiveListFooter>\n        </ul>\n    </div>\n</div>\n        </mt:ArchiveListFooter>\n    </mt:ArchiveList>\n</mt:IfArchiveTypeEnabled>\n\n','widget',0),(22,1,0,0,1,1,'2014-11-02 00:12:58','pages_list',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','ページ一覧',NULL,1,'<mt:IfArchiveTypeEnabled archive_type=\"Page\">\n<div class=\"widget-pages widget\">\n    <h3 class=\"widget-header\">ウェブページ</h3>\n    <div class=\"widget-content\">\n        <ul>\n    <mt:Pages no_folder=\"1\" sort_by=\"title\" sort_order=\"ascend\">\n            <li class=\"page page-<$mt:PageID$>\"><a href=\"<$mt:PagePermalink$>\"><$mt:PageTitle$></a></li>\n    </mt:Pages>\n    <mt:TopLevelFolders>\n            <li class=\"folder folder-<$mt:FolderID$>\"><strong><$mt:FolderLabel$></strong>\n        <mt:Pages sort_by=\"title\" sort_order=\"ascend\">\n            <mt:PagesHeader>\n                <ul>\n            </mt:PagesHeader>\n                    <li class=\"page page-<$mt:PageID$>\"><a href=\"<$mt:PagePermalink$>\"><$mt:PageTitle$></a></li>\n            <mt:PagesFooter>\n                </ul>\n            </mt:PagesFooter>\n        </mt:Pages>\n            </li>\n        <$mt:SubFolderRecurse$>\n    </mt:TopLevelFolders>\n        </ul>\n    </div>\n</div>\n</mt:IfArchiveTypeEnabled>\n','widget',0),(23,1,0,0,1,1,'2014-11-02 00:12:58','comments',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','コメント',NULL,1,'<mt:Ignore>\n<!-- Display comments for the entry/page or commenting form if entry/page is accepting comments -->\n</mt:Ignore>\n<mt:IfCommentsActive>\n\n<div id=\"comments\" class=\"comments\">\n\n\n    <mt:Ignore>\n    <!-- Display comments -->\n    </mt:Ignore>\n    <mt:Comments lastn=\"$comments_per_page\">\n        <mt:CommentsHeader>\n    <h2 class=\"comments-header\"><$mt:EntryCommentCount singular=\"コメント(1)\" plural=\"コメント(#)\" none=\"コメント(0)\"$></h2>\n            <mt:If tag=\"EntryCommentCount\" gt=\"$comments_per_page\">\n    <ul id=\"top-comment-nav\">\n        <li id=\"top-prev-comments\">\n            <a href=\"javascript://\" id=\"top-prev-comments-link\" title=\"前\">&lt;&lt;&nbsp;前</a>\n        </li>\n        <li id=\"top-num-comments\">\n            <span id=\"top-current-comments\"></span>\n        </li>\n        <li id=\"top-next-comments\">\n            <a href=\"javascript://\" id=\"top-next-comments-link\" title=\"次\">次&nbsp;&gt;&gt;</a>\n        </li>\n    </ul>\n            </mt:If>\n    <div id=\"comments-content\" class=\"comments-content\">\n        </mt:CommentsHeader>\n        <$mt:Include module=\"コメント詳細\"$>\n        <mt:CommentsFooter>\n    </div>\n            <mt:If tag=\"EntryCommentCount\" gt=\"$comments_per_page\">\n                <mt:Ignore>ページネーションスクリプトによって変更されています。</mt:Ignore>\n    <ul id=\"comment-nav\">\n        <li id=\"prev-comments\">\n            <a href=\"javascript://\" id=\"prev-comments-link\" title=\"前\">&lt;&lt;&nbsp;前</a>\n        </li>\n        <li id=\"num-comments\">\n            <span id=\"current-comments\"></span>\n        </li>\n        <li id=\"next-comments\">\n            <a href=\"javascript://\" id=\"next-comments-link\" title=\"次\">次&nbsp;&gt;&gt;</a>\n        </li>\n    </ul>\n            </mt:If>\n        </mt:CommentsFooter>\n    </mt:Comments>\n    <mt:Ignore>\n    <!-- Display commenting form if entry/page is accepting comments -->\n    </mt:Ignore>\n    <mt:IfCommentsAccepted>\n    <div class=\"comments-open\" id=\"comments-open\">\n        <h2 class=\"comments-open-header\">コメントする</h2>\n        <div class=\"comments-open-content\">\n\n        <mt:Ignore>\n        <!-- Display greeting for users if blog allows users to register locally -->\n        </mt:Ignore>\n            <div id=\"comment-greeting\"></div>\n\n            <form method=\"post\" action=\"<$mt:CGIPath$><$mt:CommentScript$>\" name=\"comments_form\" id=\"comments-form\" onsubmit=\"return mtCommentOnSubmit(this)\">\n                <input type=\"hidden\" name=\"static\" value=\"1\" />\n                <input type=\"hidden\" name=\"entry_id\" value=\"<$mt:EntryID$>\" />\n                <input type=\"hidden\" name=\"__lang\" value=\"<$mt:BlogLanguage$>\" />\n                <input type=\"hidden\" name=\"parent_id\" value=\"<$mt:CommentParentID escape=\"html\"$>\" id=\"comment-parent-id\" />\n                <input type=\"hidden\" name=\"armor\" value=\"1\" />\n                <input type=\"hidden\" name=\"preview\" value=\"\" />\n                <input type=\"hidden\" name=\"sid\" value=\"\" />\n                <div id=\"comments-open-data\">\n                    <div id=\"comment-form-name\">\n                        <label for=\"comment-author\">名前</label>\n                        <input id=\"comment-author\" name=\"author\" size=\"30\" value=\"\" onfocus=\"mtCommentFormOnFocus()\" />\n                    </div>\n                    <div id=\"comment-form-email\">\n                        <label for=\"comment-email\">電子メール</label>\n                        <input id=\"comment-email\" name=\"email\" size=\"30\" value=\"\" onfocus=\"mtCommentFormOnFocus()\" />\n                    </div>\n                    <div id=\"comment-form-url\">\n                        <label for=\"comment-url\">URL</label>\n                        <input id=\"comment-url\" name=\"url\" size=\"30\" value=\"\" onfocus=\"mtCommentFormOnFocus()\" />\n                    </div>\n                    <div id=\"comment-form-remember-me\">\n                        <input type=\"checkbox\" id=\"comment-bake-cookie\" name=\"bakecookie\" onclick=\"mtRememberMeOnClick(this)\" value=\"1\" accesskey=\"r\" />\n                        <label for=\"comment-bake-cookie\">サインイン情報を記憶</label>\n                    </div>\n                </div>\n                <div id=\"comment-form-reply\" style=\"display:none\">\n                    <input type=\"checkbox\" id=\"comment-reply\" name=\"comment_reply\" value=\"\" onclick=\"mtSetCommentParentID()\" />\n                    <label for=\"comment-reply\" id=\"comment-reply-label\"></label>\n                </div>\n                <div id=\"comments-open-text\">\n                    <label for=\"comment-text\">コメント\n                    <mt:IfAllowCommentHTML>(スタイル用のHTMLタグを使えます)</mt:IfAllowCommentHTML></label>\n                    <textarea id=\"comment-text\" name=\"text\" rows=\"15\" cols=\"50\" onfocus=\"mtCommentFormOnFocus()\"></textarea>\n                </div>\n                <div id=\"comments-open-captcha\"></div>\n                <div id=\"comments-open-footer\">\n                    <input type=\"submit\" accesskey=\"v\" name=\"preview_button\" id=\"comment-preview\" value=\"プレビュー\" onclick=\"this.form.preview.value=\'1\';\" />\n                    <input type=\"submit\" accesskey=\"s\" name=\"post\" id=\"comment-submit\" value=\"投稿\" />\n                </div>\n            </form>\n\n\n        </div>\n    </div>\n    <script type=\"text/javascript\">\n    <!--\n    mtAttachEvent(\"load\", mtEntryOnLoad);\n    mtAttachEvent(\"unload\", mtEntryOnUnload);\n    //-->\n    </script>\n    </mt:IfCommentsAccepted>\n\n\n</div>\n</mt:IfCommentsActive>\n','custom',0),(24,1,0,0,1,1,'2014-11-02 00:12:58','sidebar',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','サイドバー',NULL,1,'<mt:Ignore><!-- \n#\n#  The sidebar is made up of one or two columns.\n#  For 2-column designs, just beta.\n#  For 3-column designs, beta and gamma.\n#\n--></mt:Ignore>\n\n\n<div id=\"beta\">\n    <div id=\"beta-inner\">\n\n<mt:If name=\"page_columns\" eq=\"2\">\n    <mt:Ignore><!-- Use the 2-column layout Sidebar if page layout is layout-wt or layout-tw. --></mt:Ignore>\n    <$mt:WidgetSet name=\"2カラムのサイドバー\"$>\n<mt:Else name=\"page_columns\" eq=\"3\">\n    <mt:Ignore><!-- Use the 3-column layout Primary Sidebar if page layout is layout-wtt or layout-twt. --></mt:Ignore>\n    <$mt:WidgetSet name=\"3カラムのサイドバー(メイン)\"$>\n</mt:If>\n\n    </div>\n</div>\n\n\n<mt:If name=\"page_columns\" eq=\"3\">\n    <mt:Ignore><!-- Use the 3-column layout Secondary Sidebar if page layout is layout-wtt or layout-twt. --></mt:Ignore>\n<div id=\"gamma\">\n    <div id=\"gamma-inner\">\n    <$mt:WidgetSet name=\"3カラムのサイドバー(サブ)\"$>\n    </div>\n</div>\n</mt:If>\n','custom',0),(25,1,0,0,1,1,'2014-11-02 00:12:58','page',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','ウェブページ',NULL,1,'<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\"\n    \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\" id=\"sixapart-standard\">\n<head>\n    <$mt:Include module=\"HTMLヘッダー\"$>\n    <$mt:EntryTrackbackData$>\n    <$mt:Var name=\"comments_per_page\" value=\"50\"$>\n    <mt:If tag=\"EntryCommentCount\" gt=\"$comments_per_page\">\n	    <script type=\"text/javascript\">\n         MT.entryID = <$mt:PageID$>;\n         MT.commentsPerPage = <$mt:Var name=\"comments_per_page\"$>;\n         MT.entryCommentCount = <$mt:EntryCommentCount$>;\n         MT.commentIds = [<mt:Comments sort_order=\"ascend\" glue=\",\"><mt:CommentID></mt:Comments>];\n	    </script>\n    </mt:If>\n    <title><$mt:PageTitle encode_html=\"1\"$> - <$mt:BlogName encode_html=\"1\"$></title>\n</head>\n<body id=\"<$mt:WebsiteThemeID$>\" class=\"mt-page-archive <$mt:Var name=\"page_layout\"$>\">\n    <div id=\"container\">\n        <div id=\"container-inner\">\n\n\n            <$mt:Include module=\"バナーヘッダー\"$>\n\n\n            <div id=\"content\">\n                <div id=\"content-inner\">\n\n\n                    <div id=\"alpha\">\n                        <div id=\"alpha-inner\">\n\n\n                            <div id=\"page-<$mt:PageID$>\" class=\"page-asset asset\">\n                                <div class=\"asset-header\">\n                                    <h1 id=\"page-title\" class=\"asset-name\"><$mt:PageTitle$></h1>\n                                </div>\n                                <div class=\"asset-content\">\n<mt:If tag=\"PageBody\">\n                                    <div class=\"asset-body\">\n                                        <$mt:PageBody$>\n                                    </div>\n</mt:If>\n<mt:If tag=\"PageMore\">\n                                    <div id=\"more\" class=\"asset-more\">\n                                        <$mt:PageMore$>\n                                    </div>\n</mt:If>\n                                </div>\n                                <div class=\"asset-footer\"></div>\n                            </div>\n\n\n                    <$mt:Include module=\"トラックバック\"$>\n                    <$mt:Include module=\"コメント\"$>\n\n\n                        </div>\n                    </div>\n\n\n                    <$mt:Include module=\"サイドバー\"$>\n\n\n                </div>\n            </div>\n\n\n            <$mt:Include module=\"バナーフッター\"$>\n\n\n        </div>\n    </div>\n</body>\n</html>\n','page',0),(26,1,0,0,1,1,'2014-11-02 00:12:58','comment_detail',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','コメント詳細',NULL,1,'<div id=\"comment-<$mt:CommentID$>\" class=\"comment<mt:IfCommentParent> comment-reply</mt:IfCommentParent><mt:IfCommenterIsEntryAuthor> entry-author-comment</mt:IfCommenterIsEntryAuthor>\">\n    <div class=\"inner\">\n        <div class=\"comment-header\">\n            <div class=\"asset-meta\">\n                <span class=\"byline\">\n                    <$mt:CommentAuthorIdentity$>\n<mt:IfCommentParent>\n                    <span class=\"vcard author\"><$mt:CommentAuthorLink$></span>から<a href=\"<mt:CommentParent><$mt:CommentLink$></mt:CommentParent>\"><mt:CommentParent><$mt:CommentAuthor$></mt:CommentParent></a>への返信\n<mt:Else>\n                    <span class=\"vcard author\"><$mt:CommentAuthorLink$></span>\n</mt:IfCommentParent>\n                    | <a href=\"<$mt:CommentLink$>\"><abbr class=\"published\" title=\"<$mt:CommentDate format_name=\"iso8601\"$>\"><$mt:CommentDate$></abbr></a>\n<mt:IfCommentsAccepted>\n                    | <$mt:CommentReplyToLink$>\n</mt:IfCommentsAccepted>\n                </span>\n            </div>\n        </div>\n        <div class=\"comment-content\">\n            <$mt:CommentBody$>\n        </div>\n    </div>\n</div>','custom',0),(27,1,0,0,1,1,'2014-11-02 00:12:58','signin',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','サインイン',NULL,1,'<mt:IfRegistrationAllowed>\n<div class=\"widget-sign-in widget\">\n    <h3 class=\"widget-header\">サインイン</h3>\n    <div id=\"signin-widget-content\" class=\"widget-content\"></div>\n</div>\n<script type=\"text/javascript\">\n/* <![CDATA[ */\nfunction mtUpdateSignInWidget(u) {\n    var el = document.getElementById(\'signin-widget-content\');\n    var content = \'\';\n    if (!el) return;\n    if (u) {\n        if (u && u.is_authenticated) {\n            user = u;\n            mtSaveUser();\n        } else {\n            // user really isn\'t logged in; so let\'s do this!\n            return mtSignIn();\n        }\n    } else {\n        u = mtGetUser();\n    }\n    if (u && u.name) {\n        var url;\n        if (u.is_authenticated) {\n            if (u.is_author) {\n                url = \'<$mt:CGIPath$><$mt:CommentScript$>?__mode=edit_profile\';\n                url += \'&return_url=\' + encodeURIComponent( location.href );\n            } else {\n                url = u.url;\n            }\n        } else if (u.url) {\n            url = u.url;\n        } else {\n            url = null;\n        }\n        var content = \'ユーザー名:\';\n        if (url)\n            content += \'<a href=\"\' + url + \'\">\' + u.name + \'</a>\';\n        else\n            content += u.name;\n        content += \'.  (<a href=\"javascript:void(0)\" onclick=\"return mtSignOutOnClick()\">サインアウト</a>)\';\n    } else if (u && u.is_banned) {\n        content = \'このブログにサインインする権限がありません。\';\n    } else {\n        content = \'<a href=\"javascript:void(0)\" onclick=\"return mtSignInOnClick(\\\'signin-widget-content\\\')\">サインイン</a>\';\n    }\n    el.innerHTML = content;\n}\nmtAttachEvent(\'usersignin\', mtUpdateSignInWidget);\nmtUpdateSignInWidget();\n/* ]]> */\n</script>\n</mt:IfRegistrationAllowed>\n','widget',0),(28,1,0,0,1,1,'2014-11-02 00:12:58','current_category_monthly_archive_list',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','カテゴリ月別アーカイブ',NULL,1,'<mt:IfArchiveTypeEnabled archive_type=\"Category-Monthly\">\n    <mt:ArchiveList archive_type=\"Category-Monthly\">\n        <mt:ArchiveListHeader>\n<div class=\"widget-archive-current-category-monthly widget-archive widget\">\n    <h3 class=\"widget-header\"><$mt:CategoryLabel$>: 月別アーカイブ</h3>\n    <div class=\"widget-content\">\n        <ul>\n        </mt:ArchiveListHeader>\n            <li><a href=\"<$mt:ArchiveLink$>\"><$mt:ArchiveTitle$></a></li>\n        <mt:ArchiveListFooter>\n        </ul>\n    </div>\n</div>\n        </mt:ArchiveListFooter>\n    </mt:ArchiveList>\n</mt:IfArchiveTypeEnabled>\n','widget',0),(29,1,0,0,1,1,'2014-11-02 00:12:58','about_this_page',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','About',NULL,1,'<mt:unless name=\"main_index\">\n<div class=\"widget-about-this-page widget\">\n    <h3 class=\"widget-header\">\n<mt:If name=\"entry_template\">\n        この記事について\n<mt:Else>\n    <mt:If name=\"archive_template\">\n        このアーカイブについて\n    </mt:If>\n</mt:If>\n<mt:If name=\"archive_index\">\n        このページについて\n</mt:If>\n    </h3>\n    <div class=\"widget-content\">\n<mt:If name=\"archive_index\">\n        <p>このページには過去に書かれたすべてのコンテンツが含まれています。</p>\n</mt:If>\n<mt:If name=\"entry_template\">\n        <p class=\"first\">このページは、<$mt:EntryAuthorLink$>が<$mt:EntryDate format=\"%x %X\"$>に書いた記事です。</p>\n    <mt:EntryPrevious>\n        <p>ひとつ前の記事は「<a href=\"<$mt:EntryPermalink$>\"><$mt:EntryTitle remove_html=\"1\"$></a>」です。</p>\n    </mt:EntryPrevious>\n    <mt:EntryNext>\n        <p>次の記事は「<a href=\"<$mt:EntryPermalink$>\"><$mt:EntryTitle remove_html=\"1\"$></a>」です。</p>\n    </mt:EntryNext>\n</mt:If>\n<mt:If name=\"category_archive\">\n    <mt:If name=\"datebased_archive\">\n        <p class=\"first\">このページには、<strong><$mt:ArchiveDate format=\"%B %Y\"$></strong>以降に書かれた記事のうち<strong><$mt:CategoryLabel$></strong>カテゴリに属しているものが含まれています。</p>\n        <mt:ArchivePrevious>\n        <p>前のアーカイブは<a href=\"<$mt:ArchiveLink$>\"><$mt:ArchiveTitle$></a>です。</p>\n        </mt:ArchivePrevious>\n        <mt:ArchiveNext>\n        <p>次のアーカイブは<a href=\"<$mt:ArchiveLink$>\"><$mt:ArchiveTitle$></a>です。</p>\n        </mt:ArchiveNext>\n    <mt:Else>\n        <p class=\"first\">このページには、過去に書かれた記事のうち<strong><$mt:CategoryLabel$></strong>カテゴリに属しているものが含まれています。</p>\n        <mt:CategoryPrevious>\n        <p>前のカテゴリは<a href=\"<$mt:CategoryArchiveLink$>\"><$mt:CategoryLabel$></a>です。</p>\n        </mt:CategoryPrevious>\n        <mt:CategoryNext>\n        <p>次のカテゴリは<a href=\"<$mt:CategoryArchiveLink$>\"><$mt:CategoryLabel$></a>です。</p>\n        </mt:CategoryNext>\n    </mt:If>\n</mt:If>\n<mt:If name=\"author_archive\">\n    <mt:If name=\"datebased_archive\">\n        <p class=\"first\">このページには、<strong><$mt:AuthorDisplayName encode_html=\"1\"$></strong>が<strong><$mt:ArchiveDate format=\"%B %Y\"$></strong>に書いた記事が含まれています。</p>\n        <mt:ArchivePrevious>\n        <p>前のアーカイブは<a href=\"<$mt:ArchiveLink$>\"><$mt:ArchiveTitle$></a>です。</p>\n        </mt:ArchivePrevious>\n        <mt:ArchiveNext>\n        <p>次のアーカイブは<a href=\"<$mt:ArchiveLink$>\"><$mt:ArchiveTitle$></a>です。</p>\n        </mt:ArchiveNext>\n    <mt:Else>\n        <p class=\"first\">このページには、<strong><$mt:AuthorDisplayName encode_html=\"1\"$></strong>が最近書いた記事が含まれています。</p>\n    </mt:If>\n</mt:If>\n<mt:If name=\"datebased_only_archive\">\n        <p class=\"first\">このページには、<strong><$mt:ArchiveDate format=\"%B %Y\"$></strong>に書かれた記事が新しい順に公開されています。</p>\n    <mt:ArchivePrevious>\n        <p>前のアーカイブは<a href=\"<$mt:ArchiveLink$>\"><$mt:ArchiveTitle$></a>です。</p>\n    </mt:ArchivePrevious>\n    <mt:ArchiveNext>\n        <p>次のアーカイブは<a href=\"<$mt:ArchiveLink$>\"><$mt:ArchiveTitle$></a>です。</p>\n    </mt:ArchiveNext>\n</mt:If>\n<mt:If name=\"archive_index\">\n        <p>最近のコンテンツは<a href=\"<$mt:BlogURL$>\">インデックスページ</a>で見られます。</p>\n<mt:Else>\n        <p>最近のコンテンツは<a href=\"<$mt:BlogURL$>\">インデックスページ</a>で見られます。過去に書かれたものは<a href=\"<$mt:Link template=\"archive_index\"$>\">アーカイブのページ</a>で見られます。</p>\n</mt:If>\n    </div>\n</div>\n</mt:unless>\n','widget',0),(30,1,0,0,1,1,'2014-11-02 00:12:58','openid',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','OpenID対応',NULL,1,'<mt:IfRegistrationAllowed type=\"OpenID\">\n<div class=\"widget-openid widget\">\n    <div class=\"widget-content\">\n        <em><strong>OpenID</strong>対応しています</em>\n        <a href=\"https://www.sixapart.jp/about/openid.html\">OpenIDについて</a>\n    </div>\n</div>\n</mt:IfRegistrationAllowed>\n','widget',0),(31,1,0,0,1,1,'2014-11-02 00:12:58','creative_commons',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','クリエイティブ・コモンズ',NULL,1,'<mt:BlogIfCCLicense>\n<div class=\"widget-creative-commons widget\">\n   <div class=\"widget-content\">\n      <a href=\"<$mt:BlogCCLicenseURL$>\"><img alt=\"Creative Commons License\" src=\"<$mt:BlogCCLicenseImage$>\" /></a><br />\n      このブログは<a href=\"<$mt:BlogCCLicenseURL$>\">クリエイティブ・コモンズ</a>でライセンスされています。\n   </div>\n</div>\n</mt:BlogIfCCLicense>\n','widget',0),(32,1,0,0,1,1,'2014-11-02 00:12:58','blogs',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','ブログ',NULL,1,'<mt:Blogs include_blogs=\"children\">\n    <mt:If name=\"__first__\">\n<div class=\"widget-blogs widget-archives widget\">\n    <h3 class=\"widget-header\">ブログ</h3>\n    <div class=\"widget-content\">\n        <ul>\n        </mt:If>\n            <li><a href=\"<$mt:BlogURL$>\"><$mt:BlogName$></a></li>\n        <mt:If name=\"__last__\">\n        </ul>\n    </div>\n</div>\n        </mt:If>\n</mt:Blogs>\n','widget',0),(33,1,0,0,1,1,'2014-11-02 00:12:58','banner_footer',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','バナーフッター',NULL,1,'<div id=\"footer\">\n    <div id=\"footer-inner\">\n        <div id=\"footer-content\">\n            <div class=\"widget-powered widget\">\n                <div class=\"widget-content\">\n                    Powered by <a href=\"http://www.sixapart.jp/movabletype/\"><$MTProductName$></a>\n                </div>\n            </div>\n<mt:BlogIfCCLicense>\n            <div class=\"widget-creative-commons widget\">\n                <div class=\"widget-content\">\n                    このブログは<a href=\"<$mt:BlogCCLicenseURL$>\">クリエイティブ・コモンズ</a>でライセンスされています。\n                </div>\n            </div>\n</mt:BlogIfCCLicense>\n        </div>\n    </div>\n</div>\n','custom',0),(34,1,0,0,1,1,'2014-11-02 00:12:58','comment_response',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','コメント完了',NULL,1,'<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\"\n    \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\" id=\"sixapart-standard\">\n<head>\n\n\n<mt:If name=\"comment_confirmation\">\n    <mt:Ignore><!-- Success message when comment has been submitted --></mt:Ignore>\n    <$mt:Var name=\"page_title\" value=\"確認\"$>\n    <$mt:Var name=\"message\" value=\"<p>コメントを投稿しました。</p>\"$>\n<mt:Else name=\"comment_pending\">\n    <mt:Ignore><!-- Pending message when comment is being held for review --></mt:Ignore>\n    <$mt:Var name=\"page_title\" value=\"コメントありがとうございます。\"$>\n    <$mt:Var name=\"message\" value=\"<p>コメントは現在承認されるまで公開を保留されています。</p>\"$>\n<mt:Else name=\"comment_error\">\n    <mt:Ignore><!-- Error message when comment submission fails --></mt:Ignore>\n    <$mt:Var name=\"page_title\" value=\"コメント投稿エラー\"$>\n    <mt:SetVarBlock name=\"message\"><p>コメントを投稿できませんでした。エラー: <$mt:ErrorMessage encode_html=\"1\"$></p></mt:SetVarBlock>\n</mt:If>\n\n\n    <$mt:Include module=\"HTMLヘッダー\"$>\n    <title><$mt:BlogName encode_html=\"1\"$>: <$mt:Var name=\"page_title\"$></title>\n</head>\n<body id=\"<$mt:WebsiteThemeID$>\" class=\"<$mt:Var name=\"body_class\"$> <$mt:Var name=\"page_layout\"$>\">\n    <div id=\"container\">\n        <div id=\"container-inner\">\n\n\n            <$mt:Include module=\"バナーヘッダー\"$>\n\n\n            <div id=\"content\">\n                <div id=\"content-inner\">\n\n\n                    <div id=\"alpha\">\n                        <div id=\"alpha-inner\">\n                            <h1 id=\"page-title\"><$mt:Var name=\"page_title\"$></h1>\n                            <$mt:Var name=\"message\"$>\n                            <p>\n                            <mt:If name=\"comment_error\">\n                                <a href=\"javascript:history.back()\">戻る</a>\n                            <mt:Else>\n                                <a href=\"<$mt:EntryLink$>\">元の記事</a>に戻る\n                            </mt:If>\n                            </p>\n                        </div>\n                    </div>\n\n\n                    <$mt:Include module=\"サイドバー\"$>\n\n\n                </div>\n            </div>\n\n\n            <$mt:Include module=\"バナーフッター\"$>\n\n\n        </div>\n    </div>\n</body>\n</html>\n','comment_response',0),(35,1,0,0,1,1,'2014-11-02 00:12:58','archive_widgets_group',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','アーカイブウィジェットグループ',NULL,1,'<mt:Ignore>\n    アーカイブの種類に応じて異なる内容を表示するように設定されたウィジェットです。詳細: http://www.movabletype.org/documentation/designer/widget-sets.html\n</mt:Ignore>\n<mt:If name=\"category_archive\">\n    <mt:IfArchiveTypeEnabled archive_type=\"Category-Monthly\">\n        <$mt:Include widget=\"カテゴリ月別アーカイブ\"$>\n    </mt:IfArchiveTypeEnabled>\n</mt:If>\n<mt:IfArchiveTypeEnabled archive_type=\"Category\">\n    <$mt:Include widget=\"カテゴリアーカイブ\"$>\n</mt:IfArchiveTypeEnabled>\n<mt:IfArchiveTypeEnabled archive_type=\"Monthly\">\n    <$mt:Include widget=\"月別アーカイブ\"$>\n</mt:IfArchiveTypeEnabled>\n','widget',0),(36,1,0,0,1,1,'2014-11-02 00:12:58','category_entry_listing',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','カテゴリ別記事リスト',NULL,1,'<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\"\n    \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\" id=\"sixapart-standard\">\n<head>\n    <$mt:Include module=\"HTMLヘッダー\"$>\n    <title><$mt:BlogName encode_html=\"1\"$>: <$mt:ArchiveTitle$>アーカイブ</title>\n<mt:Ignore>\n    <!-- Include Next and Previous links if publishing a date-based archive -->\n</mt:Ignore>\n<mt:If name=\"datebased_archive\">\n    <mt:ArchivePrevious><link rel=\"prev\" href=\"<$mt:ArchiveLink$>\" title=\"<$mt:ArchiveTitle encode_html=\"1\"$>\" /></mt:ArchivePrevious>\n    <mt:ArchiveNext><link rel=\"next\" href=\"<$mt:ArchiveLink$>\" title=\"<$mt:ArchiveTitle encode_html=\"1\"$>\" /></mt:ArchiveNext>\n</mt:If>\n</head>\n<body id=\"<$mt:BlogThemeID$>\" class=\"mt-archive-listing mt-<$mt:Var name=\"archive_class\"$> <$mt:Var name=\"page_layout\"$>\">\n    <div id=\"container\">\n        <div id=\"container-inner\">\n\n\n            <$mt:Include module=\"バナーヘッダー\"$>\n\n\n            <div id=\"content\">\n                <div id=\"content-inner\">\n\n\n                    <div id=\"alpha\">\n                        <div id=\"alpha-inner\">\n<mt:If name=\"datebased_archive\">\n                            <mt:Ignore><!-- Title for category-monthly entry listings --></mt:Ignore>\n                            <h1 id=\"page-title\" class=\"archive-title\"><$mt:ArchiveTitle$>アーカイブ</h1>\n<mt:Else>\n                            <mt:Ignore><!-- Title for category entry listings --></mt:Ignore>\n                            <h1 id=\"page-title\" class=\"archive-title\"><em><$mt:ArchiveTitle$></em>の最近の記事</h1>\n</mt:If>\n\n\n<mt:Ignore><!-- Limit number of entries to the number set in Blog Entry Settings --></mt:Ignore>\n<mt:Unless name=\"datebased_archive\"><$mt:Var name=\"limit\" value=\"auto\"$></mt:Unless>\n<mt:Entries limit=\"$limit\">\n                            <mt:Ignore><!-- Use the Entry Summary module for each entry published on this page --></mt:Ignore>\n                            <$mt:Include module=\"記事の概要\"$>\n</mt:Entries>\n\n\n                            <div class=\"content-nav\">\n                                <mt:ArchivePrevious><a href=\"<$mt:ArchiveLink$>\">&laquo; <$mt:ArchiveTitle$></a> |</mt:ArchivePrevious>\n                                <a href=\"<$mt:Link template=\"main_index\"$>\">メインページ</a> |\n                                <a href=\"<$mt:Link template=\"archive_index\"$>\">アーカイブ</a>\n                                <mt:ArchiveNext>| <a href=\"<$mt:ArchiveLink$>\"><$mt:ArchiveTitle$> &raquo;</a></mt:ArchiveNext>\n                            </div>\n\n\n                        </div>\n                    </div>\n\n\n                    <$mt:Include module=\"サイドバー\"$>\n\n\n                </div>\n            </div>\n\n\n            <$mt:Include module=\"バナーフッター\"$>\n\n\n        </div>\n    </div>\n</body>\n</html>\n','archive',0),(37,1,0,0,1,1,'2014-11-02 00:12:58','syndication',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','購読',NULL,1,'<div class=\"widget-syndication widget\">\n    <div class=\"widget-content\">\n        <ul>\n            <li><img src=\"<$mt:StaticWebPath$>images/status_icons/feed.gif\" alt=\"購読する\" width=\"9\" height=\"9\" /> <a href=\"<$mt:Link template=\"feed_recent\"$>\">ウェブサイトを購読</a></li>\n<mt:If name=\"search_results\">\n    <mt:If tag=\"SearchString\">\n            <li class=\"search-results-feed\"><img src=\"<$mt:StaticWebPath$>images/status_icons/feed.gif\" alt=\"購読する\" width=\"9\" height=\"9\" /> <a href=\"<$mt:CGIPath$><$mt:SearchScript$>?<mt:IfTagSearch>tag<mt:else>search</mt:IfTagSearch>=<$mt:SearchString encode_url=\"1\"$>&amp;Template=feed&amp;IncludeBlogs=<$mt:SearchIncludeBlogs$>&amp;limit=<$mt:SearchMaxResults$>\" title=\"<mt:IfTagSearch>「<$mt:SearchString$>」の検索結果を購読<mt:Else>タグ「<$mt:SearchString$>」を購読</mt:IfTagSearch>\"><mt:IfTagSearch>タグ「<$mt:SearchString$>」のフィード<mt:Else>「<$mt:SearchString$>」を検索した結果のフィード</mt:IfTagSearch></a></li>\n    </mt:If>\n</mt:If>\n        </ul>\n    </div>\n</div>\n','widget',0),(38,1,0,0,1,1,'2014-11-02 00:12:58','calendar',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','カレンダー',NULL,1,'<mt:IfArchiveTypeEnabled archive_type=\"Individual\">\n<div class=\"widget-calendar widget\">\n    <h3 class=\"widget-header\"><$mt:Date format=\"%B %Y\"$></h3>\n    <div class=\"widget-content\">\n        <table summary=\"リンク付きのカレンダー\">\n            <tr>\n                <th abbr=\"日曜日\">日</th>\n                <th abbr=\"月曜日\">月</th>\n                <th abbr=\"火曜日\">火</th>\n                <th abbr=\"水曜日\">水</th>\n                <th abbr=\"木曜日\">木</th>\n                <th abbr=\"金曜日\">金</th>\n                <th abbr=\"土曜日\">土</th>\n            </tr>\n    <mt:Calendar>\n        <mt:CalendarWeekHeader>\n            <tr>\n        </mt:CalendarWeekHeader>\n                <td>\n        <mt:CalendarIfEntries>\n            <mt:Entries lastn=\"1\">\n                    <a href=\"<$mt:EntryPermalink$>\"><$mt:CalendarDay$></a>\n            </mt:Entries>\n        </mt:CalendarIfEntries>\n        <mt:CalendarIfNoEntries>\n                    <$mt:CalendarDay$>\n        </mt:CalendarIfNoEntries>\n        <mt:CalendarIfBlank>&nbsp;</mt:CalendarIfBlank>\n                </td>\n        <mt:CalendarWeekFooter>\n            </tr>\n        </mt:CalendarWeekFooter>\n    </mt:Calendar>\n        </table>\n    </div>\n</div>\n</mt:IfArchiveTypeEnabled>\n','widget',0),(39,1,0,0,1,1,'2014-11-02 00:12:58','dynamic_error',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','ダイナミックパブリッシングエラー',NULL,1,'<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\"\n    \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\" id=\"sixapart-standard\">\n<head>\n    <$mt:Include module=\"HTMLヘッダー\"$>\n    <title><$mt:BlogName encode_html=\"1\"$>: ページが見つかりません。</title>\n</head>\n<body id=\"<$mt:WebsiteThemeID$>\" class=\"mt-dynamic-error <$mt:Var name=\"page_layout\"$>\">\n    <div id=\"container\">\n        <div id=\"container-inner\">\n\n\n            <$mt:Include module=\"バナーヘッダー\"$>\n\n\n            <div id=\"content\">\n                <div id=\"content-inner\">\n\n\n                    <div id=\"alpha\">\n                        <div id=\"alpha-inner\">\n                            <h1 id=\"page-title\">ページが見つかりません。</h1>\n                            <blockquote>\n                                <strong><$mt:ErrorMessage$></strong>\n                            </blockquote>\n                        </div>\n                    </div>\n\n\n                    <$mt:Include module=\"サイドバー\"$>\n\n\n                </div>\n            </div>\n\n\n            <$mt:Include module=\"バナーフッター\"$>\n\n\n        </div>\n    </div>\n</body>\n</html>\n','dynamic_error',0),(40,1,0,0,1,1,'2014-11-02 00:12:58','javascript',NULL,NULL,NULL,NULL,'2014-11-02 00:12:58','JavaScript','mt.js',1,'<mt:Ignore>\n/*  The following functions and variables are here to support legacy MT templates.\n    If you have refreshed your JavaScript template but still use older MT comment\n    templates, you may need to uncomment this block in order for those templates \n    to work properly. To use, simply remove the \'mt:Ignore\' tags wrapping this\n    block of code.\n*/\n    function hideDocumentElement(id) { return mtHide(id) }\n    function showDocumentElement(id) { return mtShow(id) }\n    function individualArchivesOnLoad() { return mtEntryOnLoad() }\n    function writeCommenterGreeting() { return mtShowGreeting() }\n    function rememberMe(f) { return mtRememberMe(f) }\n    function forgetMe(f) { return mtForgetMe(f) }\n    var commenter_name;\n    var commenter_id;\n    var commenter_url;\n    var commenter_blog_ids;\n    var mtcmtmail;\n    var mtcmtauth;\n    var mtcmthome;\n    var captcha_timer;\n</mt:Ignore>\n\n// The cookie name to use for storing the blog-side comment session cookie.\nvar mtCookieName = \"<$mt:UserSessionCookieName$>\";\nvar mtCookieDomain = \"<$mt:UserSessionCookieDomain$>\";\nvar mtCookiePath = \"<$mt:UserSessionCookiePath$>\";\nvar mtCookieTimeout = <$mt:UserSessionCookieTimeout$>;\n\n<mt:Ignore>\n/***\n * Simple routine for showing a DOM element (applying a CSS display\n * attribute of \'none\').\n */\n</mt:Ignore>\nfunction mtHide(id) {\n    var el = (typeof id == \"string\") ? document.getElementById(id) : id;\n    if (el) el.style.display = \'none\';\n}\n\n<mt:Ignore>\n/***\n * Simple routine for showing a DOM element (applying a CSS display\n * attribute of \'block\').\n */\n</mt:Ignore>\nfunction mtShow(id) {\n    var el = (typeof id == \"string\") ? document.getElementById(id) : id;\n    if (el) el.style.display = \'block\';\n}\n\n<mt:Ignore>\n/***\n * A utility function for assigning/adding handlers to window events.\n */\n</mt:Ignore>\nfunction mtAttachEvent(eventName,func) {\n    var onEventName = \'on\' + eventName;\n    var old = window[onEventName];\n    if( typeof old != \'function\' )\n        window[onEventName] = func;\n    else {\n        window[onEventName] = function( evt ) {\n            old( evt );\n            return func( evt );\n        };\n    }\n}\n\n<mt:Ignore>\n/***\n * Calls the event named, if there are handlers for it.\n */\n</mt:Ignore>\nfunction mtFireEvent(eventName,param) {\n    var fn = window[\'on\' + eventName];\n    if (typeof fn == \'function\') return fn(param);\n    return;\n}\n\nif(!this.JSON){JSON={};}(function(){function f(n){return n<10?\'0\'+n:n;}if(typeof Date.prototype.toJSON!==\'function\'){Date.prototype.toJSON=function(key){return this.getUTCFullYear()+\'-\'+f(this.getUTCMonth()+1)+\'-\'+f(this.getUTCDate())+\'T\'+f(this.getUTCHours())+\':\'+f(this.getUTCMinutes())+\':\'+f(this.getUTCSeconds())+\'Z\';};String.prototype.toJSON=Number.prototype.toJSON=Boolean.prototype.toJSON=function(key){return this.valueOf();};}var cx=/[\\u0000\\u00ad\\u0600-\\u0604\\u070f\\u17b4\\u17b5\\u200c-\\u200f\\u2028-\\u202f\\u2060-\\u206f\\ufeff\\ufff0-\\uffff]/g,escapable=/[\\\\\\\"\\x00-\\x1f\\x7f-\\x9f\\u00ad\\u0600-\\u0604\\u070f\\u17b4\\u17b5\\u200c-\\u200f\\u2028-\\u202f\\u2060-\\u206f\\ufeff\\ufff0-\\uffff]/g,gap,indent,meta={\'\\b\':\'\\\\b\',\'\\t\':\'\\\\t\',\'\\n\':\'\\\\n\',\'\\f\':\'\\\\f\',\'\\r\':\'\\\\r\',\'\"\':\'\\\\\"\',\'\\\\\':\'\\\\\\\\\'},rep;function quote(string){escapable.lastIndex=0;return escapable.test(string)?\'\"\'+string.replace(escapable,function(a){var c=meta[a];return typeof c===\'string\'?c:\'\\\\u\'+(\'0000\'+a.charCodeAt(0).toString(16)).slice(-4);})+\'\"\':\'\"\'+string+\'\"\';}function str(key,holder){var i,k,v,length,mind=gap,partial,value=holder[key];if(value&&typeof value===\'object\'&&typeof value.toJSON===\'function\'){value=value.toJSON(key);}if(typeof rep===\'function\'){value=rep.call(holder,key,value);}switch(typeof value){case\'string\':return quote(value);case\'number\':return isFinite(value)?String(value):\'null\';case\'boolean\':case\'null\':return String(value);case\'object\':if(!value){return\'null\';}gap+=indent;partial=[];if(Object.prototype.toString.apply(value)===\'[object Array]\'){length=value.length;for(i=0;i<length;i+=1){partial[i]=str(i,value)||\'null\';}v=partial.length===0?\'[]\':gap?\'[\\n\'+gap+partial.join(\',\\n\'+gap)+\'\\n\'+mind+\']\':\'[\'+partial.join(\',\')+\']\';gap=mind;return v;}if(rep&&typeof rep===\'object\'){length=rep.length;for(i=0;i<length;i+=1){k=rep[i];if(typeof k===\'string\'){v=str(k,value);if(v){partial.push(quote(k)+(gap?\': \':\':\')+v);}}}}else{for(k in value){if(Object.hasOwnProperty.call(value,k)){v=str(k,value);if(v){partial.push(quote(k)+(gap?\': \':\':\')+v);}}}}v=partial.length===0?\'{}\':gap?\'{\\n\'+gap+partial.join(\',\\n\'+gap)+\'\\n\'+mind+\'}\':\'{\'+partial.join(\',\')+\'}\';gap=mind;return v;}}if(typeof JSON.stringify!==\'function\'){JSON.stringify=function(value,replacer,space){var i;gap=\'\';indent=\'\';if(typeof space===\'number\'){for(i=0;i<space;i+=1){indent+=\' \';}}else if(typeof space===\'string\'){indent=space;}rep=replacer;if(replacer&&typeof replacer!==\'function\'&&(typeof replacer!==\'object\'||typeof replacer.length!==\'number\')){throw new Error(\'JSON.stringify\');}return str(\'\',{\'\':value});};}if(typeof JSON.parse!==\'function\'){JSON.parse=function(text,reviver){var j;function walk(holder,key){var k,v,value=holder[key];if(value&&typeof value===\'object\'){for(k in value){if(Object.hasOwnProperty.call(value,k)){v=walk(value,k);if(v!==undefined){value[k]=v;}else{delete value[k];}}}}return reviver.call(holder,key,value);}cx.lastIndex=0;if(cx.test(text)){text=text.replace(cx,function(a){return\'\\\\u\'+(\'0000\'+a.charCodeAt(0).toString(16)).slice(-4);});}if(/^[\\],:{}\\s]*$/.test(text.replace(/\\\\(?:[\"\\\\\\/bfnrt]|u[0-9a-fA-F]{4})/g,\'@\').replace(/\"[^\"\\\\\\n\\r]*\"|true|false|null|-?\\d+(?:\\.\\d*)?(?:[eE][+\\-]?\\d+)?/g,\']\').replace(/(?:^|:|,)(?:\\s*\\[)+/g,\'\'))){j=eval(\'(\'+text+\')\');return typeof reviver===\'function\'?walk({\'\':j},\'\'):j;}throw new SyntaxError(\'JSON.parse\');};}}());\n\nvar MT = window.MT || {};\n\nMT.cons = function () {\n  return {\n    LOG : \'log\',\n    WARN : \'warn\',\n    DEBUG : \'debug\',\n    INFO : \'info\',\n    ERR : \'error\',\n    JSON : \'json\'\n  };\n}();\n\n<mt:Ignore>\n/**\n * Used for base functionality related to MT\n * \n * @package MT\n * @class core\n * @global\n * @param {Object} o optional configuration object\n * Options:\n */\n</mt:Ignore>\nMT.core = function (o) {\n  var _debug = false;\n  \n  return {\n    <mt:Ignore>\n    /**\n     * Makes remote call and handles response\n     * \n     * @param {String} url The URL endpoint\n     * @param {String} respType The type of response expected\n     * @param {Function} respHandler The function to handle the response\n     * @return void\n     */\n    </mt:Ignore>\n    connect : function (url,respType,respHandler) {\n      var xh = mtGetXmlHttp();\n      if (!xh) return false;\n      \n      xh.onreadystatechange = function() {\n        if ( xh.readyState == 4 ) {\n          if ( xh.status && ( xh.status != 200 ) ) {\n            // error - ignore\n          } else {\n            switch (respType) {\n              case \'json\':\n                respHandler(JSON.parse(xh.responseText));\n                break;\n                \n              case \'xml\':\n                break;\n                \n              case \'text\':\n                break;\n            }\n          }\n        }\n      };\n      \n      xh.open(\'GET\',url);\n      xh.send(null);\n    },\n    \n    getEl : function (el) {\n      return MT.util.checkNodeType(el)===\'element\' ? id : (document.getElementById(el) || false);\n    },\n    \n    addEvent : function (el,type,func,obj) {\n      if(!obj && document.addEventListener) {\n        el.addEventListener(type,func,false);\n      } else if(obj && document.addEventListener) {\n        el.addEventListener(type,function () {\n          func.call(obj,event);\n        },false);\n      } else {\n        if(obj) {\n          el.attachEvent(\'on\' + type,function () {\n            func.call(obj,event);\n          });\n        } else {\n          el.attachEvent(\'on\' + type,function () {          \n            func.call(el,event);\n          });\n        }\n      }\n    },\n    \n    <mt:Ignore>\n    /**\n     * Basic logging function\n     * \n     * @param {String} level The log level (WARN|DEBUG|INFO|ERROR|LOG)\n     * Specified by one of the MT constants\n     * @param {String} msg The log message\n     * @return void\n     */\n    </mt:Ignore>\n    log : function (level,msg) {\n      if(_debug && window.console) {\n        switch(level) {\n          case \'warn\':\n          case \'debug\':\n          case \'info\':\n          case \'error\':\n          case \'log\':\n            console[level](msg);\n            break;\n            \n          default:\n            return false; \n        }\n      } else {\n        return false;\n      }\n    }\n  }\n}();\n\n<mt:Ignore>\n/**\n * Utilities class\n * \n * @package MT\n * @class util\n * @global\n * Options:\n */\n</mt:Ignore>\nMT.util = function () {\n  return {\n    toggleVisibility : {\n      show : function () {\n        var i = arguments.length;\n        \n        while(i--) {\n          if(MT.util.checkNodeType(arguments[i])===\'element\') {\n            arguments[i].style.visibility = \'visible\';\n          } else {\n            MT.core.getEl(arguments[i]).style.visibility = \'visible\';\n          }\n        }\n      },\n      \n      hide : function () {\n        var i = arguments.length;\n        while(i--) {\n          if(MT.util.checkNodeType(arguments[i])===\'element\') {\n            arguments[i].style.visibility = \'hidden\';\n          } else {\n            MT.core.getEl(arguments[i]).style.visibility = \'hidden\';\n          }\n        }\n      }\n    },\n    \n    toggleDisplay : {\n      show : function () {\n        var i = arguments.length;\n        while(i--) {\n          if(MT.util.checkNodeType(arguments[i])===\'element\') {\n            arguments[i].style.display = \'\';\n          } else {\n            MT.core.getEl(arguments[i]).style.display = \'\';\n          }\n        }\n      },\n      \n      hide : function () {\n        var i = arguments.length;\n        while(i--) {\n          if(MT.util.checkNodeType(arguments[i])===\'element\') {\n            arguments[i].style.display = \'none\';\n          } else {\n            MT.core.getEl(arguments[i]).style.display = \'none\';\n          }\n        }\n      }\n    },\n    \n    <mt:Ignore>\n    /**\n     * Finds the nearest defining (i.e. with an id) parent to the given element\n     * \n     * @param {HTMLElement} origin the node from which to start the search\n     * @return {HTMLElement|Boolean} The parent node with an id attribute or false\n     */\n    </mt:Ignore>\n    findDefiningParent : function (origin) {\n      if(MT.util.checkNodeType(origin)===\'element\') {\n        for(var node=origin.parentNode;node.parentNode;node=node.parentNode) {\n          if((node.hasAttribute && node.hasAttribute(\'id\')) || node.getAttribute(\'id\')) {\n            return node;\n          }\n        }\n      }\n      return false;\n    },\n    \n    <mt:Ignore>\n    /**\n     * Tests objects to verify if they are DOM nodes\n     * \n     * @param {Object} obj The object to be tested\n     * @return {String} the values \'element\'|\'textnode\'|\'whitespace\'\n     */\n    </mt:Ignore>\n    checkNodeType : function (obj) {\n      if (obj && obj.nodeName){\n        switch (obj.nodeType) {\n          case 1: return \'element\';\n          case 3: return (/\\S/).test(obj.nodeValue) ? \'textnode\' : \'whitespace\';\n        }\n      }\n    }\n  }\n}();\n\n<mt:Ignore>\n/**\n * mtPaginateComments takes the currently generated static page and either:\n *  - Attempts to find an individual comment link in the query string\n *  - If no link is found, the static page loads\n * In either case, the pagination event is set\n */\n</mt:Ignore>\n(function () {\n  var M = MT.core,\n      c = MT.cons,\n      u = MT.util,\n      cache,\n      isLoading,\n      direction,\n      currentComments,\n      commentAnchor,\n      commentArrId,\n      commentsPerPage,\n      commentsTotalPages,\n      loadingIcon,\n      pageNum,\n      commentsOffset,\n      totalComments,\n      entryID,\n      commentContentDiv,\n      topNav,\n      nav,\n      currentCommentsSpan,\n      topCurrentCommentsSpan;\n            \n  M.addEvent(window,\'load\',_init);\n  \n  /**\n   * Initializes the class\n   * \n   * @return void\n   */\n  function _init () {\n    if(!MT.entryCommentCount) {\n      return;\n    }\n    \n    _initializeVariables();\n    _setCommentOffset(false);\n    _checkForAnchor();\n		_setCurrentComments();\n    _toggleNavLinks();\n    _initializeEvents();\n  }\n  \n  <mt:Ignore>\n  /**\n   * Initializes variables to their initial values\n   * \n   * @return void\n   */\n  </mt:Ignore>\n  function _initializeVariables() {\n    cache = {};\n    isLoading = false;\n    commentAnchor = \'\';\n    commentArrId = \'\';\n    commentsPerPage = MT.commentsPerPage || 50;\n    currentComments = \'\';\n    direction = \'ascend\';\n    entryID = MT.entryID;\n    totalComments = MT.entryCommentCount;\n    commentsTotalPages = Math.ceil(totalComments / commentsPerPage);\n    pageNum = 1;\n    \n    loadingIcon = \"<img title=\'Loading...\' src=\'<$MTStaticWebPath$>images/indicator.white.gif\' alt=\'Loading\' />\";\n    \n    commentContentDiv = M.getEl(\"comments-content\");\n    topNav = M.getEl(\"top-comment-nav\");\n    nav = M.getEl(\"comment-nav\");\n    \n    currentCommentsSpan = M.getEl(\"current-comments\");\n    topCurrentCommentsSpan = M.getEl(\"top-current-comments\");\n  }\n  \n  function _initializeEvents() {\n    if (commentsPerPage < totalComments) {\n      M.addEvent(nav,\'click\',_handleEvents);\n      M.addEvent(topNav,\'click\',_handleEvents);\n    }\n  }\n  \n  <mt:Ignore>\n  /**\n   * Checks for an existing anchor tag in the query string\n   * If found, it looks for it on the current page\n   * If that fails, it tries to find it in comment list and loads\n   * the desired page\n   * \n   * @return void\n   */\n  </mt:Ignore>\n  function _checkForAnchor() {\n    var found = String(window.location.hash).match( /comment-(\\d{1,6})/ );\n		\n		if (found) {\n		  M.log(c.DEBUG,found);\n			if (!Object.prototype.hasOwnProperty.call(M.getEl(found[0]), \'className\')) {\n				if (_findIdMatch(found[1])) {\n    			pageNum = Math.floor(commentArrId / commentsPerPage) + 1;\n    			M.log(c.DEBUG,\'Comment Array Id: \' + commentArrId);\n    			M.log(c.DEBUG,\'Comments Per Page: \' + commentsPerPage);\n    			M.log(c.DEBUG,\'Page Number: \' + pageNum);\n    			M.log(c.DEBUG,\'Comment Offset: \' + _getCommentOffset());\n    			_updateComments();\n    		}\n			}\n		}\n  }\n  \n  <mt:Ignore>\n  /**\n   * Sets commentsOffset (i.e. the offset number to the remote list)\n   * \n   * @return void\n   */\n  </mt:Ignore>\n  function _setCommentOffset() {\n    commentsOffset = commentsPerPage * (pageNum-1);\n  }\n  \n  <mt:Ignore>\n  /**\n   * Gets the commentsOffset (i.e. the offset number to the remote list)\n   * \n   * @return void\n   */\n  </mt:Ignore>\n  function _getCommentOffset() {\n    return commentsOffset;\n  }\n  \n  <mt:Ignore>\n  /**\n   * General event handler\n   * \n   * @param {Event} e The event object\n   * @return void\n   */\n  </mt:Ignore>\n  function _handleEvents (e) {\n    var origin = e.target || e.srcElement,\n        parentId;\n        \n    // stupid IE\n    origin = origin.id && M.getEl(origin.id) || false;\n\n    if(origin) {\n      parentId = u.checkNodeType(origin.parentNode)===\'element\' && origin.parentNode.getAttribute(\'id\') && origin.parentNode.id;\n    } else {\n      return false;\n    }\n    \n    switch(origin.nodeName) {\n      case \'A\':\n        switch (parentId) {\n          case \'prev-comments\':\n          case \'top-prev-comments\':\n            if(e.preventDefault) {\n              e.preventDefault();\n            } else {\n              e.returnValue =	false;\n            }\n            if(!isLoading) {\n              _previousPage();\n            }\n            break;\n          case \'next-comments\':\n          case \'top-next-comments\':\n            if(e.preventDefault) {\n              e.preventDefault();\n            } else {\n              e.returnValue =	false;\n            }\n            if(!isLoading) {\n              _nextPage();\n            }\n            break;\n        }\n        break;\n    }\n  }\n  \n  <mt:Ignore>\n  /**\n   * Toggles the visibility of the navigation links\n   * \n   * @return void\n   */\n  </mt:Ignore>\n  function _toggleNavLinks () {\n    M.log(c.DEBUG,M.getEl(\'top-prev-comments\'));\n    if(pageNum <= commentsTotalPages && pageNum !== 1) {\n      u.toggleVisibility.show(\'prev-comments\');\n      u.toggleVisibility.show(\'top-prev-comments\');\n    }\n    \n    if(pageNum >= 1 && pageNum !== commentsTotalPages) {\n      u.toggleVisibility.show(\'next-comments\');\n      u.toggleVisibility.show(\'top-next-comments\');\n    }\n    \n    if(pageNum===1 || nav.style.visibility===\'hidden\') {\n      u.toggleVisibility.hide(\'prev-comments\');\n      u.toggleVisibility.hide(\'top-prev-comments\');\n    }\n    \n    if(pageNum===commentsTotalPages || nav.style.visibility===\'hidden\') {\n      u.toggleVisibility.hide(\'next-comments\');\n      u.toggleVisibility.hide(\'top-next-comments\');\n    }\n  }\n  \n  <mt:Ignore>\n  /**\n   * Determines appropriate action based on the id of the parent\n   * clicked link. Decrements pageNum based on id.\n   * \n   * @param {String} id the id of the parent of the clicked link\n   * @return void\n   */\n  </mt:Ignore>\n  function _nextPage () {\n    if(pageNum < commentsTotalPages) {\n      pageNum++;\n      _updateComments();\n    }\n  }\n  \n  <mt:Ignore>\n  /**\n   * Determines appropriate action based on the id of the parent\n   * clicked link. Increments/decrements pageNum based on id.\n   * \n   * @param {String} id the id of the parent of the clicked link\n   * @return void\n   */\n  </mt:Ignore>\n  function _previousPage() {\n    if(pageNum > 1) {\n      pageNum--;\n      _updateComments();\n    }\n  }\n  \n  <mt:Ignore>\n  /**\n   * Searches for a particular comment in the list of ids\n   * \n   * @param {String} id The id for which to search\n   * @return {Boolean} true, if found, false otherwise\n   */\n  </mt:Ignore>\n  function _findIdMatch (id) {\n    var len = MT.commentIds.length;\n    \n  	while (len--) {\n  		if (MT.commentIds[len] == id) {\n  			commentAnchor = \"comment-\" + id;\n  			commentArrId = len;\n  			return true;\n  		}\n  	}\n  	\n  	return false;\n  }\n  \n  <mt:Ignore>\n  /**\n   * Sets the current comment counts on the page\n   *\n   * @return void\n   */\n  </mt:Ignore>\n  function _setCurrentComments() {\n    var commentsOnPage = pageNum != commentsTotalPages ? commentsOffset + commentsPerPage : totalComments;\n    \n    _setCurrentCommentsContent([commentsOffset+1,\" - \",commentsOnPage].join(\'\'));\n  }\n  \n  <mt:Ignore>\n  /**\n   * Sets the \"current-comments\" element with the HTML value\n   * \n   * @param {String|Element} currentCommentsHTML The content to be set\n   * @return void\n   */\n  </mt:Ignore>\n  function _setCurrentCommentsContent(currentCommentsHTML) {\n    currentCommentsSpan.innerHTML = currentCommentsHTML;\n    topCurrentCommentsSpan.innerHTML = currentCommentsHTML;\n  }\n  \n  <mt:Ignore>\n  /**\n   * Sets the content of the comment list\n   * \n   * @param {String|Element} commentHTML The content to be set \n   * @return void\n   */\n  </mt:Ignore>\n  function _setCommentContent(commentHTML) {\n    commentContentDiv.innerHTML = commentHTML;\n  }\n  \n  <mt:Ignore>\n  /**\n   * Builds the appropriate URL to make a remote call to get the\n   * next set of comments\n   * \n   * @return void\n   */\n  </mt:Ignore>\n  function _updateComments() {\n    var comments, jsonUrl, cacheKey, offset;\n    isLoading = true;\n    _setCurrentCommentsContent(loadingIcon);\n    _setCommentOffset();\n\n    offset   = _getCommentOffset();\n    cacheKey = [direction, entryID, commentsPerPage, offset]\n        .join(\'-\')\n        .replace(/[^a-zA-Z0-9-]/g, \'\');\n    jsonUrl  = [\n        \"<$mt:CGIPath$><$mt:CommentScript$>?__mode=comment_listing&direction=\",\n        direction,\n        \"&entry_id=\",\n        entryID,\n        \"&limit=\",\n        commentsPerPage,\n        \"&offset=\",\n        offset,\n        \"&cacheKey=\",\n        cacheKey,\n        \"&jsonp=mtUpdateCommentsCallback\",\n        \"&ts=\",\n        new Date().getTime()\n      ].join(\'\');\n  	\n  	if (!commentAnchor) {\n      commentAnchor = \"comments-content\";\n    }\n\n    if(cache.hasOwnProperty(cacheKey)) {\n      _refreshComments(cache[cacheKey]);\n      isLoading = false;\n    } else {\n      var script = document.createElement(\'script\');\n      script.src = jsonUrl;\n      (document.getElementsByTagName(\'head\'))[0].appendChild(script);\n    }\n  }\n\n  window[\'mtUpdateCommentsCallback\'] = function(json) {\n    cache[json.cacheKey] = json.comments;\n    _refreshComments(json.comments);\n    isLoading = false;\n  }\n  \n  <mt:Ignore>\n  /**\n   * Refreshes the comment data with the current\n   * \n   * @param {String} commentData The data used to replace current comments\n   * @return void\n   */\n  </mt:Ignore>\n  function _refreshComments(commentData) {\n    _setCommentContent(commentData);\n    _setCurrentComments();\n    window.location.hash = \'reset\';\n    window.location.hash = commentAnchor;\n    _toggleNavLinks();\n  }\n})();\n\n<mt:Ignore>\n/***\n * Displays a relative date.\n * \'ts\' is a Date object, \'fds\' is a string of the date which\n * will be displayed if the given date is older than 1 week.\n */\n</mt:Ignore>\nfunction mtRelativeDate(ts, fds) {\n    var now = new Date();\n    var ref = ts;\n    var delta = Math.floor((now.getTime() - ref.getTime()) / 1000);\n\n    var str;\n    if (delta < 60) {\n        str = \'直前\';\n    } else if (delta <= 86400) {\n        // less than 1 day\n        var hours = Math.floor(delta / 3600);\n        var min = Math.floor((delta % 3600) / 60);\n        if (hours == 1)\n            str = \'1 時間前\';\n        else if (hours > 1)\n            str = \'2 時間前\'.replace(/2/, hours);\n        else if (min == 1)\n            str = \'1 分前\';\n        else\n            str = \'2 分前\'.replace(/2/, min);\n    } else if (delta <= 604800) {\n        // less than 1 week\n        var days = Math.floor(delta / 86400);\n        var hours = Math.floor((delta % 86400) / 3600);\n        if (days == 1)\n            str = \'1 日前\';\n        else if (days > 1)\n            str = \'2 日前\'.replace(/2/, days);\n        else if (hours == 1)\n            str = \'1 時間前\';\n        else\n            str = \'2 時間前\'.replace(/2/, hours);\n    }\n    return str ? str : fds;\n}\n\n<mt:Ignore>\n/***\n * Used to display an edit link for the given entry.\n */\n</mt:Ignore>\nfunction mtEditLink(entry_id, author_id) {\n    <mt:Ignore>\n    // This function has been inactivated by default because of the security issue.\n    // You can activate this function if \"AdminScript\" is already known by visitor.\n    </mt:Ignore>\n    <mt:Ignore>\n\n    var u = mtGetUser();\n    if (! u) return;\n    if (! entry_id) return;\n    if (! author_id) return;\n    if (u.id != author_id) return;\n    var link = \'<a href=\"<$mt:AdminScript$>?__mode=view&amp;_type=entry&amp;id=\' + entry_id + \'\">編集</a>\';\n    document.write(link);\n\n    </mt:Ignore>\n}\n\n<mt:Ignore>\n/***\n * Called when an input field on the comment form receives focus.\n */\n</mt:Ignore>\nfunction mtCommentFormOnFocus() {\n    // if CAPTCHA is enabled, this causes the captcha image to be\n    // displayed if it hasn\'t been already.\n    mtShowCaptcha();\n}\n\n<mt:Ignore>\n/***\n * Displays a captcha field for anonymous commenters.\n */\n</mt:Ignore>\nvar mtCaptchaVisible = false;\nfunction mtShowCaptcha() {\n    var u = mtGetUser();\n    if ( u && u.is_authenticated ) return;\n    if (mtCaptchaVisible) return;\n    var div = document.getElementById(\'comments-open-captcha\');\n    if (div) {\n        div.innerHTML = \'<$mt:CaptchaFields$>\';\n        mtCaptchaVisible = true;\n    }\n}\n\n<mt:Ignore>\n/* user object\n    -- saved in user cookie --\n    u.name (display name)\n    u.url (link to home page)\n    u.email (for anonymous only)\n    u.userpic (url for commenter/author)\n    u.profile (link to profile)\n    u.is_trusted (boolean)\n    u.is_author (user has posting rights)\n    u.is_banned (banned status; neither post/comment perms)\n    u.can_post (has permission to post)\n    u.can_comment (has permission to comment)\n\n    -- status fields --\n    u.is_authenticated (boolean)\n    u.is_anonymous (user is anonymous)\n*/\n</mt:Ignore>\n\nvar is_preview;\nvar user;\n<mt:Ignore>\n/***\n * Assigns a user object as the actively logged in user; also saves the\n * user information in a browser cookie.\n */\n</mt:Ignore>\nfunction mtSetUser(u) {\n    if (u) {\n        // persist this\n        user = u;\n        mtSaveUser();\n        // sync up user greeting\n        mtFireEvent(\'usersignin\');\n    }\n}\n\n<mt:Ignore>\n/***\n * Simple function that escapes single quote characters for storing\n * in a cookie.\n */\n</mt:Ignore>\nfunction mtEscapeJS(s) {\n    s = s.replace(/\'/g, \"&apos;\");\n    return s;\n}\n\n<mt:Ignore>\n/***\n * Simple function that unescapes single quote characters that were\n * stored in a cookie.\n */\n</mt:Ignore>\nfunction mtUnescapeJS(s) {\n    s = s.replace(/&apos;/g, \"\'\");\n    return s;\n}\n\n<mt:Ignore>\n/***\n * Serializes a user object into a string, suitable for storing as a cookie.\n */\n</mt:Ignore>\nfunction mtBakeUserCookie(u) {\n    var str = \"\";\n    if (u.name) str += \"name:\'\" + mtEscapeJS(u.name) + \"\';\";\n    if (u.url) str += \"url:\'\" + mtEscapeJS(u.url) + \"\';\";\n    if (u.email) str += \"email:\'\" + mtEscapeJS(u.email) + \"\';\";\n    if (u.is_authenticated) str += \"is_authenticated:\'1\';\";\n    if (u.profile) str += \"profile:\'\" + mtEscapeJS(u.profile) + \"\';\";\n    if (u.userpic) str += \"userpic:\'\" + mtEscapeJS(u.userpic) + \"\';\";\n    if (u.sid) str += \"sid:\'\" + mtEscapeJS(u.sid) + \"\';\";\n    str += \"is_trusted:\'\" + (u.is_trusted ? \"1\" : \"0\") + \"\';\";\n    str += \"is_author:\'\" + (u.is_author ? \"1\" : \"0\") + \"\';\";\n    str += \"is_banned:\'\" + (u.is_banned ? \"1\" : \"0\") + \"\';\";\n    str += \"can_post:\'\" + (u.can_post ? \"1\" : \"0\") + \"\';\";\n    str += \"can_comment:\'\" + (u.can_comment ? \"1\" : \"0\") + \"\';\";\n    str = str.replace(/;$/, \'\');\n    return str;\n}\n\n<mt:Ignore>\n/***\n * Unserializes a user cookie and returns a user object with the restored\n * state.\n */\n</mt:Ignore>\nfunction mtUnbakeUserCookie(s) {\n    if (!s) return;\n\n    var u = {};\n    var m;\n    while (m = s.match(/^((name|url|email|is_authenticated|profile|userpic|sid|is_trusted|is_author|is_banned|can_post|can_comment):\'([^\']+?)\';?)/)) {\n        s = s.substring(m[1].length);\n        if (m[2].match(/^(is|can)_/)) // boolean fields\n            u[m[2]] = m[3] == \'1\' ? true : false;\n        else\n            u[m[2]] = mtUnescapeJS(m[3]);\n    }\n    if (u.is_authenticated) {\n        u.is_anonymous = false;\n    } else {\n        u.is_anonymous = true;\n        u.can_post = false;\n        u.is_author = false;\n        u.is_banned = false;\n        u.is_trusted = false;\n    }\n    return u;\n}\n\n<mt:Ignore>\n/***\n * Retrieves an object of the currently logged in user\'s state.\n * If no user is logged in or cookied, this will return null.\n */\n</mt:Ignore>\nfunction mtGetUser() {\n    if (!user) {\n        var cookie = mtGetCookie(mtCookieName);\n        if (!cookie) return;\n        user = mtUnbakeUserCookie(cookie);\n        if (! user) {\n            user = {};\n            user.is_anonymous = true;\n            user.can_post = false;\n            user.is_author = false;\n            user.is_banned = false;\n            user.is_trusted = false;\n        }\n    }\n    return user;\n}\n\n<mt:Ignore>\n/***\n * Issues a request to the MT comment script to retrieve the currently\n * logged-in user (if any).\n */\n</mt:Ignore>\nvar mtFetchedUser = false;\n<mt:IfWebsite>\nfunction mtFetchUser(cb) {\n    if (!cb) cb = \'mtSetUser\';\n    if ( ( cb == \'mtSetUser\' ) && mtGetUser() ) {\n        var url = document.URL;\n        url = url.replace(/#.+$/, \'\');\n        url += \'#comments-open\';\n        location.href = url;\n    } else {\n        // we aren\'t using AJAX for this, since we may have to request\n        // from a different domain. JSONP to the rescue.\n        mtFetchedUser = true;\n        var u = mtGetUser();\n        var script = document.createElement(\'script\');\n        var ts = new Date().getTime();\n        script.src = \'<$mt:CGIPath$><$mt:CommentScript$>?__mode=userinfo&blog_id=<$mt:BlogID$>&jsonp=\' + cb + \'&ts=\' + ts + \'&sid=\' + u.sid;\n        (document.getElementsByTagName(\'head\'))[0].appendChild(script);\n    }\n}\n\nfunction mtVerifySession(cb) {\n    if (!cb) return;\n    var script = document.createElement(\'script\');\n    var ts = new Date().getTime();\n    var u = mtGetUser();\n    script.src = \'<$mt:CGIPath$><$mt:CommentScript$>?__mode=verify_session&blog_id=<$mt:BlogID$>&jsonp=\' + cb + \'&ts=\' + ts + \'&sid=\' + u.sid;\n    (document.getElementsByTagName(\'head\'))[0].appendChild(script);\n}\n</mt:IfWebsite>\n\n<mt:Ignore>\n/***\n * Called when the \'Remember me\' checkbox is changed. If the checkbox\n * is cleared, the cached user cookie is immediately cleared.\n */\n</mt:Ignore>\nfunction mtRememberMeOnClick(b) {\n    if (!b.checked)\n        mtClearUser(b.form);\n    return true;\n}\n\n<mt:Ignore>\n/***\n * Called when comment form is sent.\n * Required parameter: Form DOM object of comment form.\n * If form has a \'bakecookie\' member, it will be used to signal\n * storing the anonymous commenter information to a cookie.\n * If form has a \'armor\' member, it will be used to store\n * a token that is checked by the comment script.\n */\n</mt:Ignore>\n<mt:IfWebsite>\nvar mtRequestSubmitted = false;\nfunction mtCommentOnSubmit(f) {\n    if (!mtRequestSubmitted) {\n        mtRequestSubmitted = true;\n\n        if (f.armor)\n            f.armor.value = \'<$mt:BlogSitePath encode_sha1=\"1\"$>\';\n        if (f.bakecookie && f.bakecookie.checked)\n            mtSaveUser(f);\n\n        // disable submit buttons\n        if (f.preview_button) f.preview_button.disabled = true;\n        if (f.post) f.post.disabled = true;\n\n        var u = mtGetUser();\n        if ( !is_preview && ( u && u.is_authenticated ) ) {\n            // validate session; then submit\n            mtVerifySession(\'mtCommentSessionVerify\');\n            return false;\n        }\n\n        return true;\n    }\n    return false;\n}\n\nfunction mtCommentSessionVerify(app_user) {\n    var f = document[\'comments_form\'];\n    if ( app_user && app_user.verified ) {\n        f.submit();\n    } else {\n        alert(\'セッションの有効期限が切れています。再度サインインしてください。\');\n        mtClearUser();\n        mtFireEvent(\'usersignin\');\n<mt:IfRegistrationRequired>\n        mtShow(\'comments-form\');\n        mtHide(\'comments-open-footer\');\n</mt:IfRegistrationRequired>\n    }\n}\n\nfunction mtUserOnLoad() {\n    var u = mtGetUser();\n\n    // if the user is authenticated, hide the \'anonymous\' fields\n    // and any captcha input if already shown\n    if ( document.getElementById(\'comments-form\')) {\n        if ( u && u.is_authenticated ) {\n            mtShow(\'comments-form\');\n            mtHide(\'comments-open-data\');\n            if (mtCaptchaVisible)\n                mtHide(\'comments-open-captcha\');\n        } else {\n<mt:IfRegistrationRequired>\n            mtHide(\'comments-form\');\n</mt:IfRegistrationRequired>\n        }\n        if ( u && u.is_banned )\n            mtHide(\'comments-form\');\n\n        // if we\'re previewing a comment, make sure the captcha\n        // field is visible\n        if (is_preview)\n            mtShowCaptcha();\n        else\n            mtShowGreeting();\n\n        // populate anonymous comment fields if user is cookied as anonymous\n        var cf = document[\'comments_form\'];\n        if (cf) {\n            if (u && u.is_anonymous) {\n                if (u.email) cf.email.value = u.email;\n                if (u.name) cf.author.value = u.name;\n                if (u.url) cf.url.value = u.url;\n                if (cf.bakecookie)\n                    cf.bakecookie.checked = u.name || u.email;\n            } else {\n                if (u && u.sid && cf.sid)\n                    cf.sid.value = u.sid;\n            }\n            if (cf.post && cf.post.disabled)\n                cf.post.disabled = false;\n            if (cf.preview_button && cf.preview_button.disabled)\n                cf.preview_button.disabled = false;\n            mtRequestSubmitted = false;\n        }\n    }\n}\n</mt:IfWebsite>\n\n<mt:Ignore>\n/***\n * Called when an entry archive page is loaded.\n * This routine controls which elements of the comment form are shown\n * or hidden, depending on commenter type and blog configuration.\n */\n</mt:Ignore>\n<mt:IfWebsite>\nfunction mtEntryOnLoad() {\n    var cf = document[\'comments_form\'];\n    if (cf && cf.preview) cf.preview.value = \'\';\n    <mt:Unless tag=\"IfPingsAccepted\">mtHide(\'trackbacks-info\');</mt:Unless>\n    <mt:Unless tag=\"IfCommentsAccepted\">mtHide(\'comments-open\');</mt:Unless>\n    mtFireEvent(\'usersignin\');\n}\n\nfunction mtEntryOnUnload() {\n    if (mtRequestSubmitted) {\n        var cf = document[\'comments_form\'];\n        if (cf) {\n            if (cf.post && cf.post.disabled)\n                cf.post.disabled = false;\n            if (cf.preview_button && cf.preview_button.disabled)\n                cf.preview_button.disabled = false;\n        }\n        mtRequestSubmitted = false;\n    }\n    return true;\n}\n\nmtAttachEvent(\'usersignin\', mtUserOnLoad);\n</mt:IfWebsite>\n\n<mt:Ignore>\n/***\n * Handles the action of the \"Sign in\" link. First clears any existing\n * user cookie, then directs to the MT comment script to sign the user in.\n */\n</mt:Ignore>\nfunction mtSignIn() {\n    var doc_url = document.URL;\n    doc_url = doc_url.replace(/#.+/, \'\');\n    var url = \'<$mt:SignInLink$>\';\n    if (is_preview) {\n        if ( document[\'comments_form\'] ) {\n            var entry_id = document[\'comments_form\'].entry_id.value;\n            url += \'&entry_id=\' + entry_id;\n        } else {\n            url += \'&return_url=<$mt:BlogURL encode_url=\"1\"$>\';\n        }\n    } else {\n        url += \'&return_url=\' + encodeURIComponent(doc_url);\n    }\n    mtClearUser();\n    location.href = url;\n}\n\nfunction mtSignInOnClick(sign_in_element) {\n    var el;\n    if (sign_in_element) {\n        // display throbber\n        el = document.getElementById(sign_in_element);\n        if (!el)  // legacy MT 4.x element id\n            el = document.getElementById(\'comment-form-external-auth\');\n    }\n    if (el)\n        el.innerHTML = \'サインインします... <span class=\"status-indicator\">&nbsp;</span>\';\n\n    mtClearUser(); // clear any \'anonymous\' user cookie to allow sign in\n    mtSignIn();\n    return false;\n}\n\nfunction mtSetUserOrLogin(u) {\n    if (u && u.is_authenticated) {\n        mtSetUser(u);\n    } else {\n        // user really isn\'t logged in; so let\'s do this!\n        mtSignIn();\n    }\n}\n\n<mt:Ignore>\n/***\n * Handles sign out from the web site.\n * First clears any existing user cookie, then direts to the MT comment\n * script to sign the user out.\n */\n</mt:Ignore>\nfunction mtSignOut(entry_id) {\n    mtClearUser();\n    var doc_url = document.URL;\n    doc_url = doc_url.replace(/#.+/, \'\');\n    var url = \'<$mt:SignOutLink$>\';\n    if (is_preview) {\n        if ( document[\'comments_form\'] ) {\n            var entry_id = document[\'comments_form\'].entry_id.value;\n            url += \'&entry_id=\' + entry_id;\n        } else {\n            url += \'&return_url=<$mt:BlogURL encode_url=\"1\"$>\';\n        }\n    } else {\n        url += \'&return_url=\' + encodeURIComponent(doc_url);\n    }\n    location.href = url;\n}\n\n<mt:Ignore>\n/***\n * Handles the action of the \"Sign out\" link.\n */\n</mt:Ignore>\nfunction mtSignOutOnClick() {\n    mtSignOut();\n    return false;\n}\n\n<mt:Ignore>\n/***\n * Handles the display of the greeting message, depending on what kind of\n * user is logged in and blog comment policy.\n */\n</mt:Ignore>\n<mt:IfWebsite>\nfunction mtShowGreeting() {\n<mt:IfRegistrationAllowed>\n    var reg_reqd = <mt:IfRegistrationRequired>true<mt:Else>false</mt:IfRegistrationRequired>;\n\n    var cf = document[\'comments_form\'];\n    if (!cf) return;\n\n    var el = document.getElementById(\'comment-greeting\');\n    if (!el)  // legacy MT 4.x element id\n        el = document.getElementById(\'comment-form-external-auth\');\n    if (!el) return;\n\n    var eid = cf.entry_id;\n    var entry_id;\n    if (eid) entry_id = eid.value;\n\n    var phrase;\n    var u = mtGetUser();\n\n    if ( u && u.is_authenticated ) {\n        if ( u.is_banned ) {\n            phrase = \'このブログにコメントする権限を持っていません。(\\<a href=\\\"javas\\cript:void(0);\\\" onclick=\\\"return mtSignOutOnClick();\\\"\\>サインアウトする\\<\\/a\\>)\';\n        } else {\n            var user_link;\n            if ( u.is_author ) {\n                user_link = \'<a href=\"<$mt:CGIPath$><$mt:CommentScript$>?__mode=edit_profile&blog_id=<mt:BlogID>&return_url=\' + encodeURIComponent( location.href );\n                user_link += \'\">\' + u.name + \'</a>\';\n            } else {\n                // registered user, but not a user with posting rights\n                if (u.url)\n                    user_link = \'<a href=\"\' + u.url + \'\">\' + u.name + \'</a>\';\n                else\n                    user_link = u.name;\n            }\n            // TBD: supplement phrase with userpic if one is available.\n            phrase = \'__NAME__としてサインインしています。(\\<a href=\\\"javas\\cript:void(0)\\\" onclick=\\\"return mtSignOutOnClick();\\\"\\>サインアウト\\<\\/a\\>)\';\n            phrase = phrase.replace(/__NAME__/, user_link);\n        }\n    } else {\n        if (reg_reqd) {\n            phrase = \'コメントするにはまず\\<a href=\\\"javas\\cript:void(0)\\\" onclick=\\\"return mtSignInOnClick(\\\'comment-greeting\\\')\\\"\\>サインイン\\<\\/a\\>してください。\';\n        } else {\n            phrase = \'コメントする前に\\<a href=\\\"javas\\cript:void(0)\\\" onclick=\\\"return mtSignInOnClick(\\\'comment-greeting\\\')\\\"\\>サインイン\\<\\/a\\>することもできます。\';\n        }\n    }\n    el.innerHTML = phrase;\n<mt:Else>\n    mtShowCaptcha();\n</mt:IfRegistrationAllowed>\n}\n</mt:IfWebsite>\n\n<mt:Ignore>\n/***\n * Handles the action of the \'Reply\' links.\n */\n</mt:Ignore>\nfunction mtReplyCommentOnClick(parent_id, author) {\n    mtShow(\'comment-form-reply\');\n\n    var checkbox = document.getElementById(\'comment-reply\');\n    var label = document.getElementById(\'comment-reply-label\');\n    var text = document.getElementById(\'comment-text\');\n\n    // Populate label with new values\n    var reply_text = \'\\<a href=\\\"#comment-__PARENT__\\\" onclick=\\\"location.href=this.href; return false\\\"\\>__AUTHOR__からのコメント\\<\\/a\\>に返信\';\n    reply_text = reply_text.replace(/__PARENT__/, parent_id);\n    reply_text = reply_text.replace(/__AUTHOR__/, author);\n    label.innerHTML = reply_text;\n\n    checkbox.value = parent_id; \n    checkbox.checked = true;\n    try {\n        // text field may be hidden\n        text.focus();\n    } catch(e) {\n    }\n\n    mtSetCommentParentID();\n}\n\n<mt:Ignore>\n/***\n * Sets the parent comment ID when replying to a comment.\n */\n</mt:Ignore>\nfunction mtSetCommentParentID() {\n    var checkbox = document.getElementById(\'comment-reply\');\n    var parent_id_field = document.getElementById(\'comment-parent-id\');\n    if (!checkbox || !parent_id_field) return;\n\n    var pid = 0;\n    if (checkbox.checked == true)\n        pid = checkbox.value;\n    parent_id_field.value = pid;\n}\n\n<mt:Ignore>\n/***\n * Persists a copy of the current user cookie into the browser cookie stash.\n */\n</mt:Ignore>\nfunction mtSaveUser(f) {\n    // We can\'t reliably store the user cookie during a preview.\n    if (is_preview) return;\n\n    var u = mtGetUser();\n\n    if (f && (!u || u.is_anonymous)) {\n        if ( !u ) {\n            u = {};\n            u.is_authenticated = false;\n            u.can_comment = true;\n            u.is_author = false;\n            u.is_banned = false;\n            u.is_anonymous = true;\n            u.is_trusted = false;\n        }\n        if (f.author != undefined) u.name = f.author.value;\n        if (f.email != undefined) u.email = f.email.value;\n        if (f.url != undefined) u.url = f.url.value;\n    }\n\n    if (!u) return;\n\n    var cache_period = mtCookieTimeout * 1000;\n\n    // cache anonymous user info for a long period if the\n    // user has requested to be remembered\n    if (u.is_anonymous && f && f.bakecookie && f.bakecookie.checked)\n        cache_period = 365 * 24 * 60 * 60 * 1000;\n\n    var now = new Date();\n    mtFixDate(now);\n    now.setTime(now.getTime() + cache_period);\n\n    var cmtcookie = mtBakeUserCookie(u);\n    mtSetCookie(mtCookieName, cmtcookie, now, mtCookiePath, mtCookieDomain,\n        location.protocol == \'https:\');\n}\n\n<mt:Ignore>\n/***\n * Clears the blog-side user cookie.\n */\n</mt:Ignore>\nfunction mtClearUser() {\n    user = null;\n    mtDeleteCookie(mtCookieName, mtCookiePath, mtCookieDomain,\n        location.protocol == \'https:\');\n}\n\n<mt:Ignore>\n/***\n * Sets a browser cookie.\n */\n</mt:Ignore>\nfunction mtSetCookie(name, value, expires, path, domain, secure) {\n    if (domain && ( domain.match(/^\\.?localhost$/) || domain.match(/^[0-9\\.]+$/) ))\n        domain = null;\n    var curCookie = name + \"=\" + encodeURIComponent(value) +\n        (expires ? \"; expires=\" + expires.toGMTString() : \"\") +\n        (path ? \"; path=\" + path : \"\") +\n        (domain ? \"; domain=\" + domain : \"\") +\n        (secure ? \"; secure\" : \"\");\n    document.cookie = curCookie;\n}\n\n<mt:Ignore>\n/***\n * Retrieves a browser cookie.\n */\n</mt:Ignore>\nfunction mtGetCookie(name) {\n    var prefix = name + \'=\';\n    var c = document.cookie;\n    var cookieStartIndex = c.indexOf(prefix);\n    if (cookieStartIndex == -1)\n        return \'\';\n    var cookieEndIndex = c.indexOf(\";\", cookieStartIndex + prefix.length);\n    if (cookieEndIndex == -1)\n        cookieEndIndex = c.length;\n    var this_cookie = c.substring(cookieStartIndex + prefix.length, cookieEndIndex);\n    if ( this_cookie.match(/\\%u/i) ) {\n        return \'\';\n    }\n    return decodeURIComponent( this_cookie );\n}\n\n<mt:Ignore>\n/***\n * Deletes a browser cookie.\n */\n</mt:Ignore>\nfunction mtDeleteCookie(name, path, domain, secure) {\n    if (mtGetCookie(name)) {\n        if (domain && domain.match(/^\\.?localhost$/))\n            domain = null;\n        document.cookie = name + \"=\" +\n            (path ? \"; path=\" + path : \"\") +\n            (domain ? \"; domain=\" + domain : \"\") +\n            (secure ? \"; secure\" : \"\") +\n            \"; expires=Thu, 01-Jan-70 00:00:01 GMT\";\n    }\n}\n\nfunction mtFixDate(date) {\n    var skew = (new Date(0)).getTime();\n    if (skew > 0)\n        date.setTime(date.getTime() - skew);\n}\n\n<mt:Ignore>\n/***\n * Returns a XMLHttpRequest object (for Ajax operations).\n */\n</mt:Ignore>\nfunction mtGetXmlHttp() {\n    if ( !window.XMLHttpRequest ) {\n        window.XMLHttpRequest = function() {\n            var types = [\n                \"Microsoft.XMLHTTP\",\n                \"MSXML2.XMLHTTP.5.0\",\n                \"MSXML2.XMLHTTP.4.0\",\n                \"MSXML2.XMLHTTP.3.0\",\n                \"MSXML2.XMLHTTP\"\n            ];\n\n            for ( var i = 0; i < types.length; i++ ) {\n                try {\n                    return new ActiveXObject( types[ i ] );\n                } catch( e ) {}\n            }\n\n            return undefined;\n        };\n    }\n    if ( window.XMLHttpRequest )\n        return new XMLHttpRequest();\n}\n\n// BEGIN: fast browser onload init\n// Modifications by David Davis, DWD\n// Dean Edwards/Matthias Miller/John Resig\n// http://dean.edwards.name/weblog/2006/06/again/?full#comment5338\n\nfunction mtInit() {\n    // quit if this function has already been called\n    if (arguments.callee.done) return;\n\n    // flag this function so we don\'t do the same thing twice\n    arguments.callee.done = true;\n\n    // kill the timer\n    // DWD - check against window\n    if ( window._timer ) clearInterval(window._timer);\n\n    // DWD - fire the window onload now, and replace it\n    if ( window.onload && ( window.onload !== window.mtInit ) ) {\n        window.onload();\n        window.onload = function() {};\n    }\n<mt:IfWebsite>\n<mt:IfRegistrationAllowed>\n    mtInitCommenter();\n</mt:IfRegistrationAllowed>\n</mt:IfWebsite>\n}\n\n/* for Mozilla/Opera9 */\nif (document.addEventListener) {\n    document.addEventListener(\"DOMContentLoaded\", mtInit, false);\n}\n\n/* for Internet Explorer */\n/*@cc_on @*/\n/*@if (@_win32)\nif (!document.addEventListener){\n  document.write(\"<script id=__ie_onload defer src=//:><\\/script>\");\n  var script = document.getElementById(\"__ie_onload\");\n  script.onreadystatechange = function() {\n      if (this.readyState == \"complete\") {\n          mtInit(); // call the onload handler\n      }\n  };\n}\n/*@end @*/\n\n/* for Safari */\nif (/WebKit/i.test(navigator.userAgent)) { // sniff\n    _timer = setInterval(function() {\n        if (/loaded|complete/.test(document.readyState)) {\n            mtInit(); // call the onload handler\n        }\n    }, 10);\n}\n\n/* for other browsers */\nwindow.onload = mtInit;\n\n// END: fast browser onload init\n\n<mt:IfWebsite>\n<mt:IfRegistrationAllowed>\n\nfunction mtLoggedIn(ott) {\n    var script = document.createElement(\'script\');\n    var ts = new Date().getTime();\n    script.src = \'<$mt:CGIPath$><$mt:CommentScript$>?__mode=userinfo&jsonp=mtSaveUserInfo&ott=\' + ott;\n    (document.getElementsByTagName(\'head\'))[0].appendChild(script);\n}\n\nfunction mtRefreshUserInfo(sid) {\n    var script = document.createElement(\'script\');\n    var ts = new Date().getTime();\n    script.src = \'<$mt:CGIPath$><$mt:CommentScript$>?__mode=userinfo&jsonp=mtSaveUserInfo&sid=\' + sid;\n    (document.getElementsByTagName(\'head\'))[0].appendChild(script);\n}\n\nfunction mtSaveUserInfo (u) {\n    if ( u.error ) {\n        if ( !user ) {\n            alert(\'サインインできませんでした。\');\n        }\n        return;\n    }\n    user = null;\n    var cmtcookie = mtBakeUserCookie(u);\n    var now = new Date();\n    var cache_period = mtCookieTimeout * 1000;\n\n    // cache anonymous user info for a long period if the\n    // user has requested to be remembered\n    mtFixDate(now);\n    now.setTime(now.getTime() + cache_period);\n    mtSetCookie(mtCookieName, cmtcookie, now, mtCookiePath, mtCookieDomain,\n        location.protocol == \'https:\');\n    mtFireEvent(\'usersignin\');\n}\n\nfunction mtInitCommenter () {\n    /***\n     * If request contains a \'#_login\' or \'#_logout\' hash, use this to\n     * also delete the blog-side user cookie, since we\'re coming back from\n     * a login, logout or edit profile operation.\n     */\n\n    var hash = ( window.location.hash );\n    hash.match( /^#_(.*)$/ );\n    var command = RegExp.$1 || \'\';\n    if ( command === \'refresh\' ) {\n        // Back from profile edit screen.\n        // Reload userinfo with current session ID.\n        var u = mtGetUser();\n        user  = null;\n        mtRefreshUserInfo(u.sid);\n    }\n    else if ( command === \'logout\' ) {\n        // clear any logged in state\n        mtClearUser();\n        mtFireEvent(\'usersignin\');\n    }\n    else if ( command.match( /^login_(.*)$/ ) ) {\n        var sid = RegExp.$1;\n        mtLoggedIn(sid);\n    }\n    else {\n        mtFireEvent(\'usersignin\');\n    }\n}\n</mt:IfRegistrationAllowed>\n</mt:IfWebsite>\n','index',0),(41,1,0,0,1,1,'2014-11-02 00:12:59','comment_listing',NULL,NULL,NULL,NULL,'2014-11-02 00:12:59','コメント一覧',NULL,1,'{\n    \"direction\": \"<mt:Var name=\"commentDirection\">\",\n    \"comments\": \"<mt:Comments sort_order=\"$commentDirection\"><$mt:Include module=\"コメント詳細\" replace=\"\\\",\"\\\\\" replace=\'\"\',\'\\\"\' regex_replace=\"/\\t/g\",\"\\\\t\" strip_linefeeds=\"1\"$></mt:Comments>\",\n    \"cacheKey\": \"<mt:Var name=\"cacheKey\">\"\n}\n','comment_listing',0),(42,1,0,0,1,1,'2014-11-02 00:12:59','archive_index',NULL,NULL,NULL,NULL,'2014-11-02 00:12:59','アーカイブインデックス','archives.html',1,'<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\"\n    \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\" id=\"sixapart-standard\">\n<head>\n    <$mt:Include module=\"HTMLヘッダー\"$>\n    <title><$mt:BlogName encode_html=\"1\"$>: アーカイブ</title>\n</head>\n<body id=\"<$mt:BlogThemeID$>\" class=\"mt-archive-index <$mt:Var name=\"page_layout\"$>\">\n    <div id=\"container\">\n        <div id=\"container-inner\">\n\n\n            <$mt:Include module=\"バナーヘッダー\"$>\n\n\n            <div id=\"content\">\n                <div id=\"content-inner\">\n\n\n                    <div id=\"alpha\">\n                        <div id=\"alpha-inner\">\n\n                            <h1 id=\"page-title\" class=\"archive-title\">アーカイブ</h1>\n\n<mt:Ignore>\n    <!-- List of monthly archives, if monthly archives are enabled -->\n</mt:Ignore>\n<mt:IfArchiveTypeEnabled archive_type=\"Monthly\">\n                            <div class=\"archive-monthly archive-date-based archive\">\n    <mt:ArchiveList archive_type=\"Monthly\">\n        <mt:ArchiveListHeader>\n                                <h2 class=\"archive-header\">月別アーカイブ</h2>\n                                <div class=\"archive-content\">\n                                    <ul>\n        </mt:ArchiveListHeader>\n                                        <li><a href=\"<$mt:ArchiveLink$>\"><$mt:ArchiveTitle$></a></li>\n        <mt:ArchiveListFooter>\n                                    </ul>\n                                </div>\n        </mt:ArchiveListFooter>\n    </mt:ArchiveList>\n                            </div>\n</mt:IfArchiveTypeEnabled>\n\n\n<mt:Ignore>\n    <!-- List of category archives, if category archives are enabled -->\n</mt:Ignore>\n<mt:IfArchiveTypeEnabled archive_type=\"Category\">\n                            <div class=\"archive-category archive\">\n                                <h2 class=\"archive-header\">カテゴリ</h2>\n                                <div class=\"archive-content\">\n    <mt:TopLevelCategories>\n        <mt:SubCatIsFirst>\n                                    <ul>\n        </mt:SubCatIsFirst>\n        <mt:If tag=\"CategoryCount\">\n                                        <li><a href=\"<$mt:CategoryArchiveLink$>\" title=\"<$mt:CategoryDescription$>\"><$mt:CategoryLabel$></a>\n        <mt:Else>\n                                        <li><$mt:CategoryLabel$>\n        </mt:If>\n        <$mt:SubCatsRecurse$>\n                                        </li>\n        <mt:SubCatIsLast>\n                                    </ul>\n        </mt:SubCatIsLast>\n    </mt:TopLevelCategories>\n                                </div>\n                            </div>\n</mt:IfArchiveTypeEnabled>\n\n\n<mt:Ignore>\n    <!-- List of author archives, if category author are enabled -->\n    <mt:IfArchiveTypeEnabled archive_type=\"Author\">\n                                <div class=\"archive-author archive\">\n        <mt:ArchiveList archive_type=\"Author\">\n            <mt:ArchiveListHeader>\n                                    <h2 class=\"archive-header\">ユーザーアーカイブ</h2>\n                                    <div class=\"archive-content\">\n                                        <ul>\n            </mt:ArchiveListHeader>\n                                            <li><a href=\"<$mt:ArchiveLink$>\"><$mt:ArchiveTitle$></a></li>\n            <mt:ArchiveListFooter>\n                                        </ul>\n                                    </div>\n            </mt:ArchiveListFooter>\n        </mt:ArchiveList>\n                                </div>\n    </mt:IfArchiveTypeEnabled>\n</mt:Ignore>\n\n\n<mt:Ignore>\n    <!-- List of category archives by month, if category archives are enabled -->\n    <mt:IfArchiveTypeEnabled archive_type=\"Category-Monthly\">\n                                <div class=\"archive-category-monthly archive\">\n        <mt:ArchiveList archive_type=\"Category-Monthly\">\n            <mt:ArchiveListHeader>\n                                    <h2 class=\"archive-header\">月別カテゴリアーカイブ</h2>\n                                    <div class=\"archive-content\">\n                                        <ul>\n            </mt:ArchiveListHeader>\n                                            <li><a href=\"<$mt:ArchiveLink$>\"><$mt:ArchiveTitle$></a></li>\n            <mt:ArchiveListFooter>\n                                        </ul>\n                                    </div>\n            </mt:ArchiveListFooter>\n        </mt:ArchiveList>\n                                </div>\n    </mt:IfArchiveTypeEnabled>\n</mt:Ignore>\n\n\n<mt:Ignore>\n    <!-- List of author archives, if category archives are enabled -->\n    <mt:IfArchiveTypeEnabled archive_type=\"Author-Monthly\">\n                                <div class=\"archive-author-monthly archive\">\n        <mt:ArchiveList archive_type=\"Author-Monthly\">\n            <mt:ArchiveListHeader>\n                                    <h2 class=\"archive-header\">月別ユーザーアーカイブ</h2>\n                                    <div class=\"archive-content\">\n                                        <ul>\n            </mt:ArchiveListHeader>\n                                            <li><a href=\"<$mt:ArchiveLink$>\"><$mt:ArchiveTitle$></a></li>\n            <mt:ArchiveListFooter>\n                                        </ul>\n                                    </div>\n            </mt:ArchiveListFooter>\n        </mt:ArchiveList>\n                                </div>\n    </mt:IfArchiveTypeEnabled>\n</mt:Ignore>\n\n\n<mt:Ignore>\n    <!-- List of entry archives, if entry archives are enabled -->\n<mt:IfArchiveTypeEnabled archive_type=\"Individual\">\n                            <div class=\"archive-individual archive-date-based archive\">\n    <mt:ArchiveList archive_type=\"Individual\">\n        <mt:ArchiveListHeader>\n                                <div class=\"archive-content\">\n                                    <ul>\n        </mt:ArchiveListHeader>\n                                        <li><$mt:ArchiveDate format=\"%Y.%m.%d\"$>: <a href=\"<$mt:ArchiveLink$>\"><$mt:ArchiveTitle$></a></li>\n        <mt:ArchiveListFooter>\n                                    </ul>\n                                </div>\n        </mt:ArchiveListFooter>\n    </mt:ArchiveList>\n                            </div>\n</mt:IfArchiveTypeEnabled>\n</mt:Ignore>\n\n\n                        </div>\n                    </div>\n\n\n                    <$mt:Include module=\"サイドバー\"$>\n\n\n                </div>\n            </div>\n\n\n            <$mt:Include module=\"バナーフッター\"$>\n\n\n        </div>\n    </div>\n</body>\n</html>\n','index',0),(43,1,0,0,1,1,'2014-11-02 00:12:59','date_based_category_archives',NULL,NULL,NULL,NULL,'2014-11-02 00:12:59','日付ベースのカテゴリアーカイブ',NULL,1,'<mt:IfArchiveTypeEnabled archive_type=\"Category-Yearly\">\n    <mt:ArchiveList archive_type=\"Category-Yearly\">\n        <mt:ArchiveListHeader>\n<div class=\"widget-archive-category-yearly widget-archive widget\">\n    <h3 class=\"widget-header\">年別カテゴリアーカイブ</h3>\n    <div class=\"widget-content\">\n        <ul>\n        </mt:ArchiveListHeader>\n            <li><a href=\"<$mt:ArchiveLink$>\"><$mt:ArchiveTitle$> (<$mt:ArchiveCount$>)</a></li>\n        <mt:ArchiveListFooter>\n        </ul>\n    </div>\n</div>\n        </mt:ArchiveListFooter>\n    </mt:ArchiveList>\n</mt:IfArchiveTypeEnabled>\n\n<mt:IfArchiveTypeEnabled archive_type=\"Category-Monthly\">\n    <mt:ArchiveList archive_type=\"Category-Monthly\">\n        <mt:ArchiveListHeader>\n<div class=\"widget-archive-category-monthly widget-archive widget\">\n    <h3 class=\"widget-header\">月別カテゴリアーカイブ</h3>\n    <div class=\"widget-content\">\n        <ul>\n        </mt:ArchiveListHeader>\n            <li><a href=\"<$mt:ArchiveLink$>\"><$mt:ArchiveTitle$> (<$mt:ArchiveCount$>)</a></li>\n        <mt:ArchiveListFooter>\n        </ul>\n    </div>\n</div>\n        </mt:ArchiveListFooter>\n    </mt:ArchiveList>\n</mt:IfArchiveTypeEnabled>\n\n<mt:IfArchiveTypeEnabled archive_type=\"Category-Weekly\">\n    <mt:ArchiveList archive_type=\"Category-Weekly\">\n        <mt:ArchiveListHeader>\n<div class=\"widget-archive-category-weekly widget-archive widget\">\n    <h3 class=\"widget-header\">週別カテゴリアーカイブ</h3>\n    <div class=\"widget-content\">\n        <ul>\n        </mt:ArchiveListHeader>\n            <li><a href=\"<$mt:ArchiveLink$>\"><$mt:ArchiveTitle$> (<$mt:ArchiveCount$>)</a></li>\n        <mt:ArchiveListFooter>\n        </ul>\n    </div>\n</div>\n        </mt:ArchiveListFooter>\n    </mt:ArchiveList>\n</mt:IfArchiveTypeEnabled>\n\n<mt:IfArchiveTypeEnabled archive_type=\"Category-Daily\">\n    <mt:ArchiveList archive_type=\"Category-Daily\">\n        <mt:ArchiveListHeader>\n<div class=\"widget-archive-category-daily widget-archive widget\">\n    <h3 class=\"widget-header\">日別カテゴリアーカイブ</h3>\n    <div class=\"widget-content\">\n        <ul>\n        </mt:ArchiveListHeader>\n            <li><a href=\"<$mt:ArchiveLink$>\"><$mt:ArchiveTitle$> (<$mt:ArchiveCount$>)</a></li>\n        <mt:ArchiveListFooter>\n        </ul>\n    </div>\n</div>\n        </mt:ArchiveListFooter>\n    </mt:ArchiveList>\n</mt:IfArchiveTypeEnabled>\n\n','widget',0),(44,1,0,0,1,1,'2014-11-02 00:12:59','main_index_widgets_group',NULL,NULL,NULL,NULL,'2014-11-02 00:12:59','ホームページウィジェットグループ',NULL,1,'<mt:Ignore>\n    main_indexのテンプレートだけに表示されるように設定されているウィジェットのセットです。詳細: http://www.movabletype.org/documentation/designer/widget-sets.html\n</mt:Ignore>\n<mt:If name=\"main_index\">\n    <$mt:Include widget=\"最近のコメント\"$>\n    <$mt:Include widget=\"最近の記事\"$>\n    <$mt:Include widget=\"アイテム\"$>\n    <$mt:Include widget=\"タグクラウド\"$>\n</mt:If>\n','widget',0),(45,1,0,0,1,1,'2014-11-02 00:12:59','html_head',NULL,NULL,NULL,NULL,'2014-11-02 00:12:59','HTMLヘッダー',NULL,1,'<meta http-equiv=\"Content-Type\" content=\"text/html; charset=<$mt:PublishCharset$>\" />\n<meta name=\"generator\" content=\"<$mt:ProductName version=\"1\"$>\" />\n<link rel=\"stylesheet\" href=\"<$mt:Link template=\"styles\"$>\" type=\"text/css\" />\n<link rel=\"start\" href=\"<$mt:BlogURL$>\" title=\"Home\" />\n<link rel=\"alternate\" type=\"application/atom+xml\" title=\"Recent Entries\" href=\"<$mt:Link template=\"feed_recent\"$>\" />\n<script type=\"text/javascript\" src=\"<$mt:Link template=\"javascript\"$>\"></script>\n<$mt:CCLicenseRDF$>\n<$mt:CanonicalLink$>\n<$mt:StatsSnippet$>\n','custom',0),(46,1,0,0,1,1,'2014-11-02 00:12:59','search',NULL,NULL,NULL,NULL,'2014-11-02 00:12:59','検索',NULL,1,'<div class=\"widget-search widget\">\n    <h3 class=\"widget-header\">検索</h3>\n    <div class=\"widget-content\">\n        <form method=\"get\" action=\"<$mt:CGIPath$><$mt:SearchScript$>\">\n            <input type=\"text\" id=\"search\" class=\"ti\" name=\"search\" value=\"<$mt:SearchString$>\" />\n<mt:If name=\"search_results\">\n            <input type=\"hidden\" name=\"IncludeBlogs\" value=\"<$mt:SearchIncludeBlogs$>\" />\n            <mt:Ignore>\n            <!-- use these options only with MT::App::Search::Legacy -->\n            <ul class=\"search-options\">\n                <li><input type=\"checkbox\" name=\"CaseSearch\" /> 大文字/小文字を区別する</li>\n                <li><input type=\"checkbox\" name=\"RegexSearch\" /> 正規表現</li>\n            </ul>\n            </mt:Ignore>\n<mt:Else>\n            <input type=\"hidden\" name=\"IncludeBlogs\" value=\"<$mt:WebsiteID$><mt:WebsiteHasBlog><mt:Blogs include_blogs=\"children\">,<mt:BlogID></mt:Blogs></mt:WebsiteHasBlog>\" />\n</mt:If>\n            <input type=\"hidden\" name=\"limit\" value=\"<$mt:SearchMaxResults$>\" />\n            <input type=\"submit\" accesskey=\"4\" value=\"検索\" />\n        </form>\n    </div>\n</div>\n<mt:If name=\"search_results\">\n    <mt:IfTagSearch>\n<div class=\"widget-tags widget\">\n    <h3 class=\"widget-header\">タグ</h3>\n    <div class=\"widget-content\">\n        <ul>\n        <mt:Tags>\n            <li><a href=\"javascript:void(0)\" onclick=\"location.href=\'<$mt:TagSearchLink encode_js=\"1\"$>\';return false;\"><$mt:TagName$> (<$mt:TagCount$>)</a></li>\n        </mt:Tags>\n        </ul>\n    </div>\n</div>\n    </mt:IfTagSearch>\n</mt:If>\n','widget',0),(47,1,0,0,1,1,'2014-11-02 00:12:59','recent_comments',NULL,NULL,NULL,NULL,'2014-11-02 00:12:59','最近のコメント',NULL,1,'<mt:If tag=\"BlogCommentCount\" include_blogs=\"children\" include_with_website=\"1\">\n    <mt:Comments lastn=\"10\" sort_order=\"descend\" include_blogs=\"children\" include_with_website=\"1\">\n        <mt:CommentsHeader>\n<div class=\"widget-recent-comments widget\">\n    <h3 class=\"widget-header\">最近のコメント</h3>\n    <div class=\"widget-content\">\n        <ul>\n        </mt:CommentsHeader>\n            <li><strong><$mt:CommentAuthor$>:</strong> <$mt:CommentBody remove_html=\"1\" words=\"10\"$> <a href=\"<$mt:CommentLink$>\" title=\"<mt:CommentEntry><$mt:EntryTitle$></mt:CommentEntry>へのコメント\">続きを読む</a></li>\n        <mt:CommentsFooter>\n        </ul>\n    </div>\n</div>\n        </mt:CommentsFooter>\n    </mt:Comments>\n</mt:If>\n','widget',0),(48,1,0,0,1,1,'2014-11-02 00:12:59','current_author_monthly_archive_list',NULL,NULL,NULL,NULL,'2014-11-02 00:12:59','ユーザー月別アーカイブ',NULL,1,'<mt:IfArchiveTypeEnabled archive_type=\"Author-Monthly\">\n    <mt:ArchiveList archive_type=\"Author-Monthly\">\n        <mt:ArchiveListHeader>\n<div class=\"widget-archive-current-author-monthly widget-archive widget\">\n    <h3 class=\"widget-header\"><$mt:AuthorDisplayName encode_html=\"1\"$>: 月別アーカイブ</h3>\n    <div class=\"widget-content\">\n        <ul>\n        </mt:ArchiveListHeader>\n            <li><a href=\"<$mt:ArchiveLink$>\"><$mt:ArchiveTitle$> (<$mt:ArchiveCount$>)</a></li>\n        <mt:ArchiveListFooter>\n        </ul>\n        </mt:ArchiveListFooter>\n    </mt:ArchiveList>\n    </div>\n</div>\n</mt:IfArchiveTypeEnabled>\n','widget',0),(49,1,0,0,1,1,'2014-11-02 00:12:59','main_index',NULL,NULL,NULL,NULL,'2014-11-02 00:12:59','メインページ','index.html',1,'<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\"\n    \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\" id=\"sixapart-standard\">\n<head>\n    <$mt:Include module=\"HTMLヘッダー\"$>\n    <link rel=\"EditURI\" type=\"application/rsd+xml\" title=\"RSD\" href=\"<$mt:Link template=\"rsd\"$>\" />\n    <title><$mt:BlogName encode_html=\"1\"$></title>\n</head>\n<body id=\"<$mt:WebsiteThemeID$>\" class=\"mt-main-index <$mt:Var name=\"page_layout\"$>\">\n    <div id=\"container\">\n        <div id=\"container-inner\">\n\n\n            <$mt:Include module=\"バナーヘッダー\"$>\n\n\n            <div id=\"content\">\n                <div id=\"content-inner\">\n\n\n                    <div id=\"alpha\">\n                        <div id=\"alpha-inner\">\n<mt:Entries include_blogs=\"children\" include_with_website=\"1\" >\n                            <mt:Ignore><!-- Use the Entry Summary module for each entry published on this page --></mt:Ignore>\n                            <$mt:Include module=\"記事の概要\" display_blog_name=\"1\"$>\n</mt:Entries>\n\n                        </div>\n                    </div>\n\n\n                    <$mt:Include module=\"サイドバー\"$>\n\n\n                </div>\n            </div>\n\n\n            <$mt:Include module=\"バナーフッター\"$>\n\n\n        </div>\n    </div>\n</body>\n</html>\n','index',0),(50,1,0,0,1,1,'2014-11-02 00:12:59','3column_layout_secondary_sidebar',NULL,NULL,NULL,NULL,'2014-11-02 00:12:59','3カラムのサイドバー(サブ)',NULL,1,'<mt:include widget=\"検索\"><mt:include widget=\"ホームページウィジェットグループ\"><mt:include widget=\"About\">','widgetset',0),(51,1,0,0,1,1,'2014-11-02 00:12:59','3column_layout_primary_sidebar',NULL,NULL,NULL,NULL,'2014-11-02 00:12:59','3カラムのサイドバー(メイン)',NULL,1,'<mt:include widget=\"ブログ\"><mt:include widget=\"アーカイブウィジェットグループ\"><mt:include widget=\"ページ一覧\"><mt:include widget=\"購読\"><mt:include widget=\"OpenID対応\"><mt:include widget=\"Powered By\">','widgetset',0),(52,1,0,0,1,1,'2014-11-02 00:12:59','2column_layout_sidebar',NULL,NULL,NULL,NULL,'2014-11-02 00:12:59','2カラムのサイドバー',NULL,1,'<mt:include widget=\"検索\"><mt:include widget=\"ブログ\"><mt:include widget=\"About\"><mt:include widget=\"ホームページウィジェットグループ\"><mt:include widget=\"アーカイブウィジェットグループ\"><mt:include widget=\"ページ一覧\"><mt:include widget=\"購読\"><mt:include widget=\"OpenID対応\"><mt:include widget=\"Powered By\">','widgetset',0),(53,0,0,0,1,1,'2014-11-02 00:12:59','notify-entry',NULL,NULL,NULL,NULL,'2014-11-02 00:12:59','記事の共有',NULL,1,'新しい<$mt:EntryClassLabel$>「<$mt:EntryTitle$>」を<$mt:BlogName$>で公開しました。\n\n<mt:If name=\"object_type\" eq=\"entry\">表示する<mt:Else>表示する</mt:If> <<mt:SetVarBlock name=\"entry_status\"><$mt:EntryStatus$></mt:SetVarBlock><mt:If name=\"entry_status\" eq=\"Publish\"><$mt:EntryPermalink$><mt:Else><$mt:Var name=\"entry_editurl\"$></mt:If>>\n\n------------------------------------------------------------------------\nタイトル: <$mt:EntryTitle$>\n日付: <$mt:EntryDate mail=\"1\"$>\n<mt:If name=\"send_excerpt\">\n\n<$mt:EntryExcerpt wrap_text=\"72\"$>\n</mt:If>\n------------------------------------------------------------------------\n\n<mt:If name=\"message\">メッセージ: \n<$mt:Var name=\"message\"$></mt:If>\n<mt:If name=\"send_body\">\n------------------------------------------------------------------------\n\n<$mt:EntryBody remove_html=\"1\" wrap_text=\"72\"$>\n\n------------------------------------------------------------------------</mt:If>\n\nこのメールは<$mt:BlogName$>で新規に作成されたコンテンツに関する通知を送るように設定されているか、またはコンテンツの著者が選択したユーザーに送信されています。このメールを受信したくない場合は、次のユーザーに連絡してください:\n\n<mt:if name=\"entry_author\"><$mt:AuthorDisplayName$> <<$mt:AuthorEmail$>><mt:else><$mt:var name=\"from_address\"$></mt:if>\n','email',0),(54,0,0,0,1,1,'2014-11-02 00:12:59','recover-password',NULL,NULL,NULL,NULL,'2014-11-02 00:12:59','パスワードの再設定',NULL,1,'パスワードをリセットしようとしています。以下のリンクをクリックして、新しいパスワードを設定してください。\n\n<mt:var name=\"link_to_login\">\n\nこのメールに心当たりがないときは、何もせずに無視してください。\n\n<mt:include module=\"メールフッター\">\n','email',0),(55,0,0,0,1,1,'2014-11-02 00:12:59','lockout-ip',NULL,NULL,NULL,NULL,'2014-11-02 00:12:59','IPアドレスのロック通知',NULL,1,'これは以下のIPアドレスからのアクセスがロックされたことを通知するメールです。\n\nIPアドレス: <mt:var name=\"ip_address\"> \n解除時刻: <mt:Date ts=\"$recovery_time\">\n\n<mt:include module=\"メールフッター\">\n','email',0),(56,0,0,0,1,1,'2014-11-02 00:12:59','commenter_confirm',NULL,NULL,NULL,NULL,'2014-11-02 00:12:59','コメントの確認',NULL,1,'<$mt:BlogName$>にコメントするために登録していただきありがとうございます。 \n\nセキュリティ上の理由から、登録を完了する前にアカウントとメールアドレスの確認を行っています。確認を完了次第、<$mt:BlogName$>にコメントできるようになります。\n\nアカウントの確認のため、次のURLをクリックするか、コピーしてブラウザのアドレス欄に貼り付けてください。\n\n<$mt:Var name=\"confirm_url\"$>\n\nこのメールに覚えがない場合や、<$mt:BlogName$>に登録するのをやめたい場合は、何もする必要はありません。\n\n \n<mt:If tag=\"AuthorDisplayName\"><$mt:AuthorDisplayName encode_html=\"1\"$><mt:Else>Movable Type</mt:If>\n\n<$mt:Include module=\"メールフッター\"$>\n','email',0),(57,0,0,0,1,1,'2014-11-02 00:12:59','new-ping',NULL,NULL,NULL,NULL,'2014-11-02 00:12:59','新しいトラックバック',NULL,1,'<mt:If name=\"unapproved\" trim=\"1\">\n  <mt:If name=\"entry_id\">\n    <mt:If tag=\"EntryClass\" eq=\"entry\">\n      サイト \'<$mt:BlogName$>\' の記事 \'<$mt:EntryTitle$>\' (ID:<$mt:EntryID$>) に未公開のトラックバックがあります。公開するまでこのトラックバックはサイトに表示されません。\n    <mt:Else>\n      サイト \'<$mt:BlogName$>\' のウェブページ \'<$mt:PageTitle$>\' (ID:<$mt:PageID$>) に未公開のトラックバックがあります。公開するまでこのトラックバックはサイトに表示されません。\n    </mt:If>\n  <mt:ElseIf name=\"category_id\">\n    サイト \'<$mt:BlogName$>\' のカテゴリ \'<$mt:CategoryLabel$>\' (ID:<$mt:CategoryID$>) に未公開のトラックバックがあります。公開するまでこのトラックバックはサイトに表示されません。\n  </mt:If>\n<mt:Else>\n  <mt:If name=\"entry_id\">\n    <mt:If tag=\"EntryClass\" eq=\"entry\">\n      サイト \'<$mt:BlogName$>\' の記事 \'<$mt:EntryTitle$>\' (ID:<$mt:EntryID$>) に新しいトラックバックがあります。\n    <mt:Else>\n      サイト \'<$mt:BlogName$>\' のウェブページ \'<$mt:PageTitle$>\' (ID:<$mt:PageID$>) に新しいトラックバックがあります。\n    </mt:If>\n  <mt:ElseIf name=\"category_id\">\n    サイト \'<$mt:BlogName$>\' のカテゴリ \'<$mt:CategoryLabel$>\' (ID:<$mt:CategoryID$>) に新しいトラックバックがあります。\n  </mt:If>\n</mt:If>\n\n概要: \n<$mt:PingExcerpt wrap_text=\"72\"$>\n\nURL: <$mt:PingURL$>\nタイトル: <$mt:PingTitle$>\nブログ: <$mt:PingBlogName$>\nIPアドレス: <$mt:PingIP$>\n\n<mt:If name=\"state_editable\"><mt:If name=\"unapproved\">トラックバックを承認する: \n  <<$mt:Var name=\"approve_url\"$>>\n</mt:If></mt:If>\n<mt:If name=\"entry_id\"><mt:If tag=\"EntryPermalink\">トラックバックを見る: \n  <<$mt:EntryPermalink$>>\n</mt:If></mt:If>\n<mt:If name=\"state_editable\">トラックバックをスパムとして報告する: \n  <<$mt:Var name=\"spam_url\"$>>\n</mt:If>\nトラックバックの編集: \n  <<$mt:Var name=\"edit_url\"$>>\n\n<$mt:Include module=\"メールフッター\"$>\n','email',0),(58,0,0,0,1,1,'2014-11-02 00:12:59','lockout-user',NULL,NULL,NULL,NULL,'2014-11-02 00:12:59','ユーザーアカウントのロック通知',NULL,1,'これは以下のユーザーアカウントがロックされたことを通知するメールです。\n\nユーザー名: <mt:AuthorName> \n表示名: <mt:AuthorDisplayName>\nメール: <mt:AuthorEmail>\n\nユーザーのロックを解除する場合は、リンクをクリックしてください。\n\n<mt:var name=\"recover_lockout_link\">\n\n<mt:include module=\"メールフッター\">\n','email',0),(59,0,0,0,1,1,'2014-11-02 00:12:59','new-comment',NULL,NULL,NULL,NULL,'2014-11-02 00:12:59','新しいコメント',NULL,1,'<mt:If name=\"unapproved\" trim=\"1\">\n    <mt:If tag=\"EntryClass\" eq=\"entry\">\n        未公開のコメントがサイト \'<$mt:BlogName$>\' の記事 \'<$mt:EntryTitle$>\' (ID:<$mt:EntryID$>) に投稿されました。公開するまでこのコメントはサイトに表示されません。\n    <mt:Else>\n        未公開のコメントがサイト \'<$mt:BlogName$>\' のウェブページ \'<$mt:PageTitle$>\' (ID:<$mt:PageID$>) に投稿されました。公開するまでこのコメントはサイトに表示されません。\n    </mt:If>\n<mt:Else>\n    <mt:If tag=\"EntryClass\" eq=\"entry\">\n        サイト \'<$mt:BlogName$>\' の記事 \'<$mt:EntryTitle$>\' (ID:<$mt:EntryID$>) に新しいコメントが投稿されました。\n    <mt:Else>\n        サイト \'<$mt:BlogName$>\' のウェブページ \'<$mt:PageTitle$>\' (ID:<$mt:PageID$>) に新しいコメントが投稿されました。\n    </mt:If>\n</mt:If>\n\n<$mt:CommentBody remove_html=\"1\" wrap_text=\"72\"$>\n\nコメント投稿者: <$mt:CommentAuthor$> \nメールアドレス: <$mt:CommentEmail$>\nURL: <$mt:CommentURL$>\nIPアドレス: <$mt:CommentIP$>\n\n<mt:If name=\"unapproved\"><mt:If name=\"state_editable\">コメントを承認する:\n    <<$mt:Var name=\"approve_url\"$>></mt:If></mt:If>\n<mt:If name=\"view_url\">コメントを見る:\n    <<$mt:Var name=\"view_url\" escape=\"html\"$>></mt:If>\nコメントを編集する:\n    <<$mt:Var name=\"edit_url\"$>>\n<mt:If name=\"state_editable\">コメントをスパムとして報告する:\n    <<$mt:Var name=\"spam_url\"$>></mt:If>\n\n<$mt:Include module=\"メールフッター\"$>\n','email',0),(60,0,0,0,1,1,'2014-11-02 00:12:59','footer-email',NULL,NULL,NULL,NULL,'2014-11-02 00:12:59','メールフッター',NULL,1,'\n-- \nPowered by Movable Type <$mt:Version$>\n<$mt:Var name=\"portal_url\"$>\n','custom',0),(61,0,0,0,1,1,'2014-11-02 00:12:59','commenter_notify',NULL,NULL,NULL,NULL,'2014-11-02 00:12:59','コメントの通知',NULL,1,'これは新しいユーザーがブログ「<$mt:BlogName$>」に登録を完了したことを通知するメールです。新しいユーザーの情報は以下に記載されています。\n\n新規登録ユーザー:\nユーザー名: <$mt:CommenterUsername$> \n名前: <$mt:CommenterName$>\nメール: <$mt:CommenterEmail$>\n\nこのユーザーの情報を見たり編集する場合には、下記のURLをクリックするか、URLをコピーしてブラウザのアドレス欄に貼り付けてください。\n<$mt:Var name=\"profile_url\"$>\n\n<$mt:Include module=\"メールフッター\"$>\n','email',0),(62,0,0,0,1,1,'2014-11-02 00:12:59','comment_throttle',NULL,NULL,NULL,NULL,'2014-11-02 00:12:59','コメントスロットル',NULL,1,'<mt:SetVarBlock name=\"message\">これが間違いである場合は、Movable Typeにサインインして、ブログの設定画面に進み、禁止IPリストからIPアドレスを削除してください。</mt:SetVarBlock>\n<$mt:BlogName$>を禁止しました。<$mt:Var name=\"throttle_seconds\"$>秒の間に許可された以上のコメントを送信してきました。\n\nこれは悪意のスクリプトがブログをコメントで飽和させるのを阻止するための措置です。以下のIPアドレスを禁止しました。\n\n<$mt:Var name=\"throttled_ip\"$>\n\n<$mt:Var name=\"message\"$>\n','email',0);
/*!40000 ALTER TABLE `mt_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_template_meta`
--

DROP TABLE IF EXISTS `mt_template_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_template_meta` (
  `template_meta_template_id` int(11) NOT NULL,
  `template_meta_type` varchar(75) NOT NULL,
  `template_meta_vchar` varchar(255) DEFAULT NULL,
  `template_meta_vchar_idx` varchar(255) DEFAULT NULL,
  `template_meta_vdatetime` datetime DEFAULT NULL,
  `template_meta_vdatetime_idx` datetime DEFAULT NULL,
  `template_meta_vinteger` int(11) DEFAULT NULL,
  `template_meta_vinteger_idx` int(11) DEFAULT NULL,
  `template_meta_vfloat` float DEFAULT NULL,
  `template_meta_vfloat_idx` float DEFAULT NULL,
  `template_meta_vblob` mediumblob,
  `template_meta_vclob` mediumtext,
  PRIMARY KEY (`template_meta_template_id`,`template_meta_type`),
  KEY `mt_template_meta_type_vint` (`template_meta_type`,`template_meta_vinteger_idx`),
  KEY `mt_template_meta_type_vflt` (`template_meta_type`,`template_meta_vfloat_idx`),
  KEY `mt_template_meta_type_vdt` (`template_meta_type`,`template_meta_vdatetime_idx`),
  KEY `mt_template_meta_type_vchar` (`template_meta_type`,`template_meta_vchar_idx`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_template_meta`
--

LOCK TABLES `mt_template_meta` WRITE;
/*!40000 ALTER TABLE `mt_template_meta` DISABLE KEYS */;
INSERT INTO `mt_template_meta` VALUES (50,'modulesets','46,44,29',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(51,'modulesets','32,35,22,37,30,20',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(52,'modulesets','46,32,29,44,35,22,37,30,20',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `mt_template_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_template_rev`
--

DROP TABLE IF EXISTS `mt_template_rev`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_template_rev` (
  `template_rev_id` int(11) NOT NULL AUTO_INCREMENT,
  `template_rev_changed` varchar(255) NOT NULL,
  `template_rev_created_by` int(11) DEFAULT NULL,
  `template_rev_created_on` datetime DEFAULT NULL,
  `template_rev_description` varchar(255) DEFAULT NULL,
  `template_rev_label` varchar(255) DEFAULT NULL,
  `template_rev_modified_by` int(11) DEFAULT NULL,
  `template_rev_modified_on` datetime DEFAULT NULL,
  `template_rev_rev_number` int(11) NOT NULL DEFAULT '0',
  `template_rev_template` mediumblob NOT NULL,
  `template_rev_template_id` int(11) NOT NULL,
  PRIMARY KEY (`template_rev_id`),
  KEY `mt_template_rev_template_id` (`template_rev_template_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_template_rev`
--

LOCK TABLES `mt_template_rev` WRITE;
/*!40000 ALTER TABLE `mt_template_rev` DISABLE KEYS */;
/*!40000 ALTER TABLE `mt_template_rev` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_templatemap`
--

DROP TABLE IF EXISTS `mt_templatemap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_templatemap` (
  `templatemap_id` int(11) NOT NULL AUTO_INCREMENT,
  `templatemap_archive_type` varchar(25) NOT NULL,
  `templatemap_blog_id` int(11) NOT NULL,
  `templatemap_build_interval` int(11) DEFAULT NULL,
  `templatemap_build_type` smallint(6) DEFAULT '1',
  `templatemap_file_template` varchar(255) DEFAULT NULL,
  `templatemap_is_preferred` tinyint(4) DEFAULT NULL,
  `templatemap_template_id` int(11) NOT NULL,
  PRIMARY KEY (`templatemap_id`),
  KEY `mt_templatemap_is_preferred` (`templatemap_is_preferred`),
  KEY `mt_templatemap_archive_type` (`templatemap_archive_type`),
  KEY `mt_templatemap_template_id` (`templatemap_template_id`),
  KEY `mt_templatemap_blog_id` (`templatemap_blog_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_templatemap`
--

LOCK TABLES `mt_templatemap` WRITE;
/*!40000 ALTER TABLE `mt_templatemap` DISABLE KEYS */;
INSERT INTO `mt_templatemap` VALUES (1,'Monthly',1,NULL,1,NULL,1,4),(2,'Individual',1,NULL,1,NULL,1,11),(3,'Page',1,NULL,1,NULL,1,25),(4,'Category',1,NULL,1,NULL,1,36);
/*!40000 ALTER TABLE `mt_templatemap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_touch`
--

DROP TABLE IF EXISTS `mt_touch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_touch` (
  `touch_id` int(11) NOT NULL AUTO_INCREMENT,
  `touch_blog_id` int(11) DEFAULT NULL,
  `touch_modified_on` datetime DEFAULT NULL,
  `touch_object_type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`touch_id`),
  KEY `mt_touch_blog_type` (`touch_blog_id`,`touch_object_type`,`touch_modified_on`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_touch`
--

LOCK TABLES `mt_touch` WRITE;
/*!40000 ALTER TABLE `mt_touch` DISABLE KEYS */;
INSERT INTO `mt_touch` VALUES (1,0,'2014-11-01 15:13:01','author'),(2,1,'2014-11-01 15:12:59','template');
/*!40000 ALTER TABLE `mt_touch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_trackback`
--

DROP TABLE IF EXISTS `mt_trackback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_trackback` (
  `trackback_id` int(11) NOT NULL AUTO_INCREMENT,
  `trackback_blog_id` int(11) NOT NULL,
  `trackback_category_id` int(11) NOT NULL DEFAULT '0',
  `trackback_created_by` int(11) DEFAULT NULL,
  `trackback_created_on` datetime DEFAULT NULL,
  `trackback_description` mediumtext,
  `trackback_entry_id` int(11) NOT NULL DEFAULT '0',
  `trackback_is_disabled` tinyint(4) DEFAULT '0',
  `trackback_modified_by` int(11) DEFAULT NULL,
  `trackback_modified_on` datetime DEFAULT NULL,
  `trackback_passphrase` varchar(30) DEFAULT NULL,
  `trackback_rss_file` varchar(255) DEFAULT NULL,
  `trackback_title` varchar(255) DEFAULT NULL,
  `trackback_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`trackback_id`),
  KEY `mt_trackback_category_id` (`trackback_category_id`),
  KEY `mt_trackback_created_on` (`trackback_created_on`),
  KEY `mt_trackback_blog_id` (`trackback_blog_id`),
  KEY `mt_trackback_entry_id` (`trackback_entry_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_trackback`
--

LOCK TABLES `mt_trackback` WRITE;
/*!40000 ALTER TABLE `mt_trackback` DISABLE KEYS */;
/*!40000 ALTER TABLE `mt_trackback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_ts_error`
--

DROP TABLE IF EXISTS `mt_ts_error`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_ts_error` (
  `ts_error_error_time` int(11) NOT NULL,
  `ts_error_funcid` int(11) NOT NULL DEFAULT '0',
  `ts_error_jobid` int(11) NOT NULL,
  `ts_error_message` varchar(255) NOT NULL,
  KEY `mt_ts_error_funcid_time` (`ts_error_funcid`,`ts_error_error_time`),
  KEY `mt_ts_error_error_time` (`ts_error_error_time`),
  KEY `mt_ts_error_jobid` (`ts_error_jobid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_ts_error`
--

LOCK TABLES `mt_ts_error` WRITE;
/*!40000 ALTER TABLE `mt_ts_error` DISABLE KEYS */;
/*!40000 ALTER TABLE `mt_ts_error` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_ts_exitstatus`
--

DROP TABLE IF EXISTS `mt_ts_exitstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_ts_exitstatus` (
  `ts_exitstatus_jobid` int(11) NOT NULL,
  `ts_exitstatus_completion_time` int(11) DEFAULT NULL,
  `ts_exitstatus_delete_after` int(11) DEFAULT NULL,
  `ts_exitstatus_funcid` int(11) NOT NULL,
  `ts_exitstatus_status` int(11) DEFAULT NULL,
  PRIMARY KEY (`ts_exitstatus_jobid`),
  KEY `mt_ts_exitstatus_funcid` (`ts_exitstatus_funcid`),
  KEY `mt_ts_exitstatus_delete_after` (`ts_exitstatus_delete_after`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_ts_exitstatus`
--

LOCK TABLES `mt_ts_exitstatus` WRITE;
/*!40000 ALTER TABLE `mt_ts_exitstatus` DISABLE KEYS */;
/*!40000 ALTER TABLE `mt_ts_exitstatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_ts_funcmap`
--

DROP TABLE IF EXISTS `mt_ts_funcmap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_ts_funcmap` (
  `ts_funcmap_funcid` int(11) NOT NULL AUTO_INCREMENT,
  `ts_funcmap_funcname` varchar(255) NOT NULL,
  PRIMARY KEY (`ts_funcmap_funcid`),
  UNIQUE KEY `mt_ts_funcmap_funcname` (`ts_funcmap_funcname`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_ts_funcmap`
--

LOCK TABLES `mt_ts_funcmap` WRITE;
/*!40000 ALTER TABLE `mt_ts_funcmap` DISABLE KEYS */;
/*!40000 ALTER TABLE `mt_ts_funcmap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mt_ts_job`
--

DROP TABLE IF EXISTS `mt_ts_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mt_ts_job` (
  `ts_job_jobid` int(11) NOT NULL AUTO_INCREMENT,
  `ts_job_arg` mediumblob,
  `ts_job_coalesce` varchar(255) DEFAULT NULL,
  `ts_job_funcid` int(11) NOT NULL,
  `ts_job_grabbed_until` int(11) NOT NULL,
  `ts_job_insert_time` int(11) DEFAULT NULL,
  `ts_job_priority` int(11) DEFAULT NULL,
  `ts_job_run_after` int(11) NOT NULL,
  `ts_job_uniqkey` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ts_job_jobid`),
  UNIQUE KEY `mt_ts_job_uniqfunc` (`ts_job_funcid`,`ts_job_uniqkey`),
  KEY `mt_ts_job_funcpri` (`ts_job_funcid`,`ts_job_priority`),
  KEY `mt_ts_job_funccoal` (`ts_job_funcid`,`ts_job_coalesce`),
  KEY `mt_ts_job_funcrun` (`ts_job_funcid`,`ts_job_run_after`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mt_ts_job`
--

LOCK TABLES `mt_ts_job` WRITE;
/*!40000 ALTER TABLE `mt_ts_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `mt_ts_job` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-11-01 15:13:33
