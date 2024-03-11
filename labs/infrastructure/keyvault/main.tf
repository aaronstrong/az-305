data "azurerm_client_config" "current" {
}

# Auto-detect your own IP address
data "http" "my_ip" {
  url = "http://api.ipify.org"
}

resource "random_id" "this" {
  byte_length = 2
}

resource "random_pet" "rg_name" {
  prefix = "rg"
}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = random_pet.rg_name.id
}

resource "azurerm_key_vault" "this" {
  name                = "thiskeyvault${random_id.this.id}" #names must be globally unique
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = var.sku_name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  enabled_for_disk_encryption = true
  purge_protection_enabled    = var.purge_protection_enabled
  soft_delete_retention_days  = var.soft_delete_retention_days

  public_network_access_enabled = var.public_network_access_enabled
  network_acls {
    bypass         = "AzureServices"
    default_action = var.nacls_default_action
    ip_rules       = ["${data.http.my_ip.response_body}"]
  }
}
