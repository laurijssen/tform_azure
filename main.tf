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

resource "azurerm_resource_group" "demo" {
  name     = "first-steps-demo"
  location = var.location
}