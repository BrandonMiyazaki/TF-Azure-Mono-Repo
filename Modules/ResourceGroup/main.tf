resource "azurerm_resource_group" "main" {
	name     = var.resource_group_name
	location = var.location
	tags     = var.tags
}

output "resource_group_name" {
	description = "The name of the created resource group."
	value       = azurerm_resource_group.this.name
}

output "resource_group_location" {
	description = "The location of the created resource group."
	value       = azurerm_resource_group.this.location
}
