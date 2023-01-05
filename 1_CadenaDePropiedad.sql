--Clase viernes 16/09
--1
--2

DROP DATABASE IF EXISTS testDB;
GO
CREATE DATABASE testDB;
GO

USE testDB;
GO 

DROP SCHEMA IF EXISTS HR;
GO

CREATE SCHEMA HR; 
GO

--/////CLASE lunes 19/09

DROP TABLE IF EXISTS HR.Employee; 
GO

CREATE TABLE HR.Employee 
(
	EmployeeID CHAR(2),
	GivenName VARCHAR(50),
	Surname VARCHAR(50),
	SSN CHAR(9)
);
GO

--Importacion txt a HR.Employee

--EmployeeID, GivenName, Surname, SSN
--1,		Luis,	Arias, 	111
--2,		Ana, 	Gomez, 	222
--3,		Juan, 	Perez,	333

--------------------------------------------------
 -- Crear una vista

DROP VIEW IF EXISTS HR.LookupEmployee; 
GO
CREATE VIEW HR.LookupEmployee    
AS
	SELECT EmployeeID, GivenName, Surname
	FROM HR.Employee;
GO

DROP ROLE IF EXISTS HumanResourcesAnalyst;
GO

CREATE ROLE HumanResourcesAnalyst;
GO

GRANT SELECT ON HR.LookupEmployee TO HumanResourcesAnalyst;    
GO
    
DROP USER IF EXISTS JaneDoe
GO 

CREATE USER JaneDoe WITHOUT LOGIN;
GO

ALTER ROLE HumanResourcesAnalyst
ADD MEMBER JaneDoe; 
GO

--Impersono
EXECUTE AS USER = 'JaneDoe';
GO

SELECT * FROM HR.LookupEmployee;
GO

PRINT USER 
GO

--Comprueba que no deja hacer un select
SELECT * FROM HR.Employee;
GO

REVERT;
GO

PRINT USER 
GO

------------CLASE jueves 22/09

---STORED PROCEDURE

CREATE OR ALTER PROC HR.InsertNewEmployee
 @EmployeeID INT,
 @gIVENnAME VARCHAR(50),
 @sURNAME VARCHAR(50),
 @SSN CHAR(9)
AS
BEGIN
	INSERT INTO HR.Employee   
	(EmployeeID, GivenName,Surname,SSN)
	VALUES
	(@EmployeeID, @GivenName, @Surname, @SSN);
END;
GO     

CREATE ROLE HumanResourcesRecruiter;
GO

GRANT EXECUTE ON SCHEMA:: HR TO HumanResourcesRecruiter;  
GO

CREATE USER Cesar WITHOUT LOGIN;
GO

ALTER ROLE HumanResourcesRecruiter
ADD MEMBER Cesar;
GO

EXECUTE AS USER = 'Cesar';
GO 

PRINT USER

REVERT

EXEC HR.InsertNewEmployee
	@EmployeeID = 4,
	@gIVENnAME = 'Jesica',
	@sURNAME = 'Quinteros',
	@SSN = '444';
GO

INSERT INTO HR.Employee
   ( EmployeeID, GivenName, Surname, SSN )
   -- (GivenName, Surname, SSN ) con IDENTITY
   VALUES
   (4, 'Fernando', 'Carro', '555' );
GO 

REVERT
GO