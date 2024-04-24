CREATE OR ALTER PROCEDURE [dbo].[usp_InsertDataContract]
    @jsonData nvarchar(MAX)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @createdOnDate datetime2 = GETUTCDATE();
    DECLARE @active bit = 0; -- 0 = Inactive, 1 = Active
    DECLARE @activeDate datetime2 = GETUTCDATE();
--Check if there is an active contract for the given ContractID
    IF EXISTS (
        SELECT 1
        FROM DataContract
        WHERE ContractID = (SELECT ContractID FROM OPENJSON(@jsonData) WITH (ContractID nvarchar(255) '$.ContractID'))
            AND Active = 1
    )
UPDATE [dbo].[DataContract]
SET Active = 0,
    InactiveDate = GETUTCDATE(),
    EditedBy = (SELECT EditedBy FROM OPENJSON(@jsonData) WITH (EditedBy nvarchar(255) '$.EditedBy')),
    EditedByEmail = (SELECT EditedByEmail FROM OPENJSON(@jsonData) WITH (EditedByEmail nvarchar(500) '$.EditedByEmail')),
    EditedByUPN = (SELECT EditedByUPN FROM OPENJSON(@jsonData) WITH (EditedByUPN nvarchar(255) '$.EditedByUPN')),
    EditedById = (SELECT EditedById FROM OPENJSON(@jsonData) WITH ([EditedById] nvarchar(255) '$.EditedById'))
FROM OPENJSON(@jsonData)
WITH (
    EditedBy nvarchar(255) '$.EditedBy',
    EditedByEmail nvarchar(500) '$.EditedByEmail',
    EditedByUPN nvarchar(255) '$.EditedByUPN',
    [EditedById] nvarchar(255) '$.EditedById'
)
WHERE ContractID = (SELECT ContractID FROM OPENJSON(@jsonData) WITH (ContractID nvarchar(255) '$.ContractID'));

    INSERT INTO DataContract (
        ContractID,
        SubjectArea,
        SourceSystem,
        PublisherName,
        DataSourceNameSystem,
        DataSourceNameFriendly,
        [Description],
        BusinessContact,
        BusinessContactEmail,
        BusinessContactUPN,
        BusinessContactObjID,
        EngineeringContact,
        EngineeringContactEmail,
        EngineeringContactUPN,
        EngineeringContactObjID,
        DataOwner,
        DataOwnerEmail,
        DataOwnerUPN,
        DataOwnerObjID,
        SME,
		Pattern,
        Restrictions,
        Metadata,
        DataClassificationLevel,
        CreatedBy,
        CreatedByEmail,
        CreatedByUPN,
        [CreatedById],
        CreatedOnDate,
        Active,
        ActiveDate,
        InactiveDate,
		[DataAssetTechnicalInformation]
    )
    SELECT 
        ContractID,
        SubjectArea,
        SourceSystem,
        PublisherName,
        DataSourceNameSystem,
        DataSourceNameFriendly,
        [Description],
        BusinessContact,
        BusinessContactEmail,
        BusinessContactUPN,
        BusinessContactObjID,
        EngineeringContact,
        EngineeringContactEmail,
        EngineeringContactUPN,
        EngineeringContactObjID,
        DataOwner,
        DataOwnerEmail,
        DataOwnerUPN,
        DataOwnerObjID,
        SME,
		Pattern,
        Restrictions,
        Metadata,
        DataClassificationLevel,
        CreatedBy,
        CreatedByEmail,
        CreatedByUPN,
        [CreatedById],
        @createdOnDate,
        1,
        @activeDate,
        '9999-12-31',
		[DataAssetTechnicalInformation]
        
    FROM OPENJSON(@jsonData)
    WITH (
        ContractID nvarchar(255) '$.ContractID',
        SubjectArea nvarchar(255) '$.SubjectArea',
        SourceSystem nvarchar(255) '$.SourceSystem',
        PublisherName nvarchar(255) '$.PublisherName',
        DataSourceNameSystem nvarchar(255) '$.DataSourceNameSystem',
        DataSourceNameFriendly nvarchar(255) '$.DataSourceNameFriendly',
        DataSetNameSystem nvarchar(255) '$.DataSetNameSystem',
        DataSetNameFriendly nvarchar(255) '$.DataSetNameFriendly',        
        [Description] nvarchar(255) '$.Description',
        BusinessContact nvarchar(255)  '$.BusinessContact',
        BusinessContactEmail nvarchar(500) '$.BusinessContactEmail',
        BusinessContactUPN nvarchar(255) '$.BusinessContactUPN',
        BusinessContactObjID nvarchar(255) '$.BusinessContactObjID',
        EngineeringContact nvarchar(255) '$.EngineeringContact',
        EngineeringContactEmail nvarchar(500) '$.EngineeringContactEmail',
        EngineeringContactUPN nvarchar(255) '$.EngineeringContactUPN',
        EngineeringContactObjID nvarchar(255) '$.EngineeringContactObjID',
        DataOwner nvarchar(255) '$.DataOwner',
        DataOwnerEmail nvarchar(500) '$.DataOwnerEmail',
        DataOwnerUPN nvarchar(255) '$.DataOwnerUPN',
        DataOwnerObjID nvarchar(255) '$.DataOwnerObjID',
        --SME nvarchar(max) as JSON,
	SME nvarchar(max) '$.SME',  
	Pattern nvarchar(255) '$.Pattern',
        [Format] nvarchar(255) '$.Format',
        Delimiter nvarchar(255) '$.Delimiter',
        Restrictions nvarchar(255) '$.Restrictions',
        Metadata nvarchar(255) '$.Metadata',
        DataClassificationLevel nvarchar(255) '$.DataClassificationLevel',
		CreatedBy nvarchar(255) '$.CreatedBy',
		CreatedByEmail nvarchar(500) '$.CreatedByEmail',
		CreatedByUPN nvarchar(255) '$.CreatedByUPN',
		[CreatedById] nvarchar(255) '$.CreatedById',
		DataAssetTechnicalInformation nvarchar(max) '$.DataAssetTechnicalInformation' AS JSON
    );

    ---------------------Handshake entry for background when data contact submit----------------------------

    DECLARE @ContractID VARCHAR(36)
    SELECT @ContractID = ContractID
    FROM OPENJSON(@jsonData)
    WITH (
         ContractID nvarchar(255) '$.ContractID'
    );

	declare @SourceTechnicalInformation nvarchar(1000),@Pattern nvarchar(500),@IngestionSchedule nvarchar(1000)
	
	set @IngestionSchedule= '[{"IngesionScheduleFrequencyRecurrenceValue":null,"IngestionSceheduleTriggerName":null,"IngestionSchedule":false,"IngestionScheduleFrequencyRecurrence":null,"IngestionScheduleRunOnSubmit":false,"IngestionScheduleStartDate":null,"IngestionScheduleStartTime":null}]'

	select @Pattern=Pattern from DataContract where ContractID=@ContractID and Active = 1
	
	if @Pattern = 'Delimited Text'
	begin

		 set @SourceTechnicalInformation='[{"label":"Source Container","value":"landing"},{"label":"Sink Container","value":"raw"},{"label":"Stored Procedure Name","value":"usp_CreateIngestionDelimited"},{"label":"Trigger Name","value":"[TR_blobCreatedEvent]"},{"label":"Top Level PipeLine Name","value":"PL_2_Process_Landed_Files_Step2"},{"label":"Data Loading Behavior","value":"{\"dataLoadingBehavior\": \"Copy_to_Raw\", \"loadType\": \"full\"}"}]'
	end
	else
	begin
		 set @SourceTechnicalInformation='[{"label":"Source Container","value":"landing"},{"label":"Sink Container","value":"raw"},{"label":"Stored Procedure Name","value":"usp_CreateIngestionJSON"},{"label":"Trigger Name","value":"[TR_blobCreatedEvent]"},{"label":"Top Level PipeLine Name","value":"PL_2_Process_Landed_Files_Step2"},{"label":"Data Loading Behavior","value":"{\"dataLoadingBehavior\": \"Copy_to_Raw\", \"loadType\": \"full\"}"}]'
		
	end

    IF EXISTS (SELECT 1 FROM [dbo].[Handshake] WHERE [DataContractID] = @ContractID)	
    BEGIN
		 UPDATE HS SET 
				HS.DataSourceName = DC.DataSourceNameSystem,
				HS.Publisher =DC.PublisherName,           
				HS.EditedByDate = GETDATE(),
				HS.DataAssetTechnicalInformation = DC.DataAssetTechnicalInformation,
				HS.SourceTechnicalInformation = @SourceTechnicalInformation,
				HS.ConnectionType = DC.Pattern,            
				HS.dynamicSinkPath = DC.SubjectArea  + '/' + DC.DataSourceNameSystem + '/',
				HS.SourceFolderPath = DataSourceNameFriendly + '/'
			FROM [dbo].[Handshake] HS
			INNER JOIN DataContract DC ON  HS.DataContractID = DC.ContractID			
			WHERE  HS.DataContractID = @ContractID 
  end
  else
  begin
		
	 INSERT INTO [dbo].[Handshake] (
            [DataSourceName],
            [Publisher],
            [CreatedBy],
            [CreatedByDate],            
            [Active],
            [ActiveDate],          
            [DataAssetTechnicalInformation],
            [SourceTechnicalInformation],
            [ConnectionType],
            [IngestionSchedule],
			[dynamicSinkPath],
			[SourceFolderPath],
			[DataContractID]
        )
		select  DataSourceNameSystem,PublisherName,CreatedBy,CreatedOnDate,Active,
		ActiveDate,DataAssetTechnicalInformation,@SourceTechnicalInformation,
		@Pattern,@IngestionSchedule,
		SubjectArea + '/' + DataSourceNameSystem + '/',
		DataSourceNameFriendly + '/',
		ContractID


		
		
		from DataContract 
		
		where ContractID=@ContractID and Active = 1


  end



END;
GO