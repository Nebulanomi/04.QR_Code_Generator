# Create a prefix for the RG
resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

# Create the RG with its unique ID
resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name = random_pet.rg_name.id
  tags = {
    "Budget" = "10€",
    "Data classification" = "Private",
    "End date" = "Never",
    "Owner" = "Alexandre Pereira",
    "Secondary owner" = "None",
    "Team name" = "None",
  }
}

# Create ACR
resource "azurerm_container_registry" "acr" {
  name                = "acralextest"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
  georeplications {
    location                = "West Europe"
    zone_redundancy_enabled = true
    tags                    = {}
  }
  georeplications {
    location                = "North Europe"
    zone_redundancy_enabled = true
    tags                    = {}
  }
}

# Create AKS
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aksalextest"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aksalextest"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

# Create a managed identity for AKS to ACR
resource "azurerm_role_assignment" "aks-role" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
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
    url             = "https://github.com/Nebulanomi/04.-QR-Code-Generator-"
    reference_type  = "branch"
    reference_value = "main"
  }

# Define the namespace resource
resource "kubernetes_namespace" "app-ns" {
  metadata {
    name = "qr-app"
  }
}

  kustomizations {
    fastapi {
      path = "./FastAPI-yaml"
    }

    nodejs {
      path = "./Node.js-yaml"
    }
  }

  depends_on = [
    azurerm_kubernetes_cluster_extension.aks-ext
  ]
}

# Add Grafana to monitor
resource "azurerm_dashboard_grafana" "aks-graf" {
  name                              = "aksagrafatest"
  resource_group_name               = azurerm_resource_group.aks.name
  location                          = "West Europe"
  api_key_enabled                   = true
  deterministic_outbound_ip_enabled = true
  public_network_access_enabled     = false

  identity {
    type = "SystemAssigned"
  }

  tags = {
    key = "value"
  }
}