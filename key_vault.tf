locals {
  common_tags = {
    environment = var.environment
    monitoring  = "true"
  }
  cost_tags = {
    ServiceNow-App = "115530"
  }
  terraform_tags = {
    workspace = terraform.workspace
  }
}

module "key_vault" {
  source                     = "equinor/key-vault/azurerm"
  version                    = "~> 11.11"
  vault_name                 = "kv-${var.resource_name_prefix}-s455-${var.environment}"
  resource_group_name        = azurerm_resource_group.rg.name
  location                   = azurerm_resource_group.rg.location
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  log_analytics_workspace_id = module.log_analytics.workspace_id
#  network_acls_ip_rules      = ["193.28.84.185", "51.107.209.242"]
  tags                       = merge(local.common_tags, local.cost_tags, local.terraform_tags)
}

resource "azurerm_role_assignment" "current_user" {
  scope                = module.key_vault.vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = data.azurerm_client_config.current.object_id
  depends_on           = [module.key_vault]
}

#resource "azurerm_role_assignment" "admin_user" {
#  scope                = module.key_vault.vault_id
#  role_definition_name = "Key Vault Administrator"
#  principal_id         = data.azuread_user.admin_user.object_id
#  depends_on           = [module.key_vault]
#}

resource "azurerm_role_assignment" "vm" {
  scope                = module.key_vault.vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = var.vm_id
  depends_on           = [module.key_vault]
}

resource "azurerm_key_vault_secret" "secret01" {
  name         = "secret001"
  value        = var.secret01_value
  key_vault_id = module.key_vault.vault_id
  depends_on   = [module.key_vault, azurerm_role_assignment.current_user]
}

resource "azurerm_key_vault_secret" "secret02" {
  name         = "secret002"
  value        = var.secret02_value
  key_vault_id = module.key_vault.vault_id
  depends_on   = [module.key_vault, azurerm_role_assignment.current_user]
}

