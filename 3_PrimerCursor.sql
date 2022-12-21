Clase jueves 20/10

USE [AdventureWorks2017]
GO

DECLARE Empleyee_Cursor CURSOR FOR
	SELECT businessEntityID, JobTitle
	FROM AdventureWorks2017.HumanResources.Employee;
OPEN Empleyee_Cursor;
FETCH NEXT FROM Empleyee_Cursor;
WHILE @@FETCH_STATUS = 0
	BEGIN
		FETCH NEXT FROM Empleyee_Cursor
	END;
CLOSE Empleyee_Cursor;
DEALLOCATE Empleyee_Cursor; 
GO

CREATE OR ALTER	PROC Empleyee_Cursor
AS
	DECLARE Empleyee_Cursor CURSOR FOR
		SELECT businessEntityID, JobTitle
		FROM AdventureWorks2017.HumanResources.Employee;
	OPEN Empleyee_Cursor;
	FETCH NEXT FROM Empleyee_Cursor;
	WHILE @@FETCH_STATUS = 0
		BEGIN
			FETCH NEXT FROM Empleyee_Cursor
	END;
	CLOSE Empleyee_Cursor;
	DEALLOCATE Empleyee_Cursor; 
GO

EXEC Empleyee_Cursor
GO

