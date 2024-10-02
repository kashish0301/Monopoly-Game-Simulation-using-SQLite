--G2 Norman(4) rolls a 1
--Goes from Kilburn to Chance 1. So he will pay 50 pounds each to other players.

--previous trigger is used for Audit_Trail

--Trigger 2
DROP TRIGGER IF EXISTS UpdateBankBalanceBEFOREChance1;

CREATE TRIGGER UpdateBankBalanceBEFOREChance1
BEFORE UPDATE of Bonus_ID on Player
WHEN NEW.Bonus_ID = (SELECT ID FROM Bonus WHERE Name = 'Chance 1')
BEGIN
	--Subtract from player 4
	UPDATE Player
	SET Bank_Balance = Bank_Balance - (50*((SELECT count(*) FROM Player) - 1))
	WHERE ID = NEW.ID;
	
	--Add to all other players
	UPDATE Player
	SET Bank_Balance = Bank_Balance + 50
	WHERE ID != NEW.ID;
END;

---------------------------------------------------------------------------------------------------------------------

-- Update player 4  Location ID to Chance 1- This will trigger the audit trail
UPDATE Player
SET 
	Location_ID = (SELECT l.ID FROM Location l INNER JOIN Bonus b on l.Bonus_ID = b.ID WHERE b.Name = 'Chance 1' ),
	Bonus_ID = (SELECT ID FROM Bonus WHERE Name='Chance 1')
WHERE 
ID = 4;



	