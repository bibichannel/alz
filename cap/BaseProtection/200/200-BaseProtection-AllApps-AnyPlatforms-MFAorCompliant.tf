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

resource "azuread_conditional_access_policy" "base_protection_mfa_or_compliant" {
  display_name  = "200-BaseProtection-AllApps-AnyPlatforms-MFAorCompliant"
  state = var.cap_state



  conditions {
    client_app_types = ["browser", "mobileAppsAndDesktopClients"]

    applications {
      included_applications = ["All"]
    }

    platforms {
      included_platforms = ["All"]
    }

    users {
      included_users  = ["All"]
      excluded_users  = ["GuestsOrExternalUsers"]
      included_groups = var.included_groups
      excluded_groups = var.excluded_groups
    }

    locations {
      included_locations = ["All"]
    }
  }

  grant_controls {
    operator = "OR"
    built_in_controls = [
      "mfa",
      "compliantDevice",
    ]
  }
}
