locals {
  base_managed_image_name = "ado-agent-windows"
  image_folder            = "C:\\image"
  os_disk_size_gb         = 512
  winrm_timeout           = "5m"
  winrm_username          = "packer"

  tags = {
    ApplicationName = "CICD-BuildAgent"
    Automation      = "Packer"
    Version         = var.image_version
  }
}