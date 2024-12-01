# resource "azurerm_consumption_budget_subscription" "this" {
#   name            = "budget-example"
#   subscription_id = data.azurerm_subscription.current.id

#   amount     = 1
#   time_grain = "Monthly"

#   time_period {
#     start_date = "2024-11-01T00:00:00Z"
#     end_date   = "2025-01-01T00:00:00Z"
#   }

#   filter {
#     dimension {
#       name = "ResourceGroupName"
#       values = [
#         azurerm_resource_group.this.name,
#       ]
#     }
#   }

#   notification {
#     enabled   = true
#     threshold = 80.0
#     operator  = "EqualTo"

#     contact_emails = ["trung.khanh150901@gmail.com", "lytrung15901@gmail.com"]

#   }

#   notification {
#     enabled   = true
#     threshold = 100.0
#     operator  = "EqualTo"

#     contact_emails = ["trung.khanh150901@gmail.com", "lytrung15901@gmail.com"]

#     contact_groups = [
#       azurerm_monitor_action_group.example.id,
#     ]
#   }

#   notification {
#     enabled        = false
#     threshold      = 100
#     operator       = "GreaterThan"
#     threshold_type = "Forecasted"

#     contact_emails = ["trung.khanh150901@gmail.com", "lytrung15901@gmail.com"]
#   }
# }
