locals {
  read_scale_out = false
  // Service tier prefixes
  premium_prefix            = "P"
  business_prefix           = "BC"
  hyperscale_prefix         = "HS"
  general_serverless_prefix = "GP_S"

  enableltr = (var.ltr_monthly_retention == null
    && var.ltr_week_of_year == null
    && var.ltr_weekly_retention == null
  && var.ltr_yearly_retention == null) ? [] : [1]

  // Minimum time in minutes supported by Terraform configuration (only General Purpose Serverless)
  min_auto_pause_supported = 60

  script = templatefile("${path.module}/ltrconfig.ps1.tftpl", {
    db_name             = var.name
    server_name         = var.server_name
    resource_group_name = var.resource_group_name
  })
}

data "azurerm_key_vault" "sqlhstkv" {
  name                = var.kv_name
  resource_group_name = var.kv_rg
}



