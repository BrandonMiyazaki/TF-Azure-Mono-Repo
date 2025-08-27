package test

import (
	"testing"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestAzureResourceGroupModule(t *testing.T) {
	t := t

	terraformOptions := &terraform.Options{
		// Path to the Terraform code that will be tested
		TerraformDir: "./AzureResources/ResourceGroup",
	}

	// Deploy resources
	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	// Validate outputs
	resourceGroupName := terraform.Output(t, terraformOptions, "resource_group_name")
	assert.NotEmpty(t, resourceGroupName, "Resource group name should not be empty")

	resourceGroupLocation := terraform.Output(t, terraformOptions, "resource_group_location")
	assert.NotEmpty(t, resourceGroupLocation, "Resource group location should not be empty")
}
