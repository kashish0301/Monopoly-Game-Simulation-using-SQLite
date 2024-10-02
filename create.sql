-- Create the Token table
CREATE TABLE Token (
	ID INTEGER PRIMARY KEY,
	Name VARCHAR(30) NOT NULL UNIQUE
);

-- Create the Property table
CREATE TABLE Property (
	ID INTEGER PRIMARY KEY,
	Name VARCHAR(30) NOT NULL UNIQUE,
	Cost INTEGER NOT NULL,
	Color VARCHAR(30) NOT NULL,
	Owner_ID INTEGER,
	FOREIGN KEY (Owner_ID) REFERENCES Player(ID)
);

-- Create the Bonus table
CREATE TABLE Bonus (
	ID INTEGER PRIMARY KEY,
	Name VARCHAR(30) NOT NULL UNIQUE,
	Description VARCHAR(30) NOT NULL
);

-- Create the Location table
CREATE TABLE Location (
	ID INTEGER PRIMARY KEY AUTOINCREMENT,
	Location_type VARCHAR(30) NOT NULL,
	Bonus_ID INTEGER,
	Property_ID INTEGER,
	FOREIGN KEY (Bonus_ID) REFERENCES Bonus(ID),
	FOREIGN KEY (Property_ID) REFERENCES Property(ID)
);


-- Create the Player table
CREATE TABLE Player (
	ID INTEGER PRIMARY KEY,
	Name VARCHAR(30) NOT NULL UNIQUE,
	Token_ID INTEGER,
	Bank_Balance INTEGER,
	Location_ID INTEGER,
	Bonus_ID INTEGER,
	FOREIGN KEY (Token_ID) REFERENCES Token(ID),
	FOREIGN KEY (Location_ID) REFERENCES Location(ID),
	FOREIGN KEY (Bonus_ID) REFERENCES Bonus(ID)
);

-- Create the Audit_Trail table
CREATE TABLE Audit_Trail (
	Player_ID INTEGER NOT NULL,
	Location_ID INTEGER NOT NULL,
	Current_Bank_Balance INTEGER NOT NULL,
	Number_of_Game_Rounds INTEGER NOT NULL,
	FOREIGN KEY (Player_ID) REFERENCES Player(ID),
	PRIMARY KEY (Player_ID, Number_of_Game_Rounds)
);
