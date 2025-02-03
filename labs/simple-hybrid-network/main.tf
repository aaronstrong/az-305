resource "azurerm_resource_group" "hub" {
  name     = "rg-hub"
  location = var.location
}

resource "azurerm_resource_group" "spoke1" {
  name     = "rg-spoke1"
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.hub.location
  name                = "vnet-${var.location}-prod"
  resource_group_name = azurerm_resource_group.hub.name

  subnet {
    address_prefixes = ["10.0.0.0/24"]
    name             = "GatewaySubnet"
  }
}

resource "azurerm_public_ip" "public_ip" {
  allocation_method   = "Static"
  location            = azurerm_resource_group.hub.location
  name                = "pip-${var.location}-prod"
  resource_group_name = azurerm_resource_group.hub.name
  sku                 = "Standard"
  zones               = ["1", "2", "3"]
}


# module "hub" {
#   source  = "Azure/avm-ptn-hubnetworking/azurerm"
#   version = "0.3.0"
#   hub_virtual_networks = {
#     primary = {
#       name                            = "vnet-hub-primary"
#       address_space                   = ["10.0.0.0/22"]
#       location                        = local.regions.primary
#       resource_group_name             = azurerm_resource_group.hub_rg["primary"].name
#       resource_group_creation_enabled = false
#       resource_group_lock_enabled     = false
#       mesh_peering_enabled            = true
#       route_table_name                = "rt-hub-primary"
#       routing_address_space           = ["10.0.0.0/16"]
#       subnets = {
#         bastion = {
#           name             = "AzureBastionSubnet"
#           address_prefixes = ["10.0.0.64/26"]
#           route_table = {
#             assign_generated_route_table = false
#           }
#         }
#         gateway = {
#           name             = "GatewaySubnet"
#           address_prefixes = ["10.0.0.128/27"]
#           route_table = {
#             assign_generated_route_table = false
#           }
#         }
#         user = {
#           name             = "hub-user-subnet"
#           address_prefixes = ["10.0.2.0/24"]
#         }
#       }
#     }
#   }
# }

# resource "tls_private_key" "key" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# resource "local_sensitive_file" "private_key" {
#   filename = "key.pem"
#   content  = tls_private_key.key.private_key_pem
# }


# module "spoke1_vnet" {
#   source  = "Azure/avm-res-network-virtualnetwork/azurerm"
#   version = "0.2.4"

#   name                = "vnet-spoke1-${random_pet.rand.id}"
#   address_space       = ["10.0.4.0/24"]
#   resource_group_name = azurerm_resource_group.spoke1.name
#   location            = azurerm_resource_group.spoke1.location

#   peerings = {
#     "spoke1-peering" = {
#       name                                 = "spoke1-peering"
#       remote_virtual_network_resource_id   = module.hub_mesh.virtual_networks["primary"].id
#       allow_forwarded_traffic              = true
#       allow_gateway_transit                = false
#       allow_virtual_network_access         = true
#       use_remote_gateways                  = false
#       create_reverse_peering               = true
#       reverse_name                         = "spoke1-peering-back"
#       reverse_allow_forwarded_traffic      = false
#       reverse_allow_gateway_transit        = false
#       reverse_allow_virtual_network_access = true
#       reverse_use_remote_gateways          = false
#     }
#   }
#   subnets = {
#     spoke1-subnet = {
#       name             = "spoke1-subnet"
#       address_prefixes = ["10.0.4.0/28"]
#     }
#   }
# }

# module "vm_spoke1" {
#   source  = "Azure/avm-res-compute-virtualmachine/azurerm"
#   version = "0.18.0"

#   location                           = azurerm_resource_group.spoke1.location
#   name                               = "vm-spoke1"
#   resource_group_name                = azurerm_resource_group.spoke1.name
#   zone                               = 1
#   admin_username                     = "adminuser"
#   generate_admin_password_or_ssh_key = false

#   admin_ssh_keys = [{
#     public_key = tls_private_key.key.public_key_openssh
#     username   = "adminuser"
#   }]

#   os_type  = "linux"
#   sku_size = "Standard_B1s"

#   network_interfaces = {
#     network_interface_1 = {
#       name = "internal"
#       ip_configurations = {
#         ip_configurations_1 = {
#           name                          = "internal"
#           private_ip_address_allocation = "Dynamic"
#           private_ip_subnet_resource_id = module.spoke1_vnet.subnets["spoke1-subnet"].resource_id
#         }
#       }
#     }
#   }

#   os_disk = {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference = {
#     offer     = "0001-com-ubuntu-server-jammy"
#     publisher = "Canonical"
#     sku       = "22_04-lts"
#     version   = "latest"
#   }
# }