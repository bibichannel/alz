resource "azurerm_conditional_access_policy" "admin_protection_mfa_break_glass" {
  name                = "110-AdminProtection-AllApps-AnyPlatforms-MFA-BreakGlassAccount"
  state               = "enabledForReportingButNotEnforced"
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
      include_groups = ["<EmergencyAccessAccountsGroup>"]
      exclude_groups = []
    }
  }
}
