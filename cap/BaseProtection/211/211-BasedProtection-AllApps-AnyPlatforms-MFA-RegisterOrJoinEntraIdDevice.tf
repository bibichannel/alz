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

resource "azuread_conditional_access_policy" "base_protection_mfa_register_or_join_device" {
  display_name  = "211-BasedProtection-AllApps-AnyPlatforms-MFA-RegisterOrJoinEntraIdDevice"
  state = var.cap_state

  conditions {
    client_app_types = ["browser", "mobileAppsAndDesktopClients"]

    applications {
      included_user_actions = ["urn:user:registerdevice"]
    }

    platforms {
      included_platforms = ["all"]
    }

    users {
      included_users  = ["All"]
      included_groups = var.included_groups
      excluded_groups = var.excluded_groups
    }

    locations {
      included_locations = ["All"]
    }
  }

  grant_controls {
    operator = "OR"
    authentication_strength_policy_id = "/policies/authenticationStrengthPolicies/00000000-0000-0000-0000-000000000002"
  }
}
