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