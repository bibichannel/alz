# data "azurerm_subscription" "current" {}

# resource "azurerm_monitor_action_group" "example" {
#   name                = "monitoring-budget"
#   resource_group_name = azurerm_resource_group.example.name
#   short_name          = "West Europe"
# }

# resource "azurerm_consumption_budget_subscription" "example" {
#   name            = "example"
#   subscription_id = data.azurerm_subscription.current.id

#   amount     = 1000
#   time_grain = "Monthly"

#   time_period {
#     start_date = "2022-06-01T00:00:00Z"
#     end_date   = "2022-07-01T00:00:00Z"
#   }

#   filter {
#     dimension {
#       name = "ResourceGroupName"
#       values = [
#         azurerm_resource_group.example.name,
#       ]
#     }

#     tag {
#       name = "foo"
#       values = [
#         "bar",
#         "baz",
#       ]
#     }
#   }

#   notification {
#     enabled   = true
#     threshold = 90.0
#     operator  = "EqualTo"

#     contact_emails = [
#       "foo@example.com",
#       "bar@example.com",
#     ]

#     contact_groups = [
#       azurerm_monitor_action_group.example.id,
#     ]

#     contact_roles = [
#       "Owner",
#     ]
#   }

#   notification {
#     enabled        = false
#     threshold      = 80.0
#     operator       = "GreaterThan"
#     threshold_type = "Forecasted"

#     contact_emails = ["trung.khanh150901@gmail.com"]
#   }
# }


# resource "azurerm_logic_app_trigger_http_request" "example" {
#   logic_app_id = azurerm_logic_app_workflow.example.id
#   name         = "budget-alert-trigger"
# }


# resource "azurerm_policy_assignment" "assign_on_breach" {
#   name                 = "budget-exceeded-policy"
#   policy_definition_id = data.azurerm_policy_definition.example.id
#   scope                = var.subscription_id
# }
