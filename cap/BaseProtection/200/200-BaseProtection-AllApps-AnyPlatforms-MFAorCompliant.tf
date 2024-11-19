resource "azurerm_conditional_access_policy" "base_protection_mfa_or_compliant" {
  name  = "200-BaseProtection-AllApps-AnyPlatforms-MFAorCompliant"
  state = "enabledForReportingButNotEnforced"

  grant_controls {
    operator = "OR"
    authentication_strength {
      id = "00000000-0000-0000-0000-000000000004"
    }
  }

  conditions {
    client_app_types = ["browser", "mobileAppsAndDesktopClients"]

    applications {
      include_applications = ["All"]
      exclude_applications = []
    }

    users {
      include_users = ["All"]
      exclude_users = []
      exclude_groups = [
        "<ExclusionTempGroup>",
        "<ExclusionPermGroup>",
        "<EmergencyAccessAccountsGroup>",
        "<SynchronizationServiceAccountsGroup>"
      ]
    }

    locations {
      include_locations = ["All"]
      exclude_locations = ["AllTrusted"]
    }
  }
}
