terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.84.0"
    }
    # modtm = {
    #   source  = "azure/modtm"
    #   version = "~> 0.3"
    # }
    # random = {
    #   source  = "hashicorp/random"
    #   version = "~> 3.6"
    # }
  }
  # cloud {
  #   organization = "theaaronstrong"
  #   workspaces {
  #     name = "az-305"
  #   }
  # }
}


provider "azurerm" {
  features {}
  use_msi = true

  client_id       = var.client_id
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

