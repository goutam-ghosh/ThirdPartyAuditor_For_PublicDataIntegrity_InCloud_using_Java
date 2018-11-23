-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.5.18


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema youcloud
--

CREATE DATABASE IF NOT EXISTS youcloud;
USE youcloud;

--
-- Definition of table `csp`
--

DROP TABLE IF EXISTS `csp`;
CREATE TABLE `csp` (
  `cid` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `pass` varchar(50) NOT NULL,
  `img` varchar(100) DEFAULT 'default.jpg',
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `csp`
--

/*!40000 ALTER TABLE `csp` DISABLE KEYS */;
INSERT INTO `csp` (`cid`,`name`,`pass`,`img`) VALUES 
 ('csp','CSP','abc','default.jpg');
/*!40000 ALTER TABLE `csp` ENABLE KEYS */;


--
-- Definition of table `csprequests`
--

DROP TABLE IF EXISTS `csprequests`;
CREATE TABLE `csprequests` (
  `email` varchar(50) NOT NULL,
  `fileid` varchar(45) NOT NULL,
  `filename` varchar(1000) NOT NULL,
  `filesize` varchar(100) DEFAULT '0',
  `timedate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(45) NOT NULL DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `csprequests`
--

/*!40000 ALTER TABLE `csprequests` DISABLE KEYS */;
INSERT INTO `csprequests` (`email`,`fileid`,`filename`,`filesize`,`timedate`,`status`) VALUES 
 ('ankush.r.nistane@gmail.com','1','cloud_security_tutorial_ICDE13.pptx','3670800','2016-07-22 07:48:04','Cleared'),
 ('akshay@gmail.com','2','CloudSecurity.pptx','2282563','2016-07-22 07:54:59','Cleared'),
 ('ankush.r.nistane@gmail.com','3','cloud_security_tutorial_ICDE13.pptx','3670800','2016-07-22 12:16:34','Cleared'),
 ('ankush.r.nistane@gmail.com','4','cloud_security_tutorial_ICDE13.pptx','3670796','2016-07-25 17:03:09','Cleared'),
 ('ankush.r.nistane@gmail.com','3','cloud_security_tutorial_ICDE13.pptx','3670800','2016-07-25 17:03:09','Pending'),
 ('ankush.r.nistane@gmail.com','5','MIND.apk','4062242','2016-08-29 13:49:17','Cleared'),
 ('ankush.r.nistane@gmail.com','6','Basics of Programming.doc','2173143','2016-11-19 11:13:42','Cleared'),
 ('ankush.r.nistane@gmail.com','8','Introudction to Computer System.doc','2505953','2016-11-19 12:58:00','Pending'),
 ('ankush.r.nistane@gmail.com','7','Business Skill-The essentials.doc','5698271','2016-11-19 12:58:01','Pending');
/*!40000 ALTER TABLE `csprequests` ENABLE KEYS */;


--
-- Definition of table `downloads`
--

DROP TABLE IF EXISTS `downloads`;
CREATE TABLE `downloads` (
  `fileowner` varchar(100) NOT NULL,
  `allowedto` varchar(100) NOT NULL,
  `fileid` int(10) unsigned NOT NULL,
  `downstatus` varchar(45) NOT NULL DEFAULT 'Block'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `downloads`
--

/*!40000 ALTER TABLE `downloads` DISABLE KEYS */;
INSERT INTO `downloads` (`fileowner`,`allowedto`,`fileid`,`downstatus`) VALUES 
 ('ankush.r.nistane@gmail.com','akshay@gmail.com',1,'Accepted'),
 ('ankush.r.nistane@gmail.com','akshay@gmail.com',3,'Accepted');
/*!40000 ALTER TABLE `downloads` ENABLE KEYS */;


--
-- Definition of table `fileblocks`
--

DROP TABLE IF EXISTS `fileblocks`;
CREATE TABLE `fileblocks` (
  `fileid` int(11) NOT NULL,
  `blockno` varchar(10) NOT NULL,
  `skey` varchar(50) DEFAULT NULL,
  `blockstatus` varchar(20) DEFAULT 'not sent',
  `mkey` longtext
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `fileblocks`
--

/*!40000 ALTER TABLE `fileblocks` DISABLE KEYS */;
INSERT INTO `fileblocks` (`fileid`,`blockno`,`skey`,`blockstatus`,`mkey`) VALUES 
 (1,'0','1','sent','c4ca4238a0b923820dcc509a6f75849b'),
 (1,'1','2','sent','c81e728d9d4c2f636f067f89cc14862c'),
 (1,'2','3','sent','eccbc87e4b5ce2fe28308fd9f2a7baf3'),
 (1,'3','4','sent','a87ff679a2f3e71d9181a67b7542122c'),
 (1,'4','5','sent','e4da3b7fbbce2345d7772b0674a318d5'),
 (1,'5','6','sent','1679091c5a880faf6fb5e6087eb1b2dc'),
 (1,'6','7','sent','8f14e45fceea167a5a36dedd4bea2543'),
 (1,'7','8','sent','c9f0f895fb98ab9159f51fd0297e236d'),
 (1,'8','9','sent','45c48cce2e2d7fbdea1afc51c7c6ad26'),
 (1,'9','10','sent','d3d9446802a44259755d38e6d163e820'),
 (2,'0','1','sent','c4ca4238a0b923820dcc509a6f75849b'),
 (2,'1','2','sent','c81e728d9d4c2f636f067f89cc14862c'),
 (2,'2','3','sent','eccbc87e4b5ce2fe28308fd9f2a7baf3'),
 (2,'3','4','sent','a87ff679a2f3e71d9181a67b7542122c'),
 (2,'4','5','sent','e4da3b7fbbce2345d7772b0674a318d5'),
 (2,'5','6','sent','1679091c5a880faf6fb5e6087eb1b2dc'),
 (2,'6','7','sent','8f14e45fceea167a5a36dedd4bea2543'),
 (2,'7','8','sent','c9f0f895fb98ab9159f51fd0297e236d'),
 (2,'8','9','sent','45c48cce2e2d7fbdea1afc51c7c6ad26'),
 (2,'9','10','sent','d3d9446802a44259755d38e6d163e820'),
 (3,'0','1','sent','c4ca4238a0b923820dcc509a6f75849b'),
 (3,'1','sagasj','sent','760f5d375639b041d3ba7036c8405f54'),
 (3,'2','djjd','sent','61ce6fb47896621d0e7095981619e097'),
 (3,'3','3','sent','eccbc87e4b5ce2fe28308fd9f2a7baf3'),
 (3,'4','4','sent','a87ff679a2f3e71d9181a67b7542122c'),
 (3,'5','5','sent','e4da3b7fbbce2345d7772b0674a318d5'),
 (3,'6','6','sent','1679091c5a880faf6fb5e6087eb1b2dc'),
 (3,'7','7','sent','8f14e45fceea167a5a36dedd4bea2543'),
 (3,'8','1','sent','c4ca4238a0b923820dcc509a6f75849b'),
 (3,'9','1','sent','c4ca4238a0b923820dcc509a6f75849b'),
 (4,'0','1','sent','c4ca4238a0b923820dcc509a6f75849b'),
 (4,'1','2','sent','c81e728d9d4c2f636f067f89cc14862c'),
 (4,'2','3','sent','eccbc87e4b5ce2fe28308fd9f2a7baf3'),
 (4,'3','4','sent','a87ff679a2f3e71d9181a67b7542122c'),
 (4,'4','5','sent','e4da3b7fbbce2345d7772b0674a318d5'),
 (4,'5','6','sent','1679091c5a880faf6fb5e6087eb1b2dc'),
 (4,'6','5','sent','e4da3b7fbbce2345d7772b0674a318d5'),
 (4,'7','4','sent','a87ff679a2f3e71d9181a67b7542122c'),
 (4,'8','6','sent','1679091c5a880faf6fb5e6087eb1b2dc'),
 (4,'9','3','sent','eccbc87e4b5ce2fe28308fd9f2a7baf3'),
 (5,'0','5','sent','e4da3b7fbbce2345d7772b0674a318d5'),
 (5,'1','2','sent','c81e728d9d4c2f636f067f89cc14862c'),
 (5,'2','3','sent','eccbc87e4b5ce2fe28308fd9f2a7baf3'),
 (5,'3','4weaweaeq','sent','484edb71361e35a52195fd52d2ce3175'),
 (5,'4','weq','sent','1d095b4d29ad942b992b9f39d7ed0483'),
 (5,'5','qeq','sent','df95126c4d938271d6faaee2d6cc0804'),
 (5,'6','qe','sent','4d6e7051b02397d7733ea9a222fdb8e0'),
 (5,'7','qew','sent','466bd066eaea252f4853611938852cfc'),
 (5,'8','qweqe','sent','3cba1eb7a5bcd42097c3c3b6ff74c3a0'),
 (5,'9','qew','sent','466bd066eaea252f4853611938852cfc'),
 (6,'0','1','sent','c4ca4238a0b923820dcc509a6f75849b'),
 (6,'1','2','sent','c81e728d9d4c2f636f067f89cc14862c'),
 (6,'2','3','sent','eccbc87e4b5ce2fe28308fd9f2a7baf3'),
 (6,'3','4','sent','a87ff679a2f3e71d9181a67b7542122c'),
 (6,'4','5','sent','e4da3b7fbbce2345d7772b0674a318d5'),
 (6,'5','6','sent','1679091c5a880faf6fb5e6087eb1b2dc'),
 (6,'6','7','sent','8f14e45fceea167a5a36dedd4bea2543'),
 (6,'7','8','sent','c9f0f895fb98ab9159f51fd0297e236d'),
 (6,'8','9','sent','45c48cce2e2d7fbdea1afc51c7c6ad26'),
 (6,'9','10','sent','d3d9446802a44259755d38e6d163e820'),
 (7,'0','1','sent','c4ca4238a0b923820dcc509a6f75849b'),
 (7,'1','2','sent','c81e728d9d4c2f636f067f89cc14862c'),
 (7,'2','3','sent','eccbc87e4b5ce2fe28308fd9f2a7baf3'),
 (7,'3','4','sent','a87ff679a2f3e71d9181a67b7542122c'),
 (7,'4','5','sent','e4da3b7fbbce2345d7772b0674a318d5'),
 (7,'5','6','sent','1679091c5a880faf6fb5e6087eb1b2dc'),
 (7,'6','7','sent','8f14e45fceea167a5a36dedd4bea2543'),
 (7,'7','7','sent','8f14e45fceea167a5a36dedd4bea2543'),
 (7,'8','8','sent','c9f0f895fb98ab9159f51fd0297e236d'),
 (7,'9','9','sent','45c48cce2e2d7fbdea1afc51c7c6ad26'),
 (8,'0','1','sent','c4ca4238a0b923820dcc509a6f75849b'),
 (8,'1','2','sent','c81e728d9d4c2f636f067f89cc14862c'),
 (8,'2','3','sent','eccbc87e4b5ce2fe28308fd9f2a7baf3'),
 (8,'3','4','sent','a87ff679a2f3e71d9181a67b7542122c'),
 (8,'4','5','sent','e4da3b7fbbce2345d7772b0674a318d5'),
 (8,'5','6','sent','1679091c5a880faf6fb5e6087eb1b2dc'),
 (8,'6','7','sent','8f14e45fceea167a5a36dedd4bea2543'),
 (8,'7','8','sent','c9f0f895fb98ab9159f51fd0297e236d'),
 (8,'8','9','sent','45c48cce2e2d7fbdea1afc51c7c6ad26'),
 (8,'9','10','sent','d3d9446802a44259755d38e6d163e820');
/*!40000 ALTER TABLE `fileblocks` ENABLE KEYS */;


--
-- Definition of table `fileuploads`
--

DROP TABLE IF EXISTS `fileuploads`;
CREATE TABLE `fileuploads` (
  `email` varchar(100) NOT NULL,
  `filename` varchar(1000) NOT NULL,
  `totalblocks` varchar(10) NOT NULL,
  `authenticator` longtext,
  `fileid` int(11) NOT NULL AUTO_INCREMENT,
  `filestatus` varchar(100) DEFAULT 'Not-sent',
  `timedate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reqAlert` int(10) unsigned NOT NULL DEFAULT '0',
  `statusAlert` int(10) unsigned NOT NULL DEFAULT '0',
  `timedateTpa` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `transferTime` varchar(45) NOT NULL DEFAULT '0',
  `splitTime` varchar(45) NOT NULL DEFAULT '0',
  `authTime` varchar(45) NOT NULL DEFAULT '0',
  `size` varchar(45) NOT NULL DEFAULT '0',
  `auditTime` varchar(45) DEFAULT '0',
  `auditType` varchar(45) DEFAULT '1',
  PRIMARY KEY (`fileid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `fileuploads`
--

/*!40000 ALTER TABLE `fileuploads` DISABLE KEYS */;
INSERT INTO `fileuploads` (`email`,`filename`,`totalblocks`,`authenticator`,`fileid`,`filestatus`,`timedate`,`reqAlert`,`statusAlert`,`timedateTpa`,`transferTime`,`splitTime`,`authTime`,`size`,`auditTime`,`auditType`) VALUES 
 ('ankush.r.nistane@gmail.com','cloud_security_tutorial_ICDE13.pptx','10','e755b70625bf0c76f1698958b3216748',1,'Verified','2016-07-22 07:41:03',0,0,'2016-07-22 07:49:14','481.0','455.0','132.0','3670800','78','0'),
 ('akshay@gmail.com','CloudSecurity.pptx','10','b3ab9459ee331b86f216a22f3ed476f5',2,'File-Tampered','2016-07-22 07:54:15',0,0,'2016-07-22 07:57:24','179.0','35.0','54.0','2282563','93','0'),
 ('ankush.r.nistane@gmail.com','cloud_security_tutorial_ICDE13.pptx','10','e755b70625bf0c76f1698958b3216748',3,'Pending-at-CSP','2016-07-22 12:13:41',0,0,'2016-07-22 12:19:59','437.0','452.0','140.0','3670800','78','1'),
 ('ankush.r.nistane@gmail.com','cloud_security_tutorial_ICDE13.pptx','10','e755b70625bf0c76f1698958b3216748',4,'Verified','2016-07-25 17:00:28',0,0,'2016-07-25 17:05:35','302.0','482.0','173.0','3670796','46','1'),
 ('ankush.r.nistane@gmail.com','MIND.apk','10','9b77610a36efc57558f7df7ae37a11b4',5,'Verified','2016-08-29 13:47:19',0,0,'2016-08-29 13:52:20','655.0','78.0','125.0','4062242','62','0'),
 ('ankush.r.nistane@gmail.com','Basics of Programming.doc','10','c8179ebbfdff08a6294810af083ed9b2',6,'Verified','2016-11-19 11:08:32',0,0,'2016-11-19 11:18:29','585.0','950.0','130.0','2173143','64','1'),
 ('ankush.r.nistane@gmail.com','Business Skill-The essentials.doc','10','81366a07cc40de3d798917ed1b41ae15',7,'Pending-at-CSP','2016-11-19 12:16:19',0,0,'0000-00-00 00:00:00','1295.0','93.0','172.0','5698271','0','1'),
 ('ankush.r.nistane@gmail.com','Introudction to Computer System.doc','10','3283095d998abfdd446a63dba28378a9',8,'Pending-at-CSP','2016-11-19 12:51:11',0,0,'0000-00-00 00:00:00','19799.0','495.0','102.0','2505953','0','1');
/*!40000 ALTER TABLE `fileuploads` ENABLE KEYS */;


--
-- Definition of table `intruder`
--

DROP TABLE IF EXISTS `intruder`;
CREATE TABLE `intruder` (
  `intruderemail` varchar(100) NOT NULL,
  `filename` varchar(1000) NOT NULL,
  `fileid` int(10) unsigned NOT NULL,
  `size` varchar(45) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `timedate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `owner` varchar(100) NOT NULL,
  `alert` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `intruder`
--

/*!40000 ALTER TABLE `intruder` DISABLE KEYS */;
INSERT INTO `intruder` (`intruderemail`,`filename`,`fileid`,`size`,`type`,`timedate`,`owner`,`alert`) VALUES 
 ('ankush.r.nistane@gmail.com','cloud_security_tutorial_ICDE13.pptx',1,NULL,NULL,'2016-07-22 12:25:39','ankush.r.nistane@gmail.com',0),
 ('ankush.r.nistane@gmail.com','cloud_security_tutorial_ICDE13.pptx',1,NULL,NULL,'2016-08-29 13:54:30','ankush.r.nistane@gmail.com',0);
/*!40000 ALTER TABLE `intruder` ENABLE KEYS */;


--
-- Definition of table `requests`
--

DROP TABLE IF EXISTS `requests`;
CREATE TABLE `requests` (
  `requestfrom` varchar(100) NOT NULL,
  `requestto` varchar(100) NOT NULL,
  `fileid` int(10) unsigned NOT NULL,
  `timedate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reqstatus` varchar(45) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT 'Pending',
  PRIMARY KEY (`fileid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `requests`
--

/*!40000 ALTER TABLE `requests` DISABLE KEYS */;
INSERT INTO `requests` (`requestfrom`,`requestto`,`fileid`,`timedate`,`reqstatus`) VALUES 
 ('akshay@gmail.com','ankush.r.nistane@gmail.com',1,'2016-07-22 07:53:25',0x4163636570746564),
 ('akshay@gmail.com','ankush.r.nistane@gmail.com',3,'2016-07-22 12:21:51',0x4163636570746564);
/*!40000 ALTER TABLE `requests` ENABLE KEYS */;


--
-- Definition of table `tpa`
--

DROP TABLE IF EXISTS `tpa`;
CREATE TABLE `tpa` (
  `tid` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `pass` varchar(50) NOT NULL,
  `img` varchar(100) DEFAULT 'default.jpg',
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tpa`
--

/*!40000 ALTER TABLE `tpa` DISABLE KEYS */;
INSERT INTO `tpa` (`tid`,`name`,`pass`,`img`) VALUES 
 ('tpa','TPA','abc','default.jpg');
/*!40000 ALTER TABLE `tpa` ENABLE KEYS */;


--
-- Definition of table `tparequests`
--

DROP TABLE IF EXISTS `tparequests`;
CREATE TABLE `tparequests` (
  `email` varchar(50) NOT NULL,
  `fileid` int(10) unsigned NOT NULL,
  `filename` varchar(1000) NOT NULL,
  `filesize` varchar(45) DEFAULT NULL,
  `timedate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `userauthenticator` longtext NOT NULL,
  `status` varchar(45) NOT NULL DEFAULT 'Pending',
  `cspauthenticator` longtext
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tparequests`
--

/*!40000 ALTER TABLE `tparequests` DISABLE KEYS */;
INSERT INTO `tparequests` (`email`,`fileid`,`filename`,`filesize`,`timedate`,`userauthenticator`,`status`,`cspauthenticator`) VALUES 
 ('ankush.r.nistane@gmail.com',1,'cloud_security_tutorial_ICDE13.pptx','3670800','2016-07-22 07:41:38','e755b70625bf0c76f1698958b3216748','Verified','e755b70625bf0c76f1698958b3216748'),
 ('akshay@gmail.com',2,'CloudSecurity.pptx','2282563','2016-07-22 07:54:43','b3ab9459ee331b86f216a22f3ed476f5','File-Tampered','7cfb065dd03d54f03b373a261a3983e1'),
 ('ankush.r.nistane@gmail.com',3,'cloud_security_tutorial_ICDE13.pptx','3670800','2016-07-22 12:15:39','e755b70625bf0c76f1698958b3216748','Sent-to-CSP','e755b70625bf0c76f1698958b3216748'),
 ('ankush.r.nistane@gmail.com',3,'cloud_security_tutorial_ICDE13.pptx','3670800','2016-07-22 12:20:06','e755b70625bf0c76f1698958b3216748','Sent-to-CSP',NULL),
 ('ankush.r.nistane@gmail.com',4,'cloud_security_tutorial_ICDE13.pptx','3670796','2016-07-25 17:00:55','e755b70625bf0c76f1698958b3216748','Verified','e755b70625bf0c76f1698958b3216748'),
 ('ankush.r.nistane@gmail.com',5,'MIND.apk','4062242','2016-08-29 13:48:31','9b77610a36efc57558f7df7ae37a11b4','Verified','9b77610a36efc57558f7df7ae37a11b4'),
 ('ankush.r.nistane@gmail.com',6,'Basics of Programming.doc','2173143','2016-11-19 11:09:25','c8179ebbfdff08a6294810af083ed9b2','Verified','c8179ebbfdff08a6294810af083ed9b2'),
 ('ankush.r.nistane@gmail.com',7,'Business Skill-The essentials.doc','5698271','2016-11-19 12:17:09','81366a07cc40de3d798917ed1b41ae15','Sent-to-CSP',NULL),
 ('ankush.r.nistane@gmail.com',8,'Introudction to Computer System.doc','2505953','2016-11-19 12:51:55','3283095d998abfdd446a63dba28378a9','Sent-to-CSP',NULL);
/*!40000 ALTER TABLE `tparequests` ENABLE KEYS */;


--
-- Definition of table `userlog`
--

DROP TABLE IF EXISTS `userlog`;
CREATE TABLE `userlog` (
  `task` varchar(200) NOT NULL,
  `email` varchar(45) NOT NULL,
  `timedate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `filename` varchar(1000) DEFAULT NULL,
  `fileid` int(10) unsigned NOT NULL,
  `size` varchar(45) DEFAULT NULL,
  `filestatus` varchar(45) DEFAULT NULL,
  `owner` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `userlog`
--

/*!40000 ALTER TABLE `userlog` DISABLE KEYS */;
INSERT INTO `userlog` (`task`,`email`,`timedate`,`filename`,`fileid`,`size`,`filestatus`,`owner`) VALUES 
 ('uploaded','ankush.r.nistane@gmail.com','2016-07-22 07:41:03','cloud_security_tutorial_ICDE13.pptx',1,'3670800','Not-sent','ankush.r.nistane@gmail.com'),
 ('downloaded','ankush.r.nistane@gmail.com','2016-07-22 07:51:45','cloud_security_tutorial_ICDE13.pptx',1,NULL,'Verified',NULL),
 ('sentrequest','akshay@gmail.com','2016-07-22 07:53:26',NULL,1,NULL,NULL,'ankush.r.nistane@gmail.com'),
 ('uploaded','akshay@gmail.com','2016-07-22 07:54:16','CloudSecurity.pptx',2,'2282563','Not-sent','akshay@gmail.com'),
 ('uploaded','ankush.r.nistane@gmail.com','2016-07-22 12:13:42','cloud_security_tutorial_ICDE13.pptx',3,'3670800','Not-sent','ankush.r.nistane@gmail.com'),
 ('sentrequest','akshay@gmail.com','2016-07-22 12:21:51',NULL,3,NULL,NULL,'ankush.r.nistane@gmail.com'),
 ('uploaded','ankush.r.nistane@gmail.com','2016-07-25 17:00:28','cloud_security_tutorial_ICDE13.pptx',4,'3670796','Not-sent','ankush.r.nistane@gmail.com'),
 ('uploaded','ankush.r.nistane@gmail.com','2016-08-29 13:47:20','MIND.apk',5,'4062242','Not-sent','ankush.r.nistane@gmail.com'),
 ('downloaded','ankush.r.nistane@gmail.com','2016-08-29 13:52:41','MIND.apk',5,NULL,'Verified',NULL),
 ('downloaded','ankush.r.nistane@gmail.com','2016-08-29 13:55:15','cloud_security_tutorial_ICDE13.pptx',1,NULL,'Verified',NULL),
 ('uploaded','ankush.r.nistane@gmail.com','2016-11-19 11:08:33','Basics of Programming.doc',6,'2173143','Not-sent','ankush.r.nistane@gmail.com'),
 ('uploaded','ankush.r.nistane@gmail.com','2016-11-19 12:16:21','Business Skill-The essentials.doc',7,'5698271','Not-sent','ankush.r.nistane@gmail.com'),
 ('uploaded','ankush.r.nistane@gmail.com','2016-11-19 12:51:13','Introudction to Computer System.doc',8,'2505953','Not-sent','ankush.r.nistane@gmail.com');
/*!40000 ALTER TABLE `userlog` ENABLE KEYS */;


--
-- Definition of table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `email` varchar(50) NOT NULL,
  `pass` varchar(20) NOT NULL,
  `nm` varchar(100) NOT NULL,
  `img` varchar(1000) DEFAULT 'default.jpg',
  `deskey` varchar(500) DEFAULT NULL,
  `otp` varchar(45) DEFAULT NULL,
  `timedate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `userstatus` varchar(45) NOT NULL DEFAULT 'Activated',
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`email`,`pass`,`nm`,`img`,`deskey`,`otp`,`timedate`,`userstatus`) VALUES 
 ('akshay@gmail.com','akshay','Akshay Kende','default.jpg',NULL,'595711367','2016-11-12 01:10:10','Activated'),
 ('ankush.r.nistane@gmail.com','abc','Ankush Nistane','photo.JPG',NULL,'789674576','2016-11-12 01:10:10','Activated'),
 ('suru@gmail.com','12345678','Suresh','default.jpg',NULL,NULL,'2016-11-19 13:33:53','Activated');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
