resource "azurerm_mssql_database" "sql_db" {
  name                        = var.name
  server_id                   = var.server_id
  collation                   = var.collation
  license_type                = "BasePrice"
  max_size_gb                 = var.max_size_gb
  read_scale                  = var.read_scale
  sku_name                    = var.sku_name
  zone_redundant              = var.zone_redundant
  auto_pause_delay_in_minutes = var.auto_pause_delay_in_minutes
  create_mode                 = var.create_mode
  creation_source_database_id = var.creation_source_database_id
  elastic_pool_id             = var.elastic_pool_id
  min_capacity                = var.min_capacity
  restore_point_in_time       = var.restore_point_in_time
  read_replica_count          = var.read_replica_count
  sample_name                 = var.sample_name

  tags       = var.tags
  depends_on = [var.db_depends_on]

  short_term_retention_policy {
    retention_days = var.short_retentiondays
  }

  long_term_retention_policy {
    weekly_retention  = var.ltr_weekly_retention
    monthly_retention = var.ltr_monthly_retention
    yearly_retention  = var.ltr_yearly_retention
    week_of_year      = var.ltr_week_of_year
  }
}

resource "azurerm_mssql_database_extended_auditing_policy" "mssqldb" {
  database_id            = azurerm_mssql_database.sql_db.id
  storage_endpoint       = data.azurerm_storage_account.storageaccountinfo.primary_blob_endpoint
  retention_in_days      = var.retention_days
  log_monitoring_enabled = true
}
