terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = var.zone-name
}

resource "yandex_container_registry" "ycr" {
  name = var.container-registry-name
}

output "ycr-name" {
  value = yandex_container_registry.ycr.id
}

resource "local_file" "build_script_template" {
    content = templatefile("${path.module}/docker_build.ps1.tpl", {
        cr-id = yandex_container_registry.ycr.id
        app-name = var.app-name
    })

    filename = "docker_build.ps1"
}