resource "azurerm_kubernetes_cluster" "aks" {
  name                              = var.cluster_name
  location                          = var.location
  resource_group_name               = var.resource_group_name
  dns_prefix                        = var.dns_prefix
  node_resource_group               = var.node_resource_group
  kubernetes_version                = var.kubernetes_version
  private_cluster_enabled           = var.private_cluster_enabled
  sku_tier                          = "Standard"  
  default_node_pool {
    name                  = var.default_node_pool.name
    node_count            = var.default_node_pool.node_count
    vm_size               = var.default_node_pool.vm_size
    min_count             = var.default_node_pool.min_count
    max_count             = var.default_node_pool.max_count
    os_disk_size_gb       = var.default_node_pool.os_disk_size_gb
    max_pods              = var.default_node_pool.max_pods
    node_labels           = var.default_node_pool.node_labels
    type                  = "VirtualMachineScaleSets"
    vnet_subnet_id        = var.vnet_subnet_id
    orchestrator_version  = var.kubernetes_version
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin     = var.network_plugin
    network_policy     = var.network_policy
    service_cidr       = var.service_cidr
    dns_service_ip     = var.dns_service_ip
    load_balancer_sku  = "standard"
  }

  dynamic "azure_active_directory_role_based_access_control" {
    for_each = var.aad_rbac_enabled ? [1] : []
    content {
      admin_group_object_ids = var.aad_admin_group_object_ids
      azure_rbac_enabled     = true
    }
  }

  dynamic "key_vault_secrets_provider" {
    for_each = var.key_vault_secrets_provider_enabled ? [1] : []
    content {
      secret_rotation_enabled  = true
      secret_rotation_interval = "2m"
    }
  }

  dynamic "oms_agent" {
    for_each = var.enable_azure_monitor ? [1] : []
    content {
      log_analytics_workspace_id = azurerm_log_analytics_workspace.aks[0].id
    }
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [
      default_node_pool[0].node_count
    ]
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "additional_pools" {
  for_each              = { for pool in var.additional_node_pools : pool.name => pool }
  
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  name                  = each.value.name
  node_count            = each.value.node_count
  vm_size               = each.value.vm_size

  min_count             = each.value.min_count
  max_count             = each.value.max_count
  os_disk_size_gb       = each.value.os_disk_size_gb
  max_pods              = each.value.max_pods
  node_labels           = each.value.node_labels
  vnet_subnet_id        = var.vnet_subnet_id

  orchestrator_version  = var.kubernetes_version

  tags = var.tags

  lifecycle {
    ignore_changes = [
      node_count
    ]
  }
}

resource "azurerm_log_analytics_workspace" "aks" {
  count               = var.enable_azure_monitor ? 1 : 0
  name                = "log-${var.cluster_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = var.tags
}

resource "azurerm_monitor_diagnostic_setting" "aks" {
  count                      = var.enable_azure_monitor ? 1 : 0
  name                       = "diag-${var.cluster_name}"
  target_resource_id         = azurerm_kubernetes_cluster.aks.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.aks[0].id

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}