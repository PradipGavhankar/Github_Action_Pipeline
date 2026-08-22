variable "resource_group_name" {
  description = "Azure Resource Group ka naam"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "ARM_CLIENT_ID" {
  description = "Azure service principal client ID"
  type        = string
  sensitive   = true
  default     = null
}

variable "ARM_CLIENT_SECRET" {
  description = "Azure service principal client secret"
  type        = string
  sensitive   = true
  default     = null
}

variable "ARM_SUBSCRIPTION_ID" {
  description = "Azure subscription ID"
  type        = string
  sensitive   = true
  default     = null
}

variable "ARM_TENANT_ID" {
  description = "Azure tenant ID"
  type        = string
  sensitive   = true
  default     = null
}