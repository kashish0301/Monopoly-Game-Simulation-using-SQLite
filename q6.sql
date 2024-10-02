--G6 Norman(4) rolls a 4
--
-- from chance 1(onus_id =1) goes to community chest 1(Bonus_ID= 3), player wins 100 pounds


--Use existing trigger to update Audit_Trail
--Trigger 3 for community chest bonus update
DROP TRIGGER IF EXISTS UpdateBankBalanceBEFORECCommunityChest1;
CREATE TRIGGER UpdateBankBalanceBEFORECommunityChest1
BEFORE UPDATE of Bonus_ID on Player
WHEN NEW.Bonus_ID = (SELECT ID FROM Bonus WHERE Name = 'Community Chest 1')
BEGIN
	--Player wins 100 in beauty contest
	UPDATE Player
	SET Bank_Balance = Bank_Balance + 100
	WHERE ID = NEW.ID;
END;

---------------------------------------------------------------------------------------------------------------------

-- Update player 4  Location ID to Community Chest 1- This will trigger the audit trail
UPDATE Player
SET 
	Location_ID = (SELECT l.ID FROM Location l INNER JOIN Bonus b on l.Bonus_ID = b.ID WHERE b.Name = 'Community Chest 1' ),
	Bonus_ID = (SELECT ID FROM Bonus WHERE Name='Community Chest 1')
WHERE 
ID = 4;



	
