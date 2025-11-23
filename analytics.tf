module "log_analytics" {
  source              = "equinor/log-analytics/azurerm"
  version             = "~> 2.0"
  workspace_name      = "log-${var.resource_name_prefix}-${var.location}-${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}