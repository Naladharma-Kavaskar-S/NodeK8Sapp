# Outputs

output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "Azure Container Registery URL" {
  value = azurerm_container_registry.acr.login_server
}