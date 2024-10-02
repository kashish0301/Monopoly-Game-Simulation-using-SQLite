-- Inserting data into the Token table
INSERT INTO Token VALUES
(1,'Dog'),
(2,'Car'),
(3,'Battleship'),
(4,'Top Hat'),
(5,'Thimble'),
(6,'Boot');
	
-- Inserting data into the Property table
INSERT INTO Property (ID, Name, Cost, Color, Owner_ID) VALUES
(1, 'Oak House', 100, 'Orange', NULL),
(2, 'Owens Park', 30, 'Orange', NULL),
(3, 'AMBS', 400, 'Blue', NULL),
(4, 'Co-Op', 30, 'Blue', NULL),
(5, 'Kilburn', 120, 'Yellow', NULL),
(6, 'Uni Place', 100, 'Yellow', NULL),
(7, 'Victoria', 75, 'Green', NULL),
(8, 'Piccadilly', 35, 'Green', NULL);

-- Inserting data into the Bonus table
INSERT INTO Bonus (ID, Name, Description) VALUES
(1, 'Chance 1', 'Pay each of the other players £50'),
(2, 'Chance 2', 'Move forward 3 spaces'),
(3, 'Community Chest 1', 'For winning a Beauty Contest, you win £100'),
(4, 'Community Chest 2', 'Your library books are overdue. Play a fine of £30'),
(5, 'Free Parking', 'No action'),
(6, 'Go to Jail', 'Go to Jail, do not pass GO, do not collect £200'),
(7, 'GO', 'Collect £200');

-- Insert data into the Location table for Properties
INSERT INTO Location (Location_Type, Bonus_ID, Property_ID)
SELECT 'Property', NULL, ID
FROM Property;
-- Insert data into the Location table for Bonuses
INSERT INTO Location (Location_Type, Bonus_ID, Property_ID)
SELECT 'Bonus', ID, NULL
FROM Bonus;

-- Inserting data into the Player table
INSERT INTO Player (ID,Name,Token_ID,Bank_Balance,Location_ID,Bonus_ID) VALUES
(1,'Mary', 3, 190, 13, 5),
(2,'Bill', 1, 500, 5, NULL),
(3,'Jane', 2, 150, 1, NULL),
(4,'Norman', 5, 250, 3, NULL);

--Audit_trail table remains empty as we have not started with the round yet.

--adding the Ownwer_ID column of Player table using UPDATE, 
--This is done beacuse the Player and Property Table have circular references and SQLITE does not support that
UPDATE Property
SET Owner_ID = 4
WHERE ID = 1;

UPDATE Property
SET Owner_ID = 4
WHERE ID = 2;

UPDATE Property
SET Owner_ID = 3
WHERE ID = 4;

UPDATE Property
SET Owner_ID = 1
WHERE ID = 6;

UPDATE Property
SET Owner_ID = 2
WHERE ID = 7;