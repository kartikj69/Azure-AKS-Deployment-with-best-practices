variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location where the resources will be deployed"
  type        = string
}

variable "Vnet" {
  description = "Virtual Network configuration"
  type = object({
    vnet_name               = string
    vnet_address_space      = list(string)
    subnet_name             = string
    subnet_address_prefixes = list(string)
  })
}
