resource "azurerm_resource_group" "apim_resource_group" {
  name     = "apim-resource-group"
  location = "East US 2"
}

resource "azurerm_api_management" "sac_api_management" {
  name = "sac-testing-api-management"   
  location = azurerm_resource_group.apim_resource_group.location    
  resource_group_name = azurerm_resource_group.apim_resource_group.name    
  publisher_name = "My Company"   
  publisher_email = "company@terraform.io"  
  sku_name = "Premium_1"  
  client_certificate_enabled = false
  public_network_access_enabled = true

  virtual_network_configuration {
    subnet_id = azurerm_subnet.sac_apim_subnet.id
  }
}

resource "azurerm_subnet" "sac_apim_subnet" {
  name                 = "sac-testing-apim-subnet"   
  resource_group_name  = azurerm_resource_group.apim_resource_group.name  
  virtual_network_name = azurerm_virtual_network.sac_apim_virtual_network.name  
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_virtual_network" "sac_apim_virtual_network" {
  name                = "sac-testing-apim-virtual-network"  
  location            = azurerm_resource_group.apim_resource_group.location   
  resource_group_name = azurerm_resource_group.apim_resource_group.name   
  address_space       = ["10.0.0.0/16"]   
}