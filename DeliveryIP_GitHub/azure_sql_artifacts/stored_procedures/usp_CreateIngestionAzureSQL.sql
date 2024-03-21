CREATE OR ALTER PROCEDURE [dbo].[usp_CreateIngestionAzureSQL]
@body nvarchar(max)
AS
BEGIN

INSERT INTO [dbo].[ControlTable] (
	 SourceObjectSettings
	,SourceConnectionSettingsName
	,CopySourceSettings
	,SinkObjectSettings
	,SinkConnectionSettingsName
	,CopySinkSettings
	,CopyActivitySettings
	,TopLevelPipelineName
	,TriggerName
	,DataLoadingBehaviorSettings
	,TaskId
	,CopyEnabled
	,DataContract
	,PurviewScanEnabled
)
VALUES (
--SourceObjectSettings
'{"schema": "' + JSON_VALUE(@body, '$.Schema') + '","table": "' + JSON_VALUE(@body, '$.Table') + '"},'
--SourceConnectionSettingsName
,''
--CopySourceSettings
,'{"partitionOption": "' + JSON_VALUE(@body, '$."Partition Option"') + '","sqlReaderQuery": "' + JSON_VALUE(@body, '$.Query') + '","partitionLowerBound": "' + JSON_VALUE(@body, '$."Partition Lower Bound"') + '","partitionUpperBound": "' + JSON_VALUE(@body, '$."Partition Upper Bound"') + '","partitionColumnName": "' + JSON_VALUE(@body, '$."Partition Column Name"') + '","partitionNames": "' + JSON_VALUE(@body, '$."Partition Names"') + '"}'
--SinkObjectSettings
,'{"compressionCodec": "' + JSON_VALUE(@body, '$."Compression Codec"') + '","fileName": "' + JSON_VALUE(@body, '$."File Name"') + '","folderPath": "' + JSON_VALUE(@body, '$."Folder Path"') + '","fileSystem": "' + JSON_VALUE(@body, '$."File System"') + '"}'
--SinkConnectionSettingsName
,''
--CopySinkSettings
,''
--CopyActivitySettings
,JSON_VALUE(@body, '$.Translator')
--TopLevelPipelineName
,JSON_VALUE(@body, '$."Top Level PipeLine Name"')
--TriggerName
,JSON_VALUE(@body, '$."Trigger Name"')
--DataLoadingBehaviorSettings
,'{"dataLoadingBehavior": "' + JSON_VALUE(@body, '$."Data Loading Behavior"') + '","watermarkColumnName": "' + JSON_VALUE(@body, '$."Watermark Column Name"') + '","watermarkColumnType": "' + JSON_VALUE(@body, '$."Watermark Column Type"') + '","watermarkColumnStartValue": "' + JSON_VALUE(@body, '$."Watermark Column Start Value"') + '"}'
--TaskId
,0
--CopyEnabled
,1
--DataContract
,'{ "DataContractID": "' + JSON_VALUE(@body,'$.DataContractID') +'"}'
--PurviewScanEnabled
,1
);
END
GO


