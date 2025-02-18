

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_council', 'council', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_council', 'council', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_council', 'council', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('council', 'council')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('council',0,'recruit','Recruit',20,'{}','{}'),
	('council',1,'officer','Officer',40,'{}','{}'),
	('council',2,'sergeant','Sergeant',60,'{}','{}'),
	('council',3,'lieutenant','Lieutenant',85,'{}','{}'),
	('council',4,'boss','Chief',100,'{}','{}')
;