variable "environment" {
  description = "Environment name (e.g. development, staging, production)"
  type        = string
}

variable "location" {
  type        = string
  description = "default resources location"
}

variable "subscription_details" {
  type = object({
    subscription_id = string
    tenant_id       = string
  })
}

variable "admin_user" {
  type = string
}

variable "resource_name_prefix" {
  type = string
}

variable "vm_id" {
  description = "The principal ID of the managed identity of the Azure Virtual Machine."
  type        = string
}

variable "secret01_value" {
  description = "Secret value to be stored in the Key Vault."
  type        = string
  sensitive   = true
}

variable "secret02_value" {
  description = "Secret value to be stored in the Key Vault."
  type        = string
  sensitive   = true
}