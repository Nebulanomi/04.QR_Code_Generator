# Backed storage account
variable "resource_group_name" {
  type        = string
}

variable "storage_account_name" {
  type        = string
}

variable "container_name" {
  type        = string
}

variable "key" {
  type        = string
}


# Service principal variables
variable "subscription_id" {
  description = "The Azure subscription ID"
  type        = string
}

variable "client_id" {
  description = "The Service principal client ID"
  type        = string
}

variable "client_secret" {
  description = "The Service principal client secret"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "The Azure Entra ID tenant ID"
  type        = string
}

# RG variables
variable "resource_group_location" {
  type        = string
  description = "Location of the resource group."
}

variable "resource_group_name_prefix" {
  type        = string
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

# ACR variables
variable "acrusername" {
  type        = string
  description = "The admin username for the new cluster."
}

variable "acrpassword" {
  type        = string
  description = "The admin username for the new cluster."
  sensitive   = true
}

# AKS variables
variable "node_count" {
  type        = number
  description = "The initial quantity of nodes for the node pool."
  default     = 3
}

variable "username" {
  type        = string
  description = "The admin username for the new cluster."
  default     = "azureadmin"
}

# Git variables
variable "url" {
  type        = string
}

variable "reference_type" {
  type        = string
}

variable "reference_value" {
  type        = string
}