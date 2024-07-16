resource "azurerm_public_ip" "bastion-pip" {
  name                = "pip-bastion-${var.customerprefix}-${var.location}-01"
  location            = var.location
  resource_group_name = var.rg-name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_bastion_host" "bastion-svc" {
  name                = "bastion-${var.customerprefix}-${var.location}-01"
  location            = var.location
  resource_group_name = var.rg-name
  sku                 = "Premium"
  copy_paste_enabled     = true
  file_copy_enabled      = true
  ip_connect_enabled     = false
  shareable_link_enabled = false
  tunneling_enabled      = true
  zones:   ["1", "2", "3"]
  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.bastion-subnet-id
    public_ip_address_id = azurerm_public_ip.bastion-pip.id
  }
}
