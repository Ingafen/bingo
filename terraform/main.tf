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

module "registry" {
  source = "./modules/cr"
  app-name = var.app-name
}