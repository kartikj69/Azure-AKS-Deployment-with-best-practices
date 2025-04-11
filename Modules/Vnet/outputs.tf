# outputs.tf
output "subnet_ids" {
  value = flatten([
    for vnet in azurerm_virtual_network.main : [
      vnet.subnet[*].id
    ]
  ])
}