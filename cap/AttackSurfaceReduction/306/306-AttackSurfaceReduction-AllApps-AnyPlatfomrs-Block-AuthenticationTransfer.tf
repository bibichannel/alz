resource "azurerm_conditional_access_policy" "attack_surface_reduction_block_auth_transfer" {
  name  = "306-AttackSurfaceReduction-AllApps-AnyPlatforms-Block-AuthenticationTransfer"
  state = "enabledForReportingButNotEnforced"

  grant_controls {
    operator         = "OR"
    built_in_controls = ["block"]
  }

  conditions {
    client_app_types = [
      "browser",
      "mobileAppsAndDesktopClients"
    ]

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

    authentication_flows {
      transfer_methods = ["authenticationTransfer"]
    }
  }
}
