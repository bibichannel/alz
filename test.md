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
