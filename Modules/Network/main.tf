resource "azurerm_virtual_network" "vn" {
  name                = var.Vnet.vnet_name
  address_space       = var.Vnet.vnet_address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "subnet" {
  name                 = var.Vnet.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vn.name
  address_prefixes     = var.Vnet.subnet_address_prefixes
  depends_on           = [azurerm_virtual_network.vn]
}