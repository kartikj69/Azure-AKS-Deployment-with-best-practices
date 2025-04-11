# Create resource group
data "azurerm_resource_group" "aks" {
  name     = var.resource_group_name

}

# Create networking resources
module "network" {
  source              = "../Modules/Network"
  resource_group_name = data.azurerm_resource_group.aks.name
  location            = data.azurerm_resource_group.aks.location
  Vnet = {
    vnet_name               = local.vnet_name
    vnet_address_space      = var.address_space
    subnet_name             = local.subnet_name
    subnet_address_prefixes = var.subnet_prefixes
  }
}

# Create AKS cluster
module "aks" {
  source = "../Modules/AKS"

  resource_group_name  = data.azurerm_resource_group.aks.name
  location             = data.azurerm_resource_group.aks.location
  cluster_name         = local.cluster_name
  kubernetes_version   = var.kubernetes_version
  node_resource_group  = local.node_resource_group
  dns_prefix           = local.dns_prefix
  
  # Networking
  vnet_subnet_id         = module.network.SubnetID
  private_cluster_enabled = true
  network_plugin         = "azure"
  network_policy         = "azure"
  service_cidr           = "10.1.0.0/16"
  dns_service_ip         = "10.1.0.10"
  docker_bridge_cidr     = "172.17.0.1/16"
  
  # Node pools
  default_node_pool      = local.default_node_pool
  additional_node_pools  = local.additional_node_pools
  
  # Security
  enable_host_encryption = true
  aad_rbac_enabled       = true
  aad_admin_group_object_ids = var.aad_admin_group_object_ids
  key_vault_secrets_provider_enabled = true
  
  # Monitoring
  enable_azure_monitor   = true
  depends_on = [ module.network ]
  tags = local.all_tags
}

# Create role assignments for AKS managed identity
resource "azurerm_role_assignment" "aks_network_contributor" {
  scope                = module.network.VnetID
  role_definition_name = "Network Contributor"
  principal_id         = module.aks.aks_principal_id
  depends_on = [ module.aks ]
}