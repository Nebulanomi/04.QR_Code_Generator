# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_version = ">=1.0"

  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.9.1"
    }
}

  backend "azurerm" {
      #resource_group_name  = TF_VAR_resource_group_name
      #storage_account_name = TF_VAR_storage_account_name
      #container_name       = TF_VAR_container_name
      #key                  = TF_VAR_key
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  skip_provider_registration = false # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
  
#  subscription_id = var.subscription_id
#  client_id       = var.client_id
#  client_secret   = var.client_secret
#  tenant_id       = var.tenant_id
}
