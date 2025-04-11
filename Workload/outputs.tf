output "resource_group_name" {
  description = "The name of the resource group"
  value       = data.azurerm_resource_group.aks.name
}

output "aks_cluster_name" {
  description = "The name of the AKS cluster"
  value       = module.aks.aks_name
}

output "aks_cluster_id" {
  description = "The ID of the AKS cluster"
  value       = module.aks.aks_id
}

output "kube_config_command" {
  description = "Command to get the kubeconfig"
  value       = "az aks get-credentials --resource-group ${data.azurerm_resource_group.aks.name} --name ${module.aks.aks_name}"
}

output "node_resource_group" {
  description = "The name of the node resource group"
  value       = module.aks.node_resource_group
}

output "subnet_id" {
  description = "The ID of the subnet"
  value       = module.network.SubnetID
}

output "vnet_id" {
  description = "The ID of the VNet"
  value       = module.network.VnetID
}