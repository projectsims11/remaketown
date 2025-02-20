-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               11.3.1-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for sever_new
CREATE DATABASE IF NOT EXISTS `sever_new` /*!40100 DEFAULT CHARACTER SET utf8mb3 COLLATE utf8mb3_bin */;
USE `sever_new`;

-- Dumping structure for table sever_new.dnk_login
CREATE TABLE IF NOT EXISTS `dnk_login` (
  `identifier` longtext DEFAULT NULL,
  `login` longtext DEFAULT '[]',
  `date` longtext DEFAULT '',
  `current` longtext DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

-- Dumping data for table sever_new.dnk_login: ~10 rows (approximately)
INSERT INTO `dnk_login` (`identifier`, `login`, `date`, `current`) VALUES
	('steam:11000014172cc46', '{}', '', ''),
	('steam:11000013bdd2caf', '{"missed":[true,true,true,true,true,true,true,true,true,true,false,true,true,false,false,true,false],"received":[false,false,false,false,false,false,false,false,false,false,true,false,false,true,true,false,true]}', '17/07', '17'),
	('steam:110000159ff2cda', '{}', '', ''),
	('steam:11000016750a711', '{}', '', ''),
	('steam:11000013f4d0eb8', '{}', '', ''),
	('steam:11000010af29280', '{}', '', ''),
	('steam:11000010a608f40', '{}', '', ''),
	('steam:110000164c4d87d', '{}', '', ''),
	('steam:11000016968ff1e', '{}', '', ''),
	('steam:1100001644ed142', '{}', '', '');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
