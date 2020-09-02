locals {
  management_subscription_id   = var.management_subscription_id != null ? [var.management_subscription_id] : []
  landing_zone_subscription_id = var.landing_zone_subscription_id != null ? [var.landing_zone_subscription_id] : []
}

module "management_groups" {
  source = "github.com/terraform-azurerm-modules/terraform-azurerm-management-groups?ref=v0.1.3"

  management_groups = {
    (var.prefix) = {
      "${var.prefix}-decommissioned" = {},
      "${var.prefix}-landingzones" = {
        "${var.prefix}-online" = {
          "subscription_ids" = local.landing_zone_subscription_id
        }
      },
      "${var.prefix}-platform" = {
        "${var.prefix}-management" = {
          "subscription_ids" = local.management_subscription_id
        }
        "${var.prefix}-connectivity" = {}
        "${var.prefix}-identity"     = {}
      },
      "${var.prefix}-sandboxes" = {}
    }
  }
}

module "azopsreference" {
  source                = "github.com/terraform-azurerm-modules/terraform-azurerm-azopsreference?ref=v0.2.0"
  management_group_name = module.management_groups.output[var.prefix].name
}
