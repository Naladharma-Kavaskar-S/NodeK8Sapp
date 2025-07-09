# Variables

variable "azurerm_resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "subscription_id" {
  description = "The Azure subscription ID."
  type        = string
}

variable "location" {
  description = "The Azure region where the resource group is located."
  type        = string
}

variable "azurerm_container_registry_name" {
  description = "The name of the Azure Container Registry."
  type        = string
}

variable "azurerm_kubernetes_cluster_name" {
  description = "The name of the Azure Kubernetes Cluster."
  type        = string
}

variable "node_count" {
  description = "The number of nodes in the Azure Kubernetes Cluster."
  type        = number
}
