resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.resource_name_prefix}-infra-${var.location}-${var.environment}"
  location = var.location

  // DT Tags applies only to resources
  tags = merge(local.common_tags, local.cost_tags, local.terraform_tags)
}