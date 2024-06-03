variable "name" {
  description = "(Required) The name of the Ms SQL Database. Changing this forces a new resource to be created."
  type        = string
}

variable "server_id" {
  description = "(Required) The id of the Ms SQL Server on which to create the database. Changing this forces a new resource to be created."
  type        = string
}

variable "server_name" {
  description = "(Required) The name of the SQL Server on which to create the database."
  type        = string
}

variable "auto_pause_delay_in_minutes" {
  description = "(Optional) Time in minutes after which database is automatically paused. A value of -1 means that automatic pause is disabled. This property is only settable for General Purpose Serverless databases."
  type        = number
  default     = null
}

variable "create_mode" {
  description = "(Optional) Specifies how to create the database. Must be either Default to create a new database or PointInTimeRestore to restore from a snapshot. Defaults to Default."
  type        = string
  default     = "Default"
}

variable "creation_source_database_id" {
  description = "(Optional) The id of the source database to be referred to create the new database. This should only be used for databases with create_mode values that use another database as reference. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "collation" {
  description = "(Optional) The name of the collation. Applies only if create_mode is Default. Azure default is SQL_LATIN1_GENERAL_CP1_CI_AS. Changing this forces a new resource to be created."
  type        = string
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "elastic_pool_id" {
  description = "(Optional) The id of the elastic database pool."
  type        = string
  default     = null
}

variable "max_size_gb" {
  description = "(Optional) The max size of the database in gigabytes."
  type        = number
  default     = null
}

variable "min_capacity" {
  description = "(Optional) Minimal capacity that database will always have allocated, if not paused. This property is only settable for General Purpose Serverless databases."
  type        = number
  default     = null
} #0.5 

variable "restore_point_in_time" {
  description = "(Optional) The point in time for the restore. Only applies if create_mode is PointInTimeRestore e.g. 2013-11-08T22:00:40Z"
  type        = string
  default     = null
}

variable "read_replica_count" {
  description = "(Optional) The number of readonly secondary replicas associated with the database to which readonly application intent connections may be routed. This property is only settable for Hyperscale edition databases."
  default     = null
}

variable "read_scale" {
  description = "(Optional) If enabled, connections that have application intent set to readonly in their connection string may be routed to a readonly secondary replica. This property is only settable for Premium and Business Critical databases."
  type        = bool
  default     = null
}

variable "sample_name" {
  description = "(Optional) Specifies the name of the sample schema to apply when creating this database. Possible value is AdventureWorksLT."
  type        = string
  default     = null
}

variable "sku" {
  description = "(Optional) Specifies the name of the sku used by the database. Only changing this from tier Hyperscale to another tier will force a new resource to be created. For example, GP_S_Gen5_2, HS_Gen4_1, BC_Gen5_2, ElasticPool, Basic, S0, P2,DW100c, DS100."
  default     = "Basic"
}

variable "administrator_login" {
  description = "SQL server admin login"
  default     = "sqlhstsvcaz"
}

variable "zone_redundant" {
  description = " (Optional) Whether or not this database is zone redundant, which means the replicas of this database will be spread across multiple availability zones. This property is only settable for Premium and Business Critical databases."
  default     = null
}

variable "str_days" {
  description = "Point in Time Restore Configuration.  Values has to be between 7 and 35"
  default     = 7
}

variable "ltr_weekly_retention" {
  description = "The weekly retention policy for an LTR backup. (1 to 520 weeks eg. P1Y, P1M, P1W, P7D)"
  default     = null #"P1W"
}

variable "ltr_monthly_retention" {
  description = "The monthly retention policy for an LTR backup. (1 to 120 weeks eg. P1Y, P1M, P4W, P30D)"
  default     = null
}

variable "ltr_yearly_retention" {
  description = "The yearly retention policy for an LTR backup. (1 to 120 weeks eg. P1Y, P12M, P52W, P365D)"
  default     = null
}

variable "ltr_week_of_year" {
  description = "The week of the year to take the yearly backup.  Value has to be between 1 and 52."
  default     = null
}

variable "environment" {
  description = "The environment used for keyvault access"
}

variable "retention_days" {
  description = "Specifies the retention in days for logs for this MSSQL Server"
  default     = null
}

variable "tags" {
  type = map(string)
  default = {
    environment : "dev"
  }
}

variable "sa_primary_blob_endpoint" {
  description = "The storage account primary blob endpoint"
  default     = ""
}

variable "sa_primary_access_key" {
  description = "The storage account primary access"
  default     = ""
}

variable "resource_group_name" {
  description = "The resource group for the sql db"
}

variable "restore_dropped_database_id" {
  description = " (Optional) The id of the source database to be restored to create the new database. This should only be used for databases with create_mode values that use another database as reference. Changing this forces a new resource to be created."
  default     = null
}

variable "recover_database_id" {
  description = " (Optional) The id of the source database to be reocvered to create the new database. This should only be used for databases with create_mode values that use another database as reference. Changing this forces a new resource to be created."
  default     = null
}

variable "job_agent_credentials" {
  description = "username and password for an elastic job agent"
  default     = null
}

variable "location" {
  description = "value"
}


variable "kv_name" {
  description = "The keyvault name"
  default     = ""
}

variable "kv_rg" {
  description = "The keyvault resource group"
  default     = ""
}

variable "sa_resource_group_name" {
  description = "The storageaccountinfo resource group name"
  default     = ""
}