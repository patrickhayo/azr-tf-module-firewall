# azr-tf-module-firewall

[Terraform](https://www.terraform.io) Module to create **Azure Firewall** in Azure

<!-- BEGIN_TF_DOCS -->
## Prerequisites

- [Terraform](https://releases.hashicorp.com/terraform/) v0.12+

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=2.36.0 |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.14.9 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=2.36.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_firewall.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall) | resource |
| [azurerm_firewall_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_policy) | resource |
| [azurerm_public_ip.config](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |
| [azurerm_public_ip.managedment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) Specifies the name of the Firewall. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group in which to create the resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | (Optional) A list of custom DNS servers' IP addresses. | `list(string)` | `null` | no |
| <a name="input_management_name"></a> [management\_name](#input\_management\_name) | (Required) Specifies the name of the IP Configuration. | `string` | `"fw_ip_management_config"` | no |
| <a name="input_management_subnet_id"></a> [management\_subnet\_id](#input\_management\_subnet\_id) | (Required) Reference to the subnet associated with the IP Configuration. Changing this forces a new resource to be created. The Management Subnet used for the Firewall must have the name AzureFirewallManagementSubnet and the subnet mask must be at least a /26. | `string` | `null` | no |
| <a name="input_proxy_enabled"></a> [proxy\_enabled](#input\_proxy\_enabled) | (Optional) Whether to enable DNS proxy on Firewalls attached to this Firewall Policy? Defaults to false. | `bool` | `false` | no |
| <a name="input_public_ip_count"></a> [public\_ip\_count](#input\_public\_ip\_count) | (Optional) Specifies the number of public IPs to assign to the Firewall. Defaults to 1. | `number` | `1` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | (Optional) SKU name of the Firewall. Possible values are AZFW\_Hub and AZFW\_VNet. Changing this forces a new resource to be created. | `string` | `"AZFW_VNet"` | no |
| <a name="input_sku_policy"></a> [sku\_policy](#input\_sku\_policy) | (Optional) The SKU Tier of the Firewall Policy. Possible values are Standard, Premium. Changing this forces a new Firewall Policy to be created. | `string` | `"Standard"` | no |
| <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier) | (Optional) SKU tier of the Firewall. Possible values are Premium and Standard. Changing this forces a new resource to be created. | `string` | `"Standard"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | (Optional) Reference to the subnet associated with the IP Configuration. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Specifies the tags of the storage account | `map` | `{}` | no |
| <a name="input_threat_intel_mode"></a> [threat\_intel\_mode](#input\_threat\_intel\_mode) | (Optional) The operation mode for threat intelligence-based filtering. Possible values are: Off, Alert,Deny and (empty string). Defaults to Alert. | `string` | `"Alert"` | no |
| <a name="input_virtual_hub_id"></a> [virtual\_hub\_id](#input\_virtual\_hub\_id) | virtual\_hub block supports the following: (Required) Specifies the ID of the Virtual Hub where the Firewall resides in. | `string` | `null` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | Specifies the availability zones of the Azure Firewall | `list(string)` | <pre>[<br>  "1",<br>  "2",<br>  "3"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ip"></a> [ip](#output\_ip) | Specifies the ID of the firewall. |
| <a name="output_ip_configuration_name"></a> [ip\_configuration\_name](#output\_ip\_configuration\_name) | Sepcifies the IP configuration. |
| <a name="output_ip_configuration_public_ip_address_id"></a> [ip\_configuration\_public\_ip\_address\_id](#output\_ip\_configuration\_public\_ip\_address\_id) | Sepcifies the IP configuration. |
| <a name="output_policy_id"></a> [policy\_id](#output\_policy\_id) | Specifies the firewall policy id. |
| <a name="output_policy_name"></a> [policy\_name](#output\_policy\_name) | Specifies the firewall policy name. |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | Specifies the private IP address of the firewall. |
| <a name="output_public_ip_addresses_config"></a> [public\_ip\_addresses\_config](#output\_public\_ip\_addresses\_config) | Specifies the public IP addresses of the firewall. |
| <a name="output_public_ip_addresses_managedment"></a> [public\_ip\_addresses\_managedment](#output\_public\_ip\_addresses\_managedment) | Specifies the managedment public IP addresses of the firewall. |
| <a name="output_virtual_hub"></a> [virtual\_hub](#output\_virtual\_hub) | Specifies the Virtual HUB configuration. |

## Example

```hcl
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
```


<!-- END_TF_DOCS -->
## Authors

Originally created by [Patrick Hayo](http://github.com/patrickhayo)

## License

[MIT](LICENSE) License - Copyright (c) 2022 by the Author.
