resource "azurerm_resource_group" "this" {
  name     = uuid()
  location = "westeurope"
}

data "azurerm_client_config" "this" {}

module "firewall" {
  source               = "./module"
  name                 = "MyFirewall"
  resource_group_name  = azurerm_resource_group.this.name
  location             = azurerm_resource_group.this.location
  public_ip_count      = 1
  subnet_id            = "/subscriptions/${data.azurerm_client_config.this.subscription_id}/resourceGroups/${azurerm_resource_group.this.name}/providers/Microsoft.Network/virtualNetworks/vn-example/subnets/AzureFirewallSubnet"           # module.network.subnet_ids["AzureFirewallSubnet"]
  management_subnet_id = "/subscriptions/${data.azurerm_client_config.this.subscription_id}/resourceGroups/${azurerm_resource_group.this.name}/providers/Microsoft.Network/virtualNetworks/vn-example/subnets/AzureFirewallManagementSubnet" # module.network.subnet_ids["AzureFirewallManagementSubnet"]
  proxy_enabled        = true

}
