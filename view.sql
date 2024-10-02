-- This is our Leaderboard - gameView
-- Create a view to display leaderboard status at any given point of the game.

DROP VIEW IF EXISTS gameView;

CREATE VIEW gameView AS
SELECT
	p.Name AS Player_Name,
    l.Location_type AS Location_Type,
	prop1.Name AS Property_Name,
	b.Name AS Bonus_Name,
	p.Bank_Balance,
    GROUP_CONCAT(prop2.Name, ', ') AS Properties_Owned,
	a.Max_Game_Round AS Game_Round
FROM Player p
JOIN Location l ON p.Location_ID = l.ID
LEFT JOIN Property prop1 ON l.Property_ID = prop1.ID
LEFT JOIN Property prop2 ON p.ID = prop2.Owner_ID
LEFT JOIN Bonus b on p.Bonus_ID = b.ID
LEFT JOIN (
    SELECT Player_ID, MAX(Number_of_Game_Rounds) AS Max_Game_Round
    FROM Audit_Trail
    GROUP BY Player_ID
) a ON p.ID = a.Player_ID
GROUP BY p.ID
ORDER BY p.Bank_Balance DESC;


SELECT * FROM gameView;