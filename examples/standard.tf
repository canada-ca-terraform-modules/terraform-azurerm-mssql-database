module "db" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-database.git?ref=v2.0.2"

  name                = "dbname"
  resource_group_name = "resourcegroupname"
  location            = "canadacentral"
  environment         = "dev"

  collation = "SQL_Latin1_General_CP1_CI_AS"
  sku       = lookup(var.db_names[count.index], "sku", "")


  max_size_gb                 = lookup(var.db_names[count.index], "db_max_size_gb", null)
  min_capacity                = lookup(var.db_names[count.index], "min_capacity", 0.5)
  auto_pause_delay_in_minutes = lookup(var.db_names[count.index], "auto_pause_delay_in_minutes", 1)
  read_replica_count          = lookup(var.db_names[count.index], "read_replica_count", 0)
  read_scale                  = lookup(var.db_names[count.index], "read_scale", null)
  zone_redundant              = lookup(var.db_names[count.index], "zone_redundant", null)
  str_days                    = lookup(var.db_names[count.index], "str_days", "7")

  #[Optional] Provisioned Configuration 
  ltr_monthly_retention = lookup(var.db_names[count.index], "ltr_monthly_retention", null)
  ltr_week_of_year      = lookup(var.db_names[count.index], "ltr_week_of_year", "52")
  ltr_weekly_retention  = lookup(var.db_names[count.index], "ltr_weekly_retention", "P1W")
  ltr_yearly_retention  = lookup(var.db_names[count.index], "ltr_yearly_retention", null)

  #[Optional] Create Mode Configuration 
  #create_mode                 = lookup(var.db_names[count.index], "create_mode", "Default")
  #creation_source_database_id = lookup(var.db_names[count.index], "creation_source_database_id", null)
  #recover_database_id         = lookup(var.db_names[count.index], "recover_database_id", null)
  #restore_dropped_database_id = lookup(var.db_names[count.index], "restore_dropped_database_id", null)
  #restore_point_in_time       = lookup(var.db_names[count.index], "restore_point_in_time", null)

  server_id   = module.sqlserver[0].id
  server_name = module.sqlserver[0].name

  elastic_pool_id = var.ep_names == null ? null : module.elasticpool[0].elasticpool.id



  job_agent_credentials = var.job_agent_credentials

  tags = var.tags
}

