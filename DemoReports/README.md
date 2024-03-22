# Downloading and Using the Procurement and Beneficial Ownership Reports

A set of reports have been created for the ACTS Procurement Accelerator, preloaded with public data that you can view to understand better the kind of information that can be obtained from this procurement solution.

## Introduction

The Enterprise Procurement Model including  red flags database and results of analyses provide a rich set of data for visualization in Power BI. For the Procurement Accelerator, a Beneficial Ownership Engine is included to enable AI-based examination of these data sets to detect relationships between corporate entities, much as a human expert would, using measures of similarity between entity attributes such as addresses, types of businesses, characteristics of businesses, red flags, and other categories. Experts in procurement know these similarties may indicate a relationship of interest. Governmental entities may have their own models that benefit from curated data and analytical results such as red flags and the results of beneficial ownership analyses.

## Prerequisites

- The latest Power BI Desktop application.
  - You can download and install the latest version from [this link](https://powerbi.microsoft.com/en-us/desktop/?WT.mc_id=Blog_Desktop_Update).
- A deployed ACTS Procurement Accelerator.
  - You can start quickly by viewing the provided sample data. When you want to connect to your own data then the Procurement Accelerator must be deployed, the Enterprise Procurement Model populated with data, and output from the Beneficial Ownership Engine must be present in the Consumer Synapse Lake Database.

## Configuration

Follow these steps to download and configure the ACTS Procurement Accelerator reports:

1. Download the Procurement Manager Report Power BI report as a zip file from [this link](https://crexlite.hmx.ai/Procurement_Manager_Report.zip) and unzip the file to a convenient local folder.
2. Open 'Procurement_Manager_Report.pbix' in Power BI Desktop. It's a large set of data so it may take a few minutes to load.

You can examine the preloaded data set and follow the descriptions in the Using the ACTS Procurement Accelerator Reports section below, or connect to your own data by following these steps:

1. In the Power BI Data pane, locate the 'Src_DR' table and from its menu select Edit Query to open the Power BI Query Editor window.
2. Select queries from the Queries panel at left to set the following 5 parameters:
    - **Synapse Workspace Name** - this must be the name of your Development Synapse Workspace.
    - **Database Name** - this must be the name of the database in your Develoment Synapse that contains the output of the Beneficial Ownership Engine.
    - **DBserver** - this must be the name of the 'Dedicated SQL endpoint' of the Development Synapse. You can find this value on the Overview page for the Development Synapse in the Azure Portal.
    - **DBname** - this must be the name of the database that contains the raw OCDS (procurement) data.
3. Select queries from the Queries panel and use the Power Query 'Advanced Editor' in the Query section of the Home ribbon to make the following changes to 5 queries:
    - **FlagAll** - change the name of the table in the SQL query to the name of the table in your DBserver:DBname database containing review flags.
    - **FlagDetails** - change the name of the table in the SQL query to the name of the table in your DBserver:DBname database that contains the red flag descriptions.
    - **ItemCategories** - change the name of the table in the SQL query to the name of the table in your DBserver:DBname database containing item categories.
    - **Src_DR** - change the table name in the SQL query to the name of the table in your DBserver:DBname database containing OCDS data.
    - **SuppliersExcluded** - change the name of the table in the SQL query to the name of the table in your DBserver:DBname database containing data on excluded/sanctioned suppliers.

With the changes in the preceding 3 steps it should now be possible to update the Power BI reports (Close & Apply, or Refresh Data) with data from your OCDS and Beneficial Ownership Engine results. If you have a Power BI Pro account, you can publish the report online for access via the web.

## Using the ACTS Procurement Accelerator Reports

The ACTS Procurement Accelerator reports unify OCDS data and Beneficial Ownership Engine results. In addition to the Home page, reports are provided for Collusion Detection, Supplier Risk, Individual Bidders and Suppliers, Buyers, and Contracting Processes. You can explore the reports by doing the following in Power BI Desktop:

- Select the ***Home*** tab, or Ctrl+click the HOME button on the left side of the page. This page includes various red flag summary visuals such as red flag counts over time, KPIs filtered on different categories, bar charts showing magnitudes of red flag categories, and visuals highlighting different aspects of contracting procedures with red flags.
- Select the ***Supplier Risk*** tab or Ctrl+click the Supplier Risk button on the left side of the page. Of particular interest to governments managing procurement procedures are quantitative measures of Supplier Risk because the bidding and supplier selection procedures in procurement are often central to willful noncompliance that may necessitate sanctions against bidders and suppliers. The Supplier Risk dashboard report summarizes red flags by Supplier including KPI displays, graphics showing Suppliers with a high number of red flags, common red flags, and supplier item categories associated with a high number of red flags.
- On the Supplier Risk page, scroll down to the list of flagged suppliers and bidders. This table contains a list of each entity with red flags by procurement procedure. Entity GTG Industrial has several red flags suggesting that further analysis of this entity is warranted.
- in the list of flagged suppliers and bidders, right-click on GTG Industrial and select ***Drill-through -> Entity Ranking*** which automatically navigates to the **Entity Ranking** page. On this page you can examine the results generated by the ACTS Procurement Accelerator Beneficial Ownership Engine. These results include an analysis of relationships that may exist between the selected supplier and other bidders or suppliers. The engine uses similarity measures to create a network of related entities that can then be examined in visuals to discover new areas for investigation or new red flags. For a selected supplier the report displays the size of the network (number of related entities based on similarities), red flags associated with the related entities, and several ways to filter the information to isolate a relationship of interest.
- On the Entity Ranking page, scroll to the top and click on the link icon in the 'report link' column of the Entity Scores table. This action will generate a complete PDF report of the Beneficial Ownership Engine analysis for the selected entity. These reports contain an overview of the discovered network, a review (red) flag summary, and details on each of the related entities as well as inter-company activities. These activities, such as buy-sell transactions, in which entities engage are also examined by the Beneficial Ownership Engine and can be visualized as aggregations across the analysis timeframe, or at different points in time (weeks, months, quarters) to detect unusual periods of activities.