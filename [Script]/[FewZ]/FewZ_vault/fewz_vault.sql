CREATE TABLE IF NOT EXISTS `fewz_inventory` (
  `name` varchar(60) COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=COMPACT;

INSERT INTO `fewz_inventory` (`name`, `label`, `shared`) VALUES
	('property', 'Property', 0),
	('society_ambulance', 'Ambulance', 1),
	('society_cheif', 'Cheif', 1),
	('society_mechanic', 'Mechanic', 1),
	('society_police', 'Police', 1),
	('vault', 'Vault', 0);

CREATE TABLE IF NOT EXISTS `fewz_inventory_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) COLLATE utf8mb4_bin NOT NULL,
  `owner` varchar(60) COLLATE utf8mb4_bin DEFAULT NULL,
  `data` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_datastore_owner_name` (`owner`,`name`),
  KEY `index_datastore_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

INSERT INTO `fewz_inventory_items` (`id`, `name`, `owner`, `data`) VALUES
	(1, 'society_ambulance', NULL, '{}'),
	(2, 'society_cheif', NULL, '{}'),
	(3, 'society_mechanic', NULL, '{}'),
	(4, 'society_police', NULL, '{"account":[],"item":[]}'),
	(5, 'property', 'steam:110000109aac70a', '{}'),
	(6, 'vault', 'steam:110000109aac70a', '{"account":[{"name":"black_money","count":1000}],"item":[{"name":"cement","count":2},{"name":"copper_bar","count":1}]}'),
	(7, 'property', 'steam:110000144b7ae30', '{}'),
	(8, 'vault', 'steam:110000144b7ae30', '{}'),
	(9, 'property', 'steam:11000014d9aa625', '{}'),
	(10, 'vault', 'steam:11000014d9aa625', '{}'),
	(11, 'property', 'steam:110000110c3860c', '{}'),
	(12, 'vault', 'steam:110000110c3860c', '{}'),
	(13, 'property', 'steam:11000010e349557', '{}'),
	(14, 'vault', 'steam:11000010e349557', '{"item":[]}'),
	(15, 'property', 'steam:11000010b897c5e', '{}'),
	(16, 'vault', 'steam:11000010b897c5e', '{}'),
	(17, 'property', 'steam:110000106ef2658', '{}'),
	(18, 'vault', 'steam:110000106ef2658', '{}'),
	(19, 'property', 'steam:11000014a971467', '{}'),
	(20, 'vault', 'steam:11000014a971467', '{}'),
	(21, 'property', 'steam:1100001488dafdf', '{}'),
	(22, 'vault', 'steam:1100001488dafdf', '{}'),
	(23, 'property', 'steam:11000010ab85310', '{}'),
	(24, 'vault', 'steam:11000010ab85310', '{}'),
	(25, 'property', 'steam:1100001339d108f', '{}'),
	(26, 'vault', 'steam:1100001339d108f', '{}');