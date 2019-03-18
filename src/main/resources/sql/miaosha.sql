-- MySQL dump 10.13  Distrib 8.0.15, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: miaosha
-- ------------------------------------------------------
-- Server version	8.0.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `goods`
--

DROP TABLE IF EXISTS `goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `goods` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '商品ID',
  `goods_name` varchar(16) DEFAULT NULL COMMENT '商品名称',
  `goods_title` varchar(64) DEFAULT NULL COMMENT '商品标题',
  `goods_img` varchar(64) DEFAULT NULL COMMENT '商品图片',
  `goods_detail` longtext COMMENT '商品详情介绍',
  `goods_price` decimal(10,2) DEFAULT '0.00' COMMENT '商品单价',
  `goods_stock` int(11) DEFAULT '0' COMMENT '商品库存',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods`
--

LOCK TABLES `goods` WRITE;
/*!40000 ALTER TABLE `goods` DISABLE KEYS */;
INSERT INTO `goods` (`id`, `goods_name`, `goods_title`, `goods_img`, `goods_detail`, `goods_price`, `goods_stock`) VALUES (1,'iPhoneX','Apple iPhoneX','/img/iphonex.png','Apple iPhoneX',8765.00,100),(2,'华为Meta9','华为Meta9','/img/meta10.png','华为Meta9',3212.00,100);
/*!40000 ALTER TABLE `goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `miaosha_goods`
--

DROP TABLE IF EXISTS `miaosha_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `miaosha_goods` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `goods_id` bigint(20) DEFAULT NULL COMMENT '商品ID',
  `miaosha_price` decimal(10,2) DEFAULT NULL COMMENT '秒杀价',
  `stock_count` int(11) DEFAULT NULL COMMENT '库存量',
  `start_date` datetime DEFAULT NULL COMMENT '秒杀开始时间',
  `end_date` datetime DEFAULT NULL COMMENT '秒杀结束时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `miaosha_goods`
--

LOCK TABLES `miaosha_goods` WRITE;
/*!40000 ALTER TABLE `miaosha_goods` DISABLE KEYS */;
INSERT INTO `miaosha_goods` (`id`, `goods_id`, `miaosha_price`, `stock_count`, `start_date`, `end_date`) VALUES (1,1,0.01,0,'2019-03-18 00:58:05','2019-03-18 21:58:05'),(2,2,0.01,10,'2019-03-18 06:58:09','2019-03-18 06:58:10');
/*!40000 ALTER TABLE `miaosha_goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `miaosha_order`
--

DROP TABLE IF EXISTS `miaosha_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `miaosha_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  `goods_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `miaosha_order_user_id_goods_id_uindex` (`user_id`,`goods_id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `miaosha_order`
--

LOCK TABLES `miaosha_order` WRITE;
/*!40000 ALTER TABLE `miaosha_order` DISABLE KEYS */;
INSERT INTO `miaosha_order` (`id`, `user_id`, `order_id`, `goods_id`) VALUES (84,10000000003,84,1),(85,10000000001,85,1),(86,10000000002,86,1),(87,10000000004,87,1),(88,10000000005,88,1),(89,10000000006,89,1),(90,10000000007,90,1),(91,10000000008,91,1),(92,10000000009,92,1),(93,10000000010,93,1);
/*!40000 ALTER TABLE `miaosha_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `miaosha_user`
--

DROP TABLE IF EXISTS `miaosha_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `miaosha_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID，手机号码',
  `nickname` varchar(255) DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL COMMENT 'MD5(MD5(pass明文+固定salt)+salt)',
  `salt` varchar(10) DEFAULT NULL,
  `head` varchar(128) DEFAULT NULL COMMENT '头像，云存储ID',
  `register_date` datetime DEFAULT NULL,
  `last_login_date` datetime DEFAULT NULL,
  `login_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18912341235 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `miaosha_user`
--

LOCK TABLES `miaosha_user` WRITE;
/*!40000 ALTER TABLE `miaosha_user` DISABLE KEYS */;
INSERT INTO `miaosha_user` (`id`, `nickname`, `password`, `salt`, `head`, `register_date`, `last_login_date`, `login_count`) VALUES (10000000001,'Joshua','b7797cce01b4b131b433b6acf4add449','1a2b3c4d','','2019-03-16 13:21:04','2019-03-16 13:20:59',1),(10000000002,'Joshua','b7797cce01b4b131b433b6acf4add449','1a2b3c4d','','2019-03-16 13:21:04','2019-03-16 13:20:59',1),(10000000003,'Joshua','b7797cce01b4b131b433b6acf4add449','1a2b3c4d','','2019-03-16 13:21:04','2019-03-16 13:20:59',1),(10000000004,'Joshua','b7797cce01b4b131b433b6acf4add449','1a2b3c4d','','2019-03-16 13:21:04','2019-03-16 13:20:59',1),(10000000005,'Joshua','b7797cce01b4b131b433b6acf4add449','1a2b3c4d','','2019-03-16 13:21:04','2019-03-16 13:20:59',1),(10000000006,'Joshua','b7797cce01b4b131b433b6acf4add449','1a2b3c4d','','2019-03-16 13:21:04','2019-03-16 13:20:59',1),(10000000007,'Joshua','b7797cce01b4b131b433b6acf4add449','1a2b3c4d','','2019-03-16 13:21:04','2019-03-16 13:20:59',1),(10000000008,'Joshua','b7797cce01b4b131b433b6acf4add449','1a2b3c4d','','2019-03-16 13:21:04','2019-03-16 13:20:59',1),(10000000009,'Joshua','b7797cce01b4b131b433b6acf4add449','1a2b3c4d','','2019-03-16 13:21:04','2019-03-16 13:20:59',1),(10000000010,'Joshua','b7797cce01b4b131b433b6acf4add449','1a2b3c4d','','2019-03-16 13:21:04','2019-03-16 13:20:59',1);
/*!40000 ALTER TABLE `miaosha_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_info`
--

DROP TABLE IF EXISTS `order_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `order_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `goods_id` bigint(20) DEFAULT NULL,
  `delivery_addr_id` bigint(20) DEFAULT NULL,
  `goods_name` varchar(16) DEFAULT NULL,
  `goods_count` int(11) DEFAULT NULL,
  `goods_price` decimal(10,2) DEFAULT NULL,
  `order_channel` tinyint(4) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `pay_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_info`
--

LOCK TABLES `order_info` WRITE;
/*!40000 ALTER TABLE `order_info` DISABLE KEYS */;
INSERT INTO `order_info` (`id`, `user_id`, `goods_id`, `delivery_addr_id`, `goods_name`, `goods_count`, `goods_price`, `order_channel`, `status`, `create_date`, `pay_date`) VALUES (3,10000000001,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:48:27',NULL),(10,10000000005,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:49:38',NULL),(11,10000000004,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:49:38',NULL),(12,10000000002,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:49:38',NULL),(13,10000000008,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:49:38',NULL),(14,10000000010,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:49:38',NULL),(15,10000000001,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:49:38',NULL),(16,10000000003,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:49:38',NULL),(17,10000000006,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:49:38',NULL),(24,10000000009,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:49:38',NULL),(26,10000000007,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:49:38',NULL),(33,10000000001,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:51:12',NULL),(34,10000000002,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:51:12',NULL),(35,10000000003,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:51:12',NULL),(36,10000000004,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:51:12',NULL),(37,10000000005,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:51:12',NULL),(38,10000000006,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:51:12',NULL),(39,10000000007,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:51:12',NULL),(40,10000000008,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:51:12',NULL),(41,10000000009,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:51:12',NULL),(42,10000000010,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:51:12',NULL),(43,10000000001,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:55:28',NULL),(44,10000000007,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:55:29',NULL),(45,10000000005,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:55:29',NULL),(46,10000000003,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:55:30',NULL),(47,10000000004,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:55:30',NULL),(48,10000000002,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:56:10',NULL),(49,10000000006,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:56:10',NULL),(50,10000000010,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:56:12',NULL),(51,10000000009,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:56:12',NULL),(53,10000000008,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:56:12',NULL),(55,10000000001,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:57:55',NULL),(56,10000000002,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:57:55',NULL),(57,10000000003,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:57:55',NULL),(58,10000000004,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:57:55',NULL),(59,10000000005,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:57:55',NULL),(60,10000000007,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:57:55',NULL),(61,10000000006,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:57:55',NULL),(62,10000000008,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:57:55',NULL),(63,10000000009,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:57:55',NULL),(64,10000000010,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:57:55',NULL),(70,10000000001,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:59:50',NULL),(71,10000000002,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:59:50',NULL),(72,10000000003,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:59:50',NULL),(73,10000000004,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:59:50',NULL),(74,10000000005,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:59:50',NULL),(75,10000000006,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:59:50',NULL),(76,10000000007,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:59:50',NULL),(77,10000000008,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:59:50',NULL),(78,10000000009,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:59:50',NULL),(79,10000000010,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 21:59:50',NULL),(84,10000000003,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 22:03:15',NULL),(85,10000000001,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 22:03:15',NULL),(86,10000000002,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 22:03:15',NULL),(87,10000000004,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 22:03:15',NULL),(88,10000000005,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 22:03:15',NULL),(89,10000000006,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 22:03:15',NULL),(90,10000000007,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 22:03:15',NULL),(91,10000000008,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 22:03:15',NULL),(92,10000000009,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 22:03:15',NULL),(93,10000000010,1,NULL,'iPhoneX',1,0.01,1,0,'2019-03-18 22:03:15',NULL);
/*!40000 ALTER TABLE `order_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`, `name`) VALUES (2,'2');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-03-18 22:13:41
