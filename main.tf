data "azurerm_client_config" "current" {}

data "azuread_user" "admin_user" {
  user_principal_name = var.admin_user
}

#data "azurerm_resource_group" "rg" {
#  name = "rg-${var.resource_name_prefix}-infra-${var.location}-${var.environment}"
#}

#data "azurerm_virtual_machine" "vm" {
#  name                = var.vm_name
#  resource_group_name = data.azurerm_resource_group.rg.name
#}

