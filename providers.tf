terraform {
  required_version = ">=1.12.2"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.41.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.1.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.7.2"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.5.3"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.4"
    }
  }

  backend "azurerm" {
    resource_group_name  = "MC"
    storage_account_name = "mctf"
    container_name       = "tfstate"
    key                  = "powerintegration.tfstate"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = var.subscription_details.subscription_id
  tenant_id       = var.subscription_details.tenant_id

  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
    template_deployment {
      delete_nested_items_during_deletion = true
    }
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }

}
