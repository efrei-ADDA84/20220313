provider "azurerm" {
  subscription_id = "765266c6-9a23-4638-af32-dd1e32613047"
  features {}
}

resource "azurerm_public_ip" "tp4" {
  name                = "evan_public-ip"
  location            = "francecentral"
  resource_group_name = "ADDA84-CTP"
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "tp4" {
  name                      = "evan_nic"
  location                  = "francecentral"
  resource_group_name       = "ADDA84-CTP"
  ip_configuration {
    name                          = "evan20220313_config"
    subnet_id                     = "/subscriptions/765266c6-9a23-4638-af32-dd1e32613047/resourceGroups/ADDA84-CTP/providers/Microsoft.Network/virtualNetworks/network-tp4/subnets/internal"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.tp4.id
  }
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_linux_virtual_machine" "tp4" {
  name                = "tp4-20220313"
  location            = "francecentral"
  resource_group_name = "ADDA84-CTP"
  size                = "Standard_D2s_v3"
  admin_username      = "devops"
  network_interface_ids = [
    azurerm_network_interface.tp4.id,
  ]

  disable_password_authentication = true 

  admin_ssh_key {
    username       = "devops"
    public_key     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDT0kjzvLT8ca6Og9frJRdeAFJ0gbgMWn7gcmDD6oB4jM2I2Y2QCIHV6YO8AZbeb39IaY5qdi+AtVjcjh/MxuXW2ZVzo/WzK/S3eD/e6W60UnoukfEAoH/gL7/BveJQYoMH2QfDT7q1zE2apZYckxAv//pP7WLO0QgXurAuSuwmMfLuHX4H2J46GH1xFeH+dY7KRL1fcKZxDO8v6NQgrgrm6fi22mxAycnnuUZJV+urHgoTeQE1QErOqih8kHvpQeWzOmiWvkRJzkv7UUOEXl+pFpxjpIdI/J0VKvW+tWxOUu/8s0XFgPinozKKtWzlfLFK8Ezvl/2Mny/vBzief8OhbwfTGCQ029q0LeKH9bSZ1xy3/LiUzIqYv2qpzzausV1I5G7CIkbKJ9A+9oJSI8xVn1W0Fc0BWzcuZO9Ps6ybvr8Izb55qZC3w4Ud4wgcD4xKD7tb0Zq7gShEHtQZ/xsNS5gItw+ngfNFb2AnWdArxclwgE2+lkMPDeHOzWtV7AN8t1AFByMP6HbwZrxNkos19UjEjXYg8Jt8q2kqmzBPmGMmQ8HvSq79vKBvoQw7P9Ny+xNl4MS0NJoXJsmYUH3xqyti9vZUNy/T3Qoc4obbGjr3/I+eWIN4gTKUnrkUhBze60PBnMmjbC7nyZtcPGVLK0HcghSiHFe54fToRcoFqw== evan.arneau@efrei.net"

  }

  os_disk {
    name              = "osdisk"
    caching           = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}