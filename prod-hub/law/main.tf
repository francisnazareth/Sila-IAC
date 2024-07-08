resource "azurerm_log_analytics_workspace" "law" {
  location     = var.location
  name = "law-{var.customerprefix}-{var.environment}-{var.regionprefix}-01"
  tags     = var.tags
  resource_group_name = var.law-rg-name
  sku                 = "PerGB2018"
}
