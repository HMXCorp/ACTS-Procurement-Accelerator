# HMX Procurement Accelerator

Access to the HMX Procurement Accelerator is by invitation.

![HMX Procurement Accelerator Architecture](./Architecture.png)

The HMX Procurement Accelerator includes the following capabilities:

1. **Data Management Infrastructure** - a comprehensive data strategy implementation including data ingestion, Azure Data Factory pipelines, Azure Synapse deployments including pipelines for development (staged) and consumer (curated) data management with associated storage containers, a common Enterprise Procurement Model (EPM), and a beneficial ownership data model. Data schema for the EPM adopts the [Open Contracting Data Standard](https://www.open-contracting.org/data-standard/), a comprehensive data standard designed to increase contracting transparency, and allow deeper analysis of contracting data by a wide range of users.
2. **Beneficial Ownership Engine** - A service that applies AI analysis techniques to detect complex relationships between procurement organizational entities and their activities.
    - The deployment includes the [Business Use Case Portal](DeliveryIP_GitHub/BusinessUseCasePortal), a Microsoft Power App that enables users and developers to establish data contrHMX and define data mappings required to ingest data from open procurement data sources that is the input to the Beneficial Ownership Engine.
3. **Power BI Templates** - For visualization of procurement compliance information and results of analysis performed by the HMX Procurement Accelerator services.
4. **Example Data** - For testing all of the accelerator capabilities.

In addition, the following capabilities can be deployed with the HMX Procurement Accelerator. Test data and preprocessing pipelines specific to the HMX Procurement Accelerator implementation also are provided.

1. **Red Flags Server and Workbench** - An Azure AI-based evaluation engine for procurement review flags (red flags or green flags) and an Excel Add-in for review flag exploration and simulation.
2. **Information Assistant** - Enhanced generative AI supporting query of private procurement organization knowledge in a secure manner.

The steps required to deploy the HMX Procurement Accelerator solution including example data and tools are described below.

## Deploy the Data Management Infrastructure & Development Synapse

The [deployment document](DeliveryIP_GitHub/) provides step by step instructions on how to deploy the data management infrastructure and Development Azure Synapse components. All required services, with developer access, will be in place after deployment. This allows immediate access to the services including those for data ingestion, data processing, and visualization with Power BI reports. Developers with knowledge of Azure Synapse, Azure Data Factory, and Power Platform can easily tailor the HMX Procurement Accelerator to fit their specific use case needs.

The Development Synapse includes pre-packaged data pipelines that process data downloaded from open data sources and uploaded to the "landing" storage container (or "zone") of the data lake. Additional pipelines transfer data from the [Open Contracting Partnership](https://www.open-contracting.org/data/) and populate the development Enterprise Procurement Model (EPM) in the "staging" zone. The EPM in the staging zone provides access for developers and data scientists, with the necessary permissions, for analysis, machine learning, modeling, and other types of exploratory inspection and analysis.

## Deploy the Consumer Synapse

The next step is to deploy a separate Consumer Synapse environment with the common EPM and populate the consumer EPM with test data [See instructions here](DeliveryIP_GitHub/consumers/procurement/). The Consumer Synapse includes pre-packaged data pipelines that copy the EPM in the staging zone to the "curated" zone, which is the database of record. Additional pipelines extract data from open data sources and populate the Beneficial Ownership Model. Data in these models within the curated zone are used, with the necessary permissions, by management, business intelligence teams, and other data consumers for reporting, and processing external to the HMX Procurement Accelerator environment.

### Deploy the Beneficial Ownership Engine

The HMX [Beneficial Ownership Engine (BOE)](https://github.com/mbarnettHMX/beneficial-ownership-engine) was developed by Microsoft Research to create visualizations of the relationships between entities that must comply with procurement laws and policies. The BOE uses machine learning spectral embedding and graph analysis techniques to reduce complex sets of procurement information from open data sources or your ogranization's private data to create a visual network that shows explicit, and possibly hidden, relationships between these entities. Hidden relationships are inferred based on similarities between attributes such as geographical location, names, addresses, and common activities (e.g, a buyer/seller relationship).

For the HMX Procurement Accelerator, specialized Azure Synapse pipelines are provided for downloading BOE input data from open data sources including [Open Contracting Partnership](https://www.open-contracting.org/data/data-use/), [Open Sanctions](https://www.opensanctions.org/datasets/), [Open Ownership](https://register.openownership.org/download), and [Open Corporates](https://opencorporates.com/info/our-data/). Follow the steps in the [Beneficial Ownership Engine](https://github.com/mbarnettHMX/beneficial-ownership-engine) repository to deploy the engine, then see [Beneficial Ownership Engine Installation and Use](BeneficialOwnership/README.md) for information on running the BOE for use with the HMX Procurement Accelerator.

The sample data are now ready to be accessed by Power BI from the Consumer Synapse EPM.

## Download the PBI Desktop Files

The Procurement and Beneficial Ownership Report Power BI file provides comprehensive reports on many aspects of procurement with a focus on review flag results, organized in many ways to simplify procurement risk and process performance management. It also contains the results generated by the Beneficial Ownership Engine including network graphs of static and dynamic activity relationships between procurement entities. The Power BI file is parameterized to connect to the EPM in the Consumer Synapse. See [Downloading and Using the Procurement and Beneficial Ownership Reports](DemoReports/README.md).

### Add Multi-language Support

HMX Accelerators includes methods and tools to support multiple languages in Power BI reports. These methods enable users to modify labels on visuals, add languages, and manage these labels and languages to tailor reports in specific implementations. The steps to deploy multi-language support for this Accelerator can be found in the [Multi-language Support](MultiLanguageSupport/) section. This section includes a document with deployment steps and an example Power BI file that implements multi-language capabilities described in the document.

## Additional Accelerator Capabilities

The HMX Procurement Accelerator components support the following additions, which are deployed separately.

### Red Flags Server and Excel Workbench Add-in

The Red Flags Workbench is a Microsoft Excel Add-in designed to allow managers and analysts to explore standard procurement red flags available in a library that is based on the [Open Contracting Data Standard](https://www.open-contracting.org/data-standard/), create their own red flags, modify how red flags are assessed, and perform simulations scenarios with a subset of their procurement data. The Add-in applies the familiar capabilities of Excel so that business users can easily create and maintain their red flags. The Add-in's Cognitive Map structure provides a context for organizing red flags in a way that keeps organizations focused on goal achievement and maintaining procurement compliance situational awareness. See [Red Flags Workbench Installation and Use](RedFlagsServer_and_Workbench/README.md) for information on deploying the workbench for use with the HMX Procurement Accelerator.

### Information Assistant

The HMX Information Assistant applies the [Microsoft Public Sector Group's Information Assistant](https://github.com/microsoft/PubSec-Info-Assistant) to enable use of OpenAI large language models for data retrieval and ChatGPT-style Q&A interactions in a secure manner with a procurement organization's private information. The Information Assistant uses Retrieval Augmented Generation (RAG) with Azure OpenAI's GPT models and Azure AI Search to discover relevant responses to user queries through simplified data ingestion, transformation, indexing, and multilingual translation services. Procurement organizations that deploy this capability can upload PDF, CSV, Excel, and image files and then engage in Q&A sessions relevant to the content of the private data. The Information Assistant is designed to address specific concerns of organizations that require natural language capabilities that are:

- **Current**: Based on the latest private data updates.
- **Relevant**: Responses tailored to the content of the uploaded private data.
- **Controlled**: Adjusted responses to provide the desired level of detail.
- **Referenced**: Provides citations from the uploaded knowledge sources.
- **Personalized**: Responses adjusted to your selected persona.
- **Explainable**: Provides information on the thought process that generated the response.

See [Information Assistant Deployment and Use](InformationAssistant/README.md) for information on deploying the Information Assistant for use with the HMX Procurement Accelerator.

## PEPPOL and UBL Support
Example data and supporting code described in this repository apply [Open Contracting Partnership](https://www.open-contracting.org/) data and rules as defined (and extended) in the [Open Contracting Data Stnadard](https://standard.open-contracting.org/latest). There are other, both proprietary and public standards that users of thi Accelerator are required to support.

With public and private membership in 45 countries, the Pan-European Public Procurement On-Line organization, or PEPPOL is an international non-profit organization that enables any organisation to send and receive standard business documents, including electronic documents in procurement processes based on the [OASIS Universal Business Language (UBL) standard](https://docs.oasis-open.org/ubl/UBL-2.4.html). The applications described in this repository can manage electronic documents defined in the PEPPOL and UBL standards, providing a layer of analytics that improve transparency and compliance. See the [PEPPOL and UBL Support document](./PEPPOL_UBL/README.md) for more infomation about implementing Procurement Accelerator capabilities with PEPPOL/UBL electronic documents.

## Contributing

HMX welcomes contributions to this repository.

## Trademarks

This project may contain trademarks or logos for projects, products, or services. Authorized use of Microsoft trademarks or logos is subject to and must follow
[Microsoft's Trademark & Brand Guidelines](https://www.microsoft.com/en-us/legal/intellectualproperty/trademarks/usage/general).
Use of Microsoft trademarks or logos in modified versions of this project must not cause confusion or imply Microsoft sponsorship. Any use of third-party trademarks or logos are subject to those third-party's policies.
