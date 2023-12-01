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

module "infr" {
  source = "./modules/vpc"

  app-name = var.app-name
  container-registry-name = var.container-registry-name
  container-registry-id = module.registry.ycr-id
  service-account-id = var.service-account-id
  folder-id = var.folder-id
}