
module "virtual_network" {
	source              = "../../Modules/VirtualNetwork"
	resource_group_name = "TF-WestUS2-RG" # Name of existing resource group
	vnet_name           = "TF-WestUS2-VNet"
	address_space       = ["10.25.0.0/16"]
	subnets = [
		{
			name           = "vmsAzureFirewallSubnet"
			address_prefix = "10.25.1.0/24"
		},
		{
			name           = "ServerSubnet"
			address_prefix = "10.25.2.0/24"
		}
        {
			name           = "StorageAccountSubnet"
			address_prefix = "10.25.3.0/24"
		}
        {
			name           = "AzSQLSubnet"
			address_prefix = "10.25.4.0/24"
		}
        {
			name           = "SQLMiSubnet"
			address_prefix = "10.25.5.0/24"
		}
	]
	location            = "westus2"
	tags = {
		created_on  = "08-22-2025"
        environment = "prod"
		owner       = "BrandonMiyazaki"
	}
	enable_nat_gateway  = false
}
