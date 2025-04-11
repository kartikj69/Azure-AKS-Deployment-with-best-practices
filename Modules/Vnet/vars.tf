variable "vnets" {
  type = list(object({
    name          = string
    address_space = list(string)
    subnets       = list(string)
  }))
  default = [
    {
      name          = "vnet-east",
      address_space = ["10.0.0.0/16"],
      subnets       = ["subnet1", "subnet2"]
    },
    {
      name          = "vnet-west",
      address_space = ["10.1.0.0/16"],
      subnets       = ["subnetA", "subnetB"]
    }
  ]
}
variable "rg" {
  type= object({
    name = string
    location = string
  })
}