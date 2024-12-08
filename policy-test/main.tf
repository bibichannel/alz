resource "azurerm_policy_definition" "policy" {
  name         = "specific_policy_assignments"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Audit specific policy assignments"
  description  = "Audits the presence of a specific policy assignment at a scope."

  metadata = <<METADATA
    {
    "category": "Policy Assignments"
    }

METADATA


  policy_rule = <<POLICY_RULE
 {
    "if": {
        "allOf": [
          {
            "field": "type",
            "equals": "Microsoft.Authorization/policyAssignments"
          },
          {
            "field": "Microsoft.Authorization/policyAssignments/displayName",
            "equals": "[parameters('displayName')]"
          }
        ]
      },
      "then": {
        "effect": "audit"
      }
  }
POLICY_RULE


  parameters = <<PARAMETERS
 {
    "displayName": {
        "type": "String",
        "metadata": {
          "description": "The display name of the policy assignment.",
          "displayName": "Display name"
        }
    }
 }
PARAMETERS

}
