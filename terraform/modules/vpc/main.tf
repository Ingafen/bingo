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

resource "yandex_vpc_network" "direbo-vpc" {
  name = "catgpt vpc"
}

resource "yandex_vpc_subnet" "direbo-vpc-subnet" {
  zone           = var.zone-name
  name           = "bingo vpc subnet"
  network_id     = yandex_vpc_network.direbo-vpc.id
  v4_cidr_blocks = ["10.5.0.0/24"]
}

data "yandex_compute_image" "coi" {
  family = "container-optimized-image"
}

resource "yandex_compute_instance" "bingo-1" {
    platform_id        = "standard-v2"    
    service_account_id = var.service-account-id

    resources {
      cores         = 2
      memory        = 1
      core_fraction = 5
    }
    scheduling_policy {
      preemptible = true
    }
    network_interface {
      subnet_id = "${yandex_vpc_subnet.direbo-vpc-subnet.id}"
      nat = true
    }
    boot_disk {
      initialize_params {
        type = "network-hdd"
        size = "30"
        image_id = data.yandex_compute_image.coi.id
      }
    }
    metadata = {
      docker-compose = templatefile("${path.module}/docker-compose.yaml", 
        {
            cr-id = var.container-registry-id, 
            app-name = var.app-name
        })
      ssh-keys  = "ubuntu:${file("${path.module}/.ssh/key.pub")}"
    }
}

resource "yandex_compute_instance" "bingo-2" {
    platform_id        = "standard-v2"    
    service_account_id = var.service-account-id

    resources {
      cores         = 2
      memory        = 1
      core_fraction = 5
    }
    scheduling_policy {
      preemptible = true
    }
    network_interface {
      subnet_id = "${yandex_vpc_subnet.direbo-vpc-subnet.id}"
      nat = true
    }
    boot_disk {
      initialize_params {
        type = "network-hdd"
        size = "30"
        image_id = data.yandex_compute_image.coi.id
      }
    }
    metadata = {
      docker-compose = templatefile("${path.module}/docker-compose.yaml", 
        {
            cr-id = var.container-registry-id, 
            app-name = var.app-name
        })
      ssh-keys  = "ubuntu:${file("${path.module}/.ssh/key.pub")}"
    }
}

resource "yandex_lb_target_group" "direbo-albtg" {
  name = "bingo-target-group"
  region_id = var.region-name

  target {
    subnet_id = yandex_vpc_subnet.direbo-vpc-subnet.id
    address = yandex_compute_instance.bingo-1.network_interface.0.ip_address
  }

  target {
    subnet_id = yandex_vpc_subnet.direbo-vpc-subnet.id
    address = yandex_compute_instance.bingo-2.network_interface.0.ip_address
  }  
}

resource "yandex_lb_network_load_balancer" "direbo-nlb" {
  name = "my-network-load-balancer"

  listener {
    name = "my-listener"
    port = 12337
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.direbo-albtg.id

    healthcheck {
      name = "http"
      http_options {
        port = 12337
        path = "/ping"
      }
    }
  }
}

output "docker-compose" {
  value = yandex_compute_instance.catgpt-1.metadata["docker-compose"]
}