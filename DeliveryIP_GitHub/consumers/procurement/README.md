# Steps to Deploy the Procurement Consumer Synapse

1. Update the [dev variable file](variables/dev.json) for variables related to the new consumer Synapse like resource names and tags

2. Trigger the **consumer_orchestrator** GitHub Action. If you're unfamiliar with triggering a GitHub Action, follow these [instructions](https://docs.github.com/en/actions/managing-workflow-runs/manually-running-a-workflow).
    - Input **beneficial_ownership** for the "Consumer Name" input

## Post Deployment Tasks - Azure SQL

1. Execute the below stored procedure in the deployed Azure SQL Database from the **new-synapse-orchestrator** GitHub Action
    - Login with AAD. SQL Auth is disabled.

```sql
EXEC [dbo].[AddManagedIdentitiesAsUsers]
```

2. Execute the below sql script in the Azure SQL Database deployed from the **data-strategy-orchestrator** GitHub Action
    - Login with AAD. SQL Auth is disabled.

```sql
EXEC [dbo].[Execute_For_Beneficial_Owner_Consumer]
```
