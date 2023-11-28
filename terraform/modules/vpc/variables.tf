variable "folder-id" {
    type = string  
}

variable "service-account-id" {
  type = string
}

variable "zone-name" {
  default = "ru-central1-a"
  type = string
}

variable "region-name" {
  default = "ru-central1"
  type = string
}

variable "service-account-name" {
    type = string
}

variable "container-registry-name" {
    type = string
}

variable "container-registry-id" {
    type = string
}

variable "app-name" {
    type = string
    description = "application image name"
}