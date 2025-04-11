output "aks_id" {
  description = "The ID of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.id
}

output "aks_name" {
  description = "The name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.name
}

output "kube_config" {
  description = "The kubeconfig for the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}

output "kube_config_host" {
  description = "The Kubernetes cluster server host"
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].host
  sensitive   = true
}

output "node_resource_group" {
  description = "The resource group where the AKS nodes are deployed"
  value       = azurerm_kubernetes_cluster.aks.node_resource_group
}

output "aks_principal_id" {
  description = "The principal ID of the system assigned identity"
  value       = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}

output "kubelet_identity" {
  description = "The Kubelet identity"
  value       = azurerm_kubernetes_cluster.aks.kubelet_identity
}

output "key_vault_secrets_provider" {
  description = "Key Vault secrets provider information"
  value       = var.key_vault_secrets_provider_enabled ? azurerm_kubernetes_cluster.aks.key_vault_secrets_provider : null
}

output "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace"
  value       = var.enable_azure_monitor ? azurerm_log_analytics_workspace.aks[0].id : null
}