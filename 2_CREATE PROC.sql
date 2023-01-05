--Script pasado por oliver / clase 03/10

--SCRIPT BACKUP BD

USE master
GO

DROP PROCEDURE IF EXISTS BACKUP_ALL_DB_PARENTRADA
GO
 
 --crear procedimiento almacenado para backup

CREATE OR ALTER PROC BACKUP_ALL_DB_PARENTRADA
	@path VARCHAR(256)='C:\backup\'
AS
DECLARE
	--@path VARCHAR (256),
	@name VARCHAR(50),
	@fileName VARCHAR(256),
	@fileDate VARCHAR(20),
	@backupCount INT
CREATE TABLE dbo.#tempBackup
(intID INT IDENTITY (1, 1),
Name VARCHAR(200))

--incluir la fecha en el filename

SET @fileDate = CONVERT (VARCHAR(20), GETDATE(), 112)

--incluir fecha y hora en el filename

--SET @fileDate = CONVERT (VARCHAR(20), GETDATE(), 112) + '_' + REPLACE(CONVERT(VARCHAR(20), GETDATE

INSERT INTO dbo.#tempBackup (name)
	SELECT name
	FROM master.dbo.sysdatabases
	WHERE name in ('Northwind','pubs','AdventureWorks2017')
	--la opción contraria seria
	--WHERE name not in ('master','model',''tempdb')  

SELECT TOP 1 @backupCount = intID
FROM dbo.#tempBackup
ORDER BY intID DESC


--Utilidad: solo comprobación Nº backups a realizar

PRINT @backupCount

-----------------CLASE 03/10

IF ((@backupCount IS NOT NULL) AND (@backupCount > 0 ))
BEGIN
	DECLARE @currentBackup INT
	SET @currentBackup = 1
	WHILE (@currentBackup <= @backupCount)
		BEGIN
			SELECT
				@name = name,
				@fileName = @path + name + '_' + @fileDate + '.BAK' --Unique Filename
				FROM dbo.#tempBackup
				WHERE intID = @currentBackup


				--Utilidad: solo comprobación nombre backup
				PRINT @fileName
					
					--does not overwrite the existing file
					BACKUP DATABASE @name TO DISK = @fileName
					--overwrites the existing file (note: remove @fileDate from the fileName source
					--BACKUP DATABASE @name TO DISK = @fileName WITH INIT

					SET @currentBackup = @currentBackup +1 
		END
END



GO







--ejecutar procedimiento 

--parametro de entrada ruta de la carpeta donde se hará el backup

EXEC BACKUP_ALL_DB_PARENTRADA 'C:\backup\'
GO


--(2 rows affected)
--2
--C:\backup\Northwind_20221003.BAK
--Processed 856 pages for database 'Northwind', file 'Northwind' on file 1.
--Processed 1 pages for database 'Northwind', file 'Northwind_log' on file 1.
--BACKUP DATABASE successfully processed 857 pages in 0.156 seconds (42.877 MB/sec).
--C:\backup\pubs_20221003.BAK
--Processed 608 pages for database 'pubs', file 'pubs' on file 1.
--Processed 1 pages for database 'pubs', file 'pubs_log' on file 1.
--BACKUP DATABASE successfully processed 609 pages in 0.113 seconds (42.048 MB/sec).

--Completion time: 2022-10-03T20:18:41.5227182+02:00


--Utilidad: solo comprobacion mirar panel de resultados autonuerico y nombre BD
SELECT  * FROM dbo.#tempBackup
DROP TABLE dbo.#tempBackup
GO