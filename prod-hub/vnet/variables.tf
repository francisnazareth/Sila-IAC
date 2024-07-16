variable tags {
  type = map(string)
}

variable customerprefix {
  type = string
}

variable environment {
  type = string
}

variable regionprefix {
  type = string
}

variable location {
  type = string
}

variable "rg-name" {
   default= "changeme"
}

variable "hub-vnet-address-space" {
  default = "changeme"
}

variable "firewall-subnet-address-space" {
  default = "changeme"
}

variable "appgw-subnet-address-space" {
  default = "changeme"
}

variable "gateway-subnet-address-space" {
  default = "changeme"
}

variable "bastion-subnet-address-space" {
  default = "changeme"
}

variable "mgmt-subnet-1-address-space" {
  default = "changeme"
}

variable "mgmt-subnet-2-address-space" {
  default = "changeme"
}

variable "shared-svcs-snet-address-space" {
  default = "changeme"
}
