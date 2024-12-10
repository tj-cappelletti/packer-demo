source "azure-arm" "rhel-9" {
  azure_tags                        = local.tags
  image_offer                       = "RHEL"
  image_publisher                   = "RedHat"
  image_sku                         = "9-lvm-gen2"
  location                          = var.location
  managed_image_name                = "rhel-9-${var.image_version}"
  managed_image_resource_group_name = var.managed_image_resource_group_name
  os_disk_size_gb                   = local.os_disk_size_gb
  os_type                           = "Linux"
  use_azure_cli_auth                = true
  vm_size                           = var.vm_size

  shared_image_gallery_destination {
    gallery_name        = var.destination_gallery_name
    image_name          = var.destination_image_name
    image_version       = var.image_version
    replication_regions = var.destination_replication_regions
    resource_group      = var.destination_resource_group_name
  }
}
