# Create a prefix for the RG
resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

# Create the RG with its unique ID
resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = random_pet.rg_name.id
  tags = {
    "Budget"              = "10€",
    "Data classification" = "Private",
    "End date"            = "Never",
    "Owner"               = "Alexandre Pereira",
    "Secondary owner"     = "None",
    "Team name"           = "None",
  }
}

# Create a prefix for the ACR

## Generate a random string for uniqueness
resource "random_id" "acr_name" {
  byte_length = 4
}

# Create ACR
resource "azurerm_container_registry" "acr" {
  name                = "acr-${random_id.acr_name.hex}"
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

# Create a prefix for AKS
resource "random_pet" "azurerm_kubernetes_cluster_name" {
  prefix = "cluster"
}

# Create a prefix for AKS DNS
resource "random_pet" "azurerm_kubernetes_cluster_dns_prefix" {
  prefix = "dns"
}

# Create AKS
resource "azurerm_kubernetes_cluster" "aks" {
  name                = random_pet.azurerm_kubernetes_cluster_name.id
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = random_pet.azurerm_kubernetes_cluster_dns_prefix.id

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  linux_profile {
    admin_username = var.username

    ssh_key {
      key_data = azapi_resource_action.ssh_public_key_gen.output.publicKey
    }
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }
}

# Create a managed identity for AKS to ACR
resource "azurerm_role_assignment" "aks-role" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}

# Define the namespace resource
resource "kubernetes_namespace" "ns-app" {
  metadata {
    name = "qr-app"
  }
}

# Add the flux extension to AKS
resource "azurerm_kubernetes_cluster_extension" "aks-ext" {
  name           = "aks-ext"
  cluster_id     = azurerm_kubernetes_cluster.aks.id
  extension_type = "microsoft.flux"
}

# Add the github repo to the flux extension
resource "azurerm_kubernetes_flux_configuration" "aks-fc" {
  name       = "aks-fc"
  cluster_id = azurerm_kubernetes_cluster.aks.id
  namespace  = "qr-app"

  git_repository {
    url             = var.url
    reference_type  = var.reference_type
    reference_value = var.reference_value
  }

  kustomizations {
    name = "kustomization-git"
  }

  depends_on = [
    azurerm_kubernetes_cluster_extension.aks-ext
  ]
}