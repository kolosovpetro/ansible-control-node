data "cloudflare_zone" "razumovsky_me_zone" {
  name = "razumovsky.me"
}

resource "cloudflare_record" "control_node_dns" {
  zone_id = data.cloudflare_zone.razumovsky_me_zone.id
  name    = local.control_node.sub_domain
  content = module.control_node.public_ip_address
  type    = "A"
  proxied = false

  depends_on = [
    module.control_node
  ]
}

resource "cloudflare_record" "linux_servers_dns" {
  for_each = local.linux_servers
  zone_id  = data.cloudflare_zone.razumovsky_me_zone.id
  name     = each.value.sub_domain
  content  = module.linux_servers[each.key].public_ip_address
  type     = "A"
  proxied  = false

  depends_on = [
    module.linux_servers
  ]
}

resource "cloudflare_record" "windows_servers_dns" {
  for_each = local.windows_servers
  zone_id  = data.cloudflare_zone.razumovsky_me_zone.id
  name     = each.value.sub_domain
  content  = module.windows_servers[each.key].public_ip_address
  type     = "A"
  proxied  = false

  depends_on = [
    module.windows_servers
  ]
}

resource "cloudflare_record" "agwy_dns" {
  for_each = {
    dev = local.custom_cloudflare_dev_fqdn
    qa  = local.custom_cloudflare_qa_fqdn
  }
  zone_id = data.cloudflare_zone.razumovsky_me_zone.id
  name    = each.value
  content = azurerm_public_ip.gateway_public_ip.ip_address
  type    = "A"
  proxied = false
}