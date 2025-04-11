resource "azurerm_virtual_network" "main" {
  count               = length(var.vnets)
  name                = element(var.vnets[*].name, count.index)
  address_space       = element(var.vnets[*].address_space, count.index)
  resource_group_name = element(var.rg.*.name, count.index)
  location            = element(var.rg.*.location, count.index)

  dynamic "subnet" {
    for_each = var.vnets[count.index].subnets
    content {
      name             = subnet.value
      address_prefixes = [cidrsubnet(element(var.vnets[*].address_space[0], count.index), 8, subnet.key)]
    }
  }
}
