# Terraform for Azure Managed Database MSSQL Database(s)

Creates MSSQL Database(s) for use with the Azure Managed Database for MSSQL.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_mssqlmod"></a> [mssqlmod](#requirement\_mssqlmod) | 0.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_mssql"></a> [mssql](#provider\_mssql) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_mssql_database.sql_db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database) | resource |
| [azurerm_mssql_database_extended_auditing_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database_extended_auditing_policy) | resource |
| [azurerm_mssql_job_agent.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_job_agent) | resource |
| [azurerm_mssql_job_credential.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_job_credential) | resource |
| [mssql_login.this](https://registry.terraform.io/providers/hashicorp/mssql/latest/docs/resources/login) | resource |
| [mssql_user.example](https://registry.terraform.io/providers/hashicorp/mssql/latest/docs/resources/user) | resource |
| [null_resource.this](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [time_sleep.this](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [azurerm_key_vault.sqlhstkv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_administrator_login"></a> [administrator\_login](#input\_administrator\_login) | SQL server admin login | `string` | `"sqlhstsvcaz"` | no |
| <a name="input_auto_pause_delay_in_minutes"></a> [auto\_pause\_delay\_in\_minutes](#input\_auto\_pause\_delay\_in\_minutes) | (Optional) Time in minutes after which database is automatically paused. A value of -1 means that automatic pause is disabled. This property is only settable for General Purpose Serverless databases. | `number` | `60` | no |
| <a name="input_collation"></a> [collation](#input\_collation) | (Optional) The name of the collation. Applies only if create\_mode is Default. Azure default is SQL\_LATIN1\_GENERAL\_CP1\_CI\_AS. Changing this forces a new resource to be created. | `any` | `null` | no |
| <a name="input_create_mode"></a> [create\_mode](#input\_create\_mode) | (Optional) Specifies how to create the database. Must be either Default to create a new database or PointInTimeRestore to restore from a snapshot. Defaults to Default. | `any` | `null` | no |
| <a name="input_creation_source_database_id"></a> [creation\_source\_database\_id](#input\_creation\_source\_database\_id) | (Optional) The id of the source database to be referred to create the new database. This should only be used for databases with create\_mode values that use another database as reference. Changing this forces a new resource to be created. | `any` | `null` | no |
| <a name="input_elastic_pool_id"></a> [elastic\_pool\_id](#input\_elastic\_pool\_id) | (Optional) The id of the elastic database pool. | `any` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment used for keyvault access | `any` | n/a | yes |
| <a name="input_job_agent_credentials"></a> [job\_agent\_credentials](#input\_job\_agent\_credentials) | username and password for an elastic job agent | `any` | `null` | no |
| <a name="input_kv_name"></a> [kv\_name](#input\_kv\_name) | The keyvault name | `string` | `""` | no |
| <a name="input_kv_rg"></a> [kv\_rg](#input\_kv\_rg) | The keyvault resource group | `string` | `""` | no |
| <a name="input_location"></a> [location](#input\_location) | value | `any` | n/a | yes |
| <a name="input_ltr_monthly_retention"></a> [ltr\_monthly\_retention](#input\_ltr\_monthly\_retention) | The monthly retention policy for an LTR backup. (1 to 120 weeks eg. P1Y, P1M, P4W, P30D) | `any` | `null` | no |
| <a name="input_ltr_week_of_year"></a> [ltr\_week\_of\_year](#input\_ltr\_week\_of\_year) | The week of the year to take the yearly backup.  Value has to be between 1 and 52. | `number` | `52` | no |
| <a name="input_ltr_weekly_retention"></a> [ltr\_weekly\_retention](#input\_ltr\_weekly\_retention) | The weekly retention policy for an LTR backup. (1 to 520 weeks eg. P1Y, P1M, P1W, P7D) | `string` | `"P1W"` | no |
| <a name="input_ltr_yearly_retention"></a> [ltr\_yearly\_retention](#input\_ltr\_yearly\_retention) | The yearly retention policy for an LTR backup. (1 to 120 weeks eg. P1Y, P12M, P52W, P365D) | `any` | `null` | no |
| <a name="input_max_size_gb"></a> [max\_size\_gb](#input\_max\_size\_gb) | (Optional) The max size of the database in gigabytes. | `any` | `null` | no |
| <a name="input_min_capacity"></a> [min\_capacity](#input\_min\_capacity) | (Optional) Minimal capacity that database will always have allocated, if not paused. This property is only settable for General Purpose Serverless databases. | `number` | `1` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the Ms SQL Database. Changing this forces a new resource to be created. | `any` | n/a | yes |
| <a name="input_read_replica_count"></a> [read\_replica\_count](#input\_read\_replica\_count) | (Optional) The number of readonly secondary replicas associated with the database to which readonly application intent connections may be routed. This property is only settable for Hyperscale edition databases. | `any` | `null` | no |
| <a name="input_read_scale"></a> [read\_scale](#input\_read\_scale) | (Optional) Read-only connections will be redirected to a high-available replica. Please see Use read-only replicas to load-balance read-only query workloads. | `any` | `null` | no |
| <a name="input_recover_database_id"></a> [recover\_database\_id](#input\_recover\_database\_id) | (Optional) The id of the source database to be reocvered to create the new database. This should only be used for databases with create\_mode values that use another database as reference. Changing this forces a new resource to be created. | `any` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group for the sql db | `any` | n/a | yes |
| <a name="input_restore_dropped_database_id"></a> [restore\_dropped\_database\_id](#input\_restore\_dropped\_database\_id) | (Optional) The id of the source database to be restored to create the new database. This should only be used for databases with create\_mode values that use another database as reference. Changing this forces a new resource to be created. | `any` | `null` | no |
| <a name="input_restore_point_in_time"></a> [restore\_point\_in\_time](#input\_restore\_point\_in\_time) | (Optional) The point in time for the restore. Only applies if create\_mode is PointInTimeRestore e.g. 2013-11-08T22:00:40Z | `any` | `null` | no |
| <a name="input_retention_days"></a> [retention\_days](#input\_retention\_days) | Specifies the retention in days for logs for this MSSQL Server | `number` | `90` | no |
| <a name="input_sa_primary_access_key"></a> [sa\_primary\_access\_key](#input\_sa\_primary\_access\_key) | The storage account primary access | `string` | `""` | no |
| <a name="input_sa_primary_blob_endpoint"></a> [sa\_primary\_blob\_endpoint](#input\_sa\_primary\_blob\_endpoint) | The storage account primary blob endpoint | `string` | `""` | no |
| <a name="input_sa_resource_group_name"></a> [sa\_resource\_group\_name](#input\_sa\_resource\_group\_name) | The storageaccountinfo resource group name | `string` | `""` | no |
| <a name="input_sample_name"></a> [sample\_name](#input\_sample\_name) | (Optional) Specifies the name of the sample schema to apply when creating this database. Possible value is AdventureWorksLT. | `any` | `null` | no |
| <a name="input_server_id"></a> [server\_id](#input\_server\_id) | (Required) The id of the Ms SQL Server on which to create the database. Changing this forces a new resource to be created. | `any` | n/a | yes |
| <a name="input_server_name"></a> [server\_name](#input\_server\_name) | (Required) The name of the SQL Server on which to create the database. | `any` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | (Optional) Specifies the name of the sku used by the database. Only changing this from tier Hyperscale to another tier will force a new resource to be created. For example, GP\_S\_Gen5\_2,HS\_Gen4\_1,BC\_Gen5\_2, ElasticPool, Basic,S0, P2 ,DW100c, DS100. | `any` | `null` | no |
| <a name="input_str_days"></a> [str\_days](#input\_str\_days) | Point in Time Restore Configuration.  Values has to be between 7 and 35 | `number` | `7` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | <pre>{<br>  "environment": "dev"<br>}</pre> | no |
| <a name="input_zone_redundant"></a> [zone\_redundant](#input\_zone\_redundant) | (Optional) Whether or not this database is zone redundant, which means the replicas of this database will be spread across multiple availability zones. This property is only settable for Premium and Business Critical databases. | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sql_db"></a> [sql\_db](#output\_sql\_db) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Usage

Examples for this module along with various configurations can be found in the [examples/](examples/) folder.

## Security Controls

* Adheres to the [CIS Microsoft Azure Foundations Benchmark 1.3.0](https://docs.microsoft.com/en-us/azure/governance/policy/samples/cis-azure-1-3-0) for Database Services.

## History

| Date     | Release    | Change                                                      |
|----------|------------|-------------------------------------------------------------|
| 20210628 | 20210628.1 | The v1.0.1 release adds additional vars to handle db output |
| 20210509 | 20210509.1 | The v1.0.0 relase of Terraform module                       |
