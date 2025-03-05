ALTER TABLE owned_vehicles
ADD garage VARCHAR(32) AFTER stored;

CREATE TABLE `2na_garages` (
    `garage` varchar(16) NOT NULL,
    `owner` varchar(60) NOT NULL,
    `safe` varchar(60) DEFAULT 0,
    PRIMARY KEY (`garage`)
)