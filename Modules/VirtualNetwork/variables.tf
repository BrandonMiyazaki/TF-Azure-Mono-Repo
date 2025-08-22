
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
