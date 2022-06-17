terraform {
  required_providers {
    azurerm = {
      version = ">= 2.93.1"
      source  = "hashicorp/azurerm"
    }
  }
  backend "azurerm" {
    resource_group_name  = "terraform-state"
    storage_account_name = "laurijssentformstate"
    container_name       = "terraform-state-container"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}
