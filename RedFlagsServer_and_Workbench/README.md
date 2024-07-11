# ACTS Red Flags Server and Excel Workbench Add-in

Two capabilities are available to users of the Accelerator software: (1) the Red Flags Server and (2) the Red Flags Excel Workbench Add-in. The ACTS Red Flags Server is an Azure service that enables you to define critical risk signals to monitor and maintain a database of red flags that occur based on taxpayer data. The Red Flags Excel Workbench Add-in is applies the [HMX.ai CRex Add-in for Excel](https://appsource.microsoft.com/en-us/product/office/WA200005695?tab=Overview). Red Flags Add-in for Excel is free to download from Microsoft AppSource. Both the Red Flags Server and Excel Workbench have the following key features:

- **Goal-Oriented** - Define tax authority goals most relevant to managing compliance and transparency.
- **Situation-Centric** - Define the critical situations that a tax authority wants to uncover and track to determine the best actions to take.
- **Cognitive Maps** - Organize goals and situations in a graphical 'Cognitive Map' that represents tax authority compliance management plans.
- **Simulation Scenarios** - Run simulations for what-if scenarios and fine-tune the tax authority compliance management plans.
- **CoPilot Integration** - Investigate how decisions impact organizational goal achievement and situational awareness with natural language Q&A.

## Red Flags Server

The following are prerequisites for deploying the Red Flags Server:

- A GitHub account into which this repository has been cloned.
A Microsoft Azure subscription
- An Azure DevOps subscription - see [Sign up for Azure DevOps](https://learn.microsoft.com/en-us/azure/devops/user-guide/sign-up-invite-teammates) for information on setting up an Azure DevOps account. You must create a resource group into which the Red Flags Server resources will be deployed.
- An understanding of Azure DevOps including configuring and creating Azure DevOps pipelines - see the [Azure Pipelines documentation](https://learn.microsoft.com/en-us/azure/devops/pipelines/?view=azure-devops) for complete information on this topic.

### Configuration and Deployment

The Red Flags Server does not require configurations, though users may inspect and edit the provided YAML files to understand the deployment steps and makes adjustments if required. To create the required resources and deploy the Red Flags Server, follow these steps:

1. Log into the Azure DevOps portal and in the palette select 'Pipelines' to display Pipelines list, which will be empty if no pipelines have been previously created.

![DevOpsPipelineList](./images/DevOpsPipelineList.png)

2. Select 'New pipeline' at the top right to display the 'Where is your code' dialog.

3. In the 'Where is your code' dialog, select GitHub and follow the steps to log into your (cloned) repository. The first time you will need to allow connection of Azure DevOps to your GitHub account and this will require your GitHub account administrator's approval. Once connected to GitHub, you can click on GitHub to display the 'Select a repository' dialog.

![WhereIsYourCode](./images/WhereIsYourCode.png)

4. In the 'Select a repository' dialog, choose your repository to display the 'Configure your pipeline' dialog. Select 'Existing Azure Pipelines YAML file' at the bottom of the list to display the 'Select and existing YAML file' pop-up dialog. The YAML file for this deployment is stored in the `RedFlagsServer_and_Workbench\DevOps` folder of this repository. Select 'main' from the Branch drop-down list and the 'deploy-all.yml' YAML file in the Path drop-down list, then click 'Continue'.

![ConfigureYourPipeline](./images/ConfigureYourPipeline.png)

![SelectYAMLFile](./images/SelectYAMLFile.png)

5. In the 'Review your pipeline YAML' dialog, you can inspect the pipeline code; however, for successful functional testing, do not alter this file. Select Run at top right to start the deployment; however, the resource group name you created in the target Azure subscription is not set in the YAML file, so an Error will be displayed. To provide the resource group name, click the 'Run new' button at top right, and in the 'Run pipeline' dialog enter the Resource Group Name that you created (the Branch/tag should already be set appropriately). Click the Run button to start the deployment.

![ReviewPipelineYAML](./images/ReviewPipelineYAML.png)

![RunNew](./images/RunNew.png)

![ResourceGroupRun](./images/ResourceGroupRun.png)

6. The first time a pipeline is created it is necessary to permit a connection to the specified Azure subscription. clicking the Run button in the last step will display a dialog for monitoring the deployment steps; however, the state of the 'Deploy resources' will be 'Not started'. Click on the Deploy Resources step, then in the 'Deploy Resources' dialog select the View button in the pop-up dialog select 'Permit' to enable the connection. In the Pipelines list, confirm that the pipeline is in a running state.

![RunNotStarted](./images/RunNotStated.png)

![PermitAccess](./images/PermitAccesspng.png)

![AccessProvided](./images/AccessProvided.png)

The YAML file will now run and create all required resources, set the needed configurations, and deploy Red Flags Server application.

### Functional Test
(An easy way to test and confirm operation of the Red Flags Server)

## Red Flags Workbench Excel Add-in

## Prerequisites

- Microsoft 365 subscription
- Internet access
- Access with appropriate credentials to your data sources

## Getting Started

The Workbench uses the familiar capabilities of Excel to simplify creation and management of red flags. The Red Flags Workbench Excel file provided in this repository includes example data tables created from public data sources. You can use this workbook to become familiar with the Workbench Add-in capabilities. You can also create and manage your own red flags using data that you add to Excel by following the steps below.

1.Download the 'Red Flags Workbench - VAT Tax.xlsx' Excel Workbook provided in this repository folder and open the file within Excel.

![Red Flags Workbench - VAT Tax.xlsx](./images/Picture1.png)

2.Obtain the HMX.ai CRex Add-in for Excel from the Excel 'File-Get Add-ins' menu item.

![Red Flags Workbench Add-in](./images/Picture2.png)

    - Search AppSource for 'HMX' then click Add next to 'CRex Add-in for Excel'.
    - Click the 'HMX CRex' button on the right-hand side of the Excel Home ribbon to open the Add-in.
3.Organize your data in Excel tables.

![Red Flags Workbench Excel Tables](./images/Picture3.png)

    - You can use any data, organized in Excel Tables.
    - To add your own data, use Excel's Data ribbon to get the data you want to analyze and copy it to an Excel worksheet. 
    - Each table is a Key Entity in your analysis. Key Entities are what you’re monitoring to achieve your goals. For example, taxpayers, invoices, etc.
4.Create a Cognitive Map.
    - On the Add-in landing pane, Click **+** (see figure above) to build your own Cognitive Map.  A Cognitive Map contains the goals you wish to achieve, and the situations that impact them.
5.Create your Cognitive Map as a tree view of your Goals and the important Situations that impact each Goal.

![Red Flags Workbench Cognitive Map](./images/Picture4.png)

    - **Goals** are objectives you want to achieve, like ensuring customer satisfaction, procurement integrity, or maximum ROI.
    - **Situations** are the Red Flags (these are used as synonyms below), the conditions that impact achievement of your goals, like compliance red flags.
    - **Key Entities** are contained in the Excel tables you inserted into your workbook. They are what you’re monitoring to achieve goals. For example, taxpayers, or invoices. Red Flag are always associated with your key entities, for example, late tax filing is a red flag associated with taxpayer key entities.
    - **Goal Impact** measures the favorable or negative impact of a red flag when it is present. A positive Goal Impact indicates a favorable or desirable "review" or "green flag". A negative Goal Impact indicates an adverse or undesired red flag.
6.Define how you assess whether a red flag is present, based on your data, by entering an Excel formula for each red flag Assessor.

![Red Flags Workbench Assessor](./images/Picture5.png)

    - To Enter a red flag Assessor, click the ***f*x** button in the Situation Specification section. This will display the Situation Assessor Editor and Formula Bulder.
        - A Assessor evaluates the presence or absence of the flag.
        - Build your formula in chunks, connected by AND or OR.
        - Use the radio buttons just above the text boxes to specify what you want to enter:
            - **R** = a cell reference for example, Customer!B2
            - **C** = an table structured reference for example, TaxPayer[VATGap]
            - **F** = an Excel formula for example, 0.3 * TaxPayer[Revenue]
            - **V** = a value for example, “active”, 12.3, or “5/2/2023 12:00:00 AM”
        - Select an operator from the center drop-down menu.
        - Use the AND/OR drop down to build the complete formula.

        The Add-in will automatically translate the information you entered to a valid Excel formula shown in the Assessor Formula text box.

    - Enter a Formula Description to describe how the flag is assessed.
7.Now that you have entered Excel data tables and have a Cognitive Map of Goals and Red Flag Situations with Assessors, you can run what-if simulations to see what red flags are present and how they impact Goal achievement.

![Red Flags Workbench Scenarios](./images/Picture6.png)

    - At the top of the Add-in click the Scenarios button to move to the Scenario Simulation pane.
    - Create a Scenario by clicking the **+** button and entering a name for your Scenario.
    - Click the Run button to start a simulation.

    During a simulation, the Add-in assesses each of the red flags you defined for the data you have provided. The Add-in automatically evaluates Goal Achievement based on whether flags are present. Adverse or red flags reduce Goal Achievement while Favorable or green flags increase Goal Achievement.
8.Run and review reports and locate the data causig the presence of a red flag.

![Red Flags Workbench Reports](./images/Picture7.png)

    - The Workbench Add-in creates 3 different reports that you can review including:  
        - ***SitRep*** (Red Flags Situation summary) with each red flag organized by count (the number of red flags present), key entity, and goal impact.
        - ***Goal Satisfaction*** goal satisfaction as a percent for each goal.
        - ***Goal Impact*** the impact of each red flag by each goal.

![Red Flags Workbench Reports](./images/Picture8.png)

    - Click on the Goals & Situations button at the top of any Workbench Add-in pane and scroll down to the Cognitive Map. The red notiifcation badges indicate the number of flags present for each of the specified flag situations (recall that they can be either red or green flags).
    - Click on a flag badge that displays a non-zero value. A list will be displayed where each item is one of the Key Entities, for example a taxpayer or invoice, for which the flag was assessed to be present. 
    - Click on any item in the displayed list and the focus will shift to the row in the Key Entity table containing the data that caused the flag to be assessed as present. You can then examine these data to understand the cause of the flag.
9.Use OpenAI to obtain explanations of your Red Flag Situation definitions.

![Red Flags Workbench Badges](./images/Picture9.png)

    - In the Cognitive Map display, mouse over the red flag and select the information ***i*** icon. This will display the red flag formula you entered together with an explanation in natural language.
