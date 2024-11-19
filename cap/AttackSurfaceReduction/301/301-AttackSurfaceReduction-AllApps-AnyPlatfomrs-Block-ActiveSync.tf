resource "azurerm_conditional_access_policy" "attack_surface_reduction_block_activesync" {
  name  = "301-AttackSurfaceReduction-AllApps-AnyPlatforms-Block-ActiveSync"
  state = "enabledForReportingButNotEnforced"

  grant_controls {
    operator        = "OR"
    built_in_controls = ["block"]
  }

  conditions {
    client_app_types = ["exchangeActiveSync"]

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
