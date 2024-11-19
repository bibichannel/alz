resource "azurerm_conditional_access_policy" "base_protection_register_security_info" {
  name  = "201-BaseProtection-AllApps-AnyPlatforms-MFAorCompliant-RegisterSecurityInfo"
  state = "enabledForReportingButNotEnforced"

  grant_controls {
    operator = "OR"
    built_in_controls = [
      "mfa",
      "compliantDevice",
      "domainJoinedDevice"
    ]
  }

  conditions {
    client_app_types = ["browser", "mobileAppsAndDesktopClients"]

    applications {
      include_user_actions = ["urn:user:registersecurityinfo"]
      include_applications = []
      exclude_applications = []
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
