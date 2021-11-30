resource "azurerm_virtual_network" "vn" {
  name                = "${var.prefix}-network"
  location            = var.location
  resource_group_name = azurerm_resource_group.geofriends.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet-internal-1" {
  name                 = "${var.prefix}-internal-1"
  resource_group_name  = azurerm_resource_group.geofriends.name
  virtual_network_name = azurerm_virtual_network.vn.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_network_security_group" "allow-ssh" {
   name                    = "${var.prefix}-allow-ssh"
   location                = var.location
   resource_group_name     = azurerm_resource_group.geofriends.name

   security_rule {
       name                    = "SSH"
       priority                = 1001
       direction               = "Inbound"
       access                  = "Allow"
       protocol                = "Tcp"
       source_port_range       = var.ssh-source-address
       destination_port_range       = var.ssh-destination-address
       source_address_prefix        = var.ssh-source-address
       destination_address_prefix   = var.ssh-destination-address
   }
}

resource "azurerm_subnet_network_security_group_association" "sec-group-association" {
  subnet_id                 = azurerm_subnet.subnet-internal-1.id
  network_security_group_id = azurerm_network_security_group.allow-ssh.id
}
