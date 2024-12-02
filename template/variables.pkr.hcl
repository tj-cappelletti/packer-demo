variable "image_version" {
  default = "DEV"
  type    = string
}

variable "managed_image_resource_group_name" {
  default = "packer-demo-eastus2-rg"
  type    = string
}

variable "vm_size" {
  default = "Standard_D2s_v3"
}