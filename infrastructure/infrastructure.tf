###########################################################
### Default configuration block when working with Azure ###
###########################################################
terraform {
  # Provide configuration details for Terraform
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.45.0"
    }
  }
  # This block allows us to save the terraform.tfstate file on the cloud, so a team of developers can use the terraform
  # configuration to update the infrastructure.
  # Link: https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=azure-cli
  # Note.- Before using this block, is important that the resource group, storage account and container ARE DEPLOYED.
  backend "azurerm" {
    resource_group_name  = "dip-prd-master-rg"
    storage_account_name = "dipprdmasterst"
    container_name       = "dip-prd-asdlgen2-fs-config"
    key                  = "dip-14as69-rg/terraform.tfstate"
    
  }
}

# provide configuration details for the Azure terraform provider
provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}


# For naming conventions please refer to:
# https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules

# Get info about current user
data "azuread_client_config" "current" {}


###########################################################
###################  Resource Group #######################
###########################################################
resource "azurerm_resource_group" "rg_prd" {
  location = var.location
  name     = "${var.default_prefix}-${var.random_id}-${var.prd_tag}-rg"
  tags = {
    owner       = var.owner
    environment = var.prd_tag

  }
}

resource "azurerm_resource_group" "rg_dev" {
  location = var.location
  name     = "${var.default_prefix}-${var.random_id}-${var.dev_tag}-rg"
  tags = {
    owner       = var.owner
    environment = var.dev_tag

  }
}


###########################################################
###################  Storage Account ######################
###########################################################
resource "azurerm_storage_account" "storageaccount_prd" {
  name = "${var.default_prefix}${var.random_id}${var.prd_tag}st"      # Between 3 to 24 characters and
                                                                      # UNIQUE within Azure
  resource_group_name      = azurerm_resource_group.rg_prd.name
  location                 = azurerm_resource_group.rg_prd.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"

  tags = {
    owner       = var.owner
    environment = var.prd_tag
  }
}

resource "azurerm_storage_account" "storageaccount_dev" {
  name = "${var.default_prefix}${var.random_id}${var.dev_tag}st"      # Between 3 to 24 characters and
                                                                      # UNIQUE within Azure
  resource_group_name      = azurerm_resource_group.rg_dev.name
  location                 = azurerm_resource_group.rg_dev.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"

  tags = {
    owner       = var.owner
    environment = var.dev_tag
  }
}

###########################################################
###################  App Service Plan #####################
###########################################################
resource "azurerm_service_plan" "service_plan_prd" {
  name                = "${var.default_prefix}-${var.random_id}-${var.prd_tag}-service-plan"
  location            = azurerm_resource_group.rg_prd.location
  resource_group_name = azurerm_resource_group.rg_prd.name
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_service_plan" "service_plan_dev" {
  name                = "${var.default_prefix}-${var.random_id}-${var.dev_tag}-service-plan"
  location            = azurerm_resource_group.rg_dev.location
  resource_group_name = azurerm_resource_group.rg_dev.name
  os_type             = "Linux"
  sku_name            = "Y1"
}


###########################################################
#####################  App Function #######################
###########################################################
resource "azurerm_linux_function_app" "function_app_prd" {
  name                         = "${var.default_prefix}-${var.random_id}-${var.prd_tag}-function-app"
  location                     = azurerm_resource_group.rg_prd.location
  resource_group_name          = azurerm_resource_group.rg_prd.name

  service_plan_id              = azurerm_service_plan.service_plan_prd.id
  storage_account_name         = azurerm_storage_account.storageaccount_prd.name
  storage_account_access_key   = azurerm_storage_account.storageaccount_prd.primary_access_key

  functions_extension_version  = "~4"
  site_config {
    application_stack {
      python_version      = "3.9"
    }
  }

}

resource "azurerm_linux_function_app" "function_app_dev" {
  name                         = "${var.default_prefix}-${var.random_id}-${var.dev_tag}-function-app"
  location                     = azurerm_resource_group.rg_dev.location
  resource_group_name          = azurerm_resource_group.rg_dev.name

  service_plan_id              = azurerm_service_plan.service_plan_dev.id
  storage_account_name         = azurerm_storage_account.storageaccount_dev.name
  storage_account_access_key   = azurerm_storage_account.storageaccount_dev.primary_access_key

  functions_extension_version  = "~4"

  site_config {
    application_stack {
      python_version      = "3.9"
    }
  }
}
