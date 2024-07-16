resource "azurerm_virtual_network" "hub-vnet" {
  name                = "vnet-${var.customerprefix}-hub-${var.location}-01"
  location            = var.location
  resource_group_name = var.rg-name
  address_space       = [var.hub-vnet-address-space]

  tags     = var.tags
}

resource "azurerm_subnet" "hub-gateway-subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.rg-name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes     = [var.gateway-subnet-address-space]
}

resource "azurerm_subnet" "hub-bastion-subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.rg-name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes     = [var.bastion-subnet-address-space]
}

resource "azurerm_subnet" "hub-firewall-subnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = var.rg-name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes     = [var.firewall-subnet-address-space]
}

resource "azurerm_subnet" "hub-appgw-subnet" {
  name                 = "snet-agw-${var.customerprefix}-hub-01"
  resource_group_name  = var.rg-name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes     = [var.appgw-subnet-address-space]
}

resource "azurerm_subnet" "hub-mgmt-subnet-01" {
  name                 = "snet-mgmt-${var.customerprefix}-hub-01"
  resource_group_name  = var.rg-name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes     = [var.mgmt-subnet-1-address-space]
}

resource "azurerm_subnet" "hub-pe-subnet" {
  name                 = "snet-pe-${var.customerprefix}-hub-01"
  resource_group_name  = var.rg-name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes     = [var.mgmt-subnet-2-address-space]
}

resource "azurerm_subnet" "hub-sharedsvc-subnet-01" {
  name                 = "snet-sharedsvc-${var.customerprefix}-hub-01"
  resource_group_name  = var.rg-name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
  address_prefixes     = [var.shared-svcs-snet-address-space]
}

output "vnetgw-snet-id" {
   value = azurerm_subnet.hub-gateway-subnet.id
}

output "bastion-snet-id" {
  value = azurerm_subnet.hub-bastion-subnet.id
}

output "firewall-snet-id" {
   value = azurerm_subnet.hub-firewall-subnet.id
}

output "appgw-snet-id" {
   value = azurerm_subnet.hub-appgw-subnet.id
}

output "management-snet-1-id" {
  value = azurerm_subnet.hub-mgmt-subnet-01.id
}

output "pe-snet-id" {
  value = azurerm_subnet.hub-pe-subnet.id
}

output "sharedsvc-snet-id" {
  value = azurerm_subnet.hub-sharedsvc-subnet-01.id
}
