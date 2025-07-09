# Provider
provider "AzureRM" {
  features {}

  subscription_id = var.subscription_id
}

# Resource Group
resource "azurerm_resource_group" "k8s_rg" {
  name     = var.azurerm_resource_group_name
  location = var.location
}

# Azure Container Registry
resource "azurerm_container_registry" "k8s_acr" {
  name                = var.azurerm_container_registry_name
  resource_group_name = azurerm_resource_group.k8s_rg.name
  location            = azurerm_resource_group.k8s_rg.location
  sku                 = "Basic"

  admin_enabled = true
}

# Role Assignment for ACR Pull
resource "azurerm_role_assignment" "acr_pull" {
    scope                = azurerm_container_registry.k8s_acr.id
    role_definition_name = "AcrPull"
    principal_id         = azurerm_kubernetes_cluster.k8s_cluster.identity[0].principal_id
  }
  
# Azure Kubernetes Cluster
resource "azurerm_kubernetes_cluster" "k8s_cluster" {
  name                = var.azurerm_kubernetes_cluster_name
  location            = azurerm_resource_group.k8s_rg.location
  resource_group_name = azurerm_resource_group.k8s_rg.name
  dns_prefix          = "k8s-${var.azurerm_kubernetes_cluster_name}"

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    load_balancer_sku = "standard"
  }

  sku_tier = "Free"

}