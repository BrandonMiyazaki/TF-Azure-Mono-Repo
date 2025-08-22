# ResourceGroup Terraform Module

This module is used to create an Azure Resource Group using Terraform.

## Usage

To use this module in your Terraform configuration, add the following to your `.tf` file:

```hcl
module "resource_group" {
	source = "../Modules/ResourceGroup"
	resource_group_name = "my-resource-group"
	location            = "eastus"
}
```

## Input Variables

- `resource_group_name` (string): The name of the resource group to create.
- `location` (string): The Azure region where the resource group will be created.

## Example

```hcl
module "resource_group" {
	source = "../Modules/ResourceGroup"
	resource_group_name = "example-rg"
	location            = "westus"
}
```

## Disclaimer

This module is provided as-is, without any warranty or guarantee of support.
