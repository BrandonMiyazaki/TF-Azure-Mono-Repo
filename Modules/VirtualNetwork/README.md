# Azure Virtual Network Terraform Module

This module is used to create an Azure Virtual Network (VNet) and its associated subnets using Terraform.

## Usage

Add the following to your Terraform configuration to use this module:

```hcl
module "virtual_network" {
	source              = "../Modules/VirtualNetwork"
	resource_group_name = "my-resource-group"
	vnet_name           = "my-vnet"
	address_space       = ["10.0.0.0/16"]
	subnets = [
		{
			name           = "subnet1"
			address_prefix = "10.0.1.0/24"
		},
		{
			name           = "subnet2"
			address_prefix = "10.0.2.0/24"
		}
	]
	location            = "eastus"
	tags = {
		environment = "dev"
		owner       = "BrandonMiyazaki"
	}
}
```

## Input Variables

- `resource_group_name` (string): The name of the resource group where the VNet will be created.
- `vnet_name` (string): The name of the virtual network.
- `address_space` (list(string)): The address space for the VNet.
- `subnets` (list(object)): List of subnets with `name` and `address_prefix`.
- `location` (string): The Azure region for the VNet.
- `tags` (map(string)): Tags to assign to the VNet.

## Example

```hcl
module "virtual_network" {
	source              = "../Modules/VirtualNetwork"
	resource_group_name = "example-rg"
	vnet_name           = "example-vnet"
	address_space       = ["10.1.0.0/16"]
	subnets = [
		{
			name           = "subnetA"
			address_prefix = "10.1.1.0/24"
		},
		{
			name           = "subnetB"
			address_prefix = "10.1.2.0/24"
		}
	]
	location            = "westus"
	tags = {
		environment = "prod"
		owner       = "BrandonMiyazaki"
	}
}
```

## Disclaimer

This module is provided as-is, without any warranty or guarantee of support.
