resource "azurerm_conditional_access_policy" "base_protection_block_non_compliant_device" {
  name  = "202-BaseProtection-AllApps-AnyPlatforms-Block-NonCompliantDevice"
  state = "enabledForReportingButNotEnforced"

  grant_controls {
    operator = "OR"
    authentication_strength {
      id = "00000000-0000-0000-0000-000000000004"
    }
  }

  conditions {
    sign_in_risk_levels = ["medium", "high"]

    client_app_types = ["browser", "mobileAppsAndDesktopClients"]

    applications {
      include_applications = ["All"]
      exclude_applications = []
      include_user_actions = []
    }

    users {
      include_users = ["All"]
      exclude_users = []
      exclude_groups = [
        "<ExclusionTempGroup>",
        "<ExclusionPermGroup>",
        "<EmergencyAccessAccountsGroup>"
      ]
    }
  }
}
