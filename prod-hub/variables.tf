variable "tags" {
  type = map(string)
  default = {
    owner       = "DevOps Team"
    environment = "Prod Hub"
    creationDate = "08-JUL-2028"
  } 
}

variable "customerprefix" {
  type = string
  default = "sila"
}

variable "environment" {
  type = string
  default = "prod"
}

variable "regionprefix" {
  type = string
  default = "eastus"
}

variable "location" {
  type = string
  default = "eastus"
}

############################ VNET & SUBNETS ###################
#Address space for HUB VNET
variable "hub-vnet-address-space" { 
  default = "10.105.0.0/22"
}

#Address range for the Firewall subnet (1-63)
variable "firewall-subnet-address-space" {
  default = "10.105.0.0/26"
}

#Address range for the application gateway subnet (64 - 127)
variable "appgw-subnet-address-space" {
  default = "10.105.0.64/26"
}

#Address range for the VNET gateway subnet (128 - 159)
variable "gateway-subnet-address-space" {
  default = "10.105.0.128/27"
}

#Address range for the bastion subnet (160 - 191)
variable "bastion-subnet-address-space" {
  default = "10.105.0.160/27"
}

#Address range for the management subnet 1 (192 - 207)
variable "mgmt-subnet-1-address-space" {
  default = "10.105.0.192/28"
}

#Address range for the management subnet 2 (208 - 223)
variable "mgmt-subnet-2-address-space" {
  default = "10.105.0.208/28"
}

#Address range for the shared services subnet (224 - 239)
variable "shared-svcs-snet-address-space" {
  default = "10.105.0.224/28"
}
