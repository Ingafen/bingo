variable "zone-name" {
  default = "ru-central1-a"
  type = string
}

variable "container-registry-name" {
  default = "direbo-cr"
  type = string
}

variable "app-name" {
  default = "bingo"
}

variable "service-account-id" {
  type = string
}

variable "folder-id" {
  type = string
}