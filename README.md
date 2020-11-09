# terraform-enterprisescale

## Description

Note that this is a **WORK IN PROGRESS**.

Example configuration to mirror the default Deploy To Azure from <https://github.com/Azure/Enterprise-Scale>.

First pass.

Currently creates management groups and defines the custom policies. Policy assignment is next.

## Example terraform.tfvars

```hcl
prefix = "estst"

#==============================================================================

management_subscription_id     = "2d31be49-d959-4415-bb65-8aec2c90ba62"
deploy_log_analytics_workspace = true
deploy_azure_security_center   = true
azure_security_center_sku      = "Free"

deploy_azure_monitor_solutions = {
  security          = true
  agent_health      = true
  change_tracking   = true
  update_management = true
  activity_log      = true
  vm_insights       = true
  antimalware       = true
  service_map       = false
  sql_assessment    = false
}

#==============================================================================

assign_landing_zone_policies = {
  enableVmBackup               = true
  preventRdpFromInternet       = true
  subnetsAssociatedToNsgs      = true
  preventIpForwarding          = true
  sqlTransparentDataEncryption = false
  sqlAuditing                  = false
  storageAccountsHttps         = true
}
```
