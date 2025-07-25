-- MySQL dump 10.13  Distrib 8.0.42, for Linux (x86_64)
--
-- Host: localhost    Database: YSWW
-- ------------------------------------------------------
-- Server version	8.0.42-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `KouTu`
--

DROP TABLE IF EXISTS `KouTu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `KouTu` (
  `account` varchar(30) NOT NULL,
  `image` varchar(30) NOT NULL,
  `generate` varchar(30) DEFAULT NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint(1) DEFAULT '0',
  KEY `account` (`account`),
  CONSTRAINT `KouTu_ibfk_1` FOREIGN KEY (`account`) REFERENCES `users` (`email`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `KouTu`
--

LOCK TABLES `KouTu` WRITE;
/*!40000 ALTER TABLE `KouTu` DISABLE KEYS */;
INSERT INTO `KouTu` VALUES ('4r40erfml5@mkzaso.com','pYjovzRoX5NfGFC6NoSoeFn4KYFPSj','gXe1Fu6LgvoAYrmLBqanWS7U3c.png','2025-07-22 13:27:55',1),('2826797374@qq.com','H32BTpA1fmh30H3wWisEzrIS6EHHk2','rLEmqI6UTjtQ1K0Bu0VMnBkCeI.png','2025-07-23 02:39:44',1),('444254881@qq.com','Vm0oTYofi00QnctWth5ik1GDpKyorb','zdJ6iAuL67PUBVPnCcu6tyb7tw.png','2025-07-23 04:59:59',1),('2049983474@qq.com','Gz0tHggU8lmwIVdCVGUgFLm193b5Vv','iO6HjKuPGh7oMV1cQ4rjR9dcRM.png','2025-07-23 08:46:02',1),('2049983474@qq.com','DWPyOWik7fei71knFqkhXNFnvyoYc9','6jiELR4TnYxC6uvV38xXgaOQ08.png','2025-07-23 08:51:32',1),('1446951932@qq.com','wydFmmCrQm3wLXqFnkcxnZzNRcd7iw','0MjjVJs6RaUe1PvNvmBJb6qnIA.png','2025-07-23 09:06:21',1),('2826797374@qq.com','ZmXUhjOP9O1TKAka84EUIWlVsbSd7S','MUwrmOFthPqWYsI9GMOBYzsQ7v.png','2025-07-23 09:08:31',1),('805500871@qq.com','54GDFWk5AZfN6p0q3cdA8YqiIXEW1J','BZ1ZMFxlDrH0LXnFOXDa8d7Kxo.png','2025-07-23 09:49:13',1),('2049983474@qq.com','4H1SjtwxV0TKCTH5WKH92Z7VAFZ0Q9','iy1rJWwENiWq5uooVpUX2lDqEG.png','2025-07-24 01:12:28',1);
/*!40000 ALTER TABLE `KouTu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PlayCount`
--

DROP TABLE IF EXISTS `PlayCount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PlayCount` (
  `playCountId` int NOT NULL,
  `count` int DEFAULT NULL,
  PRIMARY KEY (`playCountId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PlayCount`
--

LOCK TABLES `PlayCount` WRITE;
/*!40000 ALTER TABLE `PlayCount` DISABLE KEYS */;
/*!40000 ALTER TABLE `PlayCount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Portrait`
--

DROP TABLE IF EXISTS `Portrait`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Portrait` (
  `account` varchar(30) NOT NULL,
  `person` varchar(30) NOT NULL,
  `generate` varchar(30) DEFAULT NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint(1) DEFAULT '0',
  KEY `account` (`account`),
  CONSTRAINT `Portrait_ibfk_1` FOREIGN KEY (`account`) REFERENCES `users` (`email`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Portrait`
--

LOCK TABLES `Portrait` WRITE;
/*!40000 ALTER TABLE `Portrait` DISABLE KEYS */;
INSERT INTO `Portrait` VALUES ('4r40erfml5@mkzaso.com','UdSYReqFsrTffiCCixMh5kJlSZEvwc','9u8IsQkrZyTpZA0Sq0Hwz2TGy8.png','2025-07-22 12:32:40',0),('4r40erfml5@mkzaso.com','NwfjnGZqyMIcO6IAhXMHJTPJJuBUkJ','L10ZIhemwe6eyL3LaNDfaskEzU.png','2025-07-22 12:32:40',0),('4r40erfml5@mkzaso.com','M3rq9jXz1pxixB136kTh9sySxyhcHQ','wo0WDMZPqG8D7CiAxxQ3yE0lTQ.png','2025-07-22 14:38:07',0),('2049983474@qq.com','Wrb9pvierknuodQrs8KgXMA5Coqvbe','qaH4yqwjX4yBozYZyRSznTotL7.png','2025-07-23 08:45:57',1),('2049983474@qq.com','kua10Oa75HT3LONhyt2ZEw9OQ8YNFK','d3EeLcTRiGMc3VMHUq7Fw4VE4W.png','2025-07-23 08:51:28',1),('1446951932@qq.com','DCXqgA2yG4KdO7eIAE2VA8dUXw1sNi','SMuzNxjzPh1BvCD6E30QBts9jL.png','2025-07-23 09:06:38',1),('2826797374@qq.com','00HL2qsptdEiaVA2hMeXSVPySd6iBD','Fe9blChENDbUSCfUTsXA7VENmp.png','2025-07-23 09:08:25',1),('1446951932@qq.com','tRJ7pW13kBT7TSDNyw4LW108RuRsOG','Zb2IPKY1gilvMoyOxflDrsmLxl.png','2025-07-23 09:13:59',1),('1446951932@qq.com','tMfu6F77oQV6k8LUQyS7duVEhL8Fm1','se1c69QTrjglETs1hsmQe6GCA1.png','2025-07-23 09:16:05',1),('805961165@qq.com','z1HQPJ7MPMAneX2kxeIZLUczTlTPpQ','mU9IzjMUETWsjed6beOyYxt2zr.png','2025-07-23 09:21:36',1),('805961165@qq.com','mVKPSxFrStbGHBZaYNRp40xtFooXRF','P0CwxOWHVun0XLNFwGUoSFK6GD.png','2025-07-23 09:21:50',1),('1446951932@qq.com','xw7pPIl7SlZcwZp8rHgqZ9fS8kTQmB','ecyVkvKuytwsMgXteTS7XqyRU5.png','2025-07-23 09:23:04',1),('3500562056@qq.com','oBfE6TzfWrVCXRJKtdKFwobf2FQ9J9','LXjwO4PB2RF9f6cixqmnk3ARRe.png','2025-07-23 09:53:57',1),('2826797374@qq.com','rh6ij4fRnUCdW9TpfvysgCykwkbch7','qN03f77CQgdLTaDFCAxsTKpYWm.png','2025-07-23 12:32:29',1);
/*!40000 ALTER TABLE `Portrait` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RLFGH`
--

DROP TABLE IF EXISTS `RLFGH`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RLFGH` (
  `account` varchar(30) NOT NULL,
  `face` varchar(30) NOT NULL,
  `description` varchar(30) NOT NULL,
  `generate` varchar(30) DEFAULT NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint(1) DEFAULT '0',
  KEY `account` (`account`),
  CONSTRAINT `RLFGH_ibfk_1` FOREIGN KEY (`account`) REFERENCES `users` (`email`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RLFGH`
--

LOCK TABLES `RLFGH` WRITE;
/*!40000 ALTER TABLE `RLFGH` DISABLE KEYS */;
INSERT INTO `RLFGH` VALUES ('2049983474@qq.com','vMuMBrSsdh3sUkHQ2QCGX1ZTS08g8O','ZRIUPeFG1oGELRp4nFhjtJB5yomjnu','gTXM1keSXs6NgmgpHcaSJqyPLk.png','2025-07-23 08:45:52',1),('2049983474@qq.com','5fivQSmgS4HXbtCoLlSS6FgcixbPYY','r4iZqvXlfS4pHkig5qaB4UodxUi2eR','MSHbfFF1mxtkAik3M2yrRJvSF3.png','2025-07-23 08:51:21',1),('1446951932@qq.com','PP6OWShhbYJpHBaiwjHrYNMG6FDdZb','wnBdU59cyS1M3do7G0vJJRCOgNU8O8','VM0ZoHJQ8uP2KXPWnvEOI3No3z.png','2025-07-23 09:08:01',1),('2826797374@qq.com','mRv2eU5pijidQcQM7yEmCxlJg5RLU7','BiRFj2ucVo842wAPNZlGKRWP45GzpD','FtWnqNqgg7y8iBde4IHx70XaqL.png','2025-07-23 09:08:19',1),('805961165@qq.com','UTN5RkOI34XgZL2UUf0hHzBrOPBeUd','eg8GsqDifmrdSeWFuhUfNkKaOVa07j','vnlQzny7YDjBf8G3jDIzigGPJy.png','2025-07-23 09:19:24',1),('805961165@qq.com','nZ01u7dOufHnhplvMV1eKwWF5E69bc','zm7uTbhk8Y6QPeVAt8BMzf7LiCcDw3','Fosg4YQQkz8BBv2M50aR42MJr0.png','2025-07-23 09:19:35',1),('805961165@qq.com','IVFmybTLOR8szmzRtX97EEbQvEtl12','MAOwA1SyTwrGucgKDQZe9t9Koek6Fq','F8gPZ2232iSZbFRc8D4pGn7r6c.png','2025-07-23 09:19:46',1),('805961165@qq.com','TEALcy3vK3gumFazyKJJ1m9d2Vbtuz','H4ZihoDxaqyWt5PJxfkGcsALmXOxEJ','3NYPB4XIHPmX50sC75wU86wYXm.png','2025-07-23 09:19:59',1),('805961165@qq.com','yc2QhYgJafKnSEMJDMv7TB4NJZfdlp','CIRdevup0fusv3LWmBRJFmTPHP7Zqc','2zktyxatbxJB7w17dNTvUCnSVy.png','2025-07-23 09:20:19',1),('Jeff@yifuinc.com','deGwOUCZvs9e509OUVtuemJAXxwzMs','4QosbaSvmYJrINSD27VoSbhEFFn8hO','CAMW62W1hQIGWHU0stt5tLCeTl.png','2025-07-23 15:19:34',1),('Jeff@yifuinc.com','IMQ7eX8tcaiMdFpWVMWhOBwVDij7yr','JL2bTWIP3q2WbGpin9w4dSHEo2cdqy','J4ICW76KmuISPuO80sU0ghqpuY.png','2025-07-23 15:19:57',1);
/*!40000 ALTER TABLE `RLFGH` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RegistVerityCode`
--

DROP TABLE IF EXISTS `RegistVerityCode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RegistVerityCode` (
  `account` varchar(30) NOT NULL,
  `code` varchar(10) NOT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RegistVerityCode`
--

LOCK TABLES `RegistVerityCode` WRITE;
/*!40000 ALTER TABLE `RegistVerityCode` DISABLE KEYS */;
INSERT INTO `RegistVerityCode` VALUES ('2280084297@qq.com','10032','2025-07-20 13:23:30',1),('2280084297@qq.com','31207','2025-07-20 13:23:51',1),('2280084297@qq.com','68350','2025-07-20 13:26:08',1),('2280084297@qq.com','13473','2025-07-20 13:26:53',0),('2280084297@qq.com','80922','2025-07-20 13:29:40',1),('2280084297@qq.com','35624','2025-07-20 13:30:35',1),('2129007741@qq.com','49330','2025-07-20 13:42:29',1),('444254881@qq.com','31611','2025-07-20 14:18:51',1),('2826797374@qq.com','94870','2025-07-20 17:03:14',1),('2826797374@qq.com','90659','2025-07-20 17:23:10',1),('a848415502@2925.com','38660','2025-07-20 18:22:18',1),('a903017041@2925.com','01287','2025-07-20 18:23:21',1),('848415502@qq.com','47297','2025-07-20 18:49:07',0),('848415502@qq.com','68159','2025-07-20 18:51:08',0),('903017041@qq.com','82562','2025-07-20 18:51:22',1),('903017041@qq.com','44110','2025-07-20 18:52:24',1),('2826797372@qq.com','10480','2025-07-20 21:08:30',0),('2826797371@qq.com','93210','2025-07-20 21:23:13',0),('2280084297@qq.com','98654','2025-07-20 21:43:18',1),('abc@abc.com','74944','2025-07-20 22:14:34',0),('abcd@abc.com','03513','2025-07-20 22:15:03',0),('abcd@abc.com','86485','2025-07-20 22:16:26',0),('abc@abc.com','01607','2025-07-20 22:16:41',0),('abc@abc.com','62778','2025-07-20 22:17:42',0),('abcd@abc.com','75604','2025-07-20 22:17:55',0),('abcd@abc.com','42594','2025-07-20 22:20:42',0),('abcdw@abc.com','98553','2025-07-20 22:21:38',0),('2049983474@qq.com','52769','2025-07-21 02:02:32',0),('2049983474@qq.com','47989','2025-07-21 02:07:27',0),('2049983474@qq.com','11604','2025-07-21 02:08:31',1),('2280084297@qq.com','21657','2025-07-21 02:47:01',1),('123@456.com','39668','2025-07-21 03:20:39',1),('abc@abc.com','14827','2025-07-21 03:40:14',0),('abc@abc.com','25926','2025-07-21 03:45:25',0),('abc@abc.com','90781','2025-07-21 03:46:30',0),('abc@abc.com','51501','2025-07-21 03:47:31',0),('2049983474@qq.com','04793','2025-07-21 03:50:04',1),('2280084297@qq.com','31029','2025-07-21 16:45:31',0),('2280084297@qq.com','61095','2025-07-21 16:57:41',1),('3551245463@qq.com','60757','2025-07-21 20:17:40',0),('2049983474@qq.com','11117','2025-07-21 22:13:31',0),('2049983474@qq.com','76232','2025-07-21 22:14:36',1),('2049983474@qq.com','66575','2025-07-21 22:19:26',1),('2049983474@qq.com','28657','2025-07-21 23:48:48',0),('2049983474@qq.com','15175','2025-07-21 23:50:15',0),('2049983474@qq.com','14295','2025-07-21 23:51:54',1),('2129007741@qq.com','73754','2025-07-22 00:19:33',0),('2129007741@qq.com','99133','2025-07-22 00:23:19',1),('444254881@qq.com','10071','2025-07-22 08:53:30',1),('2826797371@qq.com','81712','2025-07-22 10:21:21',0),('2826797374@qq.com','09798','2025-07-22 10:21:49',1),('2826797374@qq.com','23155','2025-07-22 14:55:23',1),('test@example.com','47656','2025-07-22 15:02:27',0),('2826797374@qq.com','95542','2025-07-22 15:03:15',1),('fnnn@qabq.com','82816','2025-07-22 15:04:42',0),('2826797374@qq.com','47315','2025-07-22 15:07:27',1),('1446951932@qq.com','54446','2025-07-22 15:14:14',1),('4r40erfml5@mkzaso.com','10073','2025-07-22 19:16:50',1),('1446951932@qq.com','58651','2025-07-22 21:17:38',1),('2049983474@qq.com','20190','2025-07-23 00:17:00',1),('2826797374@qq.com','25478','2025-07-23 10:38:45',1),('2049983474@qq.com','13358','2025-07-23 15:48:33',1),('2049983474@qq.com','70613','2025-07-23 16:44:30',1),('805961165@qq.com','74394','2025-07-23 17:16:14',1),('moduleholo@gmail.com','14403','2025-07-23 17:38:34',0),('2022309589@qq.com','34345','2025-07-23 17:47:14',1),('805500871@qq.com','96223','2025-07-23 17:48:16',1),('3500562056@qq.com','07686','2025-07-23 17:48:27',1),('3500562056@qq.com','22957','2025-07-23 17:50:22',1),('3500562056@qq.com','87831','2025-07-23 17:51:27',1),('431776604@qq.com','35341','2025-07-23 17:52:15',1),('moduleholo@gmail.com','13021','2025-07-23 18:11:53',1),('moduleholo@gmail.com','94734','2025-07-23 18:13:14',1),('3822150646@qq.com','23913','2025-07-23 18:15:23',1),('3822150646@qq.com','94130','2025-07-23 18:16:34',1),('Jeff@yifuinc.com','92707','2025-07-23 23:11:32',1),('Jeff@yifuinc.com','72998','2025-07-23 23:12:52',1),('Jeff@yifuinc.com','81662','2025-07-23 23:16:21',1),('1026453794@qq.com','28749','2025-07-24 00:38:48',0),('1470909699@qq.com','40093','2025-07-24 08:35:40',0);
/*!40000 ALTER TABLE `RegistVerityCode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WST`
--

DROP TABLE IF EXISTS `WST`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `WST` (
  `account` varchar(30) NOT NULL,
  `description` varchar(30) NOT NULL,
  `generate` varchar(30) DEFAULT NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint(1) DEFAULT '0',
  KEY `account` (`account`),
  CONSTRAINT `WST_ibfk_1` FOREIGN KEY (`account`) REFERENCES `users` (`email`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WST`
--

LOCK TABLES `WST` WRITE;
/*!40000 ALTER TABLE `WST` DISABLE KEYS */;
INSERT INTO `WST` VALUES ('4r40erfml5@mkzaso.com','etXoodmX1Z0fVPun1CXuhCk508luIA','IBRJ0Xnh0fWdKHuXwQ7C0yrPoJ.png','2025-07-22 12:27:05',1),('4r40erfml5@mkzaso.com','yYz8ttZdntxN4sW19ylxNkaBf9SwuM','wGlOjb4LWj3SW3yZB60ILteW0f.png','2025-07-22 12:32:26',1),('1446951932@qq.com','vSK5hmnsT8ozsMHiZlY8sQV7v3iN9W','oo1aQJromeKHq0yhsHSd6fBneK.png','2025-07-22 13:18:33',1),('4r40erfml5@mkzaso.com','Sw1JissNRzE92di75nFewshz0dOvOh','CPwMxA0H4lWNvnLv1y0o7ikDrc.png','2025-07-22 14:36:54',1),('444254881@qq.com','aqwBS2rFeTLtG5N0Pslks5uYYCb7VL','3P7aDrjLdstLHaSlE0zkyM2GCZ.png','2025-07-23 04:59:08',1),('2826797374@qq.com','JWEsWBN292PZssi5etyWFCAYuy0tFs','gMgrUnUnJMOQG1uRtF33EOcPBj.png','2025-07-23 07:17:01',1),('2049983474@qq.com','wIuxMniTuhekTfHQMqt86c9mnXzNYE','lRpFKNVaB6q0Vev6YMkR6TFuNg.png','2025-07-23 08:45:35',1),('2049983474@qq.com','O39oosMv2ecQtgmV0OmbOVfumKzbOX','l2QwhMAZraBwAwHSFCztUKtOl4.png','2025-07-23 08:50:54',1),('2826797374@qq.com','BOfkbpkdSwwBtXrqxtUSmYaKnhgjiU','0VUvNy5YYoifydvKtYiM9SFjXN.png','2025-07-23 09:08:12',1),('1446951932@qq.com','gbuSQ6q2MFjFwcxHtnWGRXsU83ZJiz','bh3GtZV6O1uGHqbY8JaSvmrKk3.png','2025-07-23 09:08:30',1),('1446951932@qq.com','qO8HdAYh4lhVTQvXJA9tf893jqRMdL','7ERf5nwNWEPWxruDr468fj58ob.png','2025-07-23 09:08:43',1),('1446951932@qq.com','W9FvmZwx3Jz9Gx1GfLSTUrmnrDfn4X','86vzqhADb9D1wPB6XGIyA8CmZc.png','2025-07-23 09:09:43',1),('2826797374@qq.com','ZRwoTAtRuRMaOQgbwPgljQqaJZNZlg','LiUpp3Pe8YH2kZfImpATJziY1P.png','2025-07-23 09:26:56',0),('2049983474@qq.com','Ej9FrgPV8OvfpxXj7I8Jx4f85magxv','0Zk2VbpVIcGPM521Lglp9HJ4By.png','2025-07-23 09:28:54',1),('431776604@qq.com','gosjXuviUXeKdHAbserU2CDaSgCTPq','CViyXXnne8JCTWbZA3Wyekt58r.png','2025-07-23 10:04:10',1),('431776604@qq.com','Dbz68EmFBer305tQlzlwDJuMcgXrwQ','B2CRCA4YmrwbNsNYQMUQsYyRSz.png','2025-07-23 10:04:14',1),('2049983474@qq.com','SFf5j7ln0naAEBXwoKRtZZ6n0sdp2M','xpKOtdfVgpFEAVYCc9kGYnufi3.png','2025-07-24 01:14:56',1),('2022309589@qq.com','Qgz3o860LPQrZqaTyZRxqimbac4sx9','pL0ZaH77mdRrPj5CY5EleJvdCp.png','2025-07-24 06:00:22',0),('2022309589@qq.com','Pw6KwyUq7wMjk7VB6tGWktApFQsRDf','N3a4n0NGB52sUTgQBaUQcPIk1Q.png','2025-07-24 06:00:24',0);
/*!40000 ALTER TABLE `WST` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `XNCY`
--

DROP TABLE IF EXISTS `XNCY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `XNCY` (
  `account` varchar(30) NOT NULL,
  `person` varchar(40) NOT NULL,
  `clothes` varchar(40) NOT NULL,
  `generate` varchar(40) DEFAULT NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint(1) DEFAULT '0',
  KEY `account` (`account`),
  CONSTRAINT `XNCY_ibfk_1` FOREIGN KEY (`account`) REFERENCES `users` (`email`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `XNCY`
--

LOCK TABLES `XNCY` WRITE;
/*!40000 ALTER TABLE `XNCY` DISABLE KEYS */;
INSERT INTO `XNCY` VALUES ('4r40erfml5@mkzaso.com','QBuc4pajwKy1o9f6ypztMMkqkh8xLT','9LTlMC91aRBymGpJBfMq2MD1wR7jnA','SOmnnWH1hRqJux3KP5Y8Y2KtDF.png','2025-07-22 11:17:46',1),('4r40erfml5@mkzaso.com','0eq2V3VdV2TdnSKTRMtKRIceSIPvNo','FKKRKKLatVaV7ZPFAQxnmytMA497M8','BFrjmsBGLWxSxWuMlYXqxkM1zK.png','2025-07-22 11:29:08',0),('4r40erfml5@mkzaso.com','KUCTcX1alvF76rEPGVjfHF0ynTxFci','zBQBve5zgld9MFpSeOl7gYd9J3A9OC','Sjr7ooGkb225VznoBLPUZm5i5T.png','2025-07-22 11:32:16',1),('4r40erfml5@mkzaso.com','fOkuTZsO5XIaCm9HYLgpi3SZKARJuD','e61eWLOmwutkboax7JiEWYPH57OJj4','TF3VzyM9hAQufYzqX4iv8fDEf6.png','2025-07-22 12:26:36',1),('2049983474@qq.com','YPa1fb30rVrgtBM1TZCIl58F86CseN','PMXENx759iiU8yJdHMTW74mCw4eWkt','kCFunv6BusoliZxIaNUmgRQnzA.png','2025-07-23 08:44:58',1),('2049983474@qq.com','pIUb0OPyEPZJZzu5mpqWQNRytZOk3A','Hxn4j9fiUbEgegJmpse5WqIiNKrTMz','OmACz1q9OnKoBDndeatNQhWqpd.png','2025-07-23 08:51:05',1),('1446951932@qq.com','etL0kyYRjbI7BB0xQUpqyr9c7n8JXa','ZkVBRWmubTR8R49tG31zcs8aB7g5tb','RKkXp8HJB3uJVz0KGNJ1gQ4bHX.png','2025-07-23 09:07:04',1),('2826797374@qq.com','Z9gbfHZmsCyiPGOStMcOk8HfFFj8XA','QJdOA9xu7GuEhRyILFpJG6DdeZvS2Z','Y8LEuPPQjzJrVa96M6NnJJ00j6.png','2025-07-23 09:08:08',1),('2049983474@qq.com','OIuUA0nwqvq7q7zvc6av37mZy6gQRK','aTxNhGn2QGsuI1K7k1H6CS9itLMB53','0gq9AdsjQjhB16TUoe7SOh4VPS.png','2025-07-23 09:29:13',1),('2049983474@qq.com','9xouPtmH7KrjkBWEStCryciXR9A66Z','VDbyJl0s19WqRFrhRF4wu1p5PyjbgM','M3QL0l66Wwl2VI9TP7EbnPI3iU.png','2025-07-23 10:05:40',1);
/*!40000 ALTER TABLE `XNCY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `email` varchar(30) NOT NULL,
  `userID` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `vip` int DEFAULT '0',
  `avatar` varchar(30) NOT NULL DEFAULT 'Default/default_avatar.png',
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('1446951932@qq.com','彭于晏','123456','2025-07-22 13:17:51',1,'OiU0xt89nkvNBs96Q5kdcSBIIj41DO'),('2022309589@qq.com','王力宏','123456','2025-07-23 09:47:28',0,'Default/default_avatar.png'),('2049983474@qq.com','mmzz','123456','2025-07-23 08:44:37',1,'Default/default_avatar.png'),('2129007741@qq.com','666','666666','2025-07-21 16:23:36',0,'Default/default_avatar.png'),('2826797374@qq.com','用户','123456','2025-07-23 02:38:55',0,'Default/default_avatar.png'),('3500562056@qq.com','ljh','hjl20050407','2025-07-23 09:51:52',0,'Default/default_avatar.png'),('3822150646@qq.com','qq','123456','2025-07-23 10:16:48',0,'Default/default_avatar.png'),('431776604@qq.com','wbx','wbxwbx','2025-07-23 09:52:30',1,'Default/default_avatar.png'),('444254881@qq.com','杨刚','12345678','2025-07-22 00:54:11',1,'Default/default_avatar.png'),('4r40erfml5@mkzaso.com','lhw','123456','2025-07-22 11:17:17',1,'Default/default_avatar.png'),('805500871@qq.com','王力宏','13534268817','2025-07-23 09:48:33',0,'Default/default_avatar.png'),('805961165@qq.com','HeeJvl_','Hjy20050613','2025-07-23 09:17:05',0,'Default/default_avatar.png'),('Jeff@yifuinc.com','Jeffgan ','linjingru199225','2025-07-23 15:16:41',0,'Default/default_avatar.png');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `delete_vip_when_vip_disabled` AFTER UPDATE ON `users` FOR EACH ROW BEGIN
    -- 仅当vip字段从非0变为0时执行删除操作
    IF OLD.vip != 0 AND NEW.vip = 0 THEN
        DELETE FROM vip
        WHERE account = NEW.email; -- 删除vip表中account与用户email匹配的记录
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `vip`
--

DROP TABLE IF EXISTS `vip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vip` (
  `account` varchar(30) NOT NULL,
  `start_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `end_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`account`),
  CONSTRAINT `vip_ibfk_1` FOREIGN KEY (`account`) REFERENCES `users` (`email`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vip`
--

LOCK TABLES `vip` WRITE;
/*!40000 ALTER TABLE `vip` DISABLE KEYS */;
INSERT INTO `vip` VALUES ('1446951932@qq.com','2025-07-22 22:50:09','2026-07-22 22:50:09'),('2049983474@qq.com','2025-07-23 16:52:18','2026-07-23 16:52:18'),('431776604@qq.com','2025-07-23 18:03:17','2026-07-23 18:03:17'),('444254881@qq.com','2025-07-22 08:55:53','2026-07-22 08:55:53'),('4r40erfml5@mkzaso.com','2025-07-22 19:17:55','2026-07-22 19:17:55');
/*!40000 ALTER TABLE `vip` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-25 13:43:45
