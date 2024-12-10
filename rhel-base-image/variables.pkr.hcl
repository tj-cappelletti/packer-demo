variable "destination_gallery_name" {
  default = "golden_images_eus2_gal"
  type    = string
}

variable "destination_image_name" {
  default = "rhel9-base-image"
  type    = string
}

variable "destination_replication_regions" {
  default = ["eastus2"]
  type    = list(string)
}

variable "destination_resource_group_name" {
  default = "packer-demo-eastus2-rg"
  type    = string
}

variable "image_version" {
  default = "0.0.1"
  type    = string
}

variable "location" {
  default = "eastus2"
  type    = string
}

variable "managed_image_resource_group_name" {
  default = "packer-demo-eastus2-rg"
  type    = string
}

variable "vm_size" {
  default = "Standard_D2s_v3"
}
