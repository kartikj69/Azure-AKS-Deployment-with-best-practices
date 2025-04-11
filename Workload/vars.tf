variable "name_prefix" {
  description = "Prefix for all resource names"
  type        = string
  default     = "aks-bp"
}

variable "location" {
  description = "Azure region for all resources"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
  default     = "Kartik-Jindal-RG"
}

variable "subscription_id" {
  type = string
  description = "Azure subscription ID"
}
variable "kubernetes_version" {
  description = "Kubernetes version to use"
  type        = string
  default     = "1.29.0"
}

variable "environment" {
  description = "Environment name (dev, test, prod)"
  type        = string
  default     = "dev"
}

variable "node_size" {
  description = "Default node pool VM size"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "address_space" {
  description = "VNet address space"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_prefixes" {
  description = "Subnet address prefixes"
  type        = list(string)
  default     = ["10.0.0.0/24"]
}

variable "aad_admin_group_object_ids" {
  description = "AAD group object IDs for AKS admin access"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "Development"
    ManagedBy   = "Terraform"
  }
}