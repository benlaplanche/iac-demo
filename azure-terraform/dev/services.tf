resource "azurerm_data_lake_analytics_firewall_rule" "denied" {
  name                = "office-ip-range"
  account_name        = azurerm_data_lake_analytics.example.name
  resource_group_name = azurerm_resource_group.example.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}

resource "azurerm_data_lake_store_firewall_rule" "denied" {
  name                = "office-ip-range"
  account_name        = azurerm_data_lake_store.example.name
  resource_group_name = azurerm_resource_group.example.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}

resource "azurerm_mariadb_firewall_rule" "denied" {
  name                = "test-rule"
  resource_group_name = "test-rg"
  server_name         = "test-server"
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}

resource "azurerm_mysql_firewall_rule" "denied" {
  name                = "test-rule"
  resource_group_name = "test-rg"
  server_name         = "test-server"
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}

resource "azurerm_postgresql_firewall_rule" "denied" {
  name                = "test-rule"
  resource_group_name = "test-rg"
  server_name         = "test-server"
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}

resource "azurerm_redis_firewall_rule" "denied" {
  name                = "someIPrange"
  redis_cache_name    = azurerm_redis_cache.example.name
  resource_group_name = azurerm_resource_group.example.name
  start_ip            = "0.0.0.0"
  end_ip              = "255.255.255.255"
}

resource "azurerm_sql_firewall_rule" "denied" {
  name                = "test-rule"
  resource_group_name = "test-rg"
  server_name         = "test-server"
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}
