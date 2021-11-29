resource "azurerm_resource_group" "geofriends" {
  name     = "geofriends"
  location = var.location
  tags = {
    env = "geofriends"
  }
}