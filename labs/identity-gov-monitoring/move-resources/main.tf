resource "random_pet" "rg_src_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg_src" {
  location = var.resource_group_location
  name     = random_pet.rg_src_name.id
}

resource "azurerm_managed_disk" "this" {
  name                 = "movemedisk"
  location             = var.resource_group_location
  resource_group_name  = azurerm_resource_group.rg_src.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "1"
}

resource "random_pet" "rg_dest_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg_dest" {
  location = var.resource_group_location
  name     = random_pet.rg_dest_name.id
}

resource "azurerm_management_lock" "rg_level_ro" {
  name       = "readonly"
  scope      = azurerm_resource_group.rg_dest.id
  lock_level = "ReadOnly"
  notes      = "This RG is Read-Only"
}

resource "azurerm_management_lock" "rg_level_delete" {
  name       = "no-delete"
  scope      = azurerm_resource_group.rg_dest.id
  lock_level = "CanNotDelete"
  notes      = "This RG is DoNotDelete"
}