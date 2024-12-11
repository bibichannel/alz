triggerBody()?['data']?['alertContext']['AlertData']['Scope']
triggerBody()?['data']?['alertContext']['AlertData']['ThresholdType']
triggerBody()?['data']?['alertContext']['AlertData']['BudgetThreshold']

```http-put-delete
https://management.azure.com//subscriptions/bb35a463-4d55-482a-9c1d-e3434bdaa168/resourceGroups/testinggggg/providers/Microsoft.Authorization/policyAssignments/testingassignment?api-version=2023-04-01

```

[listCallbackUrl(resourceId('Microsoft.Logic/workflows/triggers', parameters('[parameters('logic_app_name')]'), 'manual'),'2021-03-01').value]

[listCallbackUrl(resourceId('resource-group-name','Microsoft.Logic/workflows/triggers', 'logic-app-name', 'manual'), '2016-06-01').value]

@{triggerBody()?['data']?['essentials']?['monitorCondition']}
@{triggerBody()?['data']?['essentials']?['firedDateTime']}
@{triggerBody()?['data']?['essentials']?['alertTargetIDs']}
@{triggerBody()?['data']?['essentials']?['description']}
@{triggerBody()?['data']?['alertContext']['AlertData']['Scope']} 
@{triggerBody()?['data']?['alertContext']['AlertData']['ThresholdType']}
@{triggerBody()?['data']?['alertContext']['AlertData']['BudgetThreshold']}


terraform import azurerm_monitor_metric_alert.main /subscriptions/bb35a463-4d55-482a-9c1d-e3434bdaa168/resourceGroups/testinggggg/providers/Microsoft.Insights/metricAlerts/example-metricalert

/subscriptions/bb35a463-4d55-482a-9c1d-e3434bdaa168/resourceGroups/testinggggg/providers/microsoft.insights/activityLogAlerts/Create or update budget alert

terraform import azurerm_monitor_activity_log_alert.example /subscriptions/bb35a463-4d55-482a-9c1d-e3434bdaa168/resourceGroups/testinggggg/providers/microsoft.Insights/activityLogAlerts/testingAlertCustomRule

terraform import azurerm_monitor_activity_log_alert.example /subscriptions/bb35a463-4d55-482a-9c1d-e3434bdaa168/resourceGroups/testinggggg/providers/Microsoft.Insights/activityLogAlerts/testingAlertCustomRule

body('HTTP')?['properties']?['amount']
body('HTTP')?['properties']?['currentSpend']?['amount']
float(body('HTTP')?['properties']?['amount'])
float(body('HTTP')?['properties']?['currentSpend']?['amount'])

https://management.azure.com/{scope}/providers/Microsoft.Consumption/budgets/{budgetName}?api-version=2024-08-01

https://management.azure.com/subscriptions/bb35a463-4d55-482a-9c1d-e3434bdaa168/providers/Microsoft.Consumption/budgets/limit-services-cost?api-version=2024-08-01

https://management.azure.com/subscriptions/bb35a463-4d55-482a-9c1d-e3434bdaa168/providers/Microsoft.Consumption/budgets/limit-services-cost?api-version=2024-08-01

((!(ActionMatches{'Microsoft.Authorization/roleAssignments/write'})) OR (@Request[Microsoft.Authorization/roleAssignments:RoleDefinitionId] ForAnyOfAllValues:GuidNotEquals {8e3af657-a8ff-443c-a75c-2fe8c4bcb635, 18d7d88d-d35e-4fb5-a5c3-7773c20a72d9, f58310d9-a9f6-439a-9e8d-f62e7b41a168})) AND ((!(ActionMatches{'Microsoft.Authorization/roleAssignments/delete'})) OR (@Resource[Microsoft.Authorization/roleAssignments:RoleDefinitionId] ForAnyOfAllValues:GuidNotEquals {8e3af657-a8ff-443c-a75c-2fe8c4bcb635, 18d7d88d-d35e-4fb5-a5c3-7773c20a72d9, f58310d9-a9f6-439a-9e8d-f62e7b41a168}))