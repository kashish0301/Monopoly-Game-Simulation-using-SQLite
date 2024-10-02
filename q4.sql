----G4 Bill(2) rolls a 2
-- Goes from Owens park to AMBS 
--Property - > bill will own AMBS update Property table -- player update(locid, bank,bonus_ID

--USE the existing trigger to update audittrail


--UPDATE Bank_Balance of of Bill(Current player if AMBS is onwed by someone and also check if the owner of AMBS owns all properties of that color (count)
UPDATE Player -- Current player 
SET
	Bank_Balance = 
	CASE	
		WHEN (Select count(*) from Property 
			  WHERE Owner_ID=(SELECT Owner_ID FROM Property WHERE Name='AMBS') 
			  AND Color=( SELECT Color FROM Property WHERE name='AMBS'))
			  = 
			 (SELECT count(*) FROM Property WHERE Color=(SELECT Color FROM Property WHERE Name='AMBS'))
		THEN Bank_Balance - (SELECT Cost*2 FROM Property WHERE Name='AMBS')--Doubles rent
		ELSE Bank_Balance - (SELECT Cost FROM Property WHERE Name='AMBS')  -- This will cover the case if owner_ID is null so it will take only rent
	END
WHERE ID = 2;

-- update owner's bank balance after recieving the rent ( If there is an owner existing)
UPDATE Player -- Current player 
SET
	Bank_Balance = 
	CASE	
		WHEN (Select count(*) from Property 
			  WHERE Owner_ID=(SELECT Owner_ID FROM Property WHERE Name='AMBS') 
			  AND Color=( SELECT Color FROM Property WHERE name='AMBS'))
			  = 
			 (SELECT count(*) FROM Property WHERE Color=(SELECT Color FROM Property WHERE Name='AMBS'))
		THEN Bank_Balance + (SELECT Cost*2 FROM Property WHERE Name='AMBS')--Doubles rent
		--WHEN Owner_ID is NULL 
		--THEN Bank_Balance
		ELSE Bank_Balance + (SELECT Cost FROM Property WHERE Name='AMBS')
	END
WHERE ID = (SELECT Owner_ID FROM Property WHERE Name='AMBS');


--If property is unowned then make bill the ownwer of AMBS
UPDATE Property
SET 
	Owner_ID = 2
WHERE Name='AMBS' AND Owner_ID is NULL;
		

--Update bills Location  based on die roll=2,owens park to AMBS
UPDATE Player
SET 
	Location_ID = (SELECT l.ID FROM Location l INNER JOIN Property p on l.Property_ID = p.ID WHERE p.Name = "AMBS" ),
	Bonus_ID = NULL
WHERE ID = 2;




