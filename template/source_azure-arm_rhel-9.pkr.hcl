source "azure-arm" "rhel-9" {
  azure_tags                        = local.tags
  image_offer                       = "RHEL"
  image_publisher                   = "RedHat"
  image_sku                         = "9-lvm-gen2"
  location                          = "eastus2"
  managed_image_name                = "rhel-9-${var.image_version}"
  managed_image_resource_group_name = var.managed_image_resource_group_name
  os_disk_size_gb                   = local.os_disk_size_gb
  os_type                           = "Linux"
  shared_image_gallery              = ""
  use_azure_cli_auth                = true
  vm_size                           = var.vm_size
  winrm_insecure                    = true
  winrm_timeout                     = local.winrm_timeout
  winrm_use_ssl                     = true
  winrm_username                    = local.winrm_username
}