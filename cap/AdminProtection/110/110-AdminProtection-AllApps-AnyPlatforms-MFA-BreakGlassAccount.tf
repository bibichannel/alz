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

resource "azuread_conditional_access_policy" "admin_protection_mfa_break_glass" {
  display_name = "110-AdminProtection-AllApps-AnyPlatforms-MFA-BreakGlassAccount"
  state        = var.cap_state
  conditions {
    client_app_types = ["browser", "mobileAppsAndDesktopClients"]

    applications {
      included_applications = ["All"]
    }

    locations {
      included_locations = ["AllTrusted"]
    }

    platforms {
      included_platforms = ["all"]
    }

    users {
      included_groups = var.included_groups
      excluded_groups = var.excluded_groups
    }
  }
  grant_controls {
    operator                          = "OR"
    authentication_strength_policy_id = "/policies/authenticationStrengthPolicies/00000000-0000-0000-0000-000000000002"
  }
}
