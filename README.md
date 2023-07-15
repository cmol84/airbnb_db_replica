# Build a DATA MART in SQL
### UPS10614033 DLBDSPBDM01 Building a sample data mart based on the Airbnb use case.

**Table of Contents**

[TOCM]


## Installation
### Support tools
To install the DB, you first need to install an sql client of your choice, however, the recommendation is to use [SQL Workbench](https://dev.mysql.com/downloads/workbench/ "SQL Workbench").

On a Mac? Just execute this in your terminal and everything is fine:
`brew install --cask mysqlworkbench`
Otherwise, just use the link above to get your specific distribution. 


### I provide 2 different ways of creating the database setup

## 1. Automated Database import
To automatically import the database structure and sample data, please follow these steps exactly as described:
- save the file ***db_dump.sql*** to your local directory
- open Mysql Workbench (instructions below valid for version 8.0)
	- on the menu bar, click on "Server" -> "Data Import"
	- select the option "Import from Self-Contained File"
	- in the selection box select the file "db_dump.sql" from the location where you saved it at step 1
	- select the Default Target Schema as "airbnb"
	- make sure under the tables the option "Dump Structure and Data" is selected 
	- press the "Start Import" button

When the import is done, the schema should appear on the left side of the screen in Workbench. 
In an SQL Editor window execute the following sql scripts one by one to verify that the db and data were imported correctly:
	`use airbnb;`
	`select * from Property;`
	`select * from Guest;`

## 2. Manual DB Creation and data insert (advanced users)
### Database creation
- save the file ***DDL.sql*** to your local directory
- open Mysql Workbench (instructions below valid for version 8.0)
	- on the menu bar, click on "File" -> "Open SQL Script"
	- in the selection box select the file "DDL.sql" from the location where you saved it at step 1
	- click the "Open" button and the file should now be open in your Workbench editor
	- Select all the content of the file and execute it
	- The Schema and the tables including the relations and indices should now be created but tables should still contain no data.
	
### Data Generation and insert
- save the file ***data_generator.py*** to your local directory
- open your terminal, navigate to the directory (`cd <your directory>`) where the file is saved and locate the file (`ls -l data_generator.py`)
- execute the script (`python3 data_generator.py`) and it should populate the data to your tables
	- if you have any errors like `import mysql.connector // ModuleNotFoundError: No module named 'mysql'` just use `pip install <missing package>` to make sure everyting is included on execution.
- navigate back to your SQL Workbench and open a new sql 
	- click on "Create new SQL Tab" and execute the following sql scripts one by one to verify that the db and data were imported correctly:
	`use airbnb;`
	`select * from Property;`
	`select * from Guest;`

Now you can test all the DB queries with the provided structure and data. 
Have fun!

### End
