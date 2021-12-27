resource "azurerm_virtual_machine" "geofriends-vm-1" {
  name                  = "${var.prefix}-vm-1"
  location              = var.location
  resource_group_name   = azurerm_resource_group.geofriends.name
  network_interface_ids = [azurerm_network_interface.geofriends-instance.id]
  vm_size               = "Standard_A1_v2"

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "geofriends-1"
    admin_username = "laurijssen"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = file("mykey.pub")
      path     = "/home/laurijssen/.ssh/authorized_keys"
    }
  }
}

# resource "azurerm_virtual_machine" "geofriends-vm-2" {
#   name                  = "${var.prefix}-vm-2"
#   location              = var.location
#   resource_group_name   = azurerm_resource_group.geofriends.name
#   network_interface_ids = [azurerm_network_interface.geofriends-instance-2.id]
#   vm_size               = "Standard_A1_v2"

#   delete_os_disk_on_termination    = true
#   delete_data_disks_on_termination = true

#   storage_image_reference {
#     publisher = "Canonical"
#     offer     = "UbuntuServer"
#     sku       = "18.04-LTS"
#     version   = "latest"
#   }

#   storage_os_disk {
#     name              = "myosdisk2"
#     caching           = "ReadWrite"
#     create_option     = "FromImage"
#     managed_disk_type = "Standard_LRS"
#   }

#   os_profile {
#     computer_name  = "geofriends-2"
#     admin_username = "laurijssen"
#   }

#   os_profile_linux_config {
#     disable_password_authentication = true
#     ssh_keys {
#       key_data = file("mykey.pub")
#       path     = "/home/laurijssen/.ssh/authorized_keys"
#     }
#   }
# }

resource "azurerm_dns_zone" "dns_zone" {
  name                = "geocachex.com"
  resource_group_name = azurerm_resource_group.geofriends.name

  tags = {
    Site = "geocachex.com"
  }
}

resource "azurerm_dns_a_record" "dns_a_record" {
  name                = "@"
  zone_name           = azurerm_dns_zone.dns_zone.name
  resource_group_name = azurerm_resource_group.geofriends.name
  ttl                 = 3600
  target_resource_id  = azurerm_public_ip.geofriends-instance-1.id
}

resource "azurerm_dns_a_record" "dns_www_a_record" {
  name                = "www"
  zone_name           = azurerm_dns_zone.dns_zone.name
  resource_group_name = azurerm_resource_group.geofriends.name
  ttl                 = 3600
  target_resource_id  = azurerm_public_ip.geofriends-instance-1.id
}

resource "azurerm_dns_cname_record" "dns_api_cname_record" {
  name                = "api"
  zone_name           = azurerm_dns_zone.dns_zone.name
  resource_group_name = azurerm_resource_group.geofriends.name
  ttl                 = 3600
  record              = azurerm_dns_zone.dns_zone.name
}

resource "azurerm_network_interface" "geofriends-instance" {
  name                = "${var.prefix}-instance1"
  location            = var.location
  resource_group_name = azurerm_resource_group.geofriends.name

  ip_configuration {
    name                          = "instance1"
    subnet_id                     = azurerm_subnet.subnet-internal-1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.geofriends-instance-1.id
  }
}

# resource "azurerm_network_interface" "geofriends-instance-2" {
#   name                = "${var.prefix}-instance2"
#   location            = var.location
#   resource_group_name = azurerm_resource_group.geofriends.name

#   ip_configuration {
#     name                          = "instance2"
#     subnet_id                     = azurerm_subnet.subnet-internal-1.id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.geofriends-instance-2.id
#   }
# }
resource "azurerm_public_ip" "geofriends-instance-1" {
  name                = "instance1-public-ip"
  location            = var.location
  resource_group_name = azurerm_resource_group.geofriends.name
  allocation_method   = "Dynamic"
}

# resource "azurerm_public_ip" "geofriends-instance-2" {
#   name                = "instance2-public-ip"
#   location            = var.location
#   resource_group_name = azurerm_resource_group.geofriends.name
#   allocation_method   = "Dynamic"
# }

resource "azurerm_application_security_group" "geo-appsec-group" {
  name                = "internet-facing"
  location            = var.location
  resource_group_name = azurerm_resource_group.geofriends.name
}