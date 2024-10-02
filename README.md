
# Monopoly Game Simulation using SQLite

## Project Overview
This project involves creating a Monopoly game simulation with an automated gameplay system, utilizing SQLite as the primary database. The project aims to model the Monopoly game and store essential gameplay data in a relational database for better insights and automation.

## Files Included:
- **Monopoly_Report_11356488.pdf**: A detailed report outlining the objectives, methodology, and results of the project.
- **README.md**: Instructions and details about the project.
- **create.sql**: SQL script to create the necessary tables for storing Monopoly game data.
- **populate.sql**: SQL script to populate the database with initial data (players, properties, etc.).
- **monopolyChecker.py**: A Python script responsible for checking the game status and handling rules validation during gameplay.
- **q1.sql - q8.sql**: Various SQL queries used in the project for different functionalities, such as fetching game statistics, player progress, or property ownership.
- **view.sql**: SQL script for creating views to simplify querying data from the Monopoly game tables.

## How to Run:
1. **Set up the database**: Run the `create.sql` script to create the necessary tables.
2. **Populate the database**: Use `populate.sql` to insert the initial data.
3. **Run the game**: Execute `monopolyChecker.py` to start the simulation and monitor the game's progress.
4. **Query game data**: Use the SQL query files (e.g., `q1.sql`, `q2.sql`) to extract insights and game details during or after the simulation.

## Additional Notes:
- Ensure that Python and SQLite are installed on your system.
- Modify `monopolyChecker.py` as needed to adjust game rules or settings.
- Detailed project explanation can be found in the provided report.
