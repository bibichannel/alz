permision_list = [
        "Microsoft.AppComplianceAutomation/*",
        "Microsoft.Storage/storageAccounts/blobServices/write",
        "Microsoft.Storage/storageAccounts/fileservices/write",
        "Microsoft.Storage/storageAccounts/listKeys/action",
        "Microsoft.Storage/storageAccounts/write",
        "Microsoft.Storage/storageAccounts/blobServices/generateUserDelegationKey/action",
    
    
        "Microsoft.Storage/storageAccounts/blobServices/containers/write",
    
        "Microsoft.PolicyInsights/policyStates/queryResults/action",
        "Microsoft.PolicyInsights/policyStates/triggerEvaluation/action",
    
    
    
    
    
        "Microsoft.Resources/subscriptions/resourceGroups/delete",
        "Microsoft.Resources/subscriptions/resourceGroups/write",
    
        "Microsoft.Resources/deployments/validate/action",
    
        "Microsoft.Resources/deployments/write",
        "Microsoft.Security/automations/delete",
        "Microsoft.Security/automations/write",
        "Microsoft.Security/register/action",
        "Microsoft.Security/unregister/action",
    
    
        "Microsoft.Attestation/attestationProviders/attestation/write",
        "Microsoft.Attestation/attestationProviders/attestation/delete",
    
        "Microsoft.Insights/alertRules/*",
        "Microsoft.Resources/deployments/*",
    
        "Microsoft.Support/*",
    
    
    
    
    
        "Microsoft.KeyVault/managedHSMs/*",
    
    
        "Microsoft.KeyVault/locations/deletedManagedHsms/purge/action",
    
    
    
        "Microsoft.Logic/workflows/triggers/listCallbackUrl/action",
    
    
        "Microsoft.Web/sites/hostruntime/webhooks/api/workflows/triggers/listCallbackUrl/action",
    
        "Microsoft.SecurityInsights/*",
        "Microsoft.OperationalInsights/workspaces/analytics/query/action",
    
        "Microsoft.OperationalInsights/workspaces/savedSearches/*",
    
    
    
    
    
        "Microsoft.Insights/workbooks/*",
    
    
        "Microsoft.Insights/alertRules/*",
        "Microsoft.Resources/deployments/*",
    
        "Microsoft.Support/*",
    
        "Microsoft.Authorization/policyAssignments/*",
        "Microsoft.Authorization/policyDefinitions/*",
        "Microsoft.Authorization/policyExemptions/*",
        "Microsoft.Authorization/policySetDefinitions/*",
        "Microsoft.Insights/alertRules/*",
    
    
        "Microsoft.Resources/deployments/*",
    
        "Microsoft.Security/*",
        "Microsoft.IoTSecurity/*",
        "Microsoft.IoTFirmwareDefense/*",
        "Microsoft.Support/*",
        "Microsoft.Security/assessments/write",
    
    
        "Microsoft.ClassicCompute/virtualMachines/*/write",
    
        "Microsoft.Insights/alertRules/*",
    
        "Microsoft.Resources/deployments/*",
    
        "Microsoft.Security/*",
        "Microsoft.Support/*",]

print(len(permision_list))
update_list=set(permision_list)
print(len(update_list))
print(sorted(update_list))


