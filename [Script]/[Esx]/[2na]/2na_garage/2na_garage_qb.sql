ALTER TABLE player_vehicles ADD stored INT DEFAULT 0;

CREATE TABLE `2na_garages` (
    `garage` varchar(16) NOT NULL,
    `owner` varchar(60) NOT NULL,
    `safe` varchar(60) DEFAULT 0,
    PRIMARY KEY (`garage`)
)