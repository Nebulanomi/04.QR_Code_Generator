# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm   = {
      source  = "hashicorp/azurerm"
      version = "~>3.0.0"
    }
  }

  backend "azurerm" {
      resource_group_name  = "rg-tfstate"
      storage_account_name = "satsstoragealex"
      container_name       = "tfstate"
      key                  = "NiRMJ4RbraIVVEcbUW7R9aI1CpexJRl+YV9bouDZZzuu/LtGX3EgbHWdcbA9F1spSe16zTkWL2rW+AStnETCPw=="
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  skip_provider_registration = false # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
  
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}
