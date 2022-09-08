locals {
  license_type = substr(var.sku_name, 3, 1) == "S" ? "LicenseIncluded" : "BasePrice"
  read_scale_out = false
    
    // Service tier prefixes
    premium_prefix = "P"
    business_prefix = "BC"
    hyperscale_prefix = "HS"
    general_serverless_prefix = "GP_S"

    // Minimum time in minutes supported by Terraform configuration (only General Purpose Serverless)
    min_auto_pause_supported = 60
}

data "azurerm_key_vault" "sqlhstkv" {
  name                = var.kv_name
  resource_group_name = var.kv_rg
}
