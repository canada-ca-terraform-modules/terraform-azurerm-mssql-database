## 2.1.0 (May 26, 2025)

FEATURES:
* `azurerm_mssql_database`- added parameter for **enclave_type**.

ENHANCEMENTS:

BUG FIXES:

## 2.0.4 (June 6, 2024)

FEATURES:

ENHANCEMENTS:

BUG FIXES:
* `azurerm_mssql_database`- Hyperscale variables settable

## 2.0.3 (June 29, 2023)

FEATURES:

ENHANCEMENTS:

BUG FIXES:
* `azurerm_mssql_database`- long term retention policy disabled by default


## 2.0.2 (March 16, 2023)

FEATURES:

ENHANCEMENTS:
* `\examples` - updated documentation to include more examples
* `azurerm_mssql_database`- added ignore_changes to tags

BUG FIXES:


## 2.0.1 (November 30, 2022)

FEATURES:

ENHANCEMENTS:

BUG FIXES:
* `azurerm_mssql_database` - remove `license_type` attribute
* `null_resource` - update ltrconfig.ps1 to change license type


## 2.0.0 (November 3, 2022)

FEATURES:
* New Resource: null_resource
* New Resource: time_sleep
* New Resource: azurerm_mssql_job_agent
* New Resource: azurerm_mssql_job_credential


ENHANCEMENTS:
* `azurerm_mssql_database` - enable Serverless, Hyperscale, BC and Premium builds

BUG FIXES: