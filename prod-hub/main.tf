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
    law-rg-name = module.rg.output.monitoring_rg_name
}

