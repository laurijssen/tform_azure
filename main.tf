terraform {
  required_providers {
    azurerm = {
      version = ">= 2.86.0"
      source  = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  features {}
}
