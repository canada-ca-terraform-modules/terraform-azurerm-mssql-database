locals {
  kv_name = var.kv_name
  kv_rg   = var.kv_rg
  env_sku = substr(var.sku_name, 0, 5)
  license_type = local.env_sku == "GP_S_" ? "null" : "BasePrice"
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
  name                = local.kv_name
  resource_group_name = local.kv_rg
}

data "azurerm_key_vault_secret" "storageaccountname" {
  name         = "storageaccountname"
  key_vault_id = data.azurerm_key_vault.sqlhstkv.id
}

data "azurerm_storage_account" "storageaccountinfo" {
  name                = data.azurerm_key_vault_secret.storageaccountname.value
  resource_group_name = var.storageaccountinfo_resource_group_name
}

