terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.16.0"
    }
  }
}

provider "azurerm" {
  features {
    
  }
}



module "resource_group" {
	source              = "../../Modules/ResourceGroup"
	resource_group_name = "TF-WestUS2-RG"
	location            = "westus2"
	tags = {
		date        = "08-22-2025"
		environment = "Prod"
		created_by  = "BrandonMiyazaki"
	}
}
