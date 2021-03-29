provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  features {}
}

terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "=2.20.0"
    }
  }
}