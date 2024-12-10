packer {
  required_plugins {
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1"
    }
    azure = {
      source  = "github.com/hashicorp/azure"
      version = "~> 1"
    }
  }
}

variable "image_ver" {
  type    = string
  default = "1.0.0"
}

variable "mgd_image" {
  type    = string
  default = "apchewebserver"
}

variable "rg" {
  type    = string
  default = "rg_name"
}

variable "ssh_pass" {
  type    = string
  default = "abc@341256"
}

variable "ssh_user" {
  type    = string
  default = "admin"
}

variable "subscription_id" {
  type    = string
  default = "subscription-id"
}

source "azure-arm" "autogenerated_1" {
  azure_tags = {
    app = "oracledb"
  }
  build_resource_group_name         = "${var.rg}"
  disk_additional_size              = "300"
  managed_image_name                = "${var.mgd_image}"
  managed_image_resource_group_name = "${var.rg}"
  os_type                           = "Linux"
  shared_image_gallery {
    gallery_name   = "web_app"
    image_name     = "rhel7"
    image_version  = "${var.image_ver}"
    resource_group = "${var.rg}"
    subscription   = "${var.subscription_id}"
  }
  shared_image_gallery_destination {
    gallery_name        = "web_app"
    image_name          = "rhel7-oracledb"
    image_version       = "${var.image_ver}"
    replication_regions = ["US East"]
    resource_group      = "${var.rg}"
  }
  shared_image_gallery_timeout        = "2h5m2s"
  ssh_password                        = "${var.ssh_pass}"
  ssh_pty                             = "true"
  ssh_username                        = "${var.ssh_user}"
  subscription_id                     = "${var.subscription_id}"
  virtual_network_name                = "vnet_name"
  virtual_network_resource_group_name = "${var.rg}"
  virtual_network_subnet_name         = "snet_name"
  vm_size                             = "Standard_A2"
}

build {
  sources = ["source.azure-arm.autogenerated_1"]

  provisioner "ansible" {
    ansible_env_vars = ["ANSIBLE_HOST_KEY_CHECKING=False", "ansible_python_interpreter=/opt/azure/bin/python", "ANSIBLE_SSH_ARGS='-o ForwardAgent=yes -o ControlMaster=auto -o ControlPersist=60s'"]
    extra_arguments  = ["-vvvv", "-e", "ansible_python_interpreter=/opt/azure/bin/python"]
    playbook_file    = "./config_oracledb.yml"
    use_proxy        = "false"
    user             = "root"
  }

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'"
    inline          = ["/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync"]
    inline_shebang  = "/bin/sh -x"
  }

  post-processor "shell-local" {
    inline = ["az image delete -n ${var.mgd_image} -g ${var.rg} --subscription ${var.subscription_id}"]
  }
}
