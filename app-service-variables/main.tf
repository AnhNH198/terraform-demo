terraform {
  backend "azurerm" {
   resource_group_name  = "anhnh-tfstate"
   storage_account_name = "anhnhtfstate"
   container_name       = "tfstate"
   key                  = "prod.terraform.tfstate"
  }
}

resource "azurerm_resource_group" "resource_group_terraform" {
  name     = "terraform_resource_group_4"
  location = "southeastasia"
}

resource "azurerm_app_service_plan" "app_service_plan_terraform" {
  name                = "terraform-appserviceplan"
  location            = azurerm_resource_group.resource_group_terraform.location
  resource_group_name = azurerm_resource_group.resource_group_terraform.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app_service_terraform" {
  name                = "app-service-terraform-houssem-4"
  location            = azurerm_resource_group.resource_group_terraform.location
  resource_group_name = azurerm_resource_group.resource_group_terraform.name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan_terraform.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }
}
