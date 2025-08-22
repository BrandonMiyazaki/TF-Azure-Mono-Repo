
variable "resource_group_name" {
	description = "The name of the existing resource group where the VNet will be deployed."
	type        = string
}

variable "vnet_name" {
	description = "The name of the virtual network."
	type        = string
}

variable "address_space" {
	description = "The address space for the VNet."
	type        = list(string)
}

variable "subnets" {
	description = "List of subnets with name and address_prefix."
	type = list(object({
		name           = string
		address_prefix = string
	}))
}

variable "location" {
	description = "The Azure region for the VNet."
	type        = string
}

variable "tags" {
	description = "Tags to assign to the VNet."
	type        = map(string)
	default     = {}
}

variable "enable_nat_gateway" {
	description = "Enable or disable NAT Gateway for subnets."
	type        = bool
	default     = false
}

data "azurerm_resource_group" "existing" {
	name = var.resource_group_name
}

resource "azurerm_virtual_network" "this" {
	name                = var.vnet_name
	address_space       = var.address_space
	location            = data.azurerm_resource_group.existing.location
	resource_group_name = data.azurerm_resource_group.existing.name
	tags                = var.tags
}

resource "azurerm_network_security_group" "default" {
	name                = "${var.vnet_name}-default-nsg"
	location            = data.azurerm_resource_group.existing.location
	resource_group_name = data.azurerm_resource_group.existing.name
	tags                = var.tags
}

resource "azurerm_nat_gateway" "this" {
	count               = var.enable_nat_gateway ? 1 : 0
	name                = "${var.vnet_name}-natgw"
	location            = data.azurerm_resource_group.existing.location
	resource_group_name = data.azurerm_resource_group.existing.name
	sku_name            = "Standard"
}

resource "azurerm_subnet" "this" {
	for_each            = { for s in var.subnets : s.name => s }
	name                = each.value.name
	address_prefixes    = [each.value.address_prefix]
	resource_group_name = data.azurerm_resource_group.existing.name
	virtual_network_name= azurerm_virtual_network.this.name
	network_security_group_id = azurerm_network_security_group.default.id
	nat_gateway_id      = var.enable_nat_gateway ? azurerm_nat_gateway.this[0].id : null
}

output "vnet_id" {
	description = "The ID of the created virtual network."
	value       = azurerm_virtual_network.this.id
}

output "subnet_ids" {
	description = "The IDs of the created subnets."
	value       = [for s in azurerm_subnet.this : s.id]
}

output "nsg_id" {
	description = "The ID of the default network security group."
	value       = azurerm_network_security_group.default.id
}

output "nat_gateway_id" {
	description = "The ID of the NAT Gateway if enabled."
	value       = var.enable_nat_gateway ? azurerm_nat_gateway.this[0].id : null
}
