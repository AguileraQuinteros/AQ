USE [AdventureWorks2017]
GO
--1
DECLARE Empleyee_Cursor CURSOR FOR
	SELECT businessEntityID JobTitle
	FROM AdventureWorks2017.HumanResources.Employee;
OPEN Empleyee_Cursor;
FETCH NEXT FROM Empleyee_Cursor;
WHILE @@FETCH_STATUS = 0
	BEGIN
		FETCH NEXT FROM Empleyee_Cursor
	END;
CLOSE Empleyee_Cursor;
DEALLOCATE Empleyee_Cursor; 