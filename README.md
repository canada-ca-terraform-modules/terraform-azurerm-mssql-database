# Terraform for Azure Managed Database MSSQL Database(s)

Creates MSSQL Database(s) for use with the Azure Managed Database for MSSQL.

## Security Controls

* Adheres to the [CIS Microsoft Azure Foundations Benchmark 1.3.0](https://docs.microsoft.com/en-us/azure/governance/policy/samples/cis-azure-1-3-0) for Database Services.

## Dependencies

* Terraform v0.14.x +
* Terraform AzureRM Provider 2.5 +

## Relationships

* [MSSQL](https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql)
* [MSSQL Database](https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-database)
* [MSSQL Elasticpool](https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-elasticpool)
* [MSSQL Server](https://github.com/canada-ca-terraform-modules/terraform-azurerm-mssql-server)

## Usage

Examples for this module along with various configurations can be found in the [examples/](examples/) folder.

## Variables

| Name                                   | Type   | Default                          | Required | Description                                                                                                                                                                                                                                                                 |
|----------------------------------------|--------|----------------------------------|----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| name                                   | string | n/a                              | yes      | The name of the database.                                                                                                                                                                                                                                                   |
| dbowner                                | string | n/a                              | yes      | The name of the user or group that will be granted dbmanager, loginmanager (master) and db_owner on their database,                                                                                                                                                         |
| environment                            | string | n/a                              | yes      | The name of the subscription.                                                                                                                                                                                                                                               |
| server_id                              | string | n/a                              | yes      | The id of the Azure SQL Server in which the database will be created.                                                                                                                                                                                                       |
| server_name                            | string | n/a                              | yes      | The name of the Azure SQL Server in which the database will be created.                                                                                                                                                                                                     |
| auto_pause_delay_in_minutes            | string | n/a                              | no       | Time in minutes after which database is automatically paused.                                                                                                                                                                                                               |
| create_mode                            | string | n/a                              | no       | Specifies how to create the database.                                                                                                                                                                                                                                       |
| source_database_id                     | string | n/a                              | no       | The URI of the source database if create_mode value is not Default.                                                                                                                                                                                                         |
| restore_point_in_time                  | string | n/a                              | no       | The point in time for the restore. Only applies if create_mode is PointInTimeRestore e.g. 2013-11-08T22:00:40Z.                                                                                                                                                             |
| edition                                | string | n/a                              | no       | The edition of the database to be created. Applies only if create_mode is Default. Valid values are: Basic, Standard, Premium, DataWarehouse, Business, BusinessCritical, Free, GeneralPurpose, Hyperscale, Premium, PremiumRS, Standard, Stretch, System, System2, or Web. |
| collation                              | string | `"SQL_LATIN1_GENERAL_CP1_CI_AS"` | no       | The name of the collation. Changing this forces a new resource to be created.                                                                                                                                                                                               |
| max_size_gb                            | string | n/a                              | no       | The maximum size of the database in GB.                                                                                                                                                                                                                                     |
| min_capacity                           | string | n/a                              | no       | Minimal capacity that database will always have allocated.                                                                                                                                                                                                                  |
| read_replica_count                     | string | n/a                              | no       | The number of readonly secondary replicas associated with the database                                                                                                                                                                                                      |
| read_scale                             | string | n/a                              | no       | Read-only connections will be redirected to a high-available replica. Please see Use read-only replicas to load-balance read-only query workloads.                                                                                                                          |
| sample_name                            | string | n/a                              | no       | Specifies the name of the sample schema to apply when creating this database. Possible value is AdventureWorksLT.                                                                                                                                                           |
| sku_name                               | string | n/a                              | no       | Specifies the name of the sku used by the database.                                                                                                                                                                                                                         |
| zone_redundant                         | string | n/a                              | no       | Whether or not this database is zone redundant                                                                                                                                                                                                                              |
| short_retentiondays                    | string | 7                                | yes      | Point in Time Restore Configuration.  Values has to be between 7 and 35                                                                                                                                                                                                     |
| ltr_weekly_retention                   | string | P1W                              | yes      | The weekly retention policy for an LTR backup. (1 to 520 weeks eg. P1Y, P1M, P1W, P7D)                                                                                                                                                                                      |
| ltr_monthly_retention                  | string | n/a                              | no       | The monthly retention policy for an LTR backup. (1 to 120 weeks eg. P1Y, P1M, P4W, P30D)                                                                                                                                                                                    |
| ltr_yearly_retention                   | string | n/a                              | no       | The yearly retention policy for an LTR backup. (1 to 120 weeks eg. P1Y, P12M, P52W, P365D)                                                                                                                                                                                  |
| ltr_week_of_year                       | string | 52                               | yes      | The week of the year to take the yearly backup.  Value has to be between 1 and 52.                                                                                                                                                                                          |
| elastic_pool_name                      | string | n/a                              | no       | The name of the elastic database pool.                                                                                                                                                                                                                                      |
| kv_name                                | string | n/a                              | yes      | The keyvault name.                                                                                                                                                                                                                                                          |
| kv_rg                                  | string | n/a                              | yes      | The keyvault resource group.                                                                                                                                                                                                                                                |
| storageaccountinfo_resource_group_name | string | n/a                              | yes      | The storageaccountinfo resource group name.                                                                                                                                                                                                                                 |
| tags                                   | map    | `"<map>"`                        | n/a      | A mapping of tags to assign to the resource.                                                                                                                                                                                                                                |

## History

| Date     | Release    | Change                                                      |
|----------|------------|-------------------------------------------------------------|
| 20210628 | 20210628.1 | The v1.0.1 release adds additional vars to handle db output |
| 20210509 | 20210509.1 | The v1.0.0 relase of Terraform module                       |
