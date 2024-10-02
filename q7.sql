--G7 Mary(1) rolls a 6, and then a 5
-- Mary moves 11 steps (no changes on roll 6)
--Next 5 steps:  From current location(Go to Jail) She lands on Oak House (Orange),
-- She will pay double rent to Ownwer:Norman as norman owns all properties of orange color
-- which implies that the player will pay double rent to owner. Player Mary pays 100*2=200 to Norman

--USE the existing trigger to update audittrail


--UPDATE Bank_Balance of of Mary(Current player if AMBS is onwed by someone and also check if the owner of Oak House owns all properties of that color (count)
UPDATE Player -- Current player 
SET
	Bank_Balance = 
	CASE	
	
		WHEN (Select count(*) from Property 
			  WHERE Owner_ID=(SELECT Owner_ID FROM Property WHERE Name='Oak House') 
			  AND Color=( SELECT Color FROM Property WHERE name='Oak House'))
			  = 
			 (SELECT count(*) FROM Property WHERE Color=(SELECT Color FROM Property WHERE Name='Oak House'))
		THEN Bank_Balance - (SELECT Cost*2 FROM Property WHERE Name='Oak House')--Doubles rent
		ELSE Bank_Balance - (SELECT Cost FROM Property WHERE Name='Oak House')  -- This will cover the case if owner_ID is null so it will take only rent
	END
WHERE ID = 1;

-- update owner's bank balance after recieving the rent ( If there is an owner existing)
UPDATE Player -- Owner  
SET
	Bank_Balance = 
	CASE	
		WHEN (Select count(*) from Property 
			  WHERE Owner_ID=(SELECT Owner_ID FROM Property WHERE Name='Oak House') 
			  AND Color=( SELECT Color FROM Property WHERE name='Oak House'))
			  = 
			 (SELECT count(*) FROM Property WHERE Color=(SELECT Color FROM Property WHERE Name='Oak House'))
		THEN Bank_Balance + (SELECT Cost*2 FROM Property WHERE Name='Oak House')--Doubles rent

		ELSE Bank_Balance + (SELECT Cost FROM Property WHERE Name='Oak House')
	END
WHERE ID = (SELECT Owner_ID FROM Property WHERE Name='Oak House'); -- only considers not null ownwer ID


--If property is unowned then make Mary the ownwer of Oak House
UPDATE Property
SET 
	Owner_ID = 1
WHERE Name='Oak House' AND Owner_ID is NULL;
		

--Update Mary's Location  based on die roll=2,Go to jail to Oak House
UPDATE Player
SET 
	Location_ID = (SELECT l.ID FROM Location l INNER JOIN Property p on l.Property_ID = p.ID WHERE p.Name = 'Oak House' ),
	Bonus_ID = NULL
WHERE ID = 1;



