resource "random_pet" "prefix" {}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg-aula-infra-aldo" {
  name     = "rg-aula-infra-aldo"
  location = "eastus2"

  tags = {
    environment = "Production"
  }
}

resource "azurerm_kubernetes_cluster" "aks-aula-infra-aldo" {
  name                = "aks-aula-infra-aldo"
  location            = azurerm_resource_group.rg-aula-infra-aldo.location
  resource_group_name = azurerm_resource_group.rg-aula-infra-aldo.name
  dns_prefix          = "aks-aula-infra-aldo"

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "standard_d11"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = var.appId
    client_secret = var.password
  }

  role_based_access_control {
    enabled = true
  }

  tags = {
    environment = "Production"
  }
}
