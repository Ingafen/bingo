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

variable "container-registry-name" {
    type = string
}

variable "container-registry-id" {
    type = string
}

variable "app-name" {
    type = string
    description = "application image name"
    default = "bingo"
}

variable "db_user_name" {
  type = string
  default = "bingo"
}

variable "db_name" {
  type = string
  default = "bingodb"
}
 
variable "db_user_password" {
  type = string
  default = "bingopass"
}

variable "mount-dir" {
  type = string
  default = "/opt/bingo"
}
