resource "azurerm_conditional_access_policy" "base_protection_register_or_join_device" {
  name  = "211-BasedProtection-AllApps-AnyPlatforms-MFA-RegisterOrJoinEntraIdDevice"
  state = "enabledForReportingButNotEnforced"

  grant_controls {
    operator = "OR"
    authentication_strength {
      id = "00000000-0000-0000-0000-000000000004"
    }
  }

  conditions {
    client_app_types = ["all"]

    applications {
      include_applications = []
      exclude_applications = []
      include_user_actions = ["urn:user:registerdevice"]
    }

    users {
      include_users = ["All"]
      exclude_users = ["GuestsOrExternalUsers"]
      exclude_groups = [
        "<ExclusionTempGroup>",
        "<ExclusionPermGroup>",
        "<EmergencyAccessAccountsGroup>"
      ]
    }

    locations {
      include_locations = ["All"]
      exclude_locations = ["AllTrusted"]
    }
  }
}
