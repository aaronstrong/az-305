
variable "sku_name" {
  description = "The Name of the SKU used for this Key Vault. Possible values are `standard` or `premium`."
  type        = string
  default     = "standard"
}

variable "resource_group_location" {
  type        = string
  default     = "eastus"
  description = "Location of the resource group."
}

variable "purge_protection_enabled" {
  description = "Is Purge Protection enabled on this Key Vault"
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Whether public network access is allowed for this Key Vault. Defaults to `false`."
  type        = string
  default     = true
}

variable "nacls_default_action" {
  description = "The default action to use when no rules match from `ip_rules` / `virtual_network_subnet_ids`. Possible values are `Allow` or `Deny`."
  type = string
  default = "Deny"
}

variable "soft_delete_retention_days" {
  description = "The number of days that items should be retained for once soft-deleted. This value can be between `7` and `90`. Default is `7`."
  type        = number
  default     = 7
}