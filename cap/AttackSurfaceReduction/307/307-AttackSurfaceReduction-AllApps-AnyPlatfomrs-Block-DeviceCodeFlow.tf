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

resource "azuread_conditional_access_policy" "attack_surface_reduction_block_device_code_flow" {
  display_name  = "307-AttackSurfaceReduction-AllApps-AnyPlatforms-Block-DeviceCodeFlow"
  state = var.cap_state

  conditions {
    client_app_types = [
      "browser",
      "mobileAppsAndDesktopClients"
    ]

    applications {
      included_applications = ["All"]
      excluded_applications = []
      included_user_actions = []
    }

    platforms {
      included_platforms = ["all"]
    }

    locations {
      included_locations = ["All"]
    }

    users {
      included_users  = ["All"]
      excluded_users  = []
      included_groups = var.included_groups
      excluded_groups = var.excluded_groups
    }

    authentication_flows {
      transfer_methods = ["deviceCodeFlow"]
    }
  }

  grant_controls {
    operator          = "OR"
    built_in_controls = ["block"]
  }
}
