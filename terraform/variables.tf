# Service Principal variables
variable "subscription_id" {
  description = "The Azure subscription ID"
  type= string
}

variable "client_id" {
  description = "The Service principal client ID"
  type= string
}

variable "client_secret" {
  description = "The Service principal client secret"
  type= string
  sensitive   = true
}

variable "tenant_id" {
  description = "The Azure Entra ID tenant ID"
  type= string
}

variable "replicationType" {
  description = "The type of replication"
  type        = string
  default     = "LRS"
}

# RG variables
variable "resource_group_location" {
  type        = string
  default     = "West Europe"
  description = "Location of the resource group."
}

variable "resource_group_name_prefix" {
  type        = string
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "url" {
  type        = string
  default     = "rg"
}

variable "reference_type" {
  type        = string
  default     = "rg"
}

variable "reference_value" {
  type        = string
  default     = "rg"
}

variable "https_user" {
  type        = string
  default     = "rg"
}

variable "https_key_base64" {
  type        = string
  default     = "rg"
}