----G5 Jane(3) rolls a 5
--From GO she will land at Victoria (Green color). As the property is owned- Jane(ID=3) will pay 75 rent to Jane(Owner_ID=2)


--Ovveride existing trigger to update audittrail for round 2
DROP TRIGGER IF EXISTS UpdateAuditTrail;
CREATE TRIGGER UpdateAuditTrail
AFTER UPDATE OF Location_ID on Player
WHEN NEW.Location_ID != OLD.Location_ID OR NEW.Bank_Balance != OLD.Bank_Balance
BEGIN
	INSERT INTO Audit_Trail (Player_ID, Location_ID,Current_Bank_Balance,Number_of_Game_Rounds)
	VALUES (NEW.ID, NEW.Location_ID, NEW.Bank_Balance,2);
END;


--UPDATE Bank_Balance of of Jane(Current player if AMBS is onwed by someone and also check if the owner of AMBS owns all properties of that color (count)
UPDATE Player -- Current player 
SET
	Bank_Balance = 
	CASE	
		WHEN (Select count(*) from Property 
			  WHERE Owner_ID=(SELECT Owner_ID FROM Property WHERE Name='Victoria') 
			  AND Color=( SELECT Color FROM Property WHERE name='Victoria'))
			  = 
			 (SELECT count(*) FROM Property WHERE Color=(SELECT Color FROM Property WHERE Name='Victoria'))
		THEN Bank_Balance - (SELECT Cost*2 FROM Property WHERE Name='Victoria')--Doubles rent
		ELSE Bank_Balance - (SELECT Cost FROM Property WHERE Name='Victoria')  -- This will cover the case if owner_ID is null so it will take only rent
	END
WHERE ID = 3;

-- update owner's bank balance after recieving the rent ( If there is an owner existing)
UPDATE Player -- Current player 
SET
	Bank_Balance = 
	CASE	
		WHEN (Select count(*) from Property 
			  WHERE Owner_ID=(SELECT Owner_ID FROM Property WHERE Name='Victoria') 
			  AND Color=( SELECT Color FROM Property WHERE name='Victoria'))
			  = 
			 (SELECT count(*) FROM Property WHERE Color=(SELECT Color FROM Property WHERE Name='Victoria'))
		THEN Bank_Balance + (SELECT Cost*2 FROM Property WHERE Name='Victoria')--Doubles rent

		ELSE Bank_Balance + (SELECT Cost FROM Property WHERE Name='Victoria')
	END
WHERE ID = (SELECT Owner_ID FROM Property WHERE Name='Victoria'); -- only considers not null ownwer ID


--If property is unowned then make Jane the ownwer of AMBS
UPDATE Property
SET 
	Owner_ID = 3
WHERE Name='Victoria' AND Owner_ID is NULL;
		

--Update Jane's Location  based on die roll=2,owens park to AMBS
UPDATE Player
SET 
	Location_ID = (SELECT l.ID FROM Location l INNER JOIN Property p on l.Property_ID = p.ID WHERE p.Name = 'Victoria' ),
	Bonus_ID = NULL
WHERE ID = 3;
