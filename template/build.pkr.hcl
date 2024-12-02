packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = "~>2"
    }
  }
}

build {
  sources = ["source.azure-arm.rhel-9"]

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'"
    inline          = [
      "yum clean all",
      "yum update --nobest --skip-broken -y"]
  }
}