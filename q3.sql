--G3 Mary(1) rolls a 4
-- Mary will go from Free parking to "Go to Jail"

--USE the existing trigger to update audittrail



UPDATE Player 
SET Location_ID = (SELECT l.ID FROM Location l INNER JOIN Bonus b on l.Bonus_ID = b.ID WHERE b.Name = "Go to Jail" ),
	Bonus_ID = (SELECT b.ID FROM Bonus b WHERE b.Name= "Go to Jail")
WHERE ID = 1;

