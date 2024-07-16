module rg {
  source = "./rg"
  customerprefix = var.customerprefix
  environment = var.environment
  location = var.location
    regionprefix = var.regionprefix
    tags = var.tags
}

module "log-analytics-workspace" {
  source = "./law"
    customerprefix = var.customerprefix
    environment = var.environment
    location = var.location
    regionprefix = var.regionprefix
    tags = var.tags
    law-rg-name = module.rg.monitoring_rg_name
}

module "hub-vnet" {
    source               = "./vnet"
    rg-name              = module.rg.rg-name
    rg-location          = var.location
    hub-vnet-address-space           = var.hub-vnet-address-space
    firewall-subnet-address-space    = var.firewall-subnet-address-space
    appgw-subnet-address-space       = var.appgw-subnet-address-space
    gateway-subnet-address-space     = var.gateway-subnet-address-space
    bastion-subnet-address-space     = var.bastion-subnet-address-space
    mgmt-subnet-1-address-space      = var.mgmt-subnet-1-address-space
    mgmt-subnet-2-address-space      = var.mgmt-subnet-2-address-space
    shared-svcs-snet-address-space   = var.shared-svcs-snet-address-space
    customer-name        = var.customer-name
}
