resource "time_sleep" "this" {
  create_duration = "5m"
}

resource "null_resource" "this" {
  count = substr(var.sku, 0, 4) == local.general_serverless_prefix ? 0 : 1
  provisioner "local-exec" {
    command = "cat ${local.script}"
  }
  depends_on = [
    time_sleep.this
  ]
}

resource "azurerm_mssql_database" "sql_db" {
  name        = var.name
  server_id   = var.server_id
  collation   = var.collation
  max_size_gb = var.max_size_gb
  sku_name    = var.sku

  create_mode                 = var.create_mode
  creation_source_database_id = var.creation_source_database_id
  restore_dropped_database_id = var.restore_dropped_database_id
  recover_database_id         = var.recover_database_id
  restore_point_in_time       = var.restore_point_in_time

  sample_name     = var.sample_name
  elastic_pool_id = var.elastic_pool_id

  // SERVERLESS
  auto_pause_delay_in_minutes = (
    substr(var.sku, 0, length(local.general_serverless_prefix)) ==
    local.general_serverless_prefix &&
    var.auto_pause_delay_in_minutes >= local.min_auto_pause_supported ?
    var.auto_pause_delay_in_minutes : null
  )
  min_capacity = (
    substr(var.sku, 0, length(local.general_serverless_prefix)) ==
    local.general_serverless_prefix ? var.min_capacity : null
  )

  // HYPERSCALE
  read_replica_count = (
    substr(var.sku, 0, length(local.hyperscale_prefix)) ==
    local.hyperscale_prefix ? var.read_replica_count : null
  )

  // BC & PREMIUM
  read_scale = (
    substr(var.sku, 0, length(local.premium_prefix)) == local.premium_prefix ||
    substr(var.sku, 0, length(local.business_prefix)) ==
    local.business_prefix ? var.read_scale : null
  )
  zone_redundant = (
    substr(var.sku, 0, length(local.premium_prefix)) == local.premium_prefix ||
    substr(var.sku, 0, length(local.business_prefix)) ==
    local.business_prefix ? var.zone_redundant : null
  )

  // STR
  short_term_retention_policy {
    retention_days = var.str_days
  }

  // LTR
  dynamic "long_term_retention_policy" {
    for_each = substr(var.sku, 0, length(local.general_serverless_prefix)) == local.general_serverless_prefix || substr(var.sku, 0, length(local.hyperscale_prefix)) == local.hyperscale_prefix ? [] : [1]
    content {
      weekly_retention  = var.ltr_weekly_retention
      monthly_retention = var.ltr_monthly_retention
      yearly_retention  = var.ltr_yearly_retention
      week_of_year      = var.ltr_week_of_year
    }
  }

  tags = merge(var.tags,
    { "prefix" = substr(var.sku, 0, length(local.general_serverless_prefix)) }
  )
  depends_on = [
    null_resource.this
  ]
}

resource "azurerm_mssql_database_extended_auditing_policy" "this" {
  database_id                = azurerm_mssql_database.sql_db.id
  storage_endpoint           = var.sa_primary_blob_endpoint
  storage_account_access_key = var.sa_primary_access_key
  retention_in_days          = var.retention_days
  log_monitoring_enabled     = true

  depends_on = [
    azurerm_mssql_database.sql_db
  ]
}

resource "azurerm_mssql_job_agent" "this" {
  count       = var.job_agent_credentials == null ? 0 : 1
  name        = "${var.name}-job-agent"
  location    = var.location
  database_id = azurerm_mssql_database.sql_db.id
}

resource "azurerm_mssql_job_credential" "this" {
  count        = var.job_agent_credentials == null ? 0 : 1
  name         = "${var.name}-job-credential"
  job_agent_id = azurerm_mssql_job_agent.this[0].id
  username     = var.job_agent_credentials.username
  password     = var.job_agent_credentials.password
}