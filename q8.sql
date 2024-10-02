--G8 Bill rolls a 6, and then a 3
-- Bill will move 6  and have no changes , then roll 3 and move 3 additional steps. Total 9 steps
-- AMBS to Community Chest 1(wins 100)

--Use existing trigger to update Audit_Trail - UpdateAuditTrail
-- Use existing Trigger for community chest bonus update - UpdateBankBalanceAFterCCommunityChest1

---------------------------------------------------------------------------------------------------------------------
-- Update player 2  bonus ID to Community Chest 1 -- This will fire the trigger : UpdateBankBalanceAFterCCommunityChest1 
UPDATE Player
SET 
	Bonus_ID = (SELECT ID FROM Bonus WHERE Name='Community Chest 1')
WHERE 
ID = 2;

-- Update player 2  Location ID to Community Chest 1- This will fire the trigger : UpdateAuditTrail
--adding 200 to bank balance since the player passes GO
UPDATE Player
SET 
	Location_ID = (SELECT l.ID FROM Location l INNER JOIN Bonus b on l.Bonus_ID = b.ID WHERE b.Name = 'Community Chest 1' ),
	Bank_Balance = Bank_Balance + 200
WHERE ID = 2;








