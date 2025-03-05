CREATE TABLE IF NOT EXISTS `owned_vehicles` (
  `owner` varchar(22) COLLATE utf8_bin NOT NULL,
  `plate` varchar(12) COLLATE utf8_bin NOT NULL,
  `vehicle` longtext COLLATE utf8_bin DEFAULT NULL,
  `type` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT 'car',
  `job` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '',
  `stored` tinyint(1) NOT NULL DEFAULT 1,
  `health_vehicles` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '{"tyres":[false,false,false,false,false,false,false],"windows":[1,1,1,false,false,1,1,1,1,1,1,false,false],"health_engine":1000.0,"health_body":1000.0,"health_tank":65.0,"doors":[false,false,false,false,false,false]}',
  `police` int(11) DEFAULT 0,
  `police_by` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;