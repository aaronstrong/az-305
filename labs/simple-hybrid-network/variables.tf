variable "subscription_id" {
  description = "Subscription id"
  type        = string
}

variable "tenant_id" {
  type = string
}

variable "location" {
  description = "Resource location"
  type        = string
  default     = "centralus"
}

variable "suffix" {
  default = "tst"
}