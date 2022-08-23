resource "azurerm_mssql_database" "sql_db" {
  name                        = var.name
  server_id                   = var.server_id 
  collation                   = var.collation
  license_type                = local.license_type
  max_size_gb                 = var.max_size_gb
  sku_name                    = var.sku_name
  create_mode                 = var.create_mode
  creation_source_database_id = var.creation_source_database_id
  elastic_pool_id             = var.elastic_pool_id
  restore_point_in_time       = var.restore_point_in_time
  sample_name                 = var.sample_name


      //Parameters for Serverless
    auto_pause_delay_in_minutes = (
        substr(var.sku_name, 0, length(local.general_serverless_prefix)) == 
            local.general_serverless_prefix && 
            var.auto_pause_delay_in_minutes >= local.min_auto_pause_supported ?
            var.auto_pause_delay_in_minutes : null
    )
    min_capacity = (
        substr(var.sku_name, 0, length(local.general_serverless_prefix)) == 
           local.general_serverless_prefix ? var.min_capacity : null
    )

      //Parameters for HyperScale
    read_replica_count = (
        substr(var.sku_name, 0, length(local.hyperscale_prefix)) == 
            local.hyperscale_prefix ? var.read_replica_count : null
    )

      //Parameters for BC and Premium.
    read_scale = (
        substr(var.sku_name, 0, length(local.premium_prefix)) == local.premium_prefix || 
        substr(var.sku_name, 0, length(local.business_prefix)) == 
            local.business_prefix ? var.read_scale : null
    )
    zone_redundant = (
        substr(var.sku_name, 0, length(local.premium_prefix)) == local.premium_prefix || 
        substr(var.sku_name, 0, length(local.business_prefix)) == 
            local.business_prefix ? var.zone_redundant : null
    )

  tags       = var.tags
  depends_on = [var.db_depends_on]

  dynamic "short_term_retention_policy" {
    for_each = substr(var.sku_name, 0, length(local.hyperscale_prefix)) == local.hyperscale_prefix ? [] : [1]
    content {
      retention_days = var.short_retentiondays
    }
  }
  //Dynamic block as LTR is not supported by hyperscale nor serverless with autopause.
  dynamic "long_term_retention_policy" {
    #for_each = substr(var.sku_name, 0, length(local.general_serverless_prefix)) == local.general_serverless_prefix || substr(var.sku_name, 0, length(local.hyperscale_prefix)) == local.hyperscale_prefix ? [] : [1]
    #content{}
    weekly_retention  = substr(var.sku_name, 0, length(local.general_serverless_prefix)) == local.general_serverless_prefix || substr(var.sku_name, 0, length(local.hyperscale_prefix)) == local.hyperscale_prefix ? null : var.ltr_weekly_retention
    monthly_retention = substr(var.sku_name, 0, length(local.general_serverless_prefix)) == local.general_serverless_prefix || substr(var.sku_name, 0, length(local.hyperscale_prefix)) == local.hyperscale_prefix ? null : var.ltr_monthly_retention
    yearly_retention  = substr(var.sku_name, 0, length(local.general_serverless_prefix)) == local.general_serverless_prefix || substr(var.sku_name, 0, length(local.hyperscale_prefix)) == local.hyperscale_prefix ? null : var.ltr_yearly_retention
    week_of_year      = substr(var.sku_name, 0, length(local.general_serverless_prefix)) == local.general_serverless_prefix || substr(var.sku_name, 0, length(local.hyperscale_prefix)) == local.hyperscale_prefix ? null : var.ltr_week_of_year

  }
}

resource "azurerm_mssql_database_extended_auditing_policy" "mssqldb" {
  database_id            = azurerm_mssql_database.sql_db.id
  storage_endpoint           = var.sa_primary_blob_endpoint
  storage_account_access_key = var.sa_primary_access_key

  retention_in_days      = var.retention_days
  log_monitoring_enabled = true
}
