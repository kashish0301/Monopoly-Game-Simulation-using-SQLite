--G1 Jane rolls a 3 
-- She Moves from AMBS and lands at GO. Therefore she will get 200 bonus

--Trigger to update the Audit_Trail table after Round 1 gameplay 
DROP TRIGGER IF EXISTS UpdateAuditTrail;

CREATE TRIGGER UpdateAuditTrail
AFTER UPDATE OF Location_ID on Player
WHEN NEW.Location_ID != OLD.Location_ID OR NEW.Bank_Balance != OLD.Bank_Balance
BEGIN
	INSERT INTO Audit_Trail (Player_ID, Location_ID,Current_Bank_Balance,Number_of_Game_Rounds)
	VALUES (NEW.ID, NEW.Location_ID, NEW.Bank_Balance,1);
END;

--Trigger Fires after player lands on Bonus -'GO' to update 200 bonus 
DROP TRIGGER IF EXISTS UpdateBankBalanceBEFOREGO;

CREATE TRIGGER UpdateBankBalanceBEFOREGO
BEFORE UPDATE of Bonus_ID on Player
WHEN NEW.Bonus_ID = (SELECT ID FROM Bonus WHERE Name = 'GO')
BEGIN
	UPDATE Player
	SET Bank_Balance = Bank_Balance + 200
	WHERE ID = NEW.ID;
END;


--Updating the table based on Round 1 Gameplay
UPDATE Player 
SET 
	Location_ID = (SELECT l.ID FROM Location l INNER JOIN Bonus b on l.Bonus_ID = b.ID WHERE b.Name = 'GO' ),
	Bonus_ID = (SELECT ID FROM Bonus WHERE Name='GO')
WHERE ID= 3;
