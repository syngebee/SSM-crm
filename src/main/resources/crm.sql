/*
SQLyog Ultimate v12.14 (64 bit)
MySQL - 5.6.22-log : Database - crm
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`crm` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `crm`;

/*Table structure for table `tbl_activity` */

DROP TABLE IF EXISTS `tbl_activity`;

CREATE TABLE `tbl_activity` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `startDate` char(10) DEFAULT NULL,
  `endDate` char(10) DEFAULT NULL,
  `cost` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `owner` (`owner`),
  CONSTRAINT `tbl_activity_ibfk_1` FOREIGN KEY (`owner`) REFERENCES `tbl_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_activity` */

insert  into `tbl_activity`(`id`,`owner`,`name`,`startDate`,`endDate`,`cost`,`description`,`createTime`,`createBy`,`editTime`,`editBy`) values 
('03191258deb941059d525c1846049c45','40f6cdea0bd34aceb77492a1656d9fb3','3333','2008-10-10','2020-08-18','400000','111111','2020-08-17 23:41:26','张三',NULL,NULL),
('1a3ea7cfec534e10a51996455cee958e','06f5fc056eac41558a964f96daa7f27c','3333','2020-08-28','2020-08-23','250000','250000','2020-08-18 07:49:14','张三',NULL,NULL),
('3ec626c00d964441a694f98c77c6c6ec','40f6cdea0bd34aceb77492a1656d9fb3','123123','2008-10-10','2020-08-18','30000','SAMCHEN','2020-08-17 23:36:19','张三',NULL,NULL),
('43565c8cec714950842c1a276b3417b7','40f6cdea0bd34aceb77492a1656d9fb3','3333','2008-10-10','2020-08-18','400000','1231231','2020-08-17 23:39:42','张三',NULL,NULL),
('553b6aee0cea48e2b6eea1339f12d443','40f6cdea0bd34aceb77492a1656d9fb3','3333','1899-12-19','2020-08-26','44444','123','2020-08-18 17:39:22','张三',NULL,NULL),
('5558ed69ce984b75838d0201de33acd8','40f6cdea0bd34aceb77492a1656d9fb3','哈哈哈1','2020-08-25','2020-12-31','500000','3212','2020-08-22 13:25:55','张三','2020-08-27 22:06:58','张三'),
('555b22fb3dc24889b2c210ed9cbb4c2e','40f6cdea0bd34aceb77492a1656d9fb3','3333','2008-10-10','2020-08-18','400000','33333','2020-08-17 23:41:22','张三',NULL,NULL),
('6c3eb79e69c8497993a0f2a563a9835b','40f6cdea0bd34aceb77492a1656d9fb3','发传单1','2008-10-10','2020-08-18','500000','3333','2020-08-18 17:44:05','张三',NULL,NULL),
('77f3909cba0949978bb2b05544aeaad4','40f6cdea0bd34aceb77492a1656d9fb3','发传单2','2008-10-10','2020-08-18','30000','SAMCHEN','2020-08-17 23:36:31','张三',NULL,NULL),
('869063c3ca70428e893ebc27c88ba4d9','40f6cdea0bd34aceb77492a1656d9fb3','发传单3','2008-10-10','2020-08-28','44444','55555','2020-08-17 23:42:36','张三',NULL,NULL),
('9968811b40fe401c8ff17160aa5d9811','40f6cdea0bd34aceb77492a1656d9fb3','发传单4','2008-10-10','2020-08-18','1231','111','2020-08-18 17:45:07','张三','2020-08-19 13:48:23','张三'),
('9bec62388e88440ba5f6075e1e5deedf','40f6cdea0bd34aceb77492a1656d9fb3','发传单5','2008-10-10','2020-08-18','30000','124214','2020-08-19 13:50:57','张三',NULL,NULL),
('b146154298734a8499f5d4c33f3c27d4','40f6cdea0bd34aceb77492a1656d9fb3','12312','2008-10-10','1899-12-31','3333','123','2020-08-18 15:02:18','张三',NULL,NULL),
('c3cce055beb745cdab5eb36326050a2e','40f6cdea0bd34aceb77492a1656d9fb3','cyyyy','2008-10-10','2020-08-26','4444','111111','2020-08-18 18:56:33','张三',NULL,NULL),
('e5dd8089f04f41a6800369e3ad4ee230','40f6cdea0bd34aceb77492a1656d9fb3','123123','2008-10-10','2020-08-18','33333333','1','2020-08-18 17:48:46','张三',NULL,NULL),
('f097787bc9de436fb1415dee19462ecb','40f6cdea0bd34aceb77492a1656d9fb3','12312','2008-10-10','1899-12-31','3333','11111','2020-08-18 15:02:05','张三',NULL,NULL);

/*Table structure for table `tbl_activity_remark` */

DROP TABLE IF EXISTS `tbl_activity_remark`;

CREATE TABLE `tbl_activity_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL COMMENT '0表示未修改，1表示已修改',
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `remark_activity` (`activityId`),
  CONSTRAINT `remark_activity` FOREIGN KEY (`activityId`) REFERENCES `tbl_activity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_activity_remark` */

insert  into `tbl_activity_remark`(`id`,`noteContent`,`createTime`,`createBy`,`editTime`,`editBy`,`editFlag`,`activityId`) values 
('1bb8a99ac61045e197ff95f021017d18','123123','2020-08-27 22:00:57','张三',NULL,NULL,'0','5558ed69ce984b75838d0201de33acd8'),
('1fad1f52ed0d4e0cb3750663fcd9c2f0','123123','2020-08-22 13:26:31','张三',NULL,NULL,'0','c3cce055beb745cdab5eb36326050a2e'),
('2b7bacf2d6984f06a94a3f4f9823b07f','3321123','2020-08-22 13:24:30','张三',NULL,NULL,'0','869063c3ca70428e893ebc27c88ba4d9'),
('3427f7726e584db3be301e30951ae6a7','123','2020-08-19 22:25:16','张三',NULL,NULL,'0','9bec62388e88440ba5f6075e1e5deedf'),
('453b4d2eb00a4477aaf5b118f0a03e79','321','2020-08-30 09:47:19','张三','2020-08-30 09:47:34','张三','1','553b6aee0cea48e2b6eea1339f12d443'),
('7712aeccd4674a538f7f54be84ad99be','333','2020-08-19 22:25:13','张三','2020-08-22 22:25:18',NULL,'1','9bec62388e88440ba5f6075e1e5deedf'),
('778ee259568141e2981074fdf97779a0','444','2020-08-19 22:25:18','张三',NULL,NULL,'0','9bec62388e88440ba5f6075e1e5deedf'),
('87ea9c18f1f44886a53f967209141768','13','2020-08-24 15:17:49','张三',NULL,NULL,'0','9bec62388e88440ba5f6075e1e5deedf'),
('9c1bc115fcbf4b21bbadeb8b7a97a24c','10','2020-08-25 22:55:32','张三',NULL,NULL,'0','e5dd8089f04f41a6800369e3ad4ee230'),
('9e73f8b75aa34393917a115d4e4f2305','123','2020-08-26 08:51:12','张三',NULL,NULL,'0','5558ed69ce984b75838d0201de33acd8'),
('a8b363a67b7349b09f521392784a178c','修改数据','2020-08-22 13:24:23','张三','2020-08-22 13:24:47','张三','1','869063c3ca70428e893ebc27c88ba4d9'),
('asfasfasfasfasfasfafasfafasfafaf','abv',NULL,NULL,NULL,NULL,NULL,NULL),
('b33dde288aab476da9a7de4d68606a05','1321312','2020-08-25 22:55:26','张三',NULL,NULL,'0','e5dd8089f04f41a6800369e3ad4ee230'),
('b3ef31d1d5aa4e62abe0282a92c7e838','333','2020-08-30 09:47:21','张三','2020-08-30 09:47:30','张三','1','553b6aee0cea48e2b6eea1339f12d443'),
('b7edbc4df47b437ea0d386315dc3abef','311','2020-08-22 13:26:28','张三',NULL,NULL,'0','c3cce055beb745cdab5eb36326050a2e'),
('c0af795c09a048ed907f6b4a24ceaf74','22','2020-08-24 16:35:41','张三',NULL,NULL,'0','5558ed69ce984b75838d0201de33acd8'),
('cf8d7c1a31ee4490994ca9358a12629b','1232321','2020-08-22 13:24:17','张三',NULL,NULL,'0','869063c3ca70428e893ebc27c88ba4d9'),
('d3b5847e1f1b4477a119b517875c7ed2','23','2020-08-22 13:26:33','张三',NULL,NULL,'0','c3cce055beb745cdab5eb36326050a2e'),
('da79599da51b4a1d80052e26e02abb67','111','2020-08-25 22:55:31','张三','2020-08-25 22:55:45','张三','1','e5dd8089f04f41a6800369e3ad4ee230');

/*Table structure for table `tbl_clue` */

DROP TABLE IF EXISTS `tbl_clue`;

CREATE TABLE `tbl_clue` (
  `id` char(32) NOT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `appellation` varchar(255) DEFAULT NULL,
  `owner` char(32) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `mphone` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_clue` */

insert  into `tbl_clue`(`id`,`fullname`,`appellation`,`owner`,`company`,`job`,`email`,`phone`,`website`,`mphone`,`state`,`source`,`createBy`,`createTime`,`editBy`,`editTime`,`description`,`contactSummary`,`nextContactTime`,`address`) values 
('48386f10257548d68074719d291b715e','ycC','先生','40f6cdea0bd34aceb77492a1656d9fb3','昆仑亿发','444444','123@123.com','13916427105','昆仑亿发','13916427105','试图联系','推销电话','张三','2020-08-22 17:14:27',NULL,NULL,'12312312','123123','2020-08-19','上海浦东'),
('5b4622b7afad4041962a7c466126867f','ccc','先生','40f6cdea0bd34aceb77492a1656d9fb3','黑马','coder','123@123.com','13916427105','昆仑亿发','13916427105','试图联系','员工介绍','张三','2020-08-27 18:57:40',NULL,NULL,'12312312','14212412','2020-08-23','上海浦东'),
('9c13f9351c304bd4a9977393a8e2e566','yc C','先生','40f6cdea0bd34aceb77492a1656d9fb3','昆仑亿发','','','13916427105','','','','','张三','2020-08-29 21:53:02',NULL,NULL,'','','',''),
('e2c49f0840fb471ea12b91f629ac66f3','ycC','先生','40f6cdea0bd34aceb77492a1656d9fb3','亿发','','','13916427105','','','','','张三','2020-08-27 19:38:48',NULL,NULL,'','','','');

/*Table structure for table `tbl_clue_activity_relation` */

DROP TABLE IF EXISTS `tbl_clue_activity_relation`;

CREATE TABLE `tbl_clue_activity_relation` (
  `id` char(32) NOT NULL,
  `clueId` char(32) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clueId` (`clueId`),
  KEY `activityId` (`activityId`),
  CONSTRAINT `tbl_clue_activity_relation_ibfk_1` FOREIGN KEY (`clueId`) REFERENCES `tbl_clue` (`id`),
  CONSTRAINT `tbl_clue_activity_relation_ibfk_2` FOREIGN KEY (`activityId`) REFERENCES `tbl_activity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_clue_activity_relation` */

insert  into `tbl_clue_activity_relation`(`id`,`clueId`,`activityId`) values 
('2b7bacf2d6984f06a94a3f4f9823b07d','48386f10257548d68074719d291b715e','9bec62388e88440ba5f6075e1e5deedf'),
('8126266d3b444d7c8f0b19b7b3dc2de7','48386f10257548d68074719d291b715e','9968811b40fe401c8ff17160aa5d9811');

/*Table structure for table `tbl_clue_remark` */

DROP TABLE IF EXISTS `tbl_clue_remark`;

CREATE TABLE `tbl_clue_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `clueId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clueId` (`clueId`),
  CONSTRAINT `tbl_clue_remark_ibfk_1` FOREIGN KEY (`clueId`) REFERENCES `tbl_clue` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_clue_remark` */

insert  into `tbl_clue_remark`(`id`,`noteContent`,`createBy`,`createTime`,`editBy`,`editTime`,`editFlag`,`clueId`) values 
('6dcf079a01b74a448d17dc762c66dead','备注4',NULL,NULL,NULL,NULL,NULL,'48386f10257548d68074719d291b715e');

/*Table structure for table `tbl_contacts` */

DROP TABLE IF EXISTS `tbl_contacts`;

CREATE TABLE `tbl_contacts` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `customerId` char(32) DEFAULT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `appellation` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mphone` varchar(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `birth` char(10) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_contacts` */

insert  into `tbl_contacts`(`id`,`owner`,`source`,`customerId`,`fullname`,`appellation`,`email`,`mphone`,`job`,`birth`,`createBy`,`createTime`,`editBy`,`editTime`,`description`,`contactSummary`,`nextContactTime`,`address`) values 
('85f39349e5a547e181e385c108612771','40f6cdea0bd34aceb77492a1656d9fb3','员工介绍','40e962f600474b8fb42b33d87033f878','ccc','先生','123@123.com','13916427105','coder',NULL,'张三','2020-08-27 21:59:06',NULL,NULL,'12312312','14212412','2020-08-23','上海浦东'),
('af421744efa24be4b7b3a3d5700f5d69','40f6cdea0bd34aceb77492a1656d9fb3','员工介绍','0353cdc8ece7497a9d450eefaa5a5789','ccc','先生','123@123.com','13916427105','coder',NULL,'张三','2020-08-27 19:38:21',NULL,NULL,'12312312','14212412','2020-08-23','上海浦东'),
('c780c6d0827e4096acc66e8c69ade3e2','40f6cdea0bd34aceb77492a1656d9fb3','员工介绍','30d738954da247cbbda8f5ad971410d5','ccc','先生','123@123.com','13916427105','coder',NULL,'张三','2020-08-27 21:59:03',NULL,NULL,'12312312','14212412','2020-08-23','上海浦东'),
('d028a43ac33c4ac68fab432cf60dc18d','06f5fc056eac41558a964f96daa7f27c','合作伙伴研讨会','df371994ac414e98a6d95393445f52d4','马云','先生','995402495@qq.com','13916427105','ceo',NULL,'张三','2020-08-27 14:59:48',NULL,NULL,'线索线索线索线索线索线索线索线索线索','纪要纪要纪要纪要纪要纪要纪要纪要纪要纪要纪要纪要','2020-08-27','上海奉贤111'),
('d87143d524bd4f63aae5928dad8d44c6','40f6cdea0bd34aceb77492a1656d9fb3','员工介绍','8ebc871e732e4f4099bce5ae3cd9da8c','ccc','先生','123@123.com','13916427105','coder',NULL,'张三','2020-08-27 21:59:09',NULL,NULL,'12312312','14212412','2020-08-23','上海浦东');

/*Table structure for table `tbl_contacts_activity_relation` */

DROP TABLE IF EXISTS `tbl_contacts_activity_relation`;

CREATE TABLE `tbl_contacts_activity_relation` (
  `id` char(32) NOT NULL,
  `contactsId` char(32) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `contactsId` (`contactsId`),
  KEY `activityId` (`activityId`),
  CONSTRAINT `tbl_contacts_activity_relation_ibfk_1` FOREIGN KEY (`contactsId`) REFERENCES `tbl_contacts` (`id`),
  CONSTRAINT `tbl_contacts_activity_relation_ibfk_2` FOREIGN KEY (`activityId`) REFERENCES `tbl_activity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_contacts_activity_relation` */

insert  into `tbl_contacts_activity_relation`(`id`,`contactsId`,`activityId`) values 
('39ecb6402f924dd299a5f5c96aafd69c','d028a43ac33c4ac68fab432cf60dc18d','77f3909cba0949978bb2b05544aeaad4'),
('54a630bffd564b44982f45ce568924b9','d028a43ac33c4ac68fab432cf60dc18d','9968811b40fe401c8ff17160aa5d9811'),
('e56c1012a5d945e2bd6305bc64428ed7','d028a43ac33c4ac68fab432cf60dc18d','6c3eb79e69c8497993a0f2a563a9835b'),
('ea33d427a896424097bd7a6c4b147e1b','d028a43ac33c4ac68fab432cf60dc18d','869063c3ca70428e893ebc27c88ba4d9');

/*Table structure for table `tbl_contacts_remark` */

DROP TABLE IF EXISTS `tbl_contacts_remark`;

CREATE TABLE `tbl_contacts_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `contactsId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `contactsId` (`contactsId`),
  CONSTRAINT `tbl_contacts_remark_ibfk_1` FOREIGN KEY (`contactsId`) REFERENCES `tbl_contacts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_contacts_remark` */

/*Table structure for table `tbl_customer` */

DROP TABLE IF EXISTS `tbl_customer`;

CREATE TABLE `tbl_customer` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_customer` */

insert  into `tbl_customer`(`id`,`owner`,`name`,`website`,`phone`,`createBy`,`createTime`,`editBy`,`editTime`,`contactSummary`,`nextContactTime`,`description`,`address`) values 
('0353cdc8ece7497a9d450eefaa5a5789','40f6cdea0bd34aceb77492a1656d9fb3','黑马','昆仑亿发','13916427105','张三','2020-08-27 19:38:21',NULL,NULL,'14212412','2020-08-23','12312312','上海浦东'),
('30d738954da247cbbda8f5ad971410d5','40f6cdea0bd34aceb77492a1656d9fb3','嘿嘿嘿','昆仑亿发','13916427105','张三','2020-08-27 21:59:03',NULL,NULL,'14212412','2020-08-23','12312312','上海浦东'),
('40e962f600474b8fb42b33d87033f878','40f6cdea0bd34aceb77492a1656d9fb3','黑马3','昆仑亿发','13916427105','张三','2020-08-27 21:59:06',NULL,NULL,'14212412','2020-08-23','12312312','上海浦东'),
('4b4294d4a0474d1e9fb88c3691593d08','40f6cdea0bd34aceb77492a1656d9fb3','上海陈涛涛股份有限公司',NULL,NULL,'张三','2020-08-28 12:40:35',NULL,NULL,'你再来个Null?','2020-09-04','我就不信了',NULL),
('8ebc871e732e4f4099bce5ae3cd9da8c','40f6cdea0bd34aceb77492a1656d9fb3','黑马1','昆仑亿发','13916427105','张三','2020-08-27 21:59:09',NULL,NULL,'14212412','2020-08-23','12312312','上海浦东'),
('9ea5d33868b249568b9874259df2c48a','40f6cdea0bd34aceb77492a1656d9fb3','yc C',NULL,NULL,'张三','2020-08-29 21:04:50',NULL,NULL,'','','',NULL),
('df371994ac414e98a6d95393445f52d4','06f5fc056eac41558a964f96daa7f27c','阿里巴巴','www.baidu.com','58726384','张三','2020-08-27 14:59:48',NULL,NULL,'纪要纪要纪要纪要纪要纪要纪要纪要纪要纪要纪要纪要','2020-08-27','线索线索线索线索线索线索线索线索线索','上海奉贤111'),
('df371994ac414e98a6d95393445f52da','06f5fc056eac41558a964f96daa7f27c','阿里集团','www.baidu.com','58726384','张三','2020-08-27 14:59:48',NULL,NULL,NULL,NULL,NULL,NULL);

/*Table structure for table `tbl_customer_remark` */

DROP TABLE IF EXISTS `tbl_customer_remark`;

CREATE TABLE `tbl_customer_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `customerId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customerId` (`customerId`),
  CONSTRAINT `tbl_customer_remark_ibfk_1` FOREIGN KEY (`customerId`) REFERENCES `tbl_customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_customer_remark` */

/*Table structure for table `tbl_dic_type` */

DROP TABLE IF EXISTS `tbl_dic_type`;

CREATE TABLE `tbl_dic_type` (
  `code` varchar(255) NOT NULL COMMENT '编码是主键，不能为空，不能含有中文。',
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_dic_type` */

insert  into `tbl_dic_type`(`code`,`name`,`description`) values 
('appellation','称呼',''),
('clueState','线索状态',''),
('returnPriority','回访优先级',''),
('returnState','回访状态',''),
('source','来源',''),
('stage','阶段',''),
('transactionType','交易类型','');

/*Table structure for table `tbl_dic_value` */

DROP TABLE IF EXISTS `tbl_dic_value`;

CREATE TABLE `tbl_dic_value` (
  `id` char(32) NOT NULL COMMENT '主键，采用UUID',
  `value` varchar(255) DEFAULT NULL COMMENT '不能为空，并且要求同一个字典类型下字典值不能重复，具有唯一性。',
  `text` varchar(255) DEFAULT NULL COMMENT '可以为空',
  `orderNo` varchar(255) DEFAULT NULL COMMENT '可以为空，但不为空的时候，要求必须是正整数',
  `typeCode` varchar(255) DEFAULT NULL COMMENT '外键',
  PRIMARY KEY (`id`),
  KEY `typeCode` (`typeCode`),
  CONSTRAINT `tbl_dic_value_ibfk_1` FOREIGN KEY (`typeCode`) REFERENCES `tbl_dic_type` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_dic_value` */

insert  into `tbl_dic_value`(`id`,`value`,`text`,`orderNo`,`typeCode`) values 
('06e3cbdf10a44eca8511dddfc6896c55','虚假线索','虚假线索','4','clueState'),
('0fe33840c6d84bf78df55d49b169a894','销售邮件','销售邮件','8','source'),
('12302fd42bd349c1bb768b19600e6b20','交易会','交易会','11','source'),
('1615f0bb3e604552a86cde9a2ad45bea','最高','最高','2','returnPriority'),
('176039d2a90e4b1a81c5ab8707268636','教授','教授','5','appellation'),
('1e0bd307e6ee425599327447f8387285','将来联系','将来联系','2','clueState'),
('2173663b40b949ce928db92607b5fe57','丢失线索','丢失线索','5','clueState'),
('2876690b7e744333b7f1867102f91153','未启动','未启动','1','returnState'),
('29805c804dd94974b568cfc9017b2e4c','07成交','07成交','7','stage'),
('310e6a49bd8a4962b3f95a1d92eb76f4','试图联系','试图联系','1','clueState'),
('31539e7ed8c848fc913e1c2c93d76fd1','博士','博士','4','appellation'),
('37ef211719134b009e10b7108194cf46','01资质审查','01资质审查','1','stage'),
('391807b5324d4f16bd58c882750ee632','08丢失的线索','08丢失的线索','8','stage'),
('3a39605d67da48f2a3ef52e19d243953','聊天','聊天','14','source'),
('474ab93e2e114816abf3ffc596b19131','低','低','3','returnPriority'),
('48512bfed26145d4a38d3616e2d2cf79','广告','广告','1','source'),
('4d03a42898684135809d380597ed3268','合作伙伴研讨会','合作伙伴研讨会','9','source'),
('59795c49896947e1ab61b7312bd0597c','先生','先生','1','appellation'),
('5c6e9e10ca414bd499c07b886f86202a','高','高','1','returnPriority'),
('67165c27076e4c8599f42de57850e39c','夫人','夫人','2','appellation'),
('68a1b1e814d5497a999b8f1298ace62b','09因竞争丢失关闭','09因竞争丢失关闭','9','stage'),
('6b86f215e69f4dbd8a2daa22efccf0cf','web调研','web调研','13','source'),
('72f13af8f5d34134b5b3f42c5d477510','合作伙伴','合作伙伴','6','source'),
('7c07db3146794c60bf975749952176df','未联系','未联系','6','clueState'),
('86c56aca9eef49058145ec20d5466c17','内部研讨会','内部研讨会','10','source'),
('9095bda1f9c34f098d5b92fb870eba17','进行中','进行中','3','returnState'),
('954b410341e7433faa468d3c4f7cf0d2','已有业务','已有业务','1','transactionType'),
('966170ead6fa481284b7d21f90364984','已联系','已联系','3','clueState'),
('96b03f65dec748caa3f0b6284b19ef2f','推迟','推迟','2','returnState'),
('97d1128f70294f0aac49e996ced28c8a','新业务','新业务','2','transactionType'),
('9ca96290352c40688de6596596565c12','完成','完成','4','returnState'),
('9e6d6e15232549af853e22e703f3e015','需要条件','需要条件','7','clueState'),
('9ff57750fac04f15b10ce1bbb5bb8bab','02需求分析','02需求分析','2','stage'),
('a70dc4b4523040c696f4421462be8b2f','等待某人','等待某人','5','returnState'),
('a83e75ced129421dbf11fab1f05cf8b4','推销电话','推销电话','2','source'),
('ab8472aab5de4ae9b388b2f1409441c1','常规','常规','5','returnPriority'),
('ab8c2a3dc05f4e3dbc7a0405f721b040','05提案/报价','05提案/报价','5','stage'),
('b924d911426f4bc5ae3876038bc7e0ad','web下载','web下载','12','source'),
('c13ad8f9e2f74d5aa84697bb243be3bb','03价值建议','03价值建议','3','stage'),
('c83c0be184bc40708fd7b361b6f36345','最低','最低','4','returnPriority'),
('db867ea866bc44678ac20c8a4a8bfefb','员工介绍','员工介绍','3','source'),
('e44be1d99158476e8e44778ed36f4355','04确定决策者','04确定决策者','4','stage'),
('e5f383d2622b4fc0959f4fe131dafc80','女士','女士','3','appellation'),
('e81577d9458f4e4192a44650a3a3692b','06谈判/复审','06谈判/复审','6','stage'),
('fb65d7fdb9c6483db02713e6bc05dd19','在线商场','在线商场','5','source'),
('fd677cc3b5d047d994e16f6ece4d3d45','公开媒介','公开媒介','7','source'),
('ff802a03ccea4ded8731427055681d48','外部介绍','外部介绍','4','source');

/*Table structure for table `tbl_tran` */

DROP TABLE IF EXISTS `tbl_tran`;

CREATE TABLE `tbl_tran` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `money` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `expectedDate` char(10) DEFAULT NULL,
  `customerId` char(32) DEFAULT NULL,
  `stage` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  `contactsId` char(32) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_tran` */

insert  into `tbl_tran`(`id`,`owner`,`money`,`name`,`expectedDate`,`customerId`,`stage`,`type`,`source`,`activityId`,`contactsId`,`createBy`,`createTime`,`editBy`,`editTime`,`description`,`contactSummary`,`nextContactTime`) values 
('13be610ebeb44452b7a3799b1c05fe7d','40f6cdea0bd34aceb77492a1656d9fb3','44444','yc C','2020-08-31','9ea5d33868b249568b9874259df2c48a','09因竞争丢失关闭','已有业务','外部介绍','9bec62388e88440ba5f6075e1e5deedf','d028a43ac33c4ac68fab432cf60dc18d','张三','2020-08-29 21:05:22',NULL,NULL,'','',''),
('28a9c9069a7143ec8109c78fe9d39127','40f6cdea0bd34aceb77492a1656d9fb3','44444','yc C','2020-08-31','9ea5d33868b249568b9874259df2c48a','08丢失的线索','已有业务','外部介绍','9bec62388e88440ba5f6075e1e5deedf','d028a43ac33c4ac68fab432cf60dc18d','张三','2020-08-29 21:05:40','张三','2020-09-04 16:10:33','','',''),
('3676dc330a3848c2936c512c7e15171b','40f6cdea0bd34aceb77492a1656d9fb3','44444','yc C','2020-08-31','9ea5d33868b249568b9874259df2c48a','01资质审查','已有业务','外部介绍','9bec62388e88440ba5f6075e1e5deedf','d028a43ac33c4ac68fab432cf60dc18d','张三','2020-08-29 21:05:34',NULL,NULL,'','',''),
('37ab17ac35e64a1d95dab9caa21c0d3a','40f6cdea0bd34aceb77492a1656d9fb3','交易测试','321123','2020-08-05','0353cdc8ece7497a9d450eefaa5a5789','08丢失的线索',NULL,'员工介绍','869063c3ca70428e893ebc27c88ba4d9','af421744efa24be4b7b3a3d5700f5d69','张三','2020-08-27 19:38:21','张三','2020-08-30 09:49:10','12312312','14212412','2020-08-23'),
('4c066130d8394c08920f28cbca568238','40f6cdea0bd34aceb77492a1656d9fb3','500','ycC','2020-09-05','40e962f600474b8fb42b33d87033f878','02需求分析','已有业务','外部介绍','9bec62388e88440ba5f6075e1e5deedf','d028a43ac33c4ac68fab432cf60dc18d','','','张三','2020-08-29 17:24:17','111','222','2020-08-28'),
('585eee7e6dd247d194d19495b7986a1f','40f6cdea0bd34aceb77492a1656d9fb3','500','一笔很大的交易','2020-08-31','4b4294d4a0474d1e9fb88c3691593d08','07成交','新业务','web调研','9bec62388e88440ba5f6075e1e5deedf','d028a43ac33c4ac68fab432cf60dc18d','张三','2020-08-27 19:38:21','张三','2020-08-29 19:15:47','我就不信了','你再来个Null?','2020-09-04'),
('780f460e38f74ec19af78d97d7f35b63','40f6cdea0bd34aceb77492a1656d9fb3','44444','yc C','2020-08-31','9ea5d33868b249568b9874259df2c48a','09因竞争丢失关闭','已有业务','外部介绍','9bec62388e88440ba5f6075e1e5deedf','d028a43ac33c4ac68fab432cf60dc18d','张三','2020-08-29 21:05:27',NULL,NULL,'','',''),
('83f8999905ab4188ad36815a5c7c7446','40f6cdea0bd34aceb77492a1656d9fb3','44444','yc C','2020-08-31','9ea5d33868b249568b9874259df2c48a','07成交','已有业务','外部介绍','9bec62388e88440ba5f6075e1e5deedf','d028a43ac33c4ac68fab432cf60dc18d','张三','2020-08-29 21:05:31',NULL,NULL,'','',''),
('8cdb5166b81f4d7882182570eadd262f','40f6cdea0bd34aceb77492a1656d9fb3','44444','yc C','2020-08-31','9ea5d33868b249568b9874259df2c48a','05提案/报价','已有业务','外部介绍','9bec62388e88440ba5f6075e1e5deedf','d028a43ac33c4ac68fab432cf60dc18d','张三','2020-08-29 21:05:02',NULL,NULL,'','',''),
('92fc3bf041954999b94579b41be89996','40f6cdea0bd34aceb77492a1656d9fb3','44444','yc C','2020-08-31','9ea5d33868b249568b9874259df2c48a','08丢失的线索','已有业务','外部介绍','9bec62388e88440ba5f6075e1e5deedf','d028a43ac33c4ac68fab432cf60dc18d','张三','2020-08-29 21:05:25',NULL,NULL,'','',''),
('9a4912e1a9e0421eb70a775a41fb5422','06f5fc056eac41558a964f96daa7f27c','50000','21321','2020-08-16','df371994ac414e98a6d95393445f52d4','07成交','新业务','合作伙伴研讨会','03191258deb941059d525c1846049c45','d028a43ac33c4ac68fab432cf60dc18d','','','张三','2020-08-29 17:24:17','线索线索线索线索线索线索线索线索线索','纪要纪要纪要纪要纪要纪要纪要纪要纪要纪要纪要纪要','2020-08-27'),
('aacfafe9b6084ec9ab6fe013a30743e5','40f6cdea0bd34aceb77492a1656d9fb3','44444','yc C','2020-08-31','9ea5d33868b249568b9874259df2c48a','03价值建议','已有业务','外部介绍','9bec62388e88440ba5f6075e1e5deedf','d028a43ac33c4ac68fab432cf60dc18d','张三','2020-08-29 21:05:18',NULL,NULL,'','',''),
('b85ce17dfa4f40619e5fd35144c28e54','40f6cdea0bd34aceb77492a1656d9fb3','44444','yc C','2020-08-31','9ea5d33868b249568b9874259df2c48a','02需求分析','已有业务','外部介绍','9bec62388e88440ba5f6075e1e5deedf','d028a43ac33c4ac68fab432cf60dc18d','张三','2020-08-29 21:05:15',NULL,NULL,'','',''),
('bca7f271412f40278c01a739f39123c8','40f6cdea0bd34aceb77492a1656d9fb3','44444','yc C','2020-08-31','9ea5d33868b249568b9874259df2c48a','05提案/报价','已有业务','外部介绍','9bec62388e88440ba5f6075e1e5deedf','d028a43ac33c4ac68fab432cf60dc18d','张三','2020-08-29 21:05:00',NULL,NULL,'','',''),
('fc73a30dbeea4aa9bd8ef7938495838d','40f6cdea0bd34aceb77492a1656d9fb3','44444','yc C','2020-08-31','9ea5d33868b249568b9874259df2c48a','06谈判/复审','已有业务','外部介绍','9bec62388e88440ba5f6075e1e5deedf','d028a43ac33c4ac68fab432cf60dc18d','张三','2020-08-29 21:05:37','张三','2020-08-30 00:15:00','','',''),
('fcf790139736464a834d18cd57d34dc2','40f6cdea0bd34aceb77492a1656d9fb3','44444','yc C','2020-08-31','9ea5d33868b249568b9874259df2c48a','05提案/报价','已有业务','外部介绍','9bec62388e88440ba5f6075e1e5deedf','d028a43ac33c4ac68fab432cf60dc18d','张三','2020-08-29 21:05:04',NULL,NULL,'','',''),
('fe03b617b3b64047b177931f7de406be','40f6cdea0bd34aceb77492a1656d9fb3','44444','yc C','2020-08-31','9ea5d33868b249568b9874259df2c48a','05提案/报价','已有业务','外部介绍','9bec62388e88440ba5f6075e1e5deedf','d028a43ac33c4ac68fab432cf60dc18d','张三','2020-08-29 21:04:50',NULL,NULL,'','','');

/*Table structure for table `tbl_tran_history` */

DROP TABLE IF EXISTS `tbl_tran_history`;

CREATE TABLE `tbl_tran_history` (
  `id` char(32) NOT NULL,
  `stage` varchar(255) DEFAULT NULL,
  `money` varchar(255) DEFAULT NULL,
  `expectedDate` char(10) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `tranId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tranId` (`tranId`),
  CONSTRAINT `tbl_tran_history_ibfk_1` FOREIGN KEY (`tranId`) REFERENCES `tbl_tran` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_tran_history` */

insert  into `tbl_tran_history`(`id`,`stage`,`money`,`expectedDate`,`createTime`,`createBy`,`tranId`) values 
('0032bb84c4f14c9a8cab2f10115908f8','06谈判/复审','44444','2020-08-31','2020-08-30 00:15:00','张三','fc73a30dbeea4aa9bd8ef7938495838d'),
('00ce46fc83264fbf99c90e9ff9222e9e','08丢失的线索','44444','2020-08-31','2020-08-29 21:05:25','张三','92fc3bf041954999b94579b41be89996'),
('01644161801b478ca100487ad3407058','08丢失的线索','500','2020-08-31','2020-08-29 19:10:18','张三','585eee7e6dd247d194d19495b7986a1f'),
('0e6b268c344247c4a8bac87f6fa34ead','09因竞争丢失关闭','500','2020-08-31','2020-08-29 19:10:00','张三','585eee7e6dd247d194d19495b7986a1f'),
('10d505bcd482496baa5a17072aab6919','03价值建议','500','2020-08-31','2020-08-29 19:02:58','张三','585eee7e6dd247d194d19495b7986a1f'),
('12a77f9dc76e4d308156634debe00979','08丢失的线索','500','2020-08-31','2020-08-29 19:10:58','张三','585eee7e6dd247d194d19495b7986a1f'),
('13bf1c574c674275b19e3cea6524e3d1','08丢失的线索','500','2020-08-31','2020-08-29 19:02:54','张三','585eee7e6dd247d194d19495b7986a1f'),
('1e9e651115534e3cbab9da166068d4fb','06谈判/复审','500','2020-08-31','2020-08-29 17:46:17','张三','585eee7e6dd247d194d19495b7986a1f'),
('1ed5ba02300f4286be64c9d1acf63c1f','06谈判/复审','44444','2020-08-31','2020-08-30 00:15:27','张三','28a9c9069a7143ec8109c78fe9d39127'),
('222d7cad32b24f2da54cd34282a2c784','07成交','500','2020-08-31','2020-08-29 19:03:36','张三','585eee7e6dd247d194d19495b7986a1f'),
('22b965cae3cd4a7981b79409fc661b2f','06谈判/复审','44444','2020-08-31','2020-08-30 00:15:25','张三','28a9c9069a7143ec8109c78fe9d39127'),
('26867504383b47f4ab8b595e8ca4c52d','08丢失的线索','交易测试','2020-08-05','2020-08-30 09:49:10','张三','37ab17ac35e64a1d95dab9caa21c0d3a'),
('2e39d431bf484d6fbea3e75054467dce','04确定决策者','44444','2020-08-31','2020-09-04 16:10:32','张三','28a9c9069a7143ec8109c78fe9d39127'),
('319bc0da4ee141479f805657e01cf84f','09因竞争丢失关闭','500','2020-08-31','2020-08-29 19:02:55','张三','585eee7e6dd247d194d19495b7986a1f'),
('3529efda47e64e439cd50b5fe5a6d2d0','09因竞争丢失关闭','500','2020-08-31','2020-08-29 19:10:53','张三','585eee7e6dd247d194d19495b7986a1f'),
('366ccfec53b54dfb8f2d14474833e736','04确定决策者','500','2020-08-31','2020-08-29 19:11:00','张三','585eee7e6dd247d194d19495b7986a1f'),
('3782b0961aa84c3c8d1343867e299ec0','03价值建议','500','2020-08-31','2020-08-29 17:55:49','张三','585eee7e6dd247d194d19495b7986a1f'),
('421151c9713941c0964841ed23bbd571','05提案/报价','44444','2020-08-31','2020-08-30 00:14:59','张三','fc73a30dbeea4aa9bd8ef7938495838d'),
('474efeb228b2404681547492dd617469','08丢失的线索','500','2020-08-31','2020-08-29 19:04:50','张三','585eee7e6dd247d194d19495b7986a1f'),
('47832a4d05134d86b7e6ddb9d7c0af19','03价值建议','500','2020-08-31','2020-08-29 17:40:53','张三','585eee7e6dd247d194d19495b7986a1f'),
('483bf959eedb427193f2785c8facb035','09因竞争丢失关闭','500','2020-08-31','2020-08-29 19:09:52','张三','585eee7e6dd247d194d19495b7986a1f'),
('4ae776722aa048d3b50a73cd80ed9a5a','03价值建议','500','2020-08-31','2020-08-29 19:11:01','张三','585eee7e6dd247d194d19495b7986a1f'),
('5253667685bb42eeabae6e4bcc173459','01资质审查','44444','2020-08-31','2020-08-29 21:05:37','张三','fc73a30dbeea4aa9bd8ef7938495838d'),
('562df3ef8d844256872ed773dd50cb5d','05提案/报价','500','2020-08-31','2020-08-29 19:11:00','张三','585eee7e6dd247d194d19495b7986a1f'),
('595c7225faa74c74ba1834bc8f4b2bfd','04确定决策者','500','2020-08-31','2020-08-29 17:55:52','张三','585eee7e6dd247d194d19495b7986a1f'),
('5e96893044a347a083a2a1977728ee1b','04确定决策者','500','2020-09-05','2020-08-28 12:41:39','张三','4c066130d8394c08920f28cbca568238'),
('5f22dfea8de74cb7ab4ae5b8df96ea7c','08丢失的线索','500','2020-08-31','2020-08-29 19:10:46','张三','585eee7e6dd247d194d19495b7986a1f'),
('63e7da4ce0434c5f9b5975d947a00039','01资质审查','500','2020-08-31','2020-08-29 17:41:58','张三','585eee7e6dd247d194d19495b7986a1f'),
('642916aa72914831ad341b831985d042','08丢失的线索','500','2020-08-31','2020-08-29 19:08:26','张三','585eee7e6dd247d194d19495b7986a1f'),
('667215fdbeea40cba3bd05cc62b27a90','07成交','500','2020-08-31','2020-08-29 17:40:48','张三','585eee7e6dd247d194d19495b7986a1f'),
('6b444ba16b154ea0a2339aa24ed42379','08丢失的线索','44444','2020-08-31','2020-08-30 00:15:26','张三','28a9c9069a7143ec8109c78fe9d39127'),
('6d18a734b3f04f7ea8ea2d49e9e877ae','02需求分析','500','2020-08-31','2020-08-29 19:02:57','张三','585eee7e6dd247d194d19495b7986a1f'),
('79feadc552e6413b97313d39f665612e','09因竞争丢失关闭','交易测试','2020-08-05','2020-08-30 09:49:06','张三','37ab17ac35e64a1d95dab9caa21c0d3a'),
('82095802f3d64ae5bd2cb6348721598a','09因竞争丢失关闭','500','2020-08-31','2020-08-29 19:08:27','张三','585eee7e6dd247d194d19495b7986a1f'),
('8270dee71038452d8f6224aeb28840e0','08丢失的线索','500','2020-08-31','2020-08-29 19:08:29','张三','585eee7e6dd247d194d19495b7986a1f'),
('82d9f5f7dccf48489d31af06ed0f12a4','07成交','500','2020-08-31','2020-08-29 19:10:56','张三','585eee7e6dd247d194d19495b7986a1f'),
('83401a05ff0e4077a8a1bc05f295d4db','05提案/报价','500','2020-08-31','2020-08-29 19:02:52','张三','585eee7e6dd247d194d19495b7986a1f'),
('8386c0f105df41fabdc3ef794aeb1fd8','08丢失的线索','500','2020-08-31','2020-08-29 19:10:54','张三','585eee7e6dd247d194d19495b7986a1f'),
('85998ffa3d844e179bde58497c1a00e2','08丢失的线索','500','2020-08-31','2020-08-29 19:03:38','张三','585eee7e6dd247d194d19495b7986a1f'),
('87985d91fb8e46029b293d8c7b34d429','02需求分析','44444','2020-08-31','2020-08-29 21:05:40','张三','28a9c9069a7143ec8109c78fe9d39127'),
('87f53e20141a42bf8b72b7aec350a380','07成交','500','2020-08-31','2020-08-29 19:10:59','张三','585eee7e6dd247d194d19495b7986a1f'),
('8aba5896e6d54a0593a166a57274ed4b','03价值建议','500','2020-08-31','2020-08-29 17:41:54','张三','585eee7e6dd247d194d19495b7986a1f'),
('8adf6e1b4c8743129ec438c2c02e867a','01资质审查','44444','2020-08-31','2020-08-29 21:05:34','张三','3676dc330a3848c2936c512c7e15171b'),
('915cdca9b16f4c4ba36ea88cfcc223ff','02需求分析','500','2020-08-31','2020-08-29 19:11:01','张三','585eee7e6dd247d194d19495b7986a1f'),
('919fde11b42e4a5cbf82da9d9ddff7fc','02需求分析','50000','2020-08-16','2020-08-27 14:59:48','张三','9a4912e1a9e0421eb70a775a41fb5422'),
('92b03bbe4545456aa1e7116963ca6ff2','05提案/报价','500','2020-08-31','2020-08-29 17:41:52','张三','585eee7e6dd247d194d19495b7986a1f'),
('9608eccf9a564c42a02748f6641e21b5','02需求分析','44444','2020-08-31','2020-08-29 21:05:15','张三','b85ce17dfa4f40619e5fd35144c28e54'),
('974e759a61cd4cd0b40555a1d19bf7ad','05提案/报价','44444','2020-08-31','2020-08-29 21:04:50','张三','fe03b617b3b64047b177931f7de406be'),
('99658736ecf74dc8b3f4cab16eb6ae0d','03价值建议','交易测试','2020-08-05','2020-08-30 09:49:09','张三','37ab17ac35e64a1d95dab9caa21c0d3a'),
('9ab9aabfe83f477dabc64f5bd81e5564','05提案/报价','500','2020-08-31','2020-08-29 19:02:59','张三','585eee7e6dd247d194d19495b7986a1f'),
('a706a508463644ffb8bfe6d436c89ce5','07成交','500','2020-08-31','2020-08-29 18:03:57','张三','585eee7e6dd247d194d19495b7986a1f'),
('b0b8a94386184d458a028fb3cbd17c3d','08丢失的线索','44444','2020-08-31','2020-09-04 16:10:33','张三','28a9c9069a7143ec8109c78fe9d39127'),
('b0bdb843d97b48d1b4382fae2c7bba73','05提案/报价','44444','2020-08-31','2020-08-29 21:05:02','张三','8cdb5166b81f4d7882182570eadd262f'),
('b416b7907087455a918d5be19f358439','09因竞争丢失关闭','44444','2020-08-31','2020-08-29 21:05:22','张三','13be610ebeb44452b7a3799b1c05fe7d'),
('b4946754a2c54a12b2583091ac474d5c','04确定决策者','500','2020-08-31','2020-08-29 17:41:53','张三','585eee7e6dd247d194d19495b7986a1f'),
('b5d5e30ea42f4e61a3e5761def3df517','03价值建议','44444','2020-08-31','2020-08-29 21:05:18','张三','aacfafe9b6084ec9ab6fe013a30743e5'),
('b6d08d09dd1f4d2ab1b04ad70447928b','05提案/报价','44444','2020-08-31','2020-08-29 21:05:04','张三','fcf790139736464a834d18cd57d34dc2'),
('ba82d296382349a282fbe2814e067d86','06谈判/复审','交易测试','2020-08-05','2020-08-30 09:49:02','张三','37ab17ac35e64a1d95dab9caa21c0d3a'),
('bb30f39d022242f1810e08b449697a41','07成交','500','2020-08-31','2020-08-29 19:10:45','张三','585eee7e6dd247d194d19495b7986a1f'),
('c0880ad038bb4028badde6acd20a55b3','08丢失的线索','交易测试','2020-08-05','2020-08-30 09:49:05','张三','37ab17ac35e64a1d95dab9caa21c0d3a'),
('c5a1670786974fb59484e3b102aedc37','06谈判/复审','500','2020-08-31','2020-08-28 12:40:35','张三','585eee7e6dd247d194d19495b7986a1f'),
('cb33622cd9ec4c1287596fb9736aaa53','09因竞争丢失关闭','500','2020-08-31','2020-08-29 19:07:08','张三','585eee7e6dd247d194d19495b7986a1f'),
('db13219487a243c190eda5d110e94419','05提案/报价','44444','2020-08-31','2020-08-29 21:05:00','张三','bca7f271412f40278c01a739f39123c8'),
('dd423ce9e50a4c7cb77206b38e63c5d6','09因竞争丢失关闭','44444','2020-08-31','2020-08-29 21:05:27','张三','780f460e38f74ec19af78d97d7f35b63'),
('dddd299e89314536b3efb4b7b541c2fc','09因竞争丢失关闭','500','2020-08-31','2020-08-29 19:10:58','张三','585eee7e6dd247d194d19495b7986a1f'),
('de089a9dcf8f4dd1bcf630255a7d9ef9','06谈判/复审','500','2020-08-31','2020-08-29 17:40:34','张三','585eee7e6dd247d194d19495b7986a1f'),
('deb0b325af874eb2aa113d4cd8d990d0','08丢失的线索','500','2020-08-31','2020-08-29 19:10:13','张三','585eee7e6dd247d194d19495b7986a1f'),
('df5eecacac5944879c385364fee4377b','06谈判/复审','500','2020-08-31','2020-08-29 17:41:51','张三','585eee7e6dd247d194d19495b7986a1f'),
('e2d538d3f7b64562af9243ffc6d9e2cd','06谈判/复审','500','2020-08-31','2020-08-29 19:02:51','张三','585eee7e6dd247d194d19495b7986a1f'),
('e307ce84c8a143e8920ba4eb0b5bd679','07成交','44444','2020-08-31','2020-08-29 21:05:31','张三','83f8999905ab4188ad36815a5c7c7446'),
('e4a7f11a416d441f97e17a532c2d48be','08丢失的线索','交易测试','2020-08-05','2020-08-27 19:38:21','张三','37ab17ac35e64a1d95dab9caa21c0d3a'),
('ebb3a0ac912446c98ff49b60c1c1f050','02需求分析','500','2020-08-31','2020-08-29 17:41:55','张三','585eee7e6dd247d194d19495b7986a1f'),
('ed87763ed2f34df89ea3571e193261c0','07成交','500','2020-08-31','2020-08-29 19:15:47','张三','585eee7e6dd247d194d19495b7986a1f'),
('f3b2c16e0a5b4418b25014c731e1b2dc','04确定决策者','交易测试','2020-08-05','2020-08-30 09:49:07','张三','37ab17ac35e64a1d95dab9caa21c0d3a'),
('f59c9cbacc6b43468c0c713cda1e1fce','04确定决策者','44444','2020-08-31','2020-08-30 00:14:58','张三','fc73a30dbeea4aa9bd8ef7938495838d');

/*Table structure for table `tbl_tran_remark` */

DROP TABLE IF EXISTS `tbl_tran_remark`;

CREATE TABLE `tbl_tran_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `tranId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tbl_tran_remark_ibfk_1` (`tranId`),
  CONSTRAINT `tbl_tran_remark_ibfk_1` FOREIGN KEY (`tranId`) REFERENCES `tbl_tran` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_tran_remark` */

/*Table structure for table `tbl_user` */

DROP TABLE IF EXISTS `tbl_user`;

CREATE TABLE `tbl_user` (
  `id` char(32) NOT NULL COMMENT 'uuid\n            ',
  `loginAct` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `loginPwd` varchar(255) DEFAULT NULL COMMENT '密码不能采用明文存储，采用密文，MD5加密之后的数据',
  `email` varchar(255) DEFAULT NULL,
  `expireTime` char(19) DEFAULT NULL COMMENT '失效时间为空的时候表示永不失效，失效时间为2018-10-10 10:10:10，则表示在该时间之前该账户可用。',
  `lockState` char(1) DEFAULT NULL COMMENT '锁定状态为空时表示启用，为0时表示锁定，为1时表示启用。',
  `deptno` char(4) DEFAULT NULL,
  `allowIps` varchar(255) DEFAULT NULL COMMENT '允许访问的IP为空时表示IP地址永不受限，允许访问的IP可以是一个，也可以是多个，当多个IP地址的时候，采用半角逗号分隔。允许IP是192.168.100.2，表示该用户只能在IP地址为192.168.100.2的机器上使用。',
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tbl_user` */

insert  into `tbl_user`(`id`,`loginAct`,`name`,`loginPwd`,`email`,`expireTime`,`lockState`,`deptno`,`allowIps`,`createTime`,`createBy`,`editTime`,`editBy`) values 
('06f5fc056eac41558a964f96daa7f27c','ls','李四1','202cb962ac59075b964b07152d234b70','ls@163.com','2021-11-27 21:50:05','1','A001','192.168.1.1,192.168.1.2,127.0.0.1','2018-11-22 12:11:40','李四',NULL,NULL),
('40f6cdea0bd34aceb77492a1656d9fb3','zs','张三','202cb962ac59075b964b07152d234b70','zs@qq.com','2021-11-30 23:50:55','1','A001','','2018-11-22 11:37:34','张三',NULL,NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
