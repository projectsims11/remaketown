-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.6.4-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for ispecialbaselegacy
CREATE DATABASE IF NOT EXISTS `ispecialbaselegacy` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `ispecialbaselegacy`;

-- Dumping structure for table ispecialbaselegacy.owned_vehicles
CREATE TABLE IF NOT EXISTS `owned_vehicles` (
  `owner` varchar(22) COLLATE utf8mb3_bin NOT NULL,
  `plate` varchar(12) COLLATE utf8mb3_bin NOT NULL,
  `vehicle` longtext COLLATE utf8mb3_bin DEFAULT NULL,
  `type` varchar(20) COLLATE utf8mb3_bin NOT NULL DEFAULT 'car',
  `job` varchar(20) COLLATE utf8mb3_bin NOT NULL DEFAULT '',
  `stored` tinyint(1) NOT NULL DEFAULT 1,
  `health_vehicles` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '{"tyres":[false,false,false,false,false,false,false],"windows":[1,1,1,false,false,1,1,1,1,1,1,false,false],"health_engine":1000.0,"health_body":1000.0,"health_tank":65.0,"doors":[false,false,false,false,false,false],"fuel":30.0}',
  `police` int(11) DEFAULT 0,
  `police_by` varchar(50) COLLATE utf8mb3_bin DEFAULT NULL,
  `time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

-- Dumping data for table ispecialbaselegacy.owned_vehicles: ~2 rows (approximately)
/*!40000 ALTER TABLE `owned_vehicles` DISABLE KEYS */;
INSERT INTO `owned_vehicles` (`owner`, `plate`, `vehicle`, `type`, `job`, `stored`, `health_vehicles`, `police`, `police_by`, `time`) VALUES
	('steam:110000109aac70a', 'AEE 374', '{"plateIndex":0,"modRearBumper":-1,"modRightFender":-1,"color2":0,"modExhaust":-1,"modBrakes":-1,"modArchCover":-1,"color1Type":0,"modFender":-1,"modDial":-1,"modGrille":-1,"modAirFilter":-1,"modDoorSpeaker":-1,"wheelColor":158,"modDoorR":-1,"modTrimA":-1,"pearlescentColor":18,"doorsBroken":{"2":false,"1":false,"4":false,"3":false,"0":false},"modStruts":-1,"windowTint":-1,"modEngineBlock":-1,"wheels":3,"neonEnabled":[false,false,false,false],"modShifterLeavers":-1,"modTransmission":-1,"windowsBroken":{"2":true,"1":false,"4":true,"3":true,"6":false,"5":true,"0":false,"7":true},"color1Custom":[5,5,5],"modLivery":-1,"modRoof":-1,"neonColor":[255,255,255],"modPlateHolder":-1,"modVanityPlate":-1,"modSuspension":-1,"modSpoilers":-1,"bodyHealth":1000.0,"modHood":-1,"tankHealth":1000.0,"modSideSkirt":-1,"modEngine":-1,"modTank":-1,"modFrontWheels":-1,"color1":0,"modSteeringWheel":-1,"extras":[],"plate":"AEE 374","modLightbar":-1,"modHorns":-1,"color2Custom":[5,5,5],"color2Type":0,"xenonColor":255,"modSeats":-1,"modXenon":false,"modTrunk":-1,"modArmor":-1,"modSpeakers":-1,"modHydrolic":-1,"fuelLevel":63.8,"modTrimB":-1,"tyreSmokeColor":[255,255,255],"modBackWheels":-1,"modSmokeEnabled":false,"tyreBurst":{"1":false,"5":false,"4":false,"0":false},"modAPlate":-1,"modOrnaments":-1,"model":-1532697517,"engineHealth":1000.0,"modFrame":-1,"modTurbo":false,"modDashboard":-1,"modAerials":-1,"modFrontBumper":-1,"dirtLevel":0.0}', 'car', '', 1, '{"health_engine":1000.0,"doors":[false,false,false,false,false,false],"fuel":63.77198791503906,"tyres":[false,false,false,false,false,false,false],"health_body":1000.0}', 0, NULL, NULL),
	('steam:110000109aac70a', 'BZE 927', '{"windowsBroken":{"5":true,"4":true,"7":true,"6":false,"1":false,"0":false,"3":true,"2":true},"plateIndex":4,"modFrontBumper":-1,"modPlateHolder":-1,"modXenon":false,"tyreBurst":[],"fuelLevel":33.2,"modFrontWheels":-1,"modTurbo":false,"modSeats":-1,"modHorns":-1,"modVanityPlate":-1,"modEngine":-1,"modBrakes":-1,"modRoof":-1,"modAirFilter":-1,"dirtLevel":0.0,"modSuspension":-1,"modOrnaments":-1,"neonColor":[255,255,255],"modFender":-1,"tyreSmokeColor":[255,255,255],"modBackWheels":-1,"modGrille":-1,"modTrunk":-1,"neonEnabled":[false,false,false,false],"doorsBroken":{"0":false},"modRightFender":-1,"modTransmission":-1,"modShifterLeavers":-1,"pearlescentColor":3,"modSteeringWheel":-1,"color2":4,"color1Custom":[8,8,8],"bodyHealth":1000.0,"windowTint":-1,"color2Type":0,"tankHealth":1000.0,"modArchCover":-1,"modFrame":-1,"color1Type":0,"modAerials":-1,"modHood":-1,"color1":0,"modExhaust":-1,"modEngineBlock":-1,"modLivery":-1,"color2Custom":[90,94,102],"plate":"BZE 927","modTrimA":-1,"engineHealth":1000.0,"modDoorSpeaker":-1,"modDoorR":-1,"model":861409633,"modArmor":-1,"modDashboard":-1,"modTrimB":-1,"extras":[],"modDial":-1,"modAPlate":-1,"modHydrolic":-1,"modLightbar":-1,"modSmokeEnabled":false,"modStruts":-1,"modTank":-1,"modSpeakers":-1,"xenonColor":255,"modSideSkirt":-1,"modRearBumper":-1,"wheelColor":156,"wheels":0,"modSpoilers":-1}', 'boat', '', 1, '{"tyres":[false,false,false,false,false,false,false],"windows":[1,1,1,false,false,1,1,1,1,1,1,false,false],"health_engine":1000.0,"health_body":1000.0,"health_tank":65.0,"doors":[false,false,false,false,false,false],"fuel":5.0}', 0, NULL, NULL);
/*!40000 ALTER TABLE `owned_vehicles` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
