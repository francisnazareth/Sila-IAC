resource azurerm_resource_group rg_backup    {
  location     = var.location
  name = "rg-backup-{var.customerprefix}-{var.environment}-{var.regionprefix}-01"
  tags     = var.tags
}

resource azurerm_resource_group rg_monitoring    {
  location     = var.location
  name = "rg-monitoring-{var.customerprefix}-{var.environment}-{var.regionprefix}-01"
  tags     = var.tags
}

resource azurerm_resource_group rg_management    {
  location     = var.location
  name = "rg-management-{var.customerprefix}-{var.environment}-{var.regionprefix}-01"
  tags     = var.tags
}

resource azurerm_resource_group rg_network    {
  location     = var.location
  name = "rg-network-{var.customerprefix}-{var.environment}-{var.regionprefix}-01"
  tags     = var.tags
}

output backup_rg_name {
  value = azurerm_resource_group.rg_backup.name
}

output monitoring_rg_name {
  value = azurerm_resource_group.rg_monitoring.name
}

output management_rg_name {
  value = azurerm_resource_group.rg_management.name
}

output network_rg_name {
  value = azurerm_resource_group.rg_network.name
}