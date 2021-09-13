
INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_burgershot', 'Burgershot', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_burgershot', 'Burgershot', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_burgershot', 'Burgershot', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('burgershot', 'Burgershot')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('burgershot',0,'recrue','Recrue',12,'{}','{}'),
	('burgershot',1,'burgershot','Employer',36,'{}','{}'),
	('burgershot',2,'boss',"Patron",48,'{}','{}')
;

INSERT INTO `items` (name, label) VALUES 
	('bread', 'Pain'),
	('cheeseburger', "Cheese Burger"),
	('nuggetscru', "Nuggets Cru"),
	('nuggets', "Nuggets"),
	('fritecru', "Frite Cru"),
	('frite', "Frite"),
	('gallette', "Gallette"),
	('wrap', "Wrap"),
	('coca', "Coca-cola"),
	('fanta', "Fanta"),
	('sprite', "Sprite")
;