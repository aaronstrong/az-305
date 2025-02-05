terraform {
  required_version = ">=1.3.0"
  required_providers {
    azurerm = {
      "source" = "hashicorp/azurerm"
      version  = "3.43.0"
    }
  }

  cloud { 
    
    organization = "theaaronstrong" 

    workspaces { 
      name = "az-305" 
    } 
  } 

}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

resource "random_string" "uniquestring" {
  length           = 20
  special          = false
  upper            = false
}

# resource "azurerm_resource_group" "rg" {
#   name     = "811-e83eb144-provide-continuous-delivery-with-gith"
#   location = "centralus"
# }

data "azurerm_resource_group" "rg" {
    name = "811-841ede58-provide-continuous-delivery-with-gith"
}

resource "azurerm_storage_account" "storageaccount" {
  name                     = "stg${random_string.uniquestring.result}"
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}