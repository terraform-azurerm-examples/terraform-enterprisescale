variable "prefix" {
  description = "Prefix used for top level management group name and to prefix child management groups. Default: es"
  type        = string
  default     = "es"

  validation {
    condition     = length(var.prefix) >= 1 && length(var.prefix) <= 5
    error_message = "The prefix must be between 1 and 5 characters in length."
  }
}

variable "region" {
  description = "Azure region used for the deployments."
  type        = string
  default     = "UK South"
}

variable "deploy_log_analytics_workspace" {
  description = "Deploy Log Analytics workspace and enable monitoring for your platform and resources (recommended)."
  type        = bool
  default     = false
}

variable "management_subscription_id" {
  description = "Subscription ID for platform/management management group. Needed for Log Analytics workspace etc."
  type        = string
  default     = null

  // validation {
  //   condition     = ! var.deploy_log_analytics_workspace || var.management_subscription_id != ""
  //   error_message = "Management subscription ID must be specified if deploying a log analytics workspace."
  // }
}

variable "deploy_azure_security_center" {
  description = "Deploy Azure Security Center and enable security monitoring for your platform and resources."
  type        = bool
  default     = false
}

variable "azure_security_center_sku" {
  description = "Azure Security Center SKU. (Standard (recommended) | Free (default))"
  type        = string
  default     = "Free"

  validation {
    condition     = var.azure_security_center_sku == "Standard" || var.azure_security_center_sku == "Free"
    error_message = "Sku must be either \"Standard\" (recommended) or \"Free\" (default)."
  }
}

variable "deploy_azure_monitor_solutions" {
  description = "Select which Azure Monitor solutions you will enable for your Log Analytics workspace. Requires deploy_log_analytics_workspace."

  type = object({
    security          = bool
    agent_health      = bool
    change_tracking   = bool
    update_management = bool
    activity_log      = bool
    vm_insights       = bool
    antimalware       = bool
    service_map       = bool
    sql_assessment    = bool
  })

  default = {
    security          = false
    agent_health      = false
    change_tracking   = false
    update_management = false
    activity_log      = false
    vm_insights       = false
    antimalware       = false
    service_map       = false
    sql_assessment    = false
  }

}

variable "landing_zone_subscription_id" {
  description = "Optional subscription ID for first landing zone."
  type        = string
  default     = null
}

variable "assign_landing_zone_policies" {
  description = "Select which of the the recommended policies you will assign to your landing zones."
  type = object({
    enableVmBackup               = bool
    preventRdpFromInternet       = bool
    subnetsAssociatedToNsgs      = bool
    preventIpForwarding          = bool
    sqlTransparentDataEncryption = bool
    sqlAuditing                  = bool
    storageAccountsHttps         = bool
  })

  default = {
    enableVmBackup               = false
    preventRdpFromInternet       = false
    subnetsAssociatedToNsgs      = false
    preventIpForwarding          = false
    sqlTransparentDataEncryption = false
    sqlAuditing                  = false
    storageAccountsHttps         = false
  }
}
