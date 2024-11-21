variable "cap_state" {
  description = "The state of the policy"
  type        = string
}

variable "included_groups" {
  description = "The groups to include in the user block policy"
  type        = list(string)
}

variable "excluded_groups" {
  description = "The groups to exclude in the user block policy"
  type        = list(string)
}

resource "azuread_conditional_access_policy" "attack_surface_reduction_block_auth_transfer" {
  display_name  = "306-AttackSurfaceReduction-AllApps-AnyPlatforms-Block-AuthenticationTransfer"
  state = var.cap_state

  conditions {
    client_app_types = ["exchangeActiveSync"]

    applications {
      included_applications = ["All"]
    }
    
    locations {
      included_locations = ["All"]
    }

    platforms {
      included_platforms = ["all"]
    }

    users {
      included_users  = ["All"]
      included_groups = var.included_groups
      excluded_groups = var.excluded_groups
    }

    # authentication_flows {
    #   transfer_methods = ["authenticationTransfer"]
    # }
  }

  grant_controls {
    operator          = "OR"
    built_in_controls = ["block"]
  }
}
