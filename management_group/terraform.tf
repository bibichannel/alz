terraform {
  required_version = ">= 0.13"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.49.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "bb35a463-4d55-482a-9c1d-e3434bdaa168"
}

