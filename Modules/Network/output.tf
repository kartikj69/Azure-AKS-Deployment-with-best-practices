output "VnetID" {
  value = azurerm_virtual_network.vn.id
}
output "SubnetID" {
  value = azurerm_subnet.subnet.id
}