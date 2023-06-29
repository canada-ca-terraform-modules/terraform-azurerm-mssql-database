module "sqlserver" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-server.git?ref=v2.0.2"

  name                                          = "servername001"
  environment                                   = "dev"
  location                                      = "canadacentral"
  resource_group_name                           = "hosting-sql-dev-rg"
  administrator_login                           = ""
  administrator_login_password                  = ""
  firewall_rules                                = [] #List of IP addresses: Ex. ["0.0.0.0"]
  active_directory_administrator_login_username = "Hosting-SQL"
  active_directory_administrator_object_id      = "124d16c2-ef85-4359-964d-26b4016c6807"
  active_directory_administrator_tenant_id      = "258f1f99-ee3d-42c7-bfc5-7af1b2343e02"

  kv_name                = "hostingops-sql-dev-kv"
  kv_rg                  = "hostingops-sql-dev-rg"
  kv_enable              = true
  sa_resource_group_name = "hostingops-sql-dev-rg"

  /*
  #[Optional] Configurations
  mssql_version                                 = "12.0"
  emails                                        = ["name@domain.ca"]
  */
  /*
  #[Optional] Firewall Configurations
  subnets                                       = [data.azurerm_subnet.devcc-back.id]
  ssl_minimal_tls_version_enforced              = "1.2"
  connection_policy                             = "Default"
  */
  /*
  #[Optional] Keyvault Configurations

  */
  /*
  #[Optional] AD Configurations
  active_directory_administrator_login_username = ""
  active_directory_administrator_object_id      = ""
  active_directory_administrator_tenant_id      = ""
  */
  /*
  #[Optional] Private Endpoint Configurations
  private_endpoint_subnet_id                    = [data.azurerm_subnet.devcc-back.id]
  private_dns_zone_ids                          = [data.azurerm_private_dns_zone.mssql.id]
  */

  tags = { "key" : "value" }
}

module "db" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-database?ref=v2.0.3"

  name                = "dbname001"
  resource_group_name = "resourcegroupname"
  location            = "canadacentral"
  environment         = "dev"

  server_id   = module.sqlserver[0].id
  server_name = module.sqlserver[0].name

  #DB Configuration
  sku                      = "GP_Gen5_2"
  kv_name                  = "hostingops-sql-dev-kv"
  kv_rg                    = "hostingops-sql-dev-rg"
  sa_resource_group_name   = "hostingops-sql-dev-rg"
  sa_primary_blob_endpoint = module.sqlserver[0].sa_primary_blob_endpoint
  sa_primary_access_key    = module.sqlserver[0].sa_primary_access_key

  /*
  #[Optional] Database Configuration 
  collation                   = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb                 = 32
  min_capacity                = 0.5
  auto_pause_delay_in_minutes = 60
  read_replica_count          = 0
  read_scale                  = lookup(var.db_names[count.index], "read_scale", null)
  zone_redundant              = "BusinessCritical"
  str_days                    = "7"
  
  /*
  #[Optional] Long Term Retention Policies Configuration (for provisioned databases only)
  ltr_monthly_retention       = "P1M"
  ltr_week_of_year            = "52"
  ltr_weekly_retention        = "P1W"
  ltr_yearly_retention        = "P12M"
  */

  /*
  #[Optional] Create Mode Configuration (where another database is used as reference)
  #create_mode                 = "Default"              #Options are "Copy", "Default", "OnlineSecondary"
  #creation_source_database_id = "databaseid"
  */

  /*
  #[Optional] Create Mode Configuration (where database is being recovered)
  #create_mode                 = "Recovery"              
  #recover_database_id         = "databaseid"
  */

  /*
  #[Optional] Create Mode Configuration (where database is being restored)
  #create_mode                 = "Restore"
  #restore_point_in_time       = "databaseid"
  */

  /*
  #[Optional] Create Mode Configuration (where database is being restored from point in time)
  #create_mode                 = "PointInTimeRestore"
  #restore_dropped_database_id = "databaseid"
  */

  /*
  #[Optional] Elastic Pool Configuration 
  elastic_pool_id = module.elasticpool[0].elasticpool[0].id
  */

  /*
  #[Optional] Job Agent Credentials Configuration
  job_agent_credentials = { username = "username", password = "password" }
  */

  tags = { "key" = "value" }
}