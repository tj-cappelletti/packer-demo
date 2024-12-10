locals {
  image_folder    = "C:\\image"
  os_disk_size_gb = 512

  tags = {
    Automation      = "Packer"
    Version         = var.image_version
  }
}
