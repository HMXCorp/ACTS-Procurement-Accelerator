-- create/alter DatasetFirstLoadCheck stored procedure
-- check if landing data is being loaded for the first time 
CREATE OR ALTER PROCEDURE [dbo].[DatasetFirstLoadCheck]
(
	-- control table record id parameter 
	@control_table_record_id int
)
AS
BEGIN

-- variable for loading status of dataset
-- default value is Yes
DECLARE @firstLoad nvarchar(255) = 'Yes'
-- variable for control table record id query result for already ingested data
DECLARE @control_table_record_id_query int

-- checks if the ingested landing data has already been processed and loaded by the control table record id 
-- returns control table record id from ingested landing data using ingestion status 
set @control_table_record_id_query = (
	SELECT		min(control_table_record_id) [control_table_record_id]
	FROM 		[dbo].[IngestedLandingDataAudit]
	WHERE		ingestion_status = 'Processed'
	AND 		control_table_record_id = @control_table_record_id
)

-- if query result and procedure parameter match set @firstload to no 
IF 	@control_table_record_id = @control_table_record_id_query
BEGIN
SET @firstLoad = 'No'
END
-- default @firstload is kept as yes 
SELECT	@firstLoad [firstLoad]
RETURN
END
GO