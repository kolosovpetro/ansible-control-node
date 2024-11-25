# resource "azurerm_application_gateway" "app_gateway" {
#   name                = "agwy-${var.prefix}"
#   resource_group_name = azurerm_resource_group.public.name
#   location            = azurerm_resource_group.public.location
# 
#   sku {
#     name     = "Standard_v2"
#     tier     = "Standard_v2"
#     capacity = 2
#   }
# 
#   gateway_ip_configuration {
#     name      = local.application_gateway_settings.gateway_ip_configuration_name
#     subnet_id = azurerm_subnet.gateway_subnet.id
#   }
# 
#   frontend_port {
#     name = local.https_port_name
#     port = 443
#   }
# 
#   frontend_port {
#     name = local.http_port_name
#     port = 80
#   }
# 
#   frontend_ip_configuration {
#     name                 = local.application_gateway_settings.frontend_ip_configuration_name
#     public_ip_address_id = azurerm_public_ip.gateway_public_ip.id
#   }
# 
#   backend_address_pool {
#     name = local.application_gateway_settings.agwy_backend_pool_name
#   }
# 
#   backend_http_settings {
#     name                  = local.application_gateway_settings.backend_http_settings_name
#     cookie_based_affinity = "Disabled"
#     port                  = 80
#     protocol              = "Http"
#     request_timeout       = 60
#   }
# 
#   http_listener {
#     name                           = local.application_gateway_settings.http_listener_name
#     frontend_ip_configuration_name = local.application_gateway_settings.frontend_ip_configuration_name
#     frontend_port_name             = local.https_port_name
#     protocol                       = "Https"
#     ssl_certificate_name           = local.application_gateway_settings.ssl_certificate_name
#   }
# 
#   ssl_certificate {
#     name     = var.ssl_certificate_name
#     data = filebase64(var.ssl_certificate_path)
#     password = var.ssl_certificate_password
#   }
# 
#   request_routing_rule {
#     name                       = local.application_gateway_settings.request_routing_rule_name
#     rule_type                  = "Basic"
#     http_listener_name         = local.application_gateway_settings.http_listener_name
#     backend_address_pool_name  = local.application_gateway_settings.agwy_backend_pool_name
#     backend_http_settings_name = local.application_gateway_settings.backend_http_settings_name
#     priority                   = 1
#   }
# }
# 
# resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "nic-assoc" {
#   for_each                = module.windows_servers
#   network_interface_id    = each.value.network_interface_id
#   ip_configuration_name   = each.value.ip_configuration_name
#   backend_address_pool_id = one(azurerm_application_gateway.app_gateway.backend_address_pool).id
# }