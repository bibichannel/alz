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

resource "azuread_conditional_access_policy" "base_protection_block_non_compliant_device" {
  display_name = "202-BaseProtection-AllApps-AnyPlatforms-Block-NonCompliantDevice"
  state        = var.cap_state

  conditions {
    client_app_types = ["browser", "mobileAppsAndDesktopClients"]

    applications {
      included_applications = ["All"]
    }

    locations {
      included_locations = ["All"]
    }

    platforms {
      included_platforms = ["all"]
    }

    devices {
      filter {
        mode = "exclude"
        rule = "device.isCompliant -eq True"
      }
    }

    users {
      included_users  = ["All"]
      included_groups = var.included_groups
      excluded_groups = var.excluded_groups
    }
  }

  grant_controls {
    operator = "OR"
    built_in_controls = [
      "block"
    ]
  }
}
