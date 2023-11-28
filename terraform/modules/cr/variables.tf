variable "zone-name" {
  default = "ru-central1-a"
  type = string
}

variable "container-registry-name" {
    type = string
    default = "direbo-cr"
}

variable "app-name" {
    type = string
    default = "bingo"
}