resource "azurerm_conditional_access_policy" "attack_surface_reduction_block_other_clients" {
  name  = "300-AttackSurfaceReduction-AllApps-AnyPlatforms-Block-UsingOtherClients"
  state = "enabledForReportingButNotEnforced"

  grant_controls {
    operator        = "OR"
    built_in_controls = ["block"]
  }

  conditions {
    client_app_types = ["other"]

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
