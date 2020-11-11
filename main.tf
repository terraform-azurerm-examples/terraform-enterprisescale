locals {}

module "management_groups" {
  source = "github.com/terraform-azurerm-modules/terraform-azurerm-management-groups?ref=v0.2.0"

  subscription_to_mg_csv_data  = csvdecode(file("sub2mg.csv"))

  management_groups = {
    (var.prefix) = {
      "${var.prefix}-decommissioned" = {},
      "${var.prefix}-landingzones" = {
        "${var.prefix}-online" = {}
      },
      "${var.prefix}-platform" = {
        "${var.prefix}-management" = {}
        "${var.prefix}-connectivity" = {}
        "${var.prefix}-identity"     = {}
      },
      "${var.prefix}-sandboxes" = {}
    }
  }
}

module "azopsreference" {
  source                = "github.com/terraform-azurerm-modules/terraform-azurerm-azopsreference?ref=v0.4.0"
  management_group_name = module.management_groups.output[var.prefix].name
}
