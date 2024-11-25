variable "prefix" {
  type        = string
  description = "Resources name prefix"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "resource_group_location" {
  type        = string
  description = "Location of the resource group."
}

variable "vm_size" {
  type        = string
  description = "The size of the virtual machine."
}

variable "storage_image_reference_publisher" {
  type        = string
  description = "The publisher of the image used to create the virtual machine."
}

variable "storage_image_reference_offer" {
  type        = string
  description = "Specifies the offer of the platform image or marketplace image used to create the virtual machine."
}

variable "storage_image_reference_sku" {
  type        = string
  description = "Specifies the SKU of the platform image or marketplace image used to create the virtual machine."
}

variable "storage_image_reference_version" {
  type        = string
  description = "Specifies the version of the platform image or marketplace image used to create the virtual machine."
}

variable "storage_os_disk_caching" {
  type        = string
  description = "Specifies the caching requirements for the OS disk."
}

variable "storage_os_disk_create_option" {
  type        = string
  description = "Specifies how the virtual machine should be created."
}

variable "storage_os_disk_managed_disk_type" {
  type        = string
  description = "Specifies the storage account type for the managed disk."
}

variable "os_profile_admin_username" {
  type        = string
  description = "Specifies the name of the administrator account."
}

variable "os_profile_admin_public_key_path" {
  type        = string
  description = "Specifies the path to the public key file of the administrator account."
}

variable "os_profile_admin_password" {
  type        = string
  description = "Specifies the password of the administrator account."
}

variable "subscription_id" {
  type        = string
  description = "Azure subscription ID"
}

variable "storage_account_replication" {
  type        = string
  description = "Specifies the replication type for this storage account."
}

variable "storage_account_tier" {
  type        = string
  description = "Specifies the tier to use for this storage account."
}

variable "cloudflare_api_token" {
  type        = string
  description = "Cloudflare API token"
}

variable "ssl_certificate_name" {
  type        = string
  description = "Name of the SSL certificate"
}
variable "ssl_certificate_path" {
  type        = string
  description = "Path to the SSL certificate file"
}

variable "ssl_certificate_password" {
  type        = string
  description = "Password for the SSL certificate"
}

variable "dns_prefix" {
  type        = string
  description = "DNS prefix for the public IP address"
}