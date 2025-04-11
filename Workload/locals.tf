locals {
  cluster_name         = "${var.name_prefix}-${var.environment}"
  node_resource_group  = "${var.name_prefix}-${var.environment}-nodes"
  dns_prefix           = "${var.name_prefix}-${var.environment}"
  
  vnet_name            = "${var.name_prefix}-${var.environment}-vnet"
  subnet_name          = "${var.name_prefix}-${var.environment}-subnet"
  
  default_node_pool = {
    name                = "system"
    node_count          = 1
    vm_size             = var.node_size
    availability_zones  = ["1"]
    enable_auto_scaling = true
    min_count           = null
    max_count           = null
    os_disk_size_gb     = 50
    max_pods            = 30
    node_labels         = {
      "nodepool-type" = "system"
      "environment"   = var.environment
    }
  }
  
  additional_node_pools = [
    {
      name                = "user"
      node_count          = 1
      vm_size             = var.node_size
      availability_zones  = ["1"]
      enable_auto_scaling = true
      min_count           = null
      max_count           = null
      os_disk_size_gb     = 50
      max_pods            = 30
      node_labels         = {
        "nodepool-type" = "user"
        "environment"   = var.environment
      }
    }
  ]

  all_tags = merge(var.tags, {
    "ClusterName" = local.cluster_name
  })
}