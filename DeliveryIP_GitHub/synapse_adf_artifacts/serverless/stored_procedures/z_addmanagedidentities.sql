--for cicd
IF NOT EXISTS(SELECT * FROM sys.database_principals WHERE name = 'insert_service_principal_name')
  BEGIN
    CREATE LOGIN [insert_service_principal_name] FROM EXTERNAL PROVIDER;

    CREATE USER [insert_service_principal_name] FROM EXTERNAL PROVIDER;
  END

ALTER ROLE db_owner ADD MEMBER [insert_service_principal_name];

IF NOT EXISTS(SELECT * FROM sys.database_principals WHERE name = 'insert_logicapp_name')
  BEGIN
    CREATE LOGIN [insert_logicapp_name] FROM EXTERNAL PROVIDER;

    CREATE USER [insert_logicapp_name] FROM EXTERNAL PROVIDER;
  END

IF NOT EXISTS(SELECT * FROM sys.database_principals WHERE name = 'insert_synapse_name')
  BEGIN
    CREATE USER [insert_synapse_name] FOR LOGIN [insert_synapse_name];
  END

ALTER ROLE db_owner ADD MEMBER [insert_synapse_name]; 
ALTER ROLE db_owner ADD MEMBER [insert_logicapp_name];

GO

/****** Object:  StoredProcedure [dbo].[schemaDynamic]    Script Date: 4/5/2023 1:00:13 PM ******/
/****** This is necessary in the compute SYNAPSE wtihin the StoredProcDB ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER PROCEDURE [dbo].[schemaDynamic]
@fileType NVARCHAR(25), @filePath NVARCHAR (1000)
AS
BEGIN
DECLARE @SQLStr nvarchar(max)
IF @fileType = 'PARQUET'
    BEGIN
SET @SQLStr = 
            N'SELECT TOP 1 *																				'+
            N'FROM OPENROWSET(BULK ''https://storageAccountName.dfs.core.windows.net'+ @filePath +''',	'+
            N'FORMAT = '''+ @fileType +'''                                                                  '+
            N') AS [result]';
    END
ELSE IF @fileType = 'CSV'
    BEGIN
    SET @SQLStr = 
            N'SELECT TOP 1 *                                                                                   '+
            N'FROM OPENROWSET(BULK ''https://storageAccountName.dfs.core.windows.net'+ @filePath +''',       '+
            N'FORMAT = '''+ @fileType +''',                                                                    '+
            N'HEADER_ROW = true,                                                                               '+
            N'PARSER_VERSION = ''2.0''                                                                         '+
            N') AS [result]';
    END
PRINT @SQLStr
EXEC sp_describe_first_result_set @tsql = @SQLStr
END;
GO