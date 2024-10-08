# Output RG
output "rg_name" {
  value = azurerm_resource_group.rg.name
}

output "rg-id" {
  value = azurerm_resource_group.rg.id
}

# Output ACR
output "acr-name" {
  value = azurerm_container_registry.acr.name
}

output "acr-admin_username" {
  value = azurerm_container_registry.acr.admin_username
}

output "acr-admin_password" {
  value     = azurerm_container_registry.acr.admin_password
  sensitive = true
}

# Output AKS
output "aks_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
  sensitive = true
}

output "client_key" {
  value     = azurerm_kubernetes_cluster.aks.kube_config[0].client_key
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate
  sensitive = true
}

output "cluster_password" {
  value     = azurerm_kubernetes_cluster.aks.kube_config[0].password
  sensitive = true
}

output "cluster_username" {
  value     = azurerm_kubernetes_cluster.aks.kube_config[0].username
  sensitive = true
}

output "host" {
  value     = azurerm_kubernetes_cluster.aks.kube_config[0].host
  sensitive = true
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}