variable "resource_group_name" {
  description = "The name of the resource group for the AKS cluster"
  type        = string
}

variable "location" {
  description = "The location where the AKS cluster will be deployed"
  type        = string
}

variable "cluster_name" {
  description = "The name of the AKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "The version of Kubernetes to use"
  type        = string
  default     = "1.27.3"
}

variable "node_resource_group" {
  description = "The name of the resource group for the AKS cluster nodes"
  type        = string
  default     = null
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
}

variable "private_cluster_enabled" {
  description = "Whether to enable private cluster"
  type        = bool
  default     = true
}

variable "default_node_pool" {
  description = "Default node pool configuration"
  type = object({
    name                = string
    node_count          = number
    vm_size             = string
    availability_zones  = list(string)
    enable_auto_scaling = bool
    min_count           = number
    max_count           = number
    os_disk_size_gb     = number
    max_pods            = number
    node_labels         = map(string)
  })
}

variable "additional_node_pools" {
  description = "Additional node pools"
  type = list(object({
    name                = string
    node_count          = number
    vm_size             = string
    availability_zones  = list(string)
    enable_auto_scaling = bool
    min_count           = number
    max_count           = number
    os_disk_size_gb     = number
    max_pods            = number
    node_labels         = map(string)
  }))
  default = []
}

variable "vnet_subnet_id" {
  description = "Subnet ID for the AKS cluster"
  type        = string
}

variable "network_plugin" {
  description = "Network plugin to use for the AKS cluster (azure or kubenet)"
  type        = string
  default     = "azure"
}

variable "network_policy" {
  description = "Network policy to use for the AKS cluster (azure or calico)"
  type        = string
  default     = "azure"
}

variable "service_cidr" {
  description = "CIDR range for Kubernetes services"
  type        = string
  default     = "10.0.0.0/16"
}

variable "dns_service_ip" {
  description = "IP address for Kubernetes DNS service"
  type        = string
  default     = "10.0.0.10"
}

variable "docker_bridge_cidr" {
  description = "CIDR range for the Docker bridge network"
  type        = string
  default     = "172.17.0.1/16"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "enable_azure_monitor" {
  description = "Enable Azure Monitor for containers"
  type        = bool
  default     = true
}

variable "enable_auto_scaling" {
  description = "Enable cluster autoscaler"
  type        = bool
  default     = true
}

variable "enable_host_encryption" {
  description = "Enable host encryption"
  type        = bool
  default     = true
}

variable "key_vault_secrets_provider_enabled" {
  description = "Enable Key Vault Secrets Provider"
  type        = bool
  default     = true
}

variable "aad_rbac_enabled" {
  description = "Enable AAD RBAC"
  type        = bool
  default     = true
}

variable "aad_admin_group_object_ids" {
  description = "Object IDs of AAD groups for admin access"
  type        = list(string)
  default     = []
}