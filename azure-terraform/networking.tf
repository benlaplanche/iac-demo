resource "azurerm_firewall_application_rule_collection" "denied" {
  name                = "testcollection"
  azure_firewall_name = azurerm_firewall.example.name
  resource_group_name = azurerm_resource_group.example.name
  priority            = 100
  action              = "Allow"
  rule {
    name = "denied"
    source_addresses = [
      "0.0.0.0/0",
    ]
    target_fqdns = [
      "*.google.com",
    ]
    protocol {
      port = "443"
      type = "Https"
    }
  }
  rule {
    name = "allowed"
    source_addresses = [
      "1.0.0.0/0",
    ]
    target_fqdns = [
      "*.google.com",
    ]
    protocol {
      port = "443"
      type = "Https"
    }
  }

}

resource "azurerm_firewall_network_rule_collection" "denied" {
  name                = "testcollection"
  azure_firewall_name = azurerm_firewall.example.name
  resource_group_name = azurerm_resource_group.example.name
  priority            = 100
  action              = "Allow"
  rule {
    name = "denied"
    source_addresses = [
      "0.0.0.0/0",
    ]
    destination_ports = [
      "53",
    ]
    destination_addresses = [
      "8.8.8.8",
      "8.8.4.4",
    ]
    protocols = [
      "TCP",
      "UDP",
    ]
  }
  rule {
    name = "denied_2"
    source_addresses = [
      "1.0.0.0/0",
    ]
    destination_ports = [
      "53",
    ]
    destination_addresses = [
      "8.8.8.8",
      "8.8.4.4",
    ]
    protocols = [
      "TCP",
      "UDP",
    ]
  }

}

resource "azurerm_network_security_group" "denied" {
  name                = "acceptanceTestSecurityGroup1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  security_rule {
    name                       = "denied"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "allowed"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "192.168.0.0/0"
    destination_address_prefix = "*"
  }
  tags = {
    environment = "Production"
  }
}

resource "azurerm_network_security_rule" "denied" {
  name                        = "test123"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.example.name
  network_security_group_name = azurerm_network_security_group.example.name
}

resource "azurerm_network_security_rule" "denied_2" {
  direction                  = "Outbound"
  action                     = "Allow"
  destination_address_prefix = "0.0.0.0/0"
}
