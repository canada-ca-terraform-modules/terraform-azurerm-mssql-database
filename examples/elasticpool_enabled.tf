// See https://learn.microsoft.com/en-us/azure/azure-sql/database/service-tiers-dtu?view=azuresql#elastic-pool-limits for more
data "azurerm_subnet" "devcc-back" {
  name                 = "devcc-back"
  virtual_network_name = "devcc-vnet"
  resource_group_name  = "network-dev-rg"
}

data "azurerm_private_dns_zone" "mssql" {
  name                = "privatelink.database.windows.net"
  resource_group_name = "network-management-rg"
  provider            = azurerm.mgmt
}

module "sqlserver" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-server.git?ref=v2.0.1"

  name                = "servername001"
  environment         = "dev"
  location            = "canadacentral"
  resource_group_name = "hosting-sql-dev-rg"

  active_directory_administrator_login_username = ""
  active_directory_administrator_object_id      = ""
  active_directory_administrator_tenant_id      = ""
  administrator_login                           = ""
  administrator_login_password                  = ""

  kv_name                = "hostingops-sql-dev-kv"
  kv_rg                  = "hostingops-sql-dev-rg"
  kv_enable              = true
  sa_resource_group_name = "hostingops-sql-dev-rg"

  firewall_rules = [] #List of IP addresses: Ex. ["0.0.0.0"]

  tags = { "key" : "value" }

  /*
  #[Optional] Configurations
  mssql_version                                 = "12.0"
  emails                                        = ["name@domain.ca"]
  retention_days                                = 90

  */
  /*
  #[Optional] Firewall Configurations
  subnets                                       = [data.azurerm_subnet.devcc-back.id]
  ssl_minimal_tls_version_enforced              = "1.2"
  connection_policy                             = "Default"
  */
  /*
  #[Optional] User Assigned Managed Identity Configurations
  primary_mi_id = "abcdefg1234567"
  */

  /*
  #[Optional] Private Endpoint Configurations
  private_endpoint_subnet_id                    = [data.azurerm_subnet.devcc-back.id]
  private_dns_zone_ids                          = [data.azurerm_private_dns_zone.mssql.id]
  */
}

module "elasticpool" {
  source              = "git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-elasticpool.git?ref=v1.0.2"
  name                = "elasticpoolname001"
  location            = "canadacentral"
  resource_group_name = "hosting-sql-rg"
  server_name         = "servername001"
  sku_name            = "GP_Gen5"
  tier                = "GeneralPurpose"
  capacity            = 2
  min_capacity        = 0.25
  max_capacity        = 2
  family              = "Gen5"
  tags                = { "key" = "value" }

  #[Optional] Configurations
  #max_size_gb         = 32               # max_size_gb conflicts with max_size_bytes
  #max_size_bytes      = 811748818944
  #zone_redundant      = "BusinessCritical"
}

module "db" {
  source = "git::https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-database.git?ref=v2.0.2"

  name                = "dbname"
  resource_group_name = "resourcegroupname"
  location            = "canadacentral"
  environment         = "dev"

  server_id   = module.sqlserver[0].id
  server_name = module.sqlserver[0].name

  #DB Configuration
  sku                      = "GP_Gen5_2"
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
  #[Optional] Create Mode Configuration
  #create_mode                 = "Default")
  #creation_source_database_id = lookup(var.db_names[count.index], "creation_source_database_id", null)
  #recover_database_id         = lookup(var.db_names[count.index], "recover_database_id", null)
  #restore_dropped_database_id = lookup(var.db_names[count.index], "restore_dropped_database_id", null)
  #restore_point_in_time       = lookup(var.db_names[count.index], "restore_point_in_time", null)
  */

  /*
  #[Optional] Elastic Pool Configuration 
  elastic_pool_id = module.elasticpool[0].elasticpool.id
  */

  /*
  #[Optional] Job Agent Credentials Configuration
  job_agent_credentials = { username = "username", password = "password" }
  */

  tags = var.tags
}

