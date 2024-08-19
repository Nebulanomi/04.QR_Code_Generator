# Providers

## Backend storage account 
variable "resource_group_name" {
  description = "The Azure Resource Group"
  type        = string
}

variable "storage_account_name" {
  description = "The Azure Storage Account"
  type        = string
}

variable "container_name" {
  description = "The Azure Storage Account Container"
  type        = string
}

variable "key" {
  description = "The access key for the Azure Storage Account"
  type        = string
  sensitive   = true
}


## Service principal variables
variable "client_id" {
  description = "The Service principal client ID"
  type        = string
}

variable "client_secret" {
  description = "The Service principal client secret"
  type        = string
  sensitive   = true
}

variable "subscription_id" {
  description = "The Azure subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "The Azure Entra ID tenant ID"
  type        = string
}


# Main

## RG variables
variable "resource_group_name_prefix" {
  type        = string
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "resource_group_location" {
  type        = string
  default     = "North Europe"
  description = "Location of the resource group."
}

## AKS variables
variable "node_count" {
  type        = number
  description = "The initial quantity of nodes for the node pool."
  default     = 1
}

## Github repo url
variable "url" {
  default = "https://github.com/Nebulanomi/04.QR_Code_Generator"
  type = string
}